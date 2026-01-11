<?php
header('Content-Type: application/json');
include '../config.php';

$data = json_decode(file_get_contents("php://input"), true);

$username = $data['username'];
$password = password_hash($data['password'], PASSWORD_DEFAULT);
$name = $data['name'];
$phone = $data['phone'];

$sql = "INSERT INTO user (username, password, name, phoneNumber)
        VALUES ('$username', '$password', '$name', '$phone')";

if ($conn->query($sql) === TRUE) {
    echo json_encode(["status"=>"success"]);
} else {
    echo json_encode(["status"=>"error", "message"=>$conn->error]);
}
?>
