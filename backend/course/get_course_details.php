<?php
header('Content-Type: application/json');
include '../config.php';

$courseId = $_GET['courseId'];
$type = $_GET['type']; // objective | reading | question

$sql = "SELECT text, choices, answer FROM course_details 
        WHERE courseId = '$courseId' AND type = '$type'";

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
