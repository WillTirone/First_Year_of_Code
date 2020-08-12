USE NORTHWND

SELECT * FROM dbo.EmployeeTerritories
SELECT * FROM dbo.Employees

/* this is joining the two tables to figure out which employee covers territoryID 53404
can do this as a join or as a subquery WHERE clause */
SELECT DISTINCT E.EmployeeID, TerritoryID, LastName, FirstName
FROM dbo.Employees E, dbo.EmployeeTerritories ET
WHERE E.EmployeeID = ET.EmployeeID AND TerritoryID = 53404; 

--\ Selecting everyone who is JUST a sales rep; this is a self join
SELECT LastName, Firstname, Title
FROM dbo.Employees E1
WHERE EXISTS (SELECT * FROM dbo.Employees E2 
			 WHERE E1.Title = E2.Title AND E1.firstname <> E2.firstname)

--\ initial query to get an idea for how these are going to be joined 
SELECT * FROM dbo.Products
SELECT * FROM dbo.[Order Details]

/* this is selecting distinct columns from both tables where the p.ProductID matches the order details table 
where the order quantity is on either side of 13 or 17 (eliminating 15 quantity orders)
or can write AND NOT p.ProductID IN on 4th line, both are equivalent */ 
SELECT DISTINCT p.ProductID, ProductName, p.UnitPrice, Quantity
FROM dbo.Products p, dbo.[Order Details]
WHERE p.ProductID IN (SELECT ProductID FROM dbo.[Order Details] WHERE QUANTITY BETWEEN 0 AND 20)
AND p.ProductID NOT IN (SELECT ProductID FROM dbo.[Order Details] WHERE QUANTITY BETWEEN 13 AND 17)
ORDER BY Quantity ASC


/*instead of using a MAX operator, we can write the same thing using subqueries
we're finding * from products such that there does not exist a price that is higher, effectively, a max */
SELECT ProductName, UnitPrice 
FROM Products P1
WHERE NOT EXISTS (SELECT * FROM Products P2 WHERE P2.UnitPrice > P1.Unitprice); 

/*instead of checking whether something is IN or NOT IN the result, we're checking if a value 
has a certain relationship with all results of the subquery
this is another MAX; if the UnitPrice is >= ALL from the subquery, then it's effectively the max of the table */
SELECT productname, unitprice 
FROM Products 
WHERE UnitPrice >= all (select UnitPrice from products) 
