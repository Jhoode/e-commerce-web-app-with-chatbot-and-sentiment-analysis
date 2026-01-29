<?php
require('connection.inc.php');
require('functions.inc.php');

session_start(); // ✅ REQUIRED for $_SESSION to persist

$email = get_safe_value($con, $_POST['email'] ?? '');
$password = trim($_POST['password'] ?? '');

if ($email === '' || $password === '') {
echo "wrong";
exit;
}

// ✅ Use prepared statement (prevents SQL injection + weird quoting issues)
$stmt = $con->prepare("SELECT id, name, email, password, status FROM users WHERE email = ? LIMIT 1");
$stmt->bind_param("s", $email);
$stmt->execute();
$res = $stmt->get_result();

if ($res && $res->num_rows > 0) {
$row = $res->fetch_assoc();

// ✅ Plaintext compare (exact match)
if ($row['password'] === $password) {

if ((string)$row['status'] === '1') {
$_SESSION['USER_LOGIN'] = 'yes';
$_SESSION['USER_ID'] = $row['id'];
$_SESSION['USER_NAME'] = $row['name'];
$_SESSION['STATUS'] = $row['status'];

// Move wishlist if needed
if (isset($_SESSION['WISHLIST_ID']) && $_SESSION['WISHLIST_ID'] !== '') {
wishlist_add($con, $_SESSION['USER_ID'], $_SESSION['WISHLIST_ID']);
unset($_SESSION['WISHLIST_ID']);
}

echo "valid";
exit;

} else {
echo "inactive";
exit;
}

} else {
echo "wrong";
exit;
}
} else {
echo "wrong";
exit;
}
