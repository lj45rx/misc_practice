/*
Union, Union All
*/

/* prepare tables */
Insert into EmployeeDemographics VALUES
(1011, 'Ryan', 'Howard', 26, 'Male'),
(NULL, 'Holly', 'Flax', NULL, NULL),
(1013, 'Darryl', 'Philbin', NULL, 'Male')

Create Table WareHouseEmployeeDemographics 
(EmployeeID int, 
FirstName varchar(50), 
LastName varchar(50), 
Age int, 
Gender varchar(50)
)

Insert into WareHouseEmployeeDemographics VALUES
(1013, 'Darryl', 'Philbin', NULL, 'Male'),
(1050, 'Roy', 'Anderson', 31, 'Male'),
(1051, 'Hidetoshi', 'Hasagawa', 40, 'Male'),
(1052, 'Val', 'Johnson', 31, 'Female')
/* prepare tables end */



Select *
From SQLTutorial.dbo.EmployeeDemographics
Full outer join SQLTutorial.dbo.WareHouseEmployeeDemographics
	on EmployeeDemographics.EmployeeID = 
		WareHouseEmployeeDemographics.EmployeeID




/* these 2 tables have the same columns*/		
Select * from SQLTutorial.dbo.EmployeeDemographics

Select * from SQLTutorial.dbo.WareHouseEmployeeDemographics

/* 
put "UNION" between select statements to get combined result 

UNION will not show dulicates
UNION ALL will show all
*/ 
Select * from SQLTutorial.dbo.EmployeeDemographics
UNION
Select * from SQLTutorial.dbo.WareHouseEmployeeDemographics
Order By EmployeeID






/* 
this will work, because same column count and same datatypes


but some rows (id, name, age)
and some rows (id, title, salary)
makes little sense

*/
Select EmployeeID, FirstName, Age
From SQLTutorial.dbo.EmployeeDemographics
union
Select EmployeeID, JobTitle, Salary
From SQLTutorial.dbo.EmployeeSalary

















