# PDO Methods Activity - Australian Grocery Items

## Run on XAMPP
1. Start **Apache** and **MySQL** in the XAMPP Control Panel.
2. Copy this folder to `C:\xampp\htdocs\grocery_pdo_activity`.
3. Open http://localhost/phpmyadmin -> **Import** -> choose `sql/grocery_schema_and_data.sql` -> Go.
4. Open http://localhost/grocery_pdo_activity/ and click each demo.

## Worksheet answers
- Table: `grocery_items` (9 columns) + lookup table `categories`; 126 rows with real Australian brands.
- Columns / data types: see `sql/grocery_schema_and_data.sql` (all snake_case).
- Screenshot `dbconfig.php`, `fetch_all_demo.php`, `fetch_demo.php`, `insert_demo.php`, `delete_demo.php`, `update_demo.php`, `render_table_demo.php` (all commented).
- Complex query (JOIN + subqueries + CASE + RANK() window function): `render_table_demo.php`.
