USE LittleLemonDB;
-- Tableau-ready line item view; export result as CSV in Workbench.
CREATE OR REPLACE VIEW SalesReport AS
SELECT o.OrderID,o.OrderDate,c.CustomerName,m.ItemName,m.Category,oi.Quantity,oi.UnitPrice,ROUND(oi.Quantity*oi.UnitPrice,2) AS Revenue
FROM Orders o JOIN Customers c ON c.CustomerID=o.CustomerID JOIN OrderItems oi ON oi.OrderID=o.OrderID JOIN MenuItems m ON m.MenuItemID=oi.MenuItemID
WHERE o.OrderStatus='Completed';
SELECT * FROM SalesReport ORDER BY OrderDate,OrderID;
SELECT Category,SUM(Revenue) AS TotalRevenue FROM SalesReport GROUP BY Category ORDER BY TotalRevenue DESC;
SELECT OrderDate,SUM(Revenue) AS DailyRevenue FROM SalesReport GROUP BY OrderDate ORDER BY OrderDate;
SELECT CustomerName,SUM(Revenue) AS CustomerRevenue FROM SalesReport GROUP BY CustomerName ORDER BY CustomerRevenue DESC;
