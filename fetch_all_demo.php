<?php
/**
 * fetch_all_demo.php
 * Demonstrates fetchAll(): gets EVERY row of the result set at once
 * and returns them as an array of arrays.
 */
require_once 'dbconfig.php'; // gives us the $pdo connection

// Write the SQL query (no user input here, so query() is fine)
$sql = "SELECT item_id, item_name, brand, unit_size, price_aud
        FROM grocery_items
        ORDER BY item_id
        LIMIT 5";

$stmt = $pdo->query($sql);          // run the query
$items = $stmt->fetchAll();         // fetch ALL rows (array of rows)

echo '<h2>fetchAll() result (first 5 grocery items)</h2>';

// <pre> keeps the line breaks/indentation so print_r() is readable
echo '<pre>';
print_r($items);
echo '</pre>';
