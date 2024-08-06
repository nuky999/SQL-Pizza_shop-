CREATE DATABASE PizzaShop;
USE PizzaShop;

CREATE TABLE customer(
cust_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
cust_firstname VARCHAR(50) NOT NULL,
cust_lastname VARCHAR(50) NOT NULL
);

CREATE TABLE address(
address_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
delivery_address VARCHAR(100) NOT NULL,
delivery_city VARCHAR(50) NOT NULL,
delivery_zipcode CHAR(5) NOT NULL
);

CREATE TABLE pizza(
pizza_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
pizza_name VARCHAR(50) NOT NULL,
pizza_size CHAR(5) NOT NULL,
pizza_price DECIMAL(5,2) NOT NULL
);

CREATE TABLE orders(
order_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL, 
order_name VARCHAR(10) NOT NULL, -- Order name (e.g. ORDER-001), same customer can have multiple orders that's why we need order_id
created_at DATETIME NOT NULL,
quantity INT NOT NULL, -- amount of pizzas ordered
cust_id INT NOT NULL,
FOREIGN KEY (cust_id) REFERENCES customer(cust_id),
address_id INT NOT NULL,
FOREIGN KEY (address_id) REFERENCES address(address_id),
pizza_id INT NOT NULL,
FOREIGN KEY (pizza_id) REFERENCES pizza(pizza_id)
);


-- With these tables the owner can determine the stock levels needed for each pizza
CREATE TABLE ingredient(
ing_id VARCHAR(10) PRIMARY KEY NOT NULL,
ing_name VARCHAR(100) NOT NULL,
ing_weight FLOAT NOT NULL,
ing_price DECIMAL(5,2) NOT NULL
);

CREATE TABLE recipe(
recipe_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
pizza_id INT NOT NULL,
FOREIGN KEY (pizza_id) REFERENCES pizza(pizza_id),
ing_id VARCHAR(10),
FOREIGN KEY (ing_id) REFERENCES ingredient(ing_id),
quantity INT NOT NULL
);

CREATE TABLE inventory(
inv_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
ing_id VARCHAR(10) NOT NULL,
FOREIGN KEY (ing_id) REFERENCES ingredient(ing_id),
quantity INT NOT NULL
);

INSERT INTO customer(cust_firstname,cust_lastname)
VALUES
  ("Clark Dillon","Bell Barker"),
  ("Jacqueline Cotton","Norman Rios"),
  ("Ivy Morrison","Alvin Joseph"),
  ("Magee Jensen","Hadassah Workman"),
  ("Charissa Mullins","Jack Perez");
  
  INSERT INTO address(delivery_address,delivery_city,delivery_zipcode)
VALUES
  ("Ap #713-7680 In St.","Patalillo","54232"),
  ("Ap #895-8543 Luctus. St.","Holmestrand","07671"),
  ("1761 Quisque Av.","Talara","38484"),
  ("9684 Cras Road","Ilesa","75432"),
  ("Ap #676-9054 Libero St.","Campos dos Goytacazes","75323");
  
  INSERT INTO pizza(pizza_name,pizza_size,pizza_price)
VALUES
  ("Margharita","M",10),
  ("Capricciosa","L",15),
  ("Prosciutto","S",7),
  ("Funghi","L",14),
  ("Margharita","L",14);
  
  INSERT INTO orders(order_name,created_at,quantity,cust_id,address_id,pizza_id)
VALUES
  ("OD-001","2024-03-22 14:44:32",2,1,1,1),
  ("OD-002","2024-03-22 15:44:32",1,2,2,2),
  ("OD-003","2024-03-22 14:44:32",3,3,3,3),
  ("OD-004","2024-03-22 14:44:32",2,4,4,4),
  ("OD-005","2024-03-22 14:44:32",4,5,5,5);
  
  
INSERT INTO ingredient(ing_id, ing_name, ing_weight, ing_price)
VALUES 
('ING001', 'Mozzarella Cheese', 0.25, 1.50),
('ING002', 'Tomato Sauce', 0.30, 0.75),
('ING003', 'Pepperoni', 0.20, 2.00),
('ING004', 'Mushrooms', 0.15, 1.25),
('ING005', 'Olives', 0.10, 1.00);

-- Insert dummy data into recipe table
INSERT INTO recipe (pizza_id, ing_id, quantity)
VALUES 
(1, 'ING001', 2), -- 2 units of Mozzarella Cheese for Pizza ID 1
(1, 'ING002', 1), -- 1 unit of Tomato Sauce for Pizza ID 1
(1, 'ING003', 3), -- 3 units of Pepperoni for Pizza ID 1
(2, 'ING001', 2), -- 2 units of Mozzarella Cheese for Pizza ID 2
(2, 'ING002', 1), -- 1 unit of Tomato Sauce for Pizza ID 2
(2, 'ING004', 1), -- 1 unit of Mushrooms for Pizza ID 2
(3, 'ING001', 2), -- 2 units of Mozzarella Cheese for Pizza ID 3
(3, 'ING002', 1), -- 1 unit of Tomato Sauce for Pizza ID 3
(3, 'ING005', 2); -- 2 units of Olives for Pizza ID 3

-- Insert dummy data into inventory table
INSERT INTO inventory (ing_id, quantity)
VALUES 
('ING001', 100), -- 100 units of Mozzarella Cheese in stock
('ING002', 200), -- 200 units of Tomato Sauce in stock
('ING003', 150), -- 150 units of Pepperoni in stock
('ING004', 120), -- 120 units of Mushrooms in stock
('ING005', 130); -- 130 units of Olives in stock

  
  