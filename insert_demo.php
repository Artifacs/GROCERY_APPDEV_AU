<?php
/**
 * insert_demo.php
 * Demonstrates INSERTING a record using a prepared statement.
 * Each refresh of this page adds one more demo row.
 */
require_once 'dbconfig.php';

// 1. SQL with named placeholders (never put variables directly in SQL)
$sql = "INSERT INTO grocery_items
            (item_name, brand, category_id, unit_size, price_aud, stock_quantity, is_gluten_free)
        VALUES
            (:item_name, :brand, :category_id, :unit_size, :price_aud, :stock_quantity, :is_gluten_free)";

// 2. Prepare the statement
$stmt = $pdo->prepare($sql);

// 3. Execute with the actual values
$stmt->execute([
    ':item_name'      => 'Demo Lamington Cakes',
    ':brand'          => 'Demo Brand',
    ':category_id'    => 2,          // 2 = Bakery
    ':unit_size'      => '6 pack',
    ':price_aud'      => 4.50,
    ':stock_quantity' => 25,
    ':is_gluten_free' => 0,
]);

// 4. Confirm what happened
echo '<h2>INSERT successful</h2>';
echo 'Rows inserted: ' . $stmt->rowCount() . '<br>';
echo 'New item_id: ' . $pdo->lastInsertId();   // auto-incremented primary key
