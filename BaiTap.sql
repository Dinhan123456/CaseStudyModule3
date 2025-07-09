CREATE DATABASE demo;

use demo;

CREATE TABLE products(
	id INT AUTO_INCREMENT PRIMARY KEY,
    productCode VARCHAR(50) UNIQUE,
    productName VARCHAR(100),
    productPrice DECIMAL(10,2),
    productAmount INT,
    productDescription TEXT,
    productStatus VARCHAR(20)
    );

INSERT INTO products (productCode, productName, productPrice, productAmount, productDescription, productStatus)
VALUE ('P001', 'Product A', 100.00, 10, 'Mô tả A', 'Available'), ('P002', 'Product B', 200.00, 5, 'Mô tả B', 'Out of stock'), ('P003', 'Product C', 150.00, 20, 'Mô tả C', 'Available');

CREATE UNIQUE INDEX idx_product_code ON products(productCode);

CREATE INDEX idx_name_price ON products(productName, productPrice);

 EXPLAIN SELECT * FROM products WHERE productName = 'Product A' and productPrice = 100.00;
 
 CREATE VIEW view_product_basic as SELECT productCode, productName, productPrice, productStatus FROM products;
  
 SELECT * FROM view_product_basic;

DELIMITER $$
CREATE PROCEDURE getAllProducts()
BEGIN
    SELECT * FROM Products;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE insertProduct(
    IN pCode VARCHAR(50),
    IN pName VARCHAR(100),
    IN pPrice DECIMAL(10,2),
    IN pAmount INT,
    IN pDesc TEXT,
    IN pStatus VARCHAR(20)
)
)
BEGIN
    INSERT INTO Products (productCode, productName, productPrice, productAmount, productDescription, productStatus)
    VALUES (pCode, pName, pPrice, pAmount, pDesc, pStatus);
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE getProductById(IN pId INT)
BEGIN
    SELECT * FROM Products WHERE id = pId;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE deleteProductById(IN pId INT)
BEGIN
    DELETE FROM Products WHERE id = pId;
END $$
DELIMITER ;

CALL getAllProducts();
CALL getProductById(1);
CALL deleteProductById(3);




 
 



    
    
    