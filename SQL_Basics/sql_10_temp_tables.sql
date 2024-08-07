/*
Temp Tables

can be reused 

Uses:
eg for extremely large table 
	first create temp table with only relevant values
	work on that for better runtimes
*/

/* start name with # */
CREATE TABLE #temp_Employee (
EmployeeID int, 
JobTitle varchar(100),
Salary int
)

/* insert data manually */
INSERT INTO #temp_Employee VALUES (
1001, 'HR', 45000
)

Select *
FROM #temp_Employee

/* insert data from other table */
INSERT INTO #temp_Employee
SELECT * 
FROM SQLTutorial.dbo.EmployeeSalary

Select *
FROM #temp_Employee





/* more complex example */
DROP TABLE IF EXISTS #temp_Emloyee2
CREATE TABLE #temp_Emloyee2 (
JobTitle varchar(50),
EmployeesPerJob int,
AvgAge int,
AvgSalary int
)

INSERT INTO #temp_Emloyee2
	SELECT JobTitle, COUNT(JobTitle), AVG(Age), AVG(Salary)
	FROM SQLTutorial.dbo.EmployeeDemographics demo
	JOIN SQLTutorial.dbo.EmployeeSalary sal
		ON demo.EmployeeID = sal.EmployeeID
	GROUP by JobTitle

SELECT *
FROM #temp_Emloyee2









