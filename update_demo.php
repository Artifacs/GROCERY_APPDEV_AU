<?php
/**
 * update_demo.php
 * Demonstrates UPDATING a record using a prepared statement.
 * Raises the price of item_id 1 by 10 cents, then shows before and after.
 */
require_once 'dbconfig.php';

$id = 1;

// Helper: read the current price of the item
$read = $pdo->prepare("SELECT item_name, price_aud FROM grocery_items WHERE item_id = :id");

// BEFORE the update
$read->execute([':id' => $id]);
$before = $read->fetch();

// The UPDATE statement
$sql  = "UPDATE grocery_items
         SET price_aud = price_aud + :increase
         WHERE item_id = :id";
$stmt = $pdo->prepare($sql);
$stmt->execute([':increase' => 0.10, ':id' => $id]);

// AFTER the update
$read->execute([':id' => $id]);
$after = $read->fetch();

echo '<h2>UPDATE successful</h2>';
echo 'Rows updated: ' . $stmt->rowCount() . '<br>';
echo '<pre>';
echo "Before:\n"; print_r($before);
echo "After:\n";  print_r($after);
echo '</pre>';
