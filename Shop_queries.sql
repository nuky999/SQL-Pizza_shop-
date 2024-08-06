-- Number of total sales

SELECT 
    COUNT(order_id) AS 'Total sales'
FROM
    orders;

-- All customer details who have placed orders

SELECT DISTINCT
    c.cust_id AS 'Customer ID',
    c.cust_firstname AS 'First name',
    c.cust_lastname AS 'Lat name'
FROM
    customer c
        JOIN
    orders o ON c.cust_id = o.cust_id;

-- Details of orders including customer name and delivery address

SELECT DISTINCT
    o.order_id AS 'Order ID',
    o.created_at 'Ordered on',
    c.cust_firstname AS 'First name',
    c.cust_lastname AS 'Last name',
    a.delivery_address AS 'Delivery address',
    a.delivery_city AS 'Delivery city',
    a.delivery_zipcode AS 'Zipcode'
FROM
    orders o
        JOIN
    customer c ON o.cust_id = c.cust_id
        JOIN
    address a ON o.address_id = a.address_id;

-- Total revenue from orders

SELECT 
    SUM(p.pizza_price * o.quantity) AS 'Total revenue'
FROM
    orders o
        JOIN
    pizza p ON o.pizza_id = p.pizza_id;	

-- Most sold pizzas

SELECT 
    p.pizza_name AS 'Pizza',
    SUM(o.quantity) AS 'Total quantity sold'
FROM
    orders o
        JOIN
    pizza p ON o.pizza_id = p.pizza_id
GROUP BY p.pizza_name
ORDER BY SUM(o.quantity) DESC;

-- Number of igredients for each pizza sold

SELECT 
    p.pizza_name AS 'Pizza Name',
    p.pizza_size AS 'Pizza Size',
    SUM(r.quantity) AS 'Total Number of Ingredients Needed'
FROM
    pizza p
        JOIN
    recipe r ON p.pizza_id = r.pizza_id
        JOIN
    orders o ON p.pizza_id = o.pizza_id
GROUP BY p.pizza_name , p.pizza_size;

-- Ingredients needed for each pizza with their name and price
SELECT 
    p.pizza_name AS 'Pizza Name',
    p.pizza_size AS 'Pizza Size',
    i.ing_name AS 'Ingredient Name',
    i.ing_price AS 'Ingredient Price',
    r.quantity AS 'Quantity Needed'
FROM
    pizza p
        JOIN
    recipe r ON p.pizza_id = r.pizza_id
        JOIN
    ingredient i ON r.ing_id = i.ing_id
ORDER BY p.pizza_name , p.pizza_size , i.ing_name;

-- Cost of each pizza being made and the return profit

WITH PizzaCost AS (
    SELECT p.pizza_id,
           p.pizza_name,
           p.pizza_size,
           SUM(i.ing_price * r.quantity) AS total_ingredient_cost
    FROM pizza p
    JOIN recipe r ON p.pizza_id = r.pizza_id
    JOIN ingredient i ON r.ing_id = i.ing_id
    GROUP BY p.pizza_id, p.pizza_name, p.pizza_size
),


DistinctOrders AS (
    SELECT DISTINCT o.order_id,
                    o.pizza_id,
                    o.quantity
    FROM orders o
)

SELECT 
    p.pizza_name AS 'Pizza Name',
    p.pizza_size AS 'Pizza Size',
    pc.total_ingredient_cost AS 'Total Ingredient Cost',
    p.pizza_price AS 'Pizza Price',
    (p.pizza_price - pc.total_ingredient_cost) AS 'Profit'
FROM
    DistinctOrders o
        JOIN
    pizza p ON o.pizza_id = p.pizza_id
        JOIN
    PizzaCost pc ON p.pizza_id = pc.pizza_id
ORDER BY p.pizza_name , p.pizza_size;