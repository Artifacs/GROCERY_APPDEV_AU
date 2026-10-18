<?php
// ---- 1. Connection settings (XAMPP defaults) ----
$host    = 'localhost';      // XAMPP runs MySQL on the same computer
$db      = 'grocery_db';     // database created by the SQL file
$user    = 'root';           // default XAMPP username
$pass    = '';               // default XAMPP password is empty
$charset = 'utf8mb4';        // supports all characters (e.g. apostrophes, emojis)

// ---- 2. DSN (Data Source Name) tells PDO which driver/database to use ----
$dsn = "mysql:host=$host;dbname=$db;charset=$charset";

// ---- 3. PDO options ----
$options = [
    // Throw exceptions on SQL errors so we can catch them
    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
    // fetch() / fetchAll() return associative arrays by default
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    // Use real prepared statements (safer against SQL injection)
    PDO::ATTR_EMULATE_PREPARES   => false,
];

// ---- 4. Create the connection ----
try {
    $pdo = new PDO($dsn, $user, $pass, $options);
} catch (PDOException $e) {
    // Stop the script and show a readable message if connection fails
    die('Database connection failed: ' . $e->getMessage());
}
