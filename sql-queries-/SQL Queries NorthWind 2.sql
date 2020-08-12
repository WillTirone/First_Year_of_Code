USE NORTHWND

--\ adds a column and allows value to be null; NOT NULL would not allow this, like in a primary key
ALTER TABLE Employees 
ADD FavoriteColor VARCHAR(50) NULL; 

/* creating a table; the IDENTITY(1,1) PRIMARY KEY tells SQL Server that 
this is an auto-generated ID and will move in increments of 1 */
CREATE TABLE [New Products] (
	NewProductID int IDENTITY(1,1) PRIMARY KEY, 
	ProductName varchar(255) NULL, 
	ProductType varchar(255) NULL, 
	FactoryLocation varchar(255) NULL, 
	ProductionDate date 
) 

/* notice that we do not have to insert the ID number because it will do it for us due 
to the primary key being auto-incrementing */
INSERT INTO [New Products] (ProductName, ProductType, FactoryLocation, ProductionDate) 
	VALUES ('BMW x9', 'Sports Car', 'Munich', '2018-8-16'),
		('BMW i7', 'Sports Car', 'Munich', '2018-8-16'), 
		('BMW x8', 'Sports Car', 'Munich', '2018-8-16')

--\ aliases the column heading 
SELECT LastName AS [Candy Bars]
FROM Employees 
WHERE LastName = 'Davolio'

--\ averages unit price 
SELECT AVG(UnitPrice)
FROM [Order Details]

--\ counts the 9 employees in the table
SELECT COUNT(EmployeeID)
FROM Employees

/*what if we wanted to select the product with the highest price?
this says select the row from products where the unit price is equal to the subquery */
SELECT * 
FROM Products
WHERE UnitPrice IN (SELECT MAX(UnitPrice) FROM Products)


/* this is the same as the "greater than average price" view; we want to know where the unitprice is > the avg. price;
SELECT TOP 10 is MS SQL's way of doing a limit */ 
SELECT TOP 10*
FROM Products 
WHERE UnitPrice > (SELECT AVG(UnitPrice) FROM products) 
ORDER BY UnitPrice DESC 

--\ what if we just wanted the highest unit price? 
SELECT MAX(UnitPrice)
FROM Products 

/* what about the 2nd highest? --> fairly common interview question. 
We want to select the MAX salary first but then we want it to maximize everything 
that isn't the actual highest; NOT IN means not equal to */ 
SELECT MAX(UnitPrice) 
FROM Products 
WHERE UnitPrice NOT IN (SELECT MAX(UnitPrice) FROM Products) 

/* select a range of products based on ID */
SELECT * 
FROM Products 
WHERE ProductID BETWEEN 60 AND 70; 

/* what if we wanted to find the name of the supplier of the most expensive product? 
We have to join the two tables while including the condition that it must be included 
in the max function*/ 
SELECT p.ProductID, p.ProductName, s.CompanyName, p.UnitPrice
FROM Products p INNER JOIN Suppliers s ON (p.SupplierID = s.SupplierID) 
WHERE UnitPrice IN (SELECT MAX(UnitPrice) FROM Products); 


--\ this will select anything that does not have the lowest price; this is the ANY and ALL function Stanford video
--\ result is returned if there is ANY unitprice that is less than some other unit price
SELECT ProductID, ProductName, UnitPrice
FROM Products 
WHERE UnitPrice > ANY (SELECT UnitPrice FROM Products)

--\ Subselects

/* This is a subselect clause under a FROM; instead of having to write that multiplication a bunch of times
we can nest it. Also usese NULLIF(column, 0) which nulls a selection if it is 0 to avoid divide by zero errors */
SELECT * 
FROM (SELECT ProductID, ProductName, UnitPrice, 100*(UnitsInStock/NULLIF(UnitsOnOrder, 0)) AS ratio
FROM Products) P
WHERE p.ratio > 1


----\ JOINS 

/* earlier we saw this...*/
SELECT DISTINCT ProductName, UnitPrice, City
FROM Products p, Suppliers s
WHERE p.SupplierID = s.SupplierID

/* which is equivalent to...*/

SELECT DISTINCT ProductName, UnitPrice, City
FROM Products p inner join Suppliers s
ON p.SupplierID = s.SupplierID


--/ GROUP BY is only used with aggregate functions; it "groups" the averages of the unitprices by categoryID --/
SELECT AVG(UnitPrice), CategoryID
FROM Products 
GROUP BY CategoryID

SELECT SUM(UnitPrice), CategoryID
FROM Products 
GROUP BY CategoryID
