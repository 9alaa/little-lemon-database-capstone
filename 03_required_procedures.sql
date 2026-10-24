USE LittleLemonDB;
DROP PROCEDURE IF EXISTS GetMaxQuantity;
DROP PROCEDURE IF EXISTS ManageBooking;
DROP PROCEDURE IF EXISTS UpdateBooking;
DROP PROCEDURE IF EXISTS AddBooking;
DROP PROCEDURE IF EXISTS CancelBooking;
DELIMITER //
CREATE PROCEDURE GetMaxQuantity()
BEGIN
 SELECT MAX(Quantity) AS MaxQuantity FROM OrderItems;
END //
CREATE PROCEDURE ManageBooking(IN booking_date DATE, IN table_number INT)
BEGIN
 SELECT IF(EXISTS(SELECT 1 FROM Bookings WHERE BookingDate=booking_date AND TableNumber=table_number AND BookingStatus <> 'Cancelled'),CONCAT('Table ',table_number,' is already booked'),CONCAT('Table ',table_number,' is available')) AS BookingStatus;
END //
CREATE PROCEDURE UpdateBooking(IN booking_id INT, IN new_date DATE)
BEGIN
 DECLARE current_table INT;
 DECLARE current_time TIME;
 SELECT TableNumber,BookingTime INTO current_table,current_time FROM Bookings WHERE BookingID=booking_id;
 IF current_table IS NULL THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Booking not found'; END IF;
 IF EXISTS(SELECT 1 FROM Bookings WHERE BookingDate=new_date AND TableNumber=current_table AND BookingTime=current_time AND BookingID<>booking_id AND BookingStatus<>'Cancelled') THEN
 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Booking slot already taken';
 END IF;
 UPDATE Bookings SET BookingDate=new_date WHERE BookingID=booking_id;
 SELECT CONCAT('Booking ',booking_id,' updated') AS Confirmation;
END //
CREATE PROCEDURE AddBooking(IN booking_id INT, IN customer_id INT, IN booking_date DATE, IN table_number INT)
BEGIN
 IF EXISTS(SELECT 1 FROM Bookings WHERE BookingDate=booking_date AND TableNumber=table_number AND BookingTime='12:00:00' AND BookingStatus<>'Cancelled') THEN
 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Table already booked for this time';
 END IF;
 INSERT INTO Bookings(BookingID,CustomerID,BookingDate,BookingTime,TableNumber,GuestCount,BookingStatus)
 VALUES(booking_id,customer_id,booking_date,'12:00:00',table_number,2,'Confirmed');
 SELECT CONCAT('Booking ',booking_id,' added') AS Confirmation;
END //
CREATE PROCEDURE CancelBooking(IN booking_id INT)
BEGIN
 UPDATE Bookings SET BookingStatus='Cancelled' WHERE BookingID=booking_id;
 SELECT CONCAT('Booking ',booking_id,' cancelled') AS Confirmation;
END //
DELIMITER ;
