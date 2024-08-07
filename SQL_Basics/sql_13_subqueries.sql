/*
Subqueries 

also called "inner" or "nested" queries
*/

Select EmployeeID, JobTitle, Salary
From EmployeeSalary


-- Subquery in Select
	-- this is the subquery
Select AVG(Salary) From EmployeeSalary

	-- use it here  (<subquery>)
Select EmployeeID, Salary, (Select AVG(Salary) From EmployeeSalary) as AllAvgSalary
From EmployeeSalary


-- The same result but using Partition By
Select EmployeeID, Salary, AVG(Salary) over () as AllAvgSalary
From EmployeeSalary


/*
group by doesn't work
because it is grouped by multiple values -> valuepairs 
*/
Select EmployeeID, Salary, AVG(Salary) as AllAvgSalary
From EmployeeSalary
Group By EmployeeID, Salary
order by EmployeeID



-- Subquery in From -> create query, select from its rows
	-- cte or temptable prefered, but solvable as subquery
Select a.EmployeeID, AllAvgSalary
From 
	(Select EmployeeID, Salary, AVG(Salary) over () as AllAvgSalary
	 From EmployeeSalary) a
Order by a.EmployeeID



/*
Subquery in Where

get only employees over 30
but table EmployeeSalary does not contain ages

select EmployeeIDs from EmployeeDemographics where age > 30
then select from EmployeeSalary where ids match

to display age join required
to just select subquery is sufficient
*/
Select EmployeeID, JobTitle, Salary
From EmployeeSalary
where EmployeeID in (
	-- get ids of employees over 30
	Select EmployeeID 
	From EmployeeDemographics
	where Age > 30)