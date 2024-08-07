/*
String Functions 
TRIM, LTRIM, RTRIM, Replace, Substring, Upper, Lower
*/

Drop Table If Exists EmployeeErrors;
CREATE TABLE EmployeeErrors (
EmployeeID varchar(50)
,FirstName varchar(50)
,LastName varchar(50)
)

-- 1st whitespaces after id, Jimbo should be Jim
-- 2nd whitespace before id
-- 3rd "- Fired" to be removed
Insert into EmployeeErrors Values 
('1001  ', 'Jimbo', 'Halbert')
,('  1002', 'Pamela', 'Beasely')
,('1005', 'TOby', 'Flenderson - Fired')

Select *
From EmployeeErrors





-- TRIM, LTRIM, RTRIM
--trim both ends
Select EmployeeID, TRIM(employeeID) AS IDTRIM
FROM EmployeeErrors 

-- trim right side
Select EmployeeID, RTRIM(employeeID) as IDRTRIM
FROM EmployeeErrors 

-- trim left side
Select EmployeeID, LTRIM(employeeID) as IDLTRIM
FROM EmployeeErrors 

	



/*
Using Replace
remove "- Fired"

REPLACE(column, string, newString)
*/
Select LastName, REPLACE(LastName, '- Fired', '') as LastNameFixed
FROM EmployeeErrors





/*
Using Substring

"fuzzy matching"
get first 3 letters of names
try to match on substrings - 
eg jimbo and jim, pamela and pam

in real example
try to match on multiple values
gender, lastname, age, date of birth 

SUBSTRING(column, start_inclusive, len)
*/
Select err.FirstName, dem.FirstName, err.LastName, dem.LastName
FROM EmployeeErrors err
JOIN SQLTutorial.dbo.EmployeeDemographics dem
	on Substring(err.FirstName,1,3) = Substring(dem.FirstName,1,3)
	and Substring(err.LastName,1,3) = Substring(dem.LastName,1,3)

-- no or not all hits when not using substring
Select err.FirstName, dem.FirstName
FROM EmployeeErrors err
JOIN SQLTutorial.dbo.EmployeeDemographics dem
	on err.FirstName = dem.FirstName







-- Using UPPER and lower
Select firstname, LOWER(firstname)
from EmployeeErrors

Select Firstname, UPPER(FirstName)
from EmployeeErrors