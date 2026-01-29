<?php
declare(strict_types=1);

header("Content-Type: application/json; charset=utf-8");
session_start();

/**
 * =========================
 * Helpers
 * =========================
 */
function respond(array $arr, int $code = 200): void {
  http_response_code($code);
  echo json_encode($arr);
  exit;
}

function clean_keywords(string $q): array {
  $q = strtolower($q);
  $q = preg_replace('/[^a-z0-9\s]/', ' ', $q);
  $parts = preg_split('/\s+/', trim($q));
  $stop = ['the','a','an','and','or','to','for','of','in','on','at','is','are','i','you','we','it','this','that','with','my','me','your','today','please'];
  $out = [];
  foreach ($parts as $p) {
    if (strlen($p) < 3) continue;
    if (in_array($p, $stop, true)) continue;
    $out[] = $p;
  }
  return array_values(array_unique($out));
}

function extract_terms(string $q): array {
  $q = strtolower($q);
  $q = preg_replace('/[^a-z0-9\s]/', ' ', $q);
  $parts = preg_split('/\s+/', trim($q));
  $stop = ['i','want','to','buy','a','an','the','and','or','for','of','in','on','at','is','are','with','me','my','your','today','please','need','looking'];
  $terms = [];
  foreach ($parts as $p) {
    if (strlen($p) < 2) continue;
    if (in_array($p, $stop, true)) continue;
    $terms[] = $p;
  }
  return array_values(array_unique($terms));
}

function detect_price_filter(string $q): array {
  // returns [min,max] where either can be null
  $q = strtolower($q);

  if (preg_match('/between\s+\$?(\d+)\s+and\s+\$?(\d+)/', $q, $m)) {
    $a = (int)$m[1]; $b = (int)$m[2];
    return [min($a, $b), max($a, $b)];
  }
  if (preg_match('/(under|below|less than)\s+\$?(\d+)/', $q, $m)) {
    return [null, (int)$m[2]];
  }
  if (preg_match('/(over|above|more than)\s+\$?(\d+)/', $q, $m)) {
    return [(int)$m[2], null];
  }
  if (preg_match('/\$(\d{2,6})/', $q, $m)) {
    return [null, (int)$m[1]];
  }
  return [null, null];
}

function detect_brand(string $q): ?string {
  $brands = ["apple","dell","hp","lenovo","asus","acer","samsung","lg","sony","microsoft","xiaomi","oneplus"];
  $q = strtolower($q);
  foreach ($brands as $b) {
    if (strpos($q, $b) !== false) return $b;
  }
  return null;
}

/**
 * IMPORTANT:
 * Update the category IDs below to match your real `categories` table IDs.
 */
function detect_category_id(string $q): ?int {
  $q = strtolower($q);

  // UPDATE THESE IDs
  $map = [
    1 => ["laptop","macbook","notebook"],
    2 => ["phone","iphone","android","mobile","smartphone"],
    3 => ["tablet","ipad","tab"],
    4 => ["tv","television","oled","qled","4k"],
    5 => ["accessory","charger","headphone","earbud","cable","mouse","keyboard"],
  ];

  foreach ($map as $catId => $words) {
    foreach ($words as $w) {
      if (strpos($q, $w) !== false) return $catId;
    }
  }
  return null;
}

/**
 * =========================
 * Main
 * =========================
 */
