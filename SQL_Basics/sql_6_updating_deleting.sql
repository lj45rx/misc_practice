
/*
Updating Deleting
*/


Select *
From SQLTutorial.dbo.EmployeeDemographics


/* this would set ALL EmployeIDs to 1012 */
UPDATE SQLTutorial.dbo.EmployeeDemographics
SET EmployeeID = 1012

/* change one */
UPDATE SQLTutorial.dbo.EmployeeDemographics
SET EmployeeID = 1012
WHERE FirstName = 'Holly' AND LastName = 'Flax'

/* change multiple */
UPDATE SQLTutorial.dbo.EmployeeDemographics
SET Age = 31, Gender = 'Female'
WHERE FirstName = 'Holly' AND LastName = 'Flax'





/* without WHERE ALL is deleted */
DELETE 
FROM SQLTutorial.dbo.EmployeeDemographics
WHERE EmployeeID = 1005


/* to be sure 
first call
*/
SELECT * 
FROM SQLTutorial.dbo.EmployeeDemographics
WHERE EmployeeID = 1005

/* is correct data
change SELECT * to DELETE
*/
DELETE
FROM SQLTutorial.dbo.EmployeeDemographics
WHERE EmployeeID = 1005




SELECT *
FROM SQLTutorial.dbo.EmployeeDemographics











