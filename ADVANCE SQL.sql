 SET SQL_SAFE_UPDATES = 0;
   use practice;
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
FOREIGN KEY (ProductID) REFERENCES Products(ProductID));

INSERT INTO Products VALUES
(1, 'Keyboard', 'Electronics', 1200),
(2, 'Mouse', 'Electronics', 800),
(3, 'Chair', 'Furniture', 2500),
(4, 'Desk', 'Furniture', 5500);

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    Quantity INT,
    SaleDate DATE
);

INSERT INTO Sales VALUES
(1, 1, 4, '2024-01-05'),
(2, 2, 10, '2024-01-06'),
(3, 3, 2, '2024-01-10'),
(4, 4, 1, '2024-01-11');

SELECT * FROM PRODUCTS;
SELECT * FROM SALES;

### Q6 Write a CTE to calculate the total revenue for each product  
####(Revenues = Price × Quantity), and return only products where  revenue > 3000

WITH REVENUE_TABLE AS (SELECT P.PRODUCTID,PRODUCTNAME,CATEGORY, 
SUM(P.PRICE * S.QUANTITY) AS REVENUE FROM PRODUCTS P
JOIN SALES S ON
S.PRODUCTID = P.PRODUCTID
GROUP BY P.PRODUCTID,PRODUCTNAME)
SELECT * FROM REVENUE_TABLE
 WHERE REVENUE > 3000;
 
 ### Q7 Create a view named that shows:
 ### Category, TotalProducts, AveragePrice.
 
 CREATE VIEW CAT_TP_AVG AS
 SELECT Category, SUM(QUANTITY) AS TotalProducts, ROUND(AVG(PRICE),0) AS AveragePrice FROM PRODUCTS P
 INNER JOIN SALES S
 ON S.PRODUCTID = P.PRODUCTID
GROUP BY CATEGORY;
 
SELECT * FROM CAT_TP_AVG;

### Q8 Create an updatable view containing ProductID, ProductName, and Price.
 ## Then update the price of ProductID = 1 using the view.

   CREATE VIEW UPDATE_VIEW AS
   SELECT ProductID, ProductName, Price FROM PRODUCTS;

   SELECT * FROM UPDATE_VIEW;
   
   UPDATE UPDATE_VIEW
   SET PRICE = 1500.00
   WHERE PRODUCTID = 1;

##Q9. Create a stored procedure that accepts a category name and returns all products belonging to that
##category.

DELIMITER //

CREATE PROCEDURE CATE_WISE(IN CATE_NAME VARCHAR(50))
BEGIN
SELECT * FROM PRODUCTS
WHERE CATEGORY = CATE_NAME ;
END //

DELIMITER ;

CALL CATE_WISE("ELECTRONICS");

###Create an AFTER DELETE trigger on the PRODUCTS table that archives deleted product rows into a new
##table PRODUCTARCHIVE. The archive should store ProductID, ProductName, Category, Price, and DeletedAt
##timestamp.

CREATE TABLE ProductArchive (
    ProductID INT,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    DeletedAt TIMESTAMP );
    
    DELIMITER $$
    
    CREATE TRIGGER  After_Product_Delete
    AFTER DELETE ON PRODUCTS
    FOR EACH ROW
    BEGIN
       INSERT INTO ProductArchive(ProductID,
       ProductName, 
       Category,
       Price, 
       DeletedAt)
       VALUES (old.ProductID, old.ProductName, old.Category, old.Price, NOW());
        END $$
        
        
            
             
             delete from products 
             where category = 'furniture';
           
     
select * from products;
    
              select * from productarchive;
    
    
    
    
    
    
    
    
    
    