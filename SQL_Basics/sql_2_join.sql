
/*
"combine multiple outputs into a single "

Inner Joins, Full/Left/Right Outer Joins
*/

Select * 
From SQLTutorial.dbo.EmployeeDemographics

Select * 
From SQLTutorial.dbo.EmployeeSalary


/* 
merge both tables by id=id
show only "matches"

"inner" is default */
Select *
From SQLTutorial.dbo.EmployeeDemographics
Inner Join SQLTutorial.dbo.EmployeeSalary
On EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID


/* "full outer join" 
show everything even if there is no match

"left outer"
include all from first, and matching from right
"right outer"
include all from second, and matching from first

for fully matching tables all types of joins give same result(?) 

would include entries that cannot be matched (some entries only in one of the tables)
filling unknown fields with NULL
*/
Select *
From SQLTutorial.dbo.EmployeeDemographics
Inner Join SQLTutorial.dbo.EmployeeSalary
On EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID





/* EmployeeID in both tables, cannot be used as is 

for fully matching tables or "inner join"
Table1.EmployeeID, Table2.EmployeeID, give identical result

for "partial joins" with NULL fields differences
*/
Select EmployeeDemographics.EmployeeID, EmployeeSalary.EmployeeID, FirstName, LastName, JobTitle, Salary
From SQLTutorial.dbo.EmployeeDemographics
Full Outer Join SQLTutorial.dbo.EmployeeSalary
On EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID






/* "find highest paid employee, except michael" (assume only one michael exists) */
Select *
From SQLTutorial.dbo.EmployeeDemographics
Inner Join SQLTutorial.dbo.EmployeeSalary
On EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
Where FirstName <> 'Michael'
Order By Salary DESC



/* average salary of a "salesman" */
Select AVG(Salary) as SalesmanAvgSalary
From SQLTutorial.dbo.EmployeeDemographics
Inner Join SQLTutorial.dbo.EmployeeSalary
On EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
Where JobTitle = 'Salesman'


/* average salary by jobtitle */
Select Jobtitle, AVG(Salary) as AvgSalary
From SQLTutorial.dbo.EmployeeDemographics
Inner Join SQLTutorial.dbo.EmployeeSalary
On EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
Group By JobTitle
Order by AvgSalary DESC
