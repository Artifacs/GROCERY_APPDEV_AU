<?php
/**
 * fetch_demo.php
 * Demonstrates fetch(): gets only ONE row (the next row) from the result set.
 * Try it: fetch_demo.php?id=10
 */
require_once 'dbconfig.php';

// Use ?id= from the URL, or default to item 1
$id = isset($_GET['id']) ? (int) $_GET['id'] : 1;

// Prepared statement: the :id placeholder is filled in safely later
$sql  = "SELECT item_id, item_name, brand, unit_size, price_aud, is_gluten_free
         FROM grocery_items
         WHERE item_id = :id";
$stmt = $pdo->prepare($sql);
$stmt->execute([':id' => $id]);     // bind the value and run

$item = $stmt->fetch();             // fetch ONE row (false if nothing found)

echo "<h2>fetch() result for item_id = $id</h2>";
echo '<pre>';
print_r($item);                     // prints a single associative array
echo '</pre>';
