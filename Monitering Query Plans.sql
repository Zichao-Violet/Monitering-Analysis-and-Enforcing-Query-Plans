--TCSS 564 Project Part 1
--Author: Zichao Zhang
--UWnetID: 2076179

--Schema 1: Inner join columns from two tables without CI or NCI.

--Schema 2: Inner join columns from two tables while setting OrderID as CI
--Drop CI OrderID
CREATE CLUSTERED INDEX PK_Orders_OrderID 
	ON Orders(OrderID);
GO
DROP INDEX PK_Orders_OrderID
	ON Orders;
GO

--Schema 3: Inner join columns from two tables while setting Customers.CustomerID as CI
--Drop CI Customers.CustomerID
CREATE CLUSTERED INDEX PK_Customers_CustomerID 
	ON Customers(CustomerID);
GO
DROP INDEX PK_Customers_CustomerID
	ON Customers;
GO

--Schema 4: Inner join columns from two tables while setting Orders.CustomerID as CI
--Drop CI Orders.CustomerID
CREATE CLUSTERED INDEX PK_Orders_CustomerID 
	ON Orders(CustomerID);
GO
DROP INDEX PK_Orders_CustomerID
	ON Orders;
GO

--Schema 5: Inner join columns from two tables while setting Customers.ContactName as CI
--Drop CI Customers.ContactName
CREATE CLUSTERED INDEX PK_Customers_ContactName 
	ON Customers(ContactName);
GO
DROP INDEX PK_Customers_ContactName
	ON Customers;
GO

--Schema 6: Inner join columns from two tables while setting Customers.CustomerID as NCI
--Drop NCI Customers.CustomerID
CREATE NONCLUSTERED INDEX IX_Customers_CustomerID 
	ON Customers(CustomerID);
GO
DROP INDEX IX_Customers_CustomerID
	ON Customers;
GO

--Schema 7: Inner join columns from two tables while setting Orders.CustomerID as NCI
--Drop NCI Orders.CustomerID
CREATE NONCLUSTERED INDEX IX_Orders_CustomerID 
	ON Orders(CustomerID);
GO
DROP INDEX IX_Orders_CustomerID
	ON Orders;
GO

--Schema 8: Inner join columns from two tables while setting Customers.ContactName as NCI
--Drop NCI Customers.ContactName
CREATE NONCLUSTERED INDEX IX_Customers_ContactName 
	ON Customers(ContactName);
GO
DROP INDEX IX_Customers_ContactName
	ON Customers;
GO

--Schema 9: Inner join columns from two tables while setting Orders.OrderID as NCI
--Drop NCI Orders.OrderID
CREATE NONCLUSTERED INDEX IX_Orders_OrderID 
	ON Orders(OrderID);
GO
DROP INDEX IX_Orders_OrderID
	ON Orders;
GO

--Execution and show actual execution time
Set statistics time on
SELECT Customers.ContactName, Orders.OrderID
	FROM Customers
	INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
	WHERE Orders.OrderID > 10260
	ORDER by Customers.ContactName
set statistics time off	