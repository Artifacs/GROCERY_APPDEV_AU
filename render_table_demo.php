<?php
/**
 * render_table_demo.php
 * Shows a (complex) SQL query's result set rendered as an HTML table.
 *
 * SQL concepts used: INNER JOIN, correlated subquery, CASE expression,
 * window function RANK() with PARTITION BY, WHERE and ORDER BY.
 * (Window functions need MariaDB 10.2+ / MySQL 8+, included in current XAMPP.)
 */
require_once 'dbconfig.php';

$sql = "SELECT
            g.item_id,
            g.item_name,
            g.brand,
            c.category_name,
            g.unit_size,
            g.price_aud,
            -- average price of all items in the same category (correlated subquery)
            ROUND((SELECT AVG(g2.price_aud)
                   FROM grocery_items g2
                   WHERE g2.category_id = g.category_id), 2) AS category_avg_price,
            -- label each item as above or below its category average
            CASE
                WHEN g.price_aud > (SELECT AVG(g3.price_aud)
                                    FROM grocery_items g3
                                    WHERE g3.category_id = g.category_id)
                    THEN 'Above average'
                ELSE 'At or below average'
            END AS price_tier,
            -- rank of the item by price inside its category (1 = most expensive)
            RANK() OVER (PARTITION BY g.category_id ORDER BY g.price_aud DESC) AS price_rank
        FROM grocery_items g
        INNER JOIN categories c ON c.category_id = g.category_id
        WHERE g.stock_quantity > 0
        ORDER BY c.category_name, price_rank";

$rows = $pdo->query($sql)->fetchAll();
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Australian Grocery Items</title>
    <style>
        body  { font-family: Arial, sans-serif; margin: 20px; }
        table { border-collapse: collapse; width: 100%; }
        th, td { border: 1px solid #ccc; padding: 6px 10px; text-align: left; }
        th    { background: #00843D; color: #fff; }       /* Aussie green */
        tr:nth-child(even) { background: #f6f6f6; }
    </style>
</head>
<body>
    <h1>Australian Grocery Items (in stock)</h1>
    <p>Total rows: <?= count($rows) ?></p>

    <table>
        <thead>
            <tr>
                <th>ID</th><th>Item</th><th>Brand</th><th>Category</th>
                <th>Size</th><th>Price (AUD)</th><th>Category Avg</th>
                <th>Price Tier</th><th>Rank in Category</th>
            </tr>
        </thead>
        <tbody>
        <?php foreach ($rows as $row): ?>
            <tr>
                <!-- htmlspecialchars() prevents HTML injection -->
                <td><?= htmlspecialchars($row['item_id']) ?></td>
                <td><?= htmlspecialchars($row['item_name']) ?></td>
                <td><?= htmlspecialchars($row['brand']) ?></td>
                <td><?= htmlspecialchars($row['category_name']) ?></td>
                <td><?= htmlspecialchars($row['unit_size']) ?></td>
                <td>$<?= number_format($row['price_aud'], 2) ?></td>
                <td>$<?= number_format($row['category_avg_price'], 2) ?></td>
                <td><?= htmlspecialchars($row['price_tier']) ?></td>
                <td><?= htmlspecialchars($row['price_rank']) ?></td>
            </tr>
        <?php endforeach; ?>
        </tbody>
    </table>
</body>
</html>
