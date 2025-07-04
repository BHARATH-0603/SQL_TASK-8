--  Stored Procedure: Get Orders by Customer
DELIMITER //

CREATE PROCEDURE GetOrdersByCustomer(IN cust_id INT)
BEGIN
    SELECT o.order_id, o.order_date
    FROM orders o
    WHERE o.customer_id = cust_id;
END //

DELIMITER ;

CALL GetOrdersByCustomer(101);


-- Stored Procedure (with OUT parameter): Count Orders for a Customer
DELIMITER //

CREATE PROCEDURE CountCustomerOrders(IN cust_id INT, OUT order_count INT)
BEGIN
    SELECT COUNT(*) INTO order_count
    FROM orders
    WHERE customer_id = cust_id;
END //

DELIMITER ;

CALL CountCustomerOrders(101, @orderCount);
SELECT @orderCount;
	
    
    
--  Function: Calculate Total Amount for a Specific Order
DELIMITER //

CREATE FUNCTION GetOrderTotal(ord_id INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT SUM(quantity * Unitprice) INTO total
    FROM online_retail
    WHERE customerID = ord_id;
    
    RETURN total;
END //

DELIMITER ;

SELECT GetOrderTotal(102); 



--  Function: Check Stock Availability of a Product
DELIMITER //

CREATE FUNCTION IsProductInStock(prod_id INT)
RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
    DECLARE stock_quantity INT;
    SELECT stock_quantity INTO stock_quantity FROM products WHERE product_id = prod_id;
    
    IF stock_quantity > 0 THEN
        RETURN 'In Stock';
    ELSE
        RETURN 'Out of Stock';
    END IF;
END //

DELIMITER ;

SELECT IsProductInStock(1);



-- Function to Return Customer Full Name
DELIMITER //

CREATE FUNCTION GetCustomerName(cust_id INT)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE full_name VARCHAR(100);
    SELECT full_name INTO full_name FROM customers WHERE customer_id = cust_id;
    RETURN full_name;
END //

DELIMITER ;

SELECT GetCustomerName(1) ;



