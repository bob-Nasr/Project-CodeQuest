<?php
$host = 'localhost';
$db = 'mobprog_codequest';
$user = 'root';
$pass = ''; // default WAMP password
$conn = new mysqli($host, $user, $pass, $db);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>
