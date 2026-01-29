<?php
require_once __DIR__ . "/../connection.inc.php";

function q($sql) {
  global $con;
  $r = $con->query($sql);
  $rows = [];
  while ($row = $r->fetch_assoc()) $rows[] = $row;
  return $rows;
}

$topQuestions = q("
  SELECT question, COUNT(*) AS times
  FROM chatbot_questions
  GROUP BY question
  ORDER BY times DESC
  LIMIT 15
");

$topKeywords = q("
  SELECT keyword, hits
  FROM chatbot_keywords
  ORDER BY hits DESC
  LIMIT 20
");

$scope = q("
  SELECT COUNT(*) AS total,
         SUM(out_of_scope) AS out_of_scope,
         SUM(CASE WHEN matched_products > 0 THEN 1 ELSE 0 END) AS in_scope
  FROM chatbot_questions
")[0] ?? ["total"=>0,"out_of_scope"=>0,"in_scope"=>0];

$daily = q("
  SELECT DATE(created_at) AS day, COUNT(*) AS cnt
  FROM chatbot_questions
  WHERE created_at >= (NOW() - INTERVAL 14 DAY)
  GROUP BY DATE(created_at)
  ORDER BY day ASC
");
?>
<!doctype html>
<html>
<head>
  <meta charset="utf-8" />
  <title>JooD+ Analytics</title>
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  <style>
    body { font-family: Arial, sans-serif; margin: 24px; }
    .grid { display: grid; grid-template-columns: 1fr 1fr; gap: 18px; }
    .card { border: 1px solid #ddd; border-radius: 12px; padding: 16px; background: #fff; }
    h2 { margin: 0 0 10px; }
    table { width: 100%; border-collapse: collapse; }
    td, th { padding: 8px; border-bottom: 1px solid #eee; text-align: left; }
    .kpi { display:flex; gap:12px; }
    .kpi .pill { padding:10px 12px; border:1px solid #eee; border-radius:12px; }
  </style>
</head>
<body>

<h1>JooD+ Analytics Dashboard</h1>

<div class="kpi">
  <div class="pill"><b>Total questions:</b> <?= (int)$scope["total"] ?></div>
  <div class="pill"><b>In-scope:</b> <?= (int)$scope["in_scope"] ?></div>
  <div class="pill"><b>Out-of-scope:</b> <?= (int)$scope["out_of_scope"] ?></div>
</div>

<br/>

<div class="grid">
  <div class="card">
    <h2>Questions (last 14 days)</h2>
    <canvas id="dailyChart" height="120"></canvas>
  </div>

  <div class="card">
    <h2>Top Keywords</h2>
    <table>
      <tr><th>Keyword</th><th>Hits</th></tr>
      <?php foreach ($topKeywords as $r): ?>
        <tr>
          <td><?= htmlspecialchars($r["keyword"]) ?></td>
          <td><?= (int)$r["hits"] ?></td>
        </tr>
      <?php endforeach; ?>
    </table>
  </div>

  <div class="card" style="grid-column: 1 / span 2;">
    <h2>Top Questions</h2>
    <table>
      <tr><th>Times</th><th>Question</th></tr>
      <?php foreach ($topQuestions as $r): ?>
        <tr>
          <td><b><?= (int)$r["times"] ?></b></td>
          <td><?= htmlspecialchars($r["question"]) ?></td>
        </tr>
      <?php endforeach; ?>
    </table>
  </div>
</div>

<script>
const labels = <?= json_encode(array_map(fn($x)=>$x["day"], $daily)) ?>;
const data = <?= json_encode(array_map(fn($x)=>(int)$x["cnt"], $daily)) ?>;

new Chart(document.getElementById("dailyChart"), {
  type: "line",
  data: { labels, datasets: [{ label: "Questions", data }] },
  options: { responsive: true }
});
</script>

</body>
</html>

