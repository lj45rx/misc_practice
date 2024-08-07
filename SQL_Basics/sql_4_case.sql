/*
Case Statement
*/



/* names and ages */
Select FirstName, LastName, Age
From SQLTutorial.dbo.EmployeeDemographics
Where Age is NOT NULL
Order By Age


/* 
show "old/young/baby" based on age 
comma after "Age" is essencial (because new column is created?)

AS-statement optional
*/
Select FirstName, LastName, Age,
CASE
	When Age > 30 Then 'Old'
	When Age BETWEEN 27 AND 30 Then 'Young'
	Else 'Baby'
END
as AgeDesc
From SQLTutorial.dbo.EmployeeDemographics
Where Age is NOT NULL
Order By Age





/* salary increase based on current salary */
Select FirstName, LastName, JobTitle, Salary,
Case
	When JobTitle = 'Salesman' Then Salary + (Salary* .10)
	When JobTitle = 'Accontant' Then Salary + (Salary* .5)
	When JobTitle = 'HR' Then Salary + (Salary* .000001)
	Else Salary + (Salary* .03)
End As NewSalary
From SQLTutorial.dbo.EmployeeDemographics
Join SQLTutorial.dbo.EmployeeSalary
	on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID






