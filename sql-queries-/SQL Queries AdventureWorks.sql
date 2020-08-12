USE AdventureWorks2012
GO

--\ businessentityID is a primary key here and a foreign key in person.person; can use this for joins --\ 
SELECT JobTitle, Gender, HireDate, BusinessEntityID
FROM HumanResources.Employee
	WHERE JobTitle = 'Design Engineer' 
	AND gender = 'F' 
	AND HireDate >= '2000-JAN-01';


SELECT BusinessEntityID, Jobtitle, VacationHours
FROM HumanResources.Employee 
	WHERE VacationHours > 80 
	OR BusinessEntityID <=50

	
--\ This is selecting vacation hours of certain employees 
SELECT BusinessEntityID, Jobtitle, VacationHours
FROM HumanResources.Employee 
WHERE VacationHours BETWEEN 75 AND 100
ORDER BY VacationHours DESC


--\ selects all females in the department 
SELECT BusinessEntityID, Jobtitle, Gender
FROM HumanResources.Employee
WHERE NOT Gender ='M'


--\ a basic union
SELECT BusinessEntityID, Jobtitle, HireDate
FROM HumanResources.Employee
WHERE JobTitle = 'Design Engineer' 
UNION
SELECT BusinessEntityid, Jobtitle, HireDate 
FROM HumanResources.Employee
WHERE HireDate BETWEEN '2005-05-01' AND '2005-12-31'


--\ a basic intersection 
SELECT ProductID 
FROM Production.Product
INTERSECT
SELECT ProductID 
FROM Production.WorkOrder
ORDER BY ProductID


--\ a look into joins 
SELECT * FROM Production.Product ORDER BY ProductID
SELECT * FROM Production.WorkOrder ORDER BY ProductID
SELECT * FROM Production.Product Inner Join Production.WorkOrder on Production.Product.ProductID=Production.WorkOrder.ProductID ORDER BY Production.Product.ProductID


SELECT COUNT (DISTINCT SalesOrderID) AS UniqueOrders,
AVG(UnitPrice) AS Avg_UnitPrice, 
MIN(OrderQty)AS Min_OrderQty,
MAX(LineTotal) AS Max_LineTotal
FROM Sales.SalesOrderDetail

--\ modifying the production unitmeasure table 
UPDATE Production.UnitMeasure
SET Name = 'Square Feet' 
WHERE Production.UnitMeasure.UnitMeasureCode = 'FT2'


INSERT INTO Production.UnitMeasure
VALUES (N'FT2', N'Square Feet', GetDate()), 
(N'Y', N'Yards', GetDate()), 
(N'Y3', N'Cubic Yards', GetDate())


UPDATE Sales.SalesPerson
SET Bonus = 6000, CommissionPct = 0.10, SalesQuota = NULL 
WHERE sales.SalesPerson.BusinessEntityID = 289; 


DELETE FROM Production.UnitMeasure
WHERE Production.UnitMeasure.Name = 'Feet' 


DELETE FROM Sales.SalesPersonQuotaHistory
