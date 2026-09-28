create database guffishop;
use guffishop;

create table customers(
	customer_id int primary key auto_increment,
    name varchar(100),
    email varchar(150) unique,
    city varchar(50),
    signup_date date
);

create table products(
	product_id int primary key auto_increment,
    product_name varchar(100),
    category varchar(100),
    price decimal(10,2),
    stock int
);

create table orders(
	order_id int primary key auto_increment,
    customer_id int,
    order_date date,
    order_status varchar(30),
    Foreign key (customer_id) references customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    payment_mode VARCHAR(30),
    amount DECIMAL(10,2),
    payment_date DATE,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);
