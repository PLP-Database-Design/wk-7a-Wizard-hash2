-- 1NF Transformation in PostgreSQL
SELECT 
  OrderID,
  CustomerName,
  TRIM(product) AS Product
FROM (
  SELECT 
    OrderID, 
    CustomerName, 
    unnest(string_to_array(Products, ',')) AS product
  FROM ProductDetail
) AS normalized;


-- 2

-- Create Orders table (OrderID → CustomerName)
CREATE TABLE Orders (
  OrderID INT PRIMARY KEY,
  CustomerName VARCHAR(100)
);

-- Insert distinct orders
INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

-- Create OrderProducts table
CREATE TABLE OrderProducts (
  OrderID INT,
  Product VARCHAR(100),
  Quantity INT,
  PRIMARY KEY (OrderID, Product),
  FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Insert normalized data
INSERT INTO OrderProducts (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;
