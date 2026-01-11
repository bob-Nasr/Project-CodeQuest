<?php
header('Content-Type: application/json');
include '../config.php';

$data = json_decode(file_get_contents("php://input"), true);

$courseId = $data['courseId'];
$userId   = $data['userId'];
$result   = $data['result'];

$sql = "INSERT INTO results (courseId, userId, result) VALUES ('$courseId', '$userId', '$result')";

if ($conn->query($sql) === TRUE) {
    echo json_encode(["status" => "success"]);
} else {
    echo json_encode(["status" => "error", "message" => $conn->error]);
}
?>
