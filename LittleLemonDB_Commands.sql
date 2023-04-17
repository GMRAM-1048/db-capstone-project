USE littlelemondb;

CREATE VIEW OrdersView AS
SELECT Order_ID, Quantity, Total_Cost
FROM Orders
WHERE Quantity >= 2;

Select * from OrdersView;

CREATE VIEW FourTablesView AS
SELECT Client_ID, Client_Name, Order_ID, Total_Cost,
Menu_Name, MenuItems_Name
FROM Orders INNER JOIN Clients
ON Client_ID = O_Client_ID
INNER JOIN Menus
ON O_Menu_ID = Menu_ID
INNER JOIN Menuitems
ON MenuItems_ID = M_MenuItem_ID
WHERE Total_Cost >= 150;

Select * from FourTablesView;

CREATE VIEW AnyView AS
SELECT MenuItems_Name
FROM Menuitems
WHERE MenuItems_ID = ANY(
SELECT M_MenuItem_ID FROM Menus INNER JOIN Orders ON M_MenuItem_ID = MenuItems_ID WHERE Quantity >= 2);

Select * from AnyView;

DELIMITER //

CREATE PROCEDURE GetMaxQuantity()
BEGIN
SELECT MAX(Quantity) AS 'Max Quantity In Orders' FROM Orders;
END //

DELIMITER ;

CALL GetMaxQuantity();

PREPARE GetOrderDetail FROM 'SELECT Order_ID, Quantity, Total_Cost FROM Orders WHERE Order_ID = ?';

SET @id = 1;
EXECUTE GetOrderDetail USING @id;

DELIMITER //

CREATE PROCEDURE CancelOrder(IN parameter INT)
BEGIN
DELETE FROM Orders WHERE Order_ID = parameter;
END //

DELIMITER ;

CALL CancelOrder(5);