/*
Partition By

often compared to group by
*/ 

/* Select all employees
add "TotalGender" in each row -> how many employees of same gender as current row
*/
SELECT FirstName, LastName, Gender, Salary,
	COUNT(Gender) OVER (PARTITION BY Gender) as TotalGender
FROM SQLTutorial.dbo.EmployeeDemographics AS Demo
JOIN SQLTutorial.dbo.EmployeeSalary AS Sal
	ON Demo.EmployeeID = Sal.EmployeeID

	
/* not popssible with group by */
SELECT FirstName, LastName, Gender, Salary, COUNT(Gender) 
FROM SQLTutorial.dbo.EmployeeDemographics AS Demo
JOIN SQLTutorial.dbo.EmployeeSalary AS Sal
	ON Demo.EmployeeID = Sal.EmployeeID
GROUP BY FirstName, LastName, Gender, Salary


/* unless reduced to gender only */
SELECT Gender, COUNT(Gender) 
FROM SQLTutorial.dbo.EmployeeDemographics AS Demo
JOIN SQLTutorial.dbo.EmployeeSalary AS Sal
	ON Demo.EmployeeID = Sal.EmployeeID
GROUP BY Gender

/* 
OVER (PARTITION BY Gender)

does something similar to the last query above
*/

