try {
  // ---- Read input
  $raw = file_get_contents("php://input");
  $data = json_decode($raw ?: "{}", true);
  $question = trim((string)($data["message"] ?? ""));

  if ($question === "") {
    respond(["reply" => "Ask JooD+ about laptops, phones, tablets, TVs, accessories, pricing, or availability."], 400);
  }

  // ---- DB connection (MUST be before any SQL)
  require_once __DIR__ . "/../connection.inc.php";
  if (!isset($con) || !($con instanceof mysqli)) {
    error_log("JooD+ ERROR: DB connection \$con not found");
    respond(["reply" => "Server DB configuration error."], 500);
  }

  // ---- Smart filters
  $catId = detect_category_id($question);           // int|null
  [$minPrice, $maxPrice] = detect_price_filter($question); // int|null
  $brand = detect_brand($question);                 // string|null

  // ---- Query products using category/price/brand first
  $products = [];

  $sql = "SELECT id, name, price, mrp, categories_id FROM product WHERE 1=1";
  $types = "";
  $params = [];

  if ($catId !== null) {
    $sql .= " AND categories_id = ?";
    $types .= "i";
    $params[] = $catId;
  }

  if ($brand !== null) {
    $sql .= " AND LOWER(name) LIKE ?";
    $types .= "s";
    $params[] = "%".$brand."%";
  }

  if ($minPrice !== null) {
    $sql .= " AND price >= ?";
    $types .= "i";
    $params[] = $minPrice;
  }

  if ($maxPrice !== null) {
    $sql .= " AND price <= ?";
    $types .= "i";
    $params[] = $maxPrice;
    $sql .= " ORDER BY price ASC";
  } else {
    $sql .= " ORDER BY id DESC";
  }

  $sql .= " LIMIT 8";

  $stmt = $con->prepare($sql);
  if ($stmt) {
    if ($types !== "") $stmt->bind_param($types, ...$params);
    $stmt->execute();
    $res = $stmt->get_result();
    while ($row = $res->fetch_assoc()) {
      $products[] = [
        "id" => (int)$row["id"],
        "name" => (string)$row["name"],
        "price" => $row["price"],
        "mrp" => $row["mrp"] ?? null,
        "categories_id" => (int)$row["categories_id"],
      ];
    }
    $stmt->close();
  } else {
    error_log("JooD+ SQL prepare error (smart query): " . $con->error);
  }

  // ---- Fallback keyword matcher if smart filters return nothing
  if (count($products) === 0) {
    $terms = extract_terms($question);
    if (empty($terms)) $terms = [strtolower($question)];

    // Try name-only first (most reliable)
    $wheres = [];
    $types = "";
    $params = [];

    foreach ($terms as $t) {
      $like = "%" . $t . "%";
      $wheres[] = "(LOWER(name) LIKE ?)";
      $types .= "s";
      $params[] = $like;
    }

    $sql = "SELECT id, name, price, mrp, categories_id FROM product WHERE " . implode(" OR ", $wheres) . " LIMIT 12";
    $stmt = $con->prepare($sql);

    if (!$stmt) {
      error_log("JooD+ SQL prepare error (fallback): " . $con->error);
    } else {
      $stmt->bind_param($types, ...$params);
      $stmt->execute();
      $res = $stmt->get_result();

      $rows = [];
      while ($row = $res->fetch_assoc()) $rows[] = $row;
      $stmt->close();

      // Rank results by keyword hits in product name
      usort($rows, function($a, $b) use ($terms) {
        $scoreA = 0; $scoreB = 0;
        $nameA = strtolower((string)($a["name"] ?? ""));
        $nameB = strtolower((string)($b["name"] ?? ""));
        foreach ($terms as $t) {
          if (strpos($nameA, $t) !== false) $scoreA++;
          if (strpos($nameB, $t) !== false) $scoreB++;
        }
        return $scoreB <=> $scoreA;
      });

      foreach (array_slice($rows, 0, 8) as $row) {
        $products[] = [
          "id" => (int)$row["id"],
          "name" => (string)$row["name"],
          "price" => $row["price"],
          "mrp" => $row["mrp"] ?? null,
          "categories_id" => (int)$row["categories_id"],
        ];
      }
    }
  }

  $matchedCount = (int)count($products);
  $outOfScope = ($matchedCount === 0) ? 1 : 0;

  // ---- Analytics: log question
  $sessionId = session_id();
  $ip = $_SERVER["REMOTE_ADDR"] ?? null;

  $stmt = $con->prepare("
    INSERT INTO chatbot_questions (session_id, user_ip, question, matched_products, out_of_scope)
    VALUES (?,?,?,?,?)
  ");
  if ($stmt) {
    $stmt->bind_param("sssii", $sessionId, $ip, $question, $matchedCount, $outOfScope);
    $stmt->execute();
    $stmt->close();
  }

  // ---- Analytics: keyword hits
  $keywords = clean_keywords($question);
  if (!empty($keywords)) {
    $stmt = $con->prepare("
      INSERT INTO chatbot_keywords (keyword, hits)
      VALUES (?, 1)
      ON DUPLICATE KEY UPDATE hits = hits + 1
    ");
    if ($stmt) {
      foreach ($keywords as $kw) {
        $stmt->bind_param("s", $kw);
        $stmt->execute();
      }
      $stmt->close();
    }
  }

  // ---- If no match, force electronics-only behavior
  if ($matchedCount === 0) {
    respond([
      "reply" => "I can help with electronics we have in stock. Try a device type (laptop/phone/tablet/TV), a budget (e.g., under $900), or a brand (Dell/Apple/Samsung)."
    ], 200);
  }

  // ---- OpenAI call (grounded to DB products)
  $apiKey = getenv("OPENAI_API_KEY");
  if (!$apiKey) {
    error_log("JooD+ ERROR: OPENAI_API_KEY missing");
    respond(["reply" => "Server missing API key."], 500);
  }
  if (!function_exists("curl_init")) {
    respond(["reply" => "Server missing php-curl. Install php8.3-curl and restart Apache."], 500);
  }

  $productContext = json_encode($products, JSON_UNESCAPED_UNICODE);

  $system = "You are JooD+, an electronics shopping assistant for this store.
Rules:
- Only use products provided in CONTEXT_PRODUCTS_JSON.
- Recommend up to 3 products with name + price.
- For each recommended product include a link in this format: product.php?id=PRODUCT_ID
- If user asks for something not in the products list, say you don't see it in stock and ask what electronics category they want.
CONTEXT_PRODUCTS_JSON: $productContext";

  $payload = [
    "model" => "gpt-4.1-mini",
    "messages" => [
      ["role" => "system", "content" => $system],
      ["role" => "user", "content" => $question]
    ],
    "max_tokens" => 280,
    "temperature" => 0.4
  ];

  $ch = curl_init("https://api.openai.com/v1/chat/completions");
  curl_setopt_array($ch, [
    CURLOPT_RETURNTRANSFER => true,
    CURLOPT_POST => true,
    CURLOPT_HTTPHEADER => [
      "Authorization: Bearer ".$apiKey,
      "Content-Type: application/json"
    ],
    CURLOPT_POSTFIELDS => json_encode($payload),
    CURLOPT_TIMEOUT => 25
  ]);

  $result = curl_exec($ch);
  $err = curl_error($ch);
  $code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
  curl_close($ch);

  if ($result === false) {
    error_log("JooD+ cURL ERROR: $err");
    respond(["reply" => "Network error contacting AI service."], 502);
  }
  if ($code < 200 || $code >= 300) {
    error_log("JooD+ OpenAI HTTP $code: $result");
    respond(["reply" => "AI service error. Check logs."], 502);
  }

  $json = json_decode($result, true);
  $reply = $json["choices"][0]["message"]["content"] ?? null;
  if (!$reply) {
    error_log("JooD+ parse error raw: $result");
    respond(["reply" => "Could not parse AI response."], 502);
  }

  respond(["reply" => $reply], 200);

} catch (Throwable $e) {
  error_log("JooD+ fatal: " . $e->getMessage());
  respond(["reply" => "Server error. Check logs."], 500);
}

