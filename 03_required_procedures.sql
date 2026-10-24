USE LittleLemonDB;

DROP PROCEDURE IF EXISTS GetMaxQuantity;
DROP PROCEDURE IF EXISTS ManageBooking;
DROP PROCEDURE IF EXISTS AddBooking;
DROP PROCEDURE IF EXISTS UpdateBooking;
DROP PROCEDURE IF EXISTS CancelBooking;

DELIMITER //

CREATE PROCEDURE GetMaxQuantity()
BEGIN
    SELECT MAX(Quantity) AS MaxQuantity
    FROM OrderItems;
END //

CREATE PROCEDURE ManageBooking(
    IN p_date DATE,
    IN p_table INT
)
BEGIN
    DECLARE v_customer INT;

    IF EXISTS (
        SELECT 1 FROM Bookings
        WHERE BookingDate = p_date
        AND TableNumber = p_table
        AND BookingStatus <> 'Cancelled'
    ) THEN
        SELECT CONCAT(
            'Table ', p_table,
            ' is already booked'
        ) AS BookingStatus;
    ELSE
        SELECT MIN(CustomerID)
        INTO v_customer
        FROM Customers;

        INSERT INTO Bookings(
            BookingDate, BookingTime,
            TableNumber, CustomerID,
            GuestCount, BookingStatus
        )
        VALUES (
            p_date, '12:00:00',
            p_table, v_customer,
            2, 'Confirmed'
        );

        SELECT CONCAT(
            'Table ', p_table,
            ' booked successfully'
        ) AS BookingStatus;
    END IF;
END //

CREATE PROCEDURE AddBooking(
    IN p_booking INT,
    IN p_customer INT,
    IN p_table INT,
    IN p_date DATE
)
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM Customers
        WHERE CustomerID = p_customer
    ) THEN
        INSERT INTO Customers(
            CustomerID, CustomerName
        )
        VALUES (
            p_customer,
            CONCAT('Customer ', p_customer)
        );
    END IF;

    INSERT INTO Bookings(
        BookingID, CustomerID,
        BookingDate, BookingTime,
        TableNumber, GuestCount,
        BookingStatus
    )
    VALUES (
        p_booking, p_customer,
        p_date, '12:00:00',
        p_table, 2, 'Confirmed'
    );

    SELECT CONCAT(
        'New booking added. Booking ID: ',
        p_booking
    ) AS Confirmation;
END //

CREATE PROCEDURE UpdateBooking(
    IN p_table INT,
    IN p_date DATE
)
BEGIN
    DECLARE v_booking INT DEFAULT NULL;

    SELECT MAX(BookingID)
    INTO v_booking
    FROM Bookings
    WHERE TableNumber = p_table
    AND BookingStatus <> 'Cancelled';

    IF v_booking IS NOT NULL THEN
        UPDATE Bookings
        SET BookingDate = p_date
        WHERE BookingID = v_booking;

        SELECT CONCAT(
            'Booking ', v_booking,
            ' updated'
        ) AS Confirmation;
    ELSE
        SELECT 'Booking not found'
        AS Confirmation;
    END IF;
END //

CREATE PROCEDURE CancelBooking(
    IN p_table INT
)
BEGIN
    DECLARE v_booking INT DEFAULT NULL;

    SELECT MAX(BookingID)
    INTO v_booking
    FROM Bookings
    WHERE TableNumber = p_table
    AND BookingStatus <> 'Cancelled';

    IF v_booking IS NOT NULL THEN
        UPDATE Bookings
        SET BookingStatus = 'Cancelled'
        WHERE BookingID = v_booking;

        SELECT CONCAT(
            'Booking ', v_booking,
            ' cancelled'
        ) AS Confirmation;
    ELSE
        SELECT 'Booking not found'
        AS Confirmation;
    END IF;
END //

DELIMITER ;
