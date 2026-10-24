USE LittleLemonDB;

CALL GetMaxQuantity();

CALL ManageBooking('2022-12-10', 98);
CALL ManageBooking('2022-12-10', 98);

CALL AddBooking(99, 99, 99, '2022-12-10');

CALL UpdateBooking(99, '2022-01-10');

CALL CancelBooking(99);

SELECT * FROM Bookings WHERE TableNumber = 99;
