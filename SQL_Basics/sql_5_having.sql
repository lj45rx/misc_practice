
/*
Having 

"having is dependant on group by"
*/


/* find jobtitle with more than 1 employees */
Select JobTitle, COUNT(JobTitle) as NumEmployees
From SQLTutorial.dbo.EmployeeSalary
Group By JobTitle
Having COUNT(JobTitle) > 1


/* find jobtitle with avg salary > 45k */
Select JobTitle, AVG(Salary) as AvgSalary
From SQLTutorial.dbo.EmployeeDemographics
Join SQLTutorial.dbo.EmployeeSalary
	On EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
Group By JobTitle
Having AVG(Salary) > 45000
Order By AVG(Salary)




