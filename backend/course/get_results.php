<?php
header('Content-Type: application/json');
include '../config.php';

$courseId = $_GET['courseId'];
$userId   = $_GET['userId'];

$sql = "SELECT result, timestamp FROM results 
        WHERE courseId='$courseId' AND userId='$userId' 
        ORDER BY timestamp DESC LIMIT 2";

$result = $conn->query($sql);

$data = [];
while ($row = $result->fetch_assoc()) {
    $data[] = $row;
}

echo json_encode([
    "status" => "success",
    "data" => $data
]);
?>
