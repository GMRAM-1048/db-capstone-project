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

INSERT INTO Clients (Client_ID, Client_Name, ContactNumber)
VALUES (1, 'John', '066666'), (2, 'JACK', '06626262'), (3, 'SAM', '07666666');

INSERT INTO Bookings (Booking_ID, Booking_Date, TableNum, B_Client_ID)
VALUES (1, '2022-10-10', 5, 1), (2, '2022-11-12', 3, 3), (3, '2022-10-11', 2, 2), (4, '2022-10-13', 2, 1);

SELECT * FROM Bookings;

SELECT EXISTS ( SELECT 1 FROM Bookings WHERE TableNum = 3 );

DELIMITER //

CREATE PROCEDURE CheckBooking(IN da DATE, IN num INT)
BEGIN
    IF EXISTS (SELECT Booking_ID FROM Bookings WHERE TableNum = num AND Booking_Date = da) THEN
        SELECT CONCAT('Table ', num, ' is booked') AS Status;
    ELSE
        SELECT CONCAT('Table ', num, ' is free') AS Status;
    END IF;
END //


DELIMITER ;

CALL CheckBooking("2022-11-12", 2);

CALL CheckBooking("2022-11-12", 3);

DELIMITER //

CREATE PROCEDURE AddValidBooking(IN da DATE, IN num INT)
BEGIN
	DECLARE v_count INT;
    DECLARE id INT;
    SELECT MAX(Booking_ID)+1 INTO id FROM bookings;
    START TRANSACTION;
		INSERT INTO Bookings (Booking_ID, Booking_Date, TableNum, B_Client_ID) VALUES (id, da, num, 2);
		SELECT COUNT(*) INTO v_count FROM bookings WHERE Booking_Date = da AND TableNum = num;
        IF v_count > 1 THEN
			SELECT CONCAT("Table ", num, " is already booked - booking cancelled") AS "Booking Status";
            ROLLBACK;
		ELSE
			SELECT CONCAT("Table ", num, " is booked - booking validated") AS "Booking Status";
            COMMIT;
		END IF;
END //

DELIMITER ;

CALL AddValidBooking("2022-11-12", 7);

DELIMITER //

CREATE PROCEDURE AddBooking(IN id INT, IN da DATE, IN num INT, IN C_ID INT)
BEGIN
	DECLARE v_count INT;
    START TRANSACTION;
		INSERT INTO Bookings (Booking_ID, Booking_Date, TableNum, B_Client_ID) VALUES (id, da, num, C_ID);
		SELECT COUNT(*) INTO v_count FROM bookings WHERE Booking_Date = da AND TableNum = num;
        IF v_count > 1 THEN
			BEGIN
				SELECT CONCAT("Table ", num, " is already booked - booking cancelled") AS "Booking Status";
				ROLLBACK;
			END;
        ELSE
			BEGIN
				SELECT CONCAT("Table ", num, " is booked - booking validated") AS "Booking Status";
				COMMIT;
			END;
        END IF;
END //

DELIMITER ;

CALL AddBooking(8,"2022-11-11", 7, 2);

DELIMITER //

CREATE PROCEDURE UpdateBooking(IN id INT, IN da DATE)
BEGIN
	DECLARE v_count INT;
    DECLARE num INT;
    SELECT TableNum INTO num FROM Bookings WHERE Booking_ID = id;
    START TRANSACTION;
		UPDATE Bookings SET Booking_Date = da WHERE Booking_ID = id;
		SELECT COUNT(Booking_ID) INTO v_count FROM bookings WHERE Booking_Date = da AND TableNum = num;
        IF v_count > 1 THEN
            BEGIN
				SELECT CONCAT("Table ", num, " is already booked - Update cancelled") AS "Update Status";
                ROLLBACK;
			END;
        ELSE
			BEGIN
				SELECT CONCAT("Table ", num, " is booked - Update validated") AS "Update Status 2";
                COMMIT;
			END;
        END IF;
END //

DELIMITER ;

CALL UpdateBooking(8, "2022-11-12");

DELIMITER //

CREATE PROCEDURE CancelBooking(IN id INT)
BEGIN
	DELETE FROM Bookings WHERE Booking_ID = id;
END //

DELIMITER ;

CALL CancelBooking(8);