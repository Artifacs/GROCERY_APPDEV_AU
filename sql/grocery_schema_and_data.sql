-- ============================================================
-- Australian Grocery Database  (PDO Methods Activity)
-- Country chosen: Australia
-- Works on XAMPP (MariaDB 10.2+ / MySQL 8+). Import via phpMyAdmin
-- (Import tab) or: mysql -u root < grocery_schema_and_data.sql
-- NOTE: prices are realistic estimates in AUD, for school use only.
-- ============================================================

DROP DATABASE IF EXISTS grocery_db;
CREATE DATABASE grocery_db CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE grocery_db;

-- ------------------------------------------------------------
-- Table 1: categories (lookup table)
-- ------------------------------------------------------------
CREATE TABLE categories (
    category_id   INT UNSIGNED NOT NULL AUTO_INCREMENT,
    category_name VARCHAR(50)  NOT NULL,
    PRIMARY KEY (category_id),
    UNIQUE KEY uq_category_name (category_name)
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- Table 2: grocery_items (main table, 9 columns)
-- ------------------------------------------------------------
CREATE TABLE grocery_items (
    item_id        INT UNSIGNED  NOT NULL AUTO_INCREMENT,   -- primary key
    item_name      VARCHAR(100)  NOT NULL,                  -- e.g. Tim Tam Original
    brand          VARCHAR(60)   NOT NULL,                  -- e.g. Arnott's
    category_id    INT UNSIGNED  NOT NULL,                  -- FK -> categories
    unit_size      VARCHAR(30)   NOT NULL,                  -- e.g. 200g, 2L, 6 pack
    price_aud      DECIMAL(6,2)  NOT NULL,                  -- price in Australian dollars
    stock_quantity INT           NOT NULL DEFAULT 0,        -- units on the shelf
    is_gluten_free TINYINT(1)    NOT NULL DEFAULT 0,        -- 1 = yes, 0 = no
    date_added     DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (item_id),
    CONSTRAINT fk_items_category FOREIGN KEY (category_id)
        REFERENCES categories (category_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- Records: categories
-- ------------------------------------------------------------
INSERT INTO categories (category_id, category_name) VALUES
    (1, 'Dairy & Eggs'),
    (2, 'Bakery'),
    (3, 'Pantry'),
    (4, 'Snacks & Confectionery'),
    (5, 'Beverages'),
    (6, 'Meat & Seafood'),
    (7, 'Frozen'),
    (8, 'Breakfast'),
    (9, 'Fruit & Veg');

-- ------------------------------------------------------------
-- Records: grocery_items (126 rows)
-- ------------------------------------------------------------
INSERT INTO grocery_items
    (item_name, brand, category_id, unit_size, price_aud, stock_quantity, is_gluten_free, date_added) VALUES
    ('Full Cream Milk', 'Dairy Farmers', 1, '2L', 3.10, 3, 1, '2026-05-24 09:00:00'),
    ('Lite White Milk', 'Pauls', 1, '2L', 3.00, 17, 1, '2026-02-24 09:00:00'),
    ('Classic Full Cream Milk', 'Pura', 1, '2L', 3.20, 114, 1, '2026-02-18 09:00:00'),
    ('Greek Style Natural Yoghurt', 'Jalna', 1, '1kg', 6.50, 4, 1, '2026-02-01 09:00:00'),
    ('Tasty Cheese Block', 'Bega', 1, '500g', 8.50, 64, 1, '2026-01-20 09:00:00'),
    ('Stringer Cheese', 'Bega', 1, '180g', 5.50, 91, 1, '2026-09-21 09:00:00'),
    ('Shredded Mozzarella', 'Perfect Italiano', 1, '250g', 5.20, 57, 1, '2026-05-19 09:00:00'),
    ('Salted Butter', 'Devondale', 1, '250g', 4.80, 0, 1, '2026-03-25 09:00:00'),
    ('Spreadable Butter', 'Western Star', 1, '375g', 5.60, 43, 1, '2026-03-09 09:00:00'),
    ('Thickened Cream', 'Dairy Farmers', 1, '300ml', 3.40, 97, 1, '2026-02-11 09:00:00'),
    ('Original Margarine Spread', 'Meadow Lea', 1, '500g', 4.20, 12, 1, '2026-06-12 09:00:00'),
    ('Free Range Eggs', 'Sunny Queen', 1, '700g', 6.80, 103, 1, '2026-08-02 09:00:00'),
    ('Chocolate Milk', 'Oak', 1, '600ml', 3.70, 118, 1, '2026-02-13 09:00:00'),
    ('Almond Milk Unsweetened', 'So Good', 1, '1L', 3.50, 106, 1, '2026-06-21 09:00:00'),
    ('Cream Cheese Block', 'Bega', 1, '250g', 4.60, 90, 1, '2026-01-03 09:00:00'),
    ('Soft White Sandwich Bread', 'Tip Top', 2, '700g', 3.50, 98, 0, '2026-02-10 09:00:00'),
    ('9 Grain Bread', 'Tip Top', 2, '700g', 4.20, 110, 0, '2026-07-04 09:00:00'),
    ('Soft White Bread', 'Wonder', 2, '700g', 3.20, 81, 0, '2026-06-27 09:00:00'),
    ('Wholemeal Bread', 'Helga''s', 2, '750g', 4.60, 45, 0, '2026-05-07 09:00:00'),
    ('Multigrain Bread', 'Abbott''s Village Bakery', 2, '700g', 5.20, 87, 0, '2026-02-21 09:00:00'),
    ('English Muffins', 'Tip Top', 2, '6 pack', 4.00, 21, 0, '2026-04-18 09:00:00'),
    ('Original Crumpets', 'Golden', 2, '6 pack', 3.30, 48, 0, '2026-09-09 09:00:00'),
    ('Raisin Toast', 'Tip Top', 2, '550g', 4.30, 41, 0, '2026-01-27 09:00:00'),
    ('Burger Buns', 'Tip Top', 2, '6 pack', 3.80, 4, 0, '2026-06-26 09:00:00'),
    ('Yeast Extract Spread', 'Vegemite', 3, '380g', 7.50, 8, 0, '2026-06-07 09:00:00'),
    ('Smooth Peanut Butter', 'Bega', 3, '470g', 5.50, 63, 1, '2026-08-13 09:00:00'),
    ('Crunchy Peanut Butter', 'Bega', 3, '470g', 5.50, 17, 1, '2026-09-08 09:00:00'),
    ('Tomato Sauce', 'MasterFoods', 3, '500ml', 3.60, 95, 1, '2026-07-19 09:00:00'),
    ('Barbecue Sauce', 'MasterFoods', 3, '500ml', 3.60, 51, 1, '2026-04-12 09:00:00'),
    ('Sliced Peaches in Juice', 'SPC', 3, '825g', 3.40, 17, 1, '2026-08-17 09:00:00'),
    ('Baked Beans in Tomato Sauce', 'SPC', 3, '425g', 1.80, 6, 0, '2026-02-28 09:00:00'),
    ('Spaghetti in Tomato Sauce', 'SPC', 3, '420g', 1.80, 20, 0, '2026-07-26 09:00:00'),
    ('Corn Kernels', 'Edgell', 3, '420g', 1.90, 49, 1, '2026-08-13 09:00:00'),
    ('Extra Virgin Olive Oil', 'Cobram Estate', 3, '500ml', 13.00, 70, 1, '2026-01-28 09:00:00'),
    ('Pure Honey Squeezable', 'Capilano', 3, '500g', 9.50, 14, 1, '2026-09-22 09:00:00'),
    ('Spaghetti Pasta', 'San Remo', 3, '500g', 2.20, 98, 0, '2026-06-21 09:00:00'),
    ('Penne Pasta', 'San Remo', 3, '500g', 2.20, 55, 0, '2026-08-06 09:00:00'),
    ('Medium Grain White Rice', 'SunRice', 3, '1kg', 3.50, 0, 1, '2026-05-24 09:00:00'),
    ('Brown Rice', 'SunRice', 3, '1kg', 4.20, 97, 1, '2026-09-06 09:00:00'),
    ('Plain Flour', 'White Wings', 3, '1kg', 2.40, 111, 0, '2026-05-21 09:00:00'),
    ('Self Raising Flour', 'Defiance', 3, '1kg', 2.40, 64, 0, '2026-04-20 09:00:00'),
    ('White Sugar', 'CSR', 3, '1kg', 2.60, 97, 1, '2026-09-06 09:00:00'),
    ('Iodised Table Salt', 'Saxa', 3, '750g', 2.10, 118, 1, '2026-01-17 09:00:00'),
    ('Strawberry Jam', 'Cottee''s', 3, '500g', 4.30, 62, 1, '2026-02-01 09:00:00'),
    ('Apricot Jam', 'IXL', 3, '480g', 4.50, 112, 1, '2026-05-27 09:00:00'),
    ('Real Mayonnaise', 'Praise', 3, '445g', 4.80, 30, 1, '2026-02-19 09:00:00'),
    ('Beef Gravy Mix', 'Gravox', 3, '120g', 2.80, 62, 0, '2026-02-27 09:00:00'),
    ('Chicken Noodle Cup-a-Soup', 'Continental', 3, '2 pack', 2.60, 68, 0, '2026-03-25 09:00:00'),
    ('Tuna in Olive Oil', 'Sirena', 3, '185g', 3.40, 60, 1, '2026-03-18 09:00:00'),
    ('Pink Salmon', 'Safcol', 3, '415g', 6.50, 111, 1, '2026-07-20 09:00:00'),
    ('Tim Tam Original', 'Arnott''s', 4, '200g', 4.50, 118, 0, '2026-04-18 09:00:00'),
    ('Shapes Pizza', 'Arnott''s', 4, '190g', 3.50, 51, 0, '2026-06-22 09:00:00'),
    ('Scotch Finger Biscuits', 'Arnott''s', 4, '250g', 3.20, 66, 0, '2026-02-15 09:00:00'),
    ('Jatz Original Crackers', 'Arnott''s', 4, '225g', 3.60, 8, 0, '2026-01-11 09:00:00'),
    ('Milk Arrowroot Biscuits', 'Arnott''s', 4, '250g', 2.50, 29, 0, '2026-04-19 09:00:00'),
    ('Iced VoVo Biscuits', 'Arnott''s', 4, '290g', 3.80, 0, 0, '2026-01-23 09:00:00'),
    ('Cheezels Cheese Snacks', 'Arnott''s', 4, '125g', 3.30, 115, 0, '2026-06-02 09:00:00'),
    ('Original Crinkle Cut Chips', 'Smith''s', 4, '170g', 3.80, 30, 1, '2026-08-09 09:00:00'),
    ('Original Corn Chips', 'CC''s', 4, '175g', 3.50, 16, 1, '2026-08-24 09:00:00'),
    ('Cheese Twisties', 'Twisties', 4, '170g', 3.40, 60, 1, '2026-07-26 09:00:00'),
    ('Lightly Salted Chips', 'Samboy', 4, '175g', 3.80, 12, 1, '2026-07-22 09:00:00'),
    ('Soft Eating Licorice', 'Darrell Lea', 4, '260g', 5.50, 52, 0, '2026-01-15 09:00:00'),
    ('Snakes Alive Lollies', 'Allen''s', 4, '190g', 3.00, 82, 0, '2026-01-04 09:00:00'),
    ('Jelly Babies', 'The Natural Confectionery Co.', 4, '220g', 3.20, 43, 1, '2026-02-26 09:00:00'),
    ('Violet Crumble Bar', 'Violet Crumble', 4, '50g', 1.80, 24, 0, '2026-08-18 09:00:00'),
    ('Cherry Ripe Bar', 'Cadbury', 4, '52g', 1.90, 23, 1, '2026-08-09 09:00:00'),
    ('Minties', 'Rowntree''s', 4, '180g', 3.20, 118, 1, '2026-08-03 09:00:00'),
    ('Fruit Free Muesli Bars Apricot', 'Carman''s', 4, '6 pack', 5.20, 109, 0, '2026-02-18 09:00:00'),
    ('Choc Chip Muesli Bars', 'Uncle Tobys', 4, '6 pack', 4.30, 69, 0, '2026-01-27 09:00:00'),
    ('Sea Salt Deli Chips', 'Red Rock Deli', 4, '165g', 4.30, 118, 1, '2026-04-25 09:00:00'),
    ('Ginger Beer', 'Bundaberg', 5, '4 x 375ml', 8.50, 62, 1, '2026-04-16 09:00:00'),
    ('Lemon Lime & Bitters', 'Bundaberg', 5, '4 x 375ml', 8.50, 115, 1, '2026-03-02 09:00:00'),
    ('Chocolate Malt Drink Powder', 'Milo', 5, '1kg', 9.00, 49, 0, '2026-08-09 09:00:00'),
    ('Classic Coffee Beans', 'Vittoria', 5, '1kg', 24.00, 89, 1, '2026-09-24 09:00:00'),
    ('Original Coffee Bags', 'Robert Timms', 5, '10 pack', 3.80, 62, 1, '2026-04-05 09:00:00'),
    ('Blue Label Tea Bags', 'Bushells', 5, '100 pack', 5.50, 7, 1, '2026-09-19 09:00:00'),
    ('English Breakfast Tea Bags', 'Madura', 5, '100 pack', 5.20, 40, 1, '2026-01-02 09:00:00'),
    ('Orange Juice No Added Sugar', 'Golden Circle', 5, '1L', 3.20, 64, 1, '2026-09-28 09:00:00'),
    ('Apple Juice', 'Golden Circle', 5, '1L', 3.00, 65, 1, '2026-03-03 09:00:00'),
    ('Raspberry Cordial', 'Cottee''s', 5, '1L', 3.60, 8, 1, '2026-04-22 09:00:00'),
    ('Spring Water', 'Mount Franklin', 5, '24 x 600ml', 12.00, 120, 1, '2026-04-19 09:00:00'),
    ('Creaming Soda', 'Kirks', 5, '1.25L', 2.50, 5, 1, '2026-02-20 09:00:00'),
    ('Lemon Soft Drink', 'Solo', 5, '1.25L', 3.10, 74, 1, '2026-09-19 09:00:00'),
    ('Chocolate Liquid Breakfast', 'Up&Go', 5, '3 x 250ml', 4.80, 33, 0, '2026-06-07 09:00:00'),
    ('Squeezed Orange Juice', 'Berri', 5, '2L', 5.20, 50, 1, '2026-05-05 09:00:00'),
    ('Short Cut Bacon Rashers', 'Primo', 6, '250g', 5.50, 118, 1, '2026-02-25 09:00:00'),
    ('Shaved Ham Off the Bone', 'Primo', 6, '100g', 3.20, 0, 1, '2026-02-20 09:00:00'),
    ('Chicken Breast Fillets', 'Steggles', 6, '1kg', 11.00, 27, 1, '2026-05-17 09:00:00'),
    ('Chicken Drumsticks', 'Inghams', 6, '1kg', 7.50, 44, 1, '2026-04-03 09:00:00'),
    ('Chicken Frankfurts', 'Hans', 6, '340g', 5.00, 20, 0, '2026-09-15 09:00:00'),
    ('Danish Salami Sliced', 'Hans', 6, '100g', 3.60, 78, 1, '2026-09-26 09:00:00'),
    ('Smoked Salmon Slices', 'Tassal', 6, '100g', 7.50, 0, 1, '2026-09-27 09:00:00'),
    ('Thick Beef Sausages', 'Coles', 6, '500g', 5.50, 84, 0, '2026-03-04 09:00:00'),
    ('Salmon Fillets Skin On', 'Tassal', 6, '2 pack', 12.00, 113, 1, '2026-09-04 09:00:00'),
    ('Traditional Meat Pies', 'Four''N Twenty', 7, '4 pack', 6.50, 36, 0, '2026-04-20 09:00:00'),
    ('Party Pies', 'Four''N Twenty', 7, '24 pack', 9.50, 26, 0, '2026-05-22 09:00:00'),
    ('Sausage Rolls', 'Four''N Twenty', 7, '6 pack', 6.80, 32, 0, '2026-01-28 09:00:00'),
    ('Paddle Pop Rainbow', 'Streets', 7, '8 pack', 7.50, 54, 1, '2026-05-27 09:00:00'),
    ('Original Drumstick Ice Cream Cones', 'Peters', 7, '4 pack', 6.50, 0, 0, '2026-03-11 09:00:00'),
    ('Creamy Classics Vanilla Ice Cream', 'Bulla', 7, '2L', 6.00, 33, 1, '2026-08-06 09:00:00'),
    ('Gourmet Vanilla Bean Ice Cream', 'Connoisseur', 7, '1L', 8.50, 54, 1, '2026-01-18 09:00:00'),
    ('Chicken Nuggets', 'Steggles', 7, '1kg', 9.50, 120, 0, '2026-03-23 09:00:00'),
    ('Magnum Classic Ice Cream', 'Streets', 7, '4 pack', 8.00, 106, 1, '2026-09-12 09:00:00'),
    ('Weet-Bix Original', 'Sanitarium', 8, '575g', 4.50, 16, 0, '2026-05-02 09:00:00'),
    ('Weet-Bix Original Family Pack', 'Sanitarium', 8, '1.1kg', 7.60, 119, 0, '2026-01-26 09:00:00'),
    ('Traditional Rolled Oats', 'Uncle Tobys', 8, '1kg', 4.40, 26, 0, '2026-04-22 09:00:00'),
    ('Vita Brits', 'Uncle Tobys', 8, '650g', 4.80, 45, 0, '2026-09-25 09:00:00'),
    ('Original Fruit Free Muesli', 'Carman''s', 8, '500g', 8.50, 52, 0, '2026-03-20 09:00:00'),
    ('Cheerios', 'Uncle Tobys', 8, '700g', 6.80, 30, 0, '2026-03-28 09:00:00'),
    ('Granola Honey Almond', 'Sanitarium', 8, '500g', 7.50, 103, 0, '2026-07-06 09:00:00'),
    ('Light n Tasty Oats Apple Cinnamon', 'Sanitarium', 8, '10 pack', 4.80, 0, 0, '2026-06-24 09:00:00'),
    ('Pink Lady Apples', 'Pink Lady', 9, '1kg', 6.50, 52, 1, '2026-04-26 09:00:00'),
    ('Cherry Tomatoes', 'Perfection Fresh', 9, '250g', 4.00, 100, 1, '2026-02-23 09:00:00'),
    ('Button Mushrooms', 'Costa', 9, '200g', 3.50, 4, 1, '2026-08-28 09:00:00'),
    ('Truss Tomatoes', 'Perfection Fresh', 9, '500g', 5.00, 104, 1, '2026-06-15 09:00:00'),
    ('Baby Spinach Leaves', 'Perfection Fresh', 9, '120g', 3.50, 101, 1, '2026-04-28 09:00:00'),
    ('Brown Onions', 'Perfection Fresh', 9, '1kg', 3.00, 84, 1, '2026-07-07 09:00:00'),
    ('Carrots', 'Perfection Fresh', 9, '1kg', 2.50, 110, 1, '2026-05-03 09:00:00'),
    ('Burnt Fig Jam', 'Maggie Beer', 3, '190g', 7.50, 65, 1, '2026-09-13 09:00:00'),
    ('Sliced Beetroot', 'Golden Circle', 3, '440g', 2.50, 3, 1, '2026-05-04 09:00:00'),
    ('Pineapple Slices in Juice', 'Golden Circle', 3, '439g', 2.50, 33, 1, '2026-02-02 09:00:00'),
    ('Tomato Paste', 'Leggo''s', 3, '140g', 2.00, 44, 1, '2026-06-24 09:00:00'),
    ('Pasta Sauce Tomato & Basil', 'Leggo''s', 3, '500g', 3.40, 65, 1, '2026-07-04 09:00:00'),
    ('Mild Curry Simmer Sauce', 'Masterfoods', 3, '500g', 4.00, 24, 0, '2026-01-09 09:00:00'),
    ('Light Olive Oil', 'Cobram Estate', 3, '750ml', 14.50, 0, 1, '2026-09-17 09:00:00'),
    ('Milk Chocolate Frogs', 'Haigh''s', 4, '200g', 12.00, 120, 1, '2026-04-24 09:00:00');
