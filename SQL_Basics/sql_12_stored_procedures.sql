/*
Stored Procedures

"functions"

group of statements 
can take parameters
can be used by multiple users

if modified, modified for everyone
*/


/*
create procedure:
	([0,n] parameters)

CREATE PROCEDURE <Name_of_procedure>
@Param1 nvarchar(100)
@Param2 int
AS
<Some Query>

run procedure:
EXEC <Name_of_procedure> @Param1 = 'Salesman' @Param2 = 10
*/
CREATE PROCEDURE TestProc
AS
Select *
From SQLTutorial.dbo.EmployeeDemographics

EXEC TestProc




/*
Begin creation of procedure
*/

--create table
CREATE PROCEDURE Temp_Employee
AS
DROP TABLE IF EXISTS #temp_employee
Create table #temp_employee (
JobTitle varchar(100),
EmployeesPerJob int ,
AvgAge int,
AvgSalary int
)

--fill table
Insert into #temp_employee
SELECT JobTitle, Count(JobTitle), Avg(Age), AVG(salary)
FROM SQLTutorial..EmployeeDemographics emp
JOIN SQLTutorial..EmployeeSalary sal
	ON emp.EmployeeID = sal.EmployeeID
group by JobTitle

--select on table
Select * 
From #temp_employee
GO;


/* end procedure creation */
EXEC Temp_Employee





/*
Begin creation of procedure
with parameters
	
*/
CREATE PROCEDURE Temp_Employee2 
@JobTitle nvarchar(100)
AS
DROP TABLE IF EXISTS #temp_employee3
Create table #temp_employee3 (
JobTitle varchar(100),
EmployeesPerJob int ,
AvgAge int,
AvgSalary int
)


Insert into #temp_employee3
SELECT JobTitle, Count(JobTitle), Avg(Age), AVG(salary)
FROM SQLTutorial..EmployeeDemographics emp
JOIN SQLTutorial..EmployeeSalary sal
	ON emp.EmployeeID = sal.EmployeeID
where JobTitle = @JobTitle --- select only where JobTitle matched given parameter
group by JobTitle

Select * 
From #temp_employee3
GO;

/* end procedure creation */
exec Temp_Employee2 @jobtitle = 'Salesman'
exec Temp_Employee2 @jobtitle = 'Accountant'