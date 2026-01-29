<?php
require_once __DIR__ . "/../connection.inc.php";

$apiKey = getenv("OPENAI_API_KEY");
if (!$apiKey) die("Missing API key");

$res = $con->query("SELECT id, comment FROM contact_us WHERE sentiment IS NULL LIMIT 20");

while ($row = $res->fetch_assoc()) {
    $id = (int)$row["id"];
    $comment = $row["comment"];

    $payload = [
        "model" => "gpt-4.1-mini",
        "messages" => [
            [
                "role" => "system",
                "content" => "Classify the sentiment of this text as Positive, Neutral, or Negative. 
Also provide a sentiment score from -1 (very negative) to 1 (very positive). 
Return JSON like: {\"sentiment\":\"Positive\",\"score\":0.85}"
            ],
            ["role" => "user", "content" => $comment]
        ],
        "temperature" => 0
    ];

    $ch = curl_init("https://api.openai.com/v1/chat/completions");
    curl_setopt_array($ch, [
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_POST => true,
        CURLOPT_HTTPHEADER => [
            "Authorization: Bearer ".$apiKey,
            "Content-Type: application/json"
        ],
        CURLOPT_POSTFIELDS => json_encode($payload)
    ]);

    $result = curl_exec($ch);
    curl_close($ch);

    $json = json_decode($result, true);
    $content = $json["choices"][0]["message"]["content"] ?? "";

    $analysis = json_decode($content, true);

    if (isset($analysis["sentiment"])) {
        $sentiment = $analysis["sentiment"];
        $score = (float)$analysis["score"];

        $stmt = $con->prepare("
            UPDATE contact_us 
            SET sentiment=?, sentiment_score=?, analyzed_at=NOW()
            WHERE id=?
        ");
        $stmt->bind_param("sdi", $sentiment, $score, $id);
        $stmt->execute();
        $stmt->close();
    }
}


$sentimentStats = $con->query("
    SELECT sentiment, COUNT(*) as cnt 
    FROM contact_us 
    GROUP BY sentiment
");

while ($row = $sentimentStats->fetch_assoc()) {
    echo $row["sentiment"] . ": " . $row["cnt"] . "<br>";
}





echo "Sentiment analysis complete.";

