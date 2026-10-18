<?php
/**
 * delete_demo.php
 * Demonstrates DELETING records using a prepared statement.
 * It removes the rows created by insert_demo.php (brand = 'Demo Brand')
 * so the original 100+ records are never touched.
 */
require_once 'dbconfig.php';

// 1. SQL with a placeholder
$sql  = "DELETE FROM grocery_items WHERE brand = :brand";

// 2. Prepare and execute
$stmt = $pdo->prepare($sql);
$stmt->execute([':brand' => 'Demo Brand']);

// 3. rowCount() = how many rows were deleted
echo '<h2>DELETE successful</h2>';
echo 'Rows deleted: ' . $stmt->rowCount();
