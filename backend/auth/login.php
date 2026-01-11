<?php
header('Content-Type: application/json');
include '../config.php';

$data = json_decode(file_get_contents("php://input"), true);
$username = $data['username'];
$password = $data['password'];

$sql = "SELECT * FROM user WHERE username='$username'";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $row = $result->fetch_assoc();
    if (password_verify($password, $row['password'])) {
        echo json_encode(["status"=>"success", "userId"=>$row['userId']]);
    } else {
        echo json_encode(["status"=>"error", "message"=>"Invalid password"]);
    }
} else {
    echo json_encode(["status"=>"error", "message"=>"User not found"]);
}
?>
