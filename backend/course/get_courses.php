<?php
header('Content-Type: application/json');
include '../config.php';

$result = $conn->query("SELECT courseId, courseName FROM course");

$courses = [];
while ($row = $result->fetch_assoc()) {
    $courses[] = $row;
}

echo json_encode([
    "status" => "success",
    "courses" => $courses
]);
?>
