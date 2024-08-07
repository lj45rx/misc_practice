CREATE TABLE EmployeeDemographics
(EmployeeID int,
FirstName varchar(50),
LastName varchar(50),
Age int,
Gender varchar(50)
)


CREATE TABLE EmployeeSalary
(EmployeeID int,
JobTitle varchar(50),
Salary int
) 


INSERT INTO EmployeeDemographics VALUES
(1001, 'Jim', 'Halpert', 30, 'Male'),
(1002, 'Pam', 'Beasley', 30, 'Female'),
(1003, 'Dwight', 'Schrute', 29, 'Male'),
(1004, 'Angela', 'Martin', 31, 'Female'),
(1005, 'Toby', 'Flenderson', 32, 'Male'),
(1006, 'Michael', 'Scott', 35, 'Male'),
(1007, 'Meredith', 'Palmer', 32, 'Female'),
(1008, 'Stanley', 'Hudson', 38, 'Male'),
(1009, 'Kevin', 'Malone', 31, 'Male')


INSERT INTO EmployeeSalary VALUES
(1001, 'Salesman', 45000),
(1002, 'Receptionist', 36000),
(1003, 'Salesman', 63000),
(1004, 'Accountant', 47000),
(1005, 'HR', 50000),
(1006, 'Regional Manager', 65000),
(1007, 'Supplier Relations', 41000),
(1008, 'Salesman', 48000),
(1009, 'Accountant', 42000)





/*
Select Statement
*, Top, Distinct, Count, As, Max, Min, Avg
*/

SELECT TOP (5) [FirstName], [LastName]
FROM EmployeeDemographics

SELECT TOP 5 FirstName, LastName
FROM EmployeeDemographics

/* get every distinct value of column */
Select DISTINCT(Gender)
From EmployeeDemographics

/* count non-empty rows */
Select COUNT(LastName)
From EmployeeDemographics

/* count non-empty rows */
/* set header to "result-table" (instead of default "(no column name)")*/
Select COUNT(LastName) AS LastNameCount
From EmployeeDemographics

/* max,min,avg */
Select Max(Salary) AS MaxSalary
From EmployeeSalary

Select Avg(Salary)
From EmployeeSalary

/* select from "master" -> set which table is used */
/* FROM <TABLENAME>.dbo.<COLUMN> */
Select *
FROM SQLTutorial.dbo.EmployeeSalary








/*
Where Statement
=, <>, <, >, <=, And, Or, Like, Null, Not Null, In
*/

/* use "<>" -> "not equal"  */
Select *
From EmployeeDemographics
Where FirstName <> 'Jim'

/* 30 or older */
Select *
From EmployeeDemographics
Where Age >= 30

/* below 30 */
Select *
From EmployeeDemographics
Where Age < 30

/* 30 and male */
Select *
From EmployeeDemographics
Where Age = 30 AND Gender = 'Male'



/* 'S%' -> starts with an 'S' 
% as wildcard
*/
Select *
From EmployeeDemographics
Where LastName Like 'S%'

/* examples
'S%' starts with S 
'%S%' contains an S 
'S%o%' starts with S, contains o 

but
'S%ott%c%' will not match "Scott"
because searched in order - c only searched after ott
*/


/* "is null" & "is not null" */
Select *
From EmployeeDemographics
Where FirstName is NOT NULL


/* "in" for "mulitple =s" */
Select *
From EmployeeDemographics
Where FirstName in ('Jim', 'Michael')
/* Where FirstName = 'Jim' or FirstName = 'Michael' */







/* Group By, Order By */

/* this gives the "first hits" for distinct values */
Select DISTINCT(Gender)
From EmployeeDemographics

/* this contains all hits */
Select Gender
From EmployeeDemographics
Group By Gender

/* count different genders as column "CountGender" (add new column with counts) */
Select Gender, Count(Gender) as CountGender
From EmployeeDemographics
Where Age > 30
Group By Gender
/* order by new column - default is ASC */
Order By CountGender DESC

/* 
count distinct age,gender combinations 
eg(male, 30) 
*/
Select Gender, Age, Count(Gender)
From EmployeeDemographics
Group By Gender, Age


/* order by (first) gender (then) age */
Select *
From EmployeeDemographics
Order By Gender DESC, Age

/* not the same as this */
Select *
From EmployeeDemographics
Order By Age, Gender

/* 
numbers can be used instead of column names 
by 5th column, then by 4th
start counting at 1
*/
Select *
From EmployeeDemographics
Order By 5 DESC, 4


/*  */
/*  */
/*  */
