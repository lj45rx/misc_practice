/*
CTE
Common table expression

somethimes called "with-queries"

named temporary result set
kept in memory
exists only in scope of current query
similar to a subquery
*/


/* WITH CTE_Employee AS (SELECT_QUERY) */
/* using the following query*/
SELECT FirstName, LastName, Gender, Salary,
	COUNT(Gender) OVER (PARTITION BY Gender) as TotalGender,
	AVG(Salary) OVER (PARTITION BY Gender) as AvgSalary
FROM SQLTutorial.dbo.EmployeeDemographics AS Demo
JOIN SQLTutorial.dbo.EmployeeSalary AS Sal
	ON Demo.EmployeeID = Sal.EmployeeID
WHERE Salary > 45000


/* full example */
WITH CTE_Employee AS 
(
	SELECT FirstName, LastName, Gender, Salary,
		COUNT(Gender) OVER (PARTITION BY Gender) as TotalGender,
		AVG(Salary) OVER (PARTITION BY Gender) as AvgSalary
	FROM SQLTutorial.dbo.EmployeeDemographics AS Demo
	JOIN SQLTutorial.dbo.EmployeeSalary AS Sal
		ON Demo.EmployeeID = Sal.EmployeeID
	WHERE Salary > 45000
)
Select * 
FROM CTE_Employee
/* select has to be directly after WITH  */

