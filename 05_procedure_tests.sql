USE LittleLemonDB;
CALL GetMaxQuantity();
CALL ManageBooking('2026-10-20',1);
CALL AddBooking(900,1,'2026-12-01',7);
CALL UpdateBooking(900,'2026-12-02');
CALL CancelBooking(900);
SELECT * FROM Bookings WHERE BookingID=900;
