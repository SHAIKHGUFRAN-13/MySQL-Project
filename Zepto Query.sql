create database Zepto;

use Zepto;

CREATE TABLE product (
    sku_id INT AUTO_INCREMENT PRIMARY KEY,
    category VARCHAR(100),
    name VARCHAR(100) NOT NULL,
    mrp NUMERIC(8,2),
    discountPercent NUMERIC(5,2),
    availableQuantity INTEGER,
    discountSellingprice NUMERIC(8,2),
    weightinGms INTEGER,
    outofstock BOOLEAN,
    quantity INTEGER
);

SET GLOBAL local_infile = 1;

LOAD DATA LOCAL INFILE 'C:/Users/MY PC/OneDrive/Desktop/MY APPS/Data Analysis/codewithharry/SQL (My sql)/PROJECTS/ZEPTO E-Commerce/zepto_v2.csv'
INTO TABLE product
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(
    category,
    name,
    mrp,
    discountPercent,
    availableQuantity,
    discountSellingprice,
    weightinGms,
    outofstock,
    quantity
);

select * from product;

select count(*) from product;

-- Null value check
select * from product where name is null;

-- different product category
select  distinct category from product order by category ;

-- home many product in stock and how many how stock
select outofstock, count(sku_id) from product group by outofstock;

---- data cleaning 
---- see price and discountsellingprice
select * from product where mrp =0 or discountsellingprice=0;

delete from product where sku_id = 3607;

-- data analysis
-- Q1. Find the top 10 best-value products based on the discount percentage.
SELECT DISTINCT name, mrp, discountPercent
FROM product
ORDER BY discountPercent DESC
LIMIT 10;

-- Q2.What are the Products with High MRP but Out of Stock

SELECT DISTINCT name,mrp
FROM product
WHERE outOfStock = TRUE and mrp > 300
ORDER BY mrp DESC;

-- Q3.Calculate Estimated Revenue for each category
SELECT category,
SUM(discountSellingprice * availableQuantity) AS total_revenue
FROM product
GROUP BY category
ORDER BY total_revenue;


-- Q4. Find all products where MRP is greater than ₹500 and discount is less than 10%.

SELECT DISTINCT name, mrp, discountPercent
FROM product
WHERE mrp > 500 AND discountPercent < 10
ORDER BY mrp DESC, discountPercent DESC;


-- Q5. Identify the top 5 categories offering the highest average discount percentage.

SELECT category,
ROUND(AVG(discountPercent),2) AS avg_discount
FROM product
GROUP BY category
ORDER BY avg_discount DESC
LIMIT 5;

-- Q6. Find the price per gram for products above 100g and sort by best value.

SELECT DISTINCT name, weightInGms, discountSellingprice,
ROUND(discountSellingprice/weightInGms,2) AS price_per_gram
FROM product
WHERE weightInGms >= 100
ORDER BY price_per_gram;

-- Q7.Group the products into categories like Low, Medium, Bulk.
SELECT DISTINCT name, weightInGms,
CASE WHEN weightInGms < 1000 THEN 'Low'
	WHEN weightInGms < 5000 THEN 'Medium'
	ELSE 'Bulk'
	END AS weight_category
FROM product;

-- Q8.What is the Total Inventory Weight Per Category 

SELECT category,
SUM(weightInGms * availableQuantity) AS total_weight
FROM product
GROUP BY category
ORDER BY total_weight;

