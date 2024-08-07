/*
aliasing
temporarily change column or tablename
used for readability
*/ 


/* the following are equivalent */
SELECT FirstName AS Fname
FROM SQLTutorial.dbo.EmployeeDemographics

SELECT FirstName Fname
FROM SQLTutorial.dbo.EmployeeDemographics

/* combining fields */
SELECT FirstName + ' ' + LastName AS FullName
FROM SQLTutorial.dbo.EmployeeDemographics


/* aliasing tables */
/* make join more readable */
SELECT Demo.EmployeeID, Sal.Salary
FROM SQLTutorial.dbo.EmployeeDemographics AS Demo
JOIN SQLTutorial.dbo.EmployeeSalary AS Sal
	ON Demo.EmployeeID = Sal.EmployeeID


/* join 3 using aliases */
/* left join because not all data "matches" */
SELECT *
FROM SQLTutorial.dbo.EmployeeDemographics AS Demo
LEFT JOIN SQLTutorial.dbo.EmployeeSalary AS Sal
	ON Demo.EmployeeID = Sal.EmployeeID
LEFT JOIN SQLTutorial.dbo.WareHouseEmployeeDemographics AS Ware
	ON Demo.EmployeeID = Ware.EmployeeID





















