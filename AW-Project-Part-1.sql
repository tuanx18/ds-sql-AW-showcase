-- Part 1: 6/11/2023

-- Tables used for practicing
-- List of employees in HR (PK: BusinessEntityID)
SELECT * FROM HumanResources.Employee   
-- Keyword: H

-- List of HR Employees' personal information (PK: BusinessEntityID)
SELECT * FROM Person.Person 
-- Keyword: P

-- List of Email Addresses of each Employee (PK: BusinessEntityID + EmailAddressID)
SELECT * FROM Person.EmailAddress 
-- Keyword: E
----------------------------------------------------------------
-- ADVENTURE WORK PRACTICE PROJECT
-- TASK 1 TO 50
-- KNOWLEDGE COVERED: TOP, Subqueries, CTE, Temporary Tables, DATEPART
----------------------------------------------------------------

-- 1. See all Employee who has the NationalIDNumber (H) starts with 1, 2 or 3
SELECT *
FROM HumanResources.Employee
WHERE NationalIDNumber LIKE '[1-3]%'

-- 2. See all Employee who has LoginID (H) contains "na" and "ma"
SELECT *
FROM HumanResources.Employee
WHERE LoginID LIKE '%na%' OR LoginID LIKE '%ma%'

-- 3. See all Employee who has JobTitle (H) contains "Desginer"
SELECT *
FROM HumanResources.Employee
WHERE JobTitle LIKE '%Designer%'

-- 4. See all Employee who has OrganizationLevel (H) is NULL
SELECT *
FROM HumanResources.Employee
WHERE OrganizationLevel IS NULL

-- 5. See all Employee who has OrganizationLevel (H) is 2
SELECT * 
FROM HumanResources.Employee
WHERE OrganizationLevel = 2

-- 6. See all Employee who has the NationalIDNumber (H) contains 36 or 63
SELECT *
FROM HumanResources.Employee
WHERE NationalIDNumber LIKE '%36%' OR NationalIDNumber LIKE '%63%'

-- 7. See all Employee who has the NationalIDNumber (H) contains 84 at the furthest right
SELECT * 
FROM HumanResources.Employee
WHERE NationalIDNumber LIKE '%84'

-- 8. See all Employee who has the NationalIDNumber (H) with number of digits is exactly 8
SELECT *
FROM HumanResources.Employee
WHERE LEN(CONVERT(VARCHAR, NationalIDNumber)) = 8

-- 9. See all Employee who has the NationalIDNumber (H) with total of digits is greater than 7 and smaller than 9
SELECT *
FROM HumanResources.Employee
WHERE LEN(CONVERT(VARCHAR, NationalIDNumber)) > 7 AND LEN(CONVERT(VARCHAR, NationalIDNumber)) < 9

-- 10. See the value counts for MaritalStatus (H)
SELECT COUNT(*) AS 'Count of MS', MaritalStatus
FROM HumanResources.Employee
GROUP BY MaritalStatus

-- 11. See the value counts for Gender (H)
SELECT COUNT(*) AS 'Gender Count', Gender
FROM HumanResources.Employee
GROUP BY Gender

-- 12. See the value counts for SalariedFlag (H)
SELECT COUNT(*) AS 'Gender SalariedFlag', SalariedFlag
FROM HumanResources.Employee
GROUP BY SalariedFlag

-- 13. See all Employee who has the VacationHours (H) smaller or equal 3
SELECT * 
FROM HumanResources.Employee
WHERE VacationHours <= 3

-- 14. See the top 10 employees with highest SickLeaveHours
SELECT TOP 10 * 
FROM HumanResources.Employee
ORDER BY SickLeaveHours DESC

-- 15. See the top 10 employees with lowest SickLeaveHours
SELECT TOP 10 * 
FROM HumanResources.Employee
ORDER BY SickLeaveHours ASC

-- 16. See all Employee who has the CurrentFlag (H) is NOT 1
SELECT * 
FROM HumanResources.Employee
WHERE CurrentFlag <> 1

-- 17. See all Employee who has the total of digit in SickLeaveHours (H) equal 1
SELECT *
FROM HumanResources.Employee
WHERE LEN(CONVERT(VARCHAR, SickLeaveHours)) = 1

-- 18. See all Employee who has the total of digit in SickLeaveHours (H) greater than 1
SELECT *
FROM HumanResources.Employee
WHERE LEN(CONVERT(varchar, SickLeaveHours)) > 1

-- 19. See all Employee that has JobTitle (H) "Senior Tool Designer" and has 9-digit NationalIDNumber (H)
SELECT *
FROM HumanResources.Employee
WHERE JobTitle = 'Senior Tool Designer' AND LEN(CONVERT(VARCHAR, NationalIDNumber)) = 9

-- 20. See top 4 Employee that has JobTitle (H) contains "Product" at the start and has 9-digit NationalIDNumber (H) 
SELECT TOP 4*
FROM HumanResources.Employee
WHERE JobTitle LIKE 'Product%' AND LEN(CONVERT(VARCHAR, NationalIDNumber)) = 9

-- 21. See top 3 Employee that has JobTitle (H) contains "Account" at the start and has 9-digit NationalIDNumber (H), order by SickLeaveHour (H)
SELECT TOP 3*
FROM HumanResources.Employee
WHERE JobTitle LIKE 'Account%' AND LEN(CONVERT(VARCHAR, NationalIDNumber)) = 9
ORDER BY SickLeaveHours

-- 22. See top 7 Employee that has JobTitle (H) contains "me" and has 6-digit or 7-digit OrganizationNode (H), order by SickLeaveHour (H)
SELECT TOP 7*
FROM HumanResources.Employee
WHERE JobTitle LIKE '%me%' AND LEN(CONVERT(VARCHAR, OrganizationNode)) LIKE '[6-7]%'
ORDER BY SickLeaveHours

-- 23. See the top 15 Employee with the lowest VacationHours (H)
SELECT TOP 15*
FROM HumanResources.Employee
ORDER BY VacationHours DESC

-- 24. See all Employee who has NationalIDNumber (H) greater than 666666666, order by Year of BirthDate(H)
SELECT *
FROM HumanResources.Employee
WHERE NationalIDNumber > 666666666
ORDER BY DATEPART(YEAR, BirthDate)

-- 25. See all Employee who has NationalIDNumber (H) smaller or equal 99999999, order by Month of BirthDate(H)
SELECT *
FROM HumanResources.Employee
WHERE NationalIDNumber <= 99999999
ORDER BY DATEPART(MONTH, BirthDate)

-- 26. See all Employee who has MartialStatus (H) is not M, order by Day of BirthDate(H)
SELECT *
FROM HumanResources.Employee
WHERE NOT MaritalStatus = 'M'
ORDER BY DATEPART(DAY, BirthDate)

-- 27. See all Employee who has MartialStatus (H) is M, order by Month of BirthDate(H)
SELECT *
FROM HumanResources.Employee
WHERE MaritalStatus = 'M'
ORDER BY DATEPART(MONTH, BirthDate)

-- 28. Count the values for each Year of BirthDate (H)
SELECT COUNT(*) AS "Counter", DATEPART(YEAR, BirthDate) AS "Year"
FROM HumanResources.Employee
GROUP BY DATEPART(YEAR, BirthDate)

-- 29. Count the values for each Month of each Year of BirthDate (H)
SELECT COUNT(*) AS "Counter", DATEPART(MONTH, BirthDate) AS "Month", DATEPART(YEAR, BirthDate) AS "Year"
FROM HumanResources.Employee
GROUP BY DATEPART(MONTH, BirthDate), DATEPART(YEAR, BirthDate)

-- 30. Count the values for each Day of BirthDate (H)
SELECT COUNT(*) AS "Counter", DATEPART(DAY, BirthDate) AS "Day Born"
FROM HumanResources.Employee
GROUP BY DATEPART(DAY, BirthDate)

-- 31. Count the values for each JobTitle (H), order by Descending JobTitle
SELECT COUNT(*) AS "Counter", JobTitle
FROM HumanResources.Employee
GROUP BY JobTitle
ORDER BY JobTitle DESC

-- 32. Count the values for each OrganizationLevel (H), order by Descending OrganizationLevel
SELECT COUNT(*) AS "Counter", OrganizationLevel
FROM HumanResources.Employee
GROUP BY OrganizationLevel
ORDER BY OrganizationLevel DESC

-- 33. Sum all the digit of values of NationalIDNumber (H) by each OrganizationLevel (H)
SELECT SUM(LEN(CONVERT(VARCHAR, NationalIDNumber))) AS "SUM OF DIGITS", OrganizationLevel 
FROM HumanResources.Employee 
GROUP BY OrganizationLevel
ORDER BY SUM(LEN(CONVERT(VARCHAR, NationalIDNumber)))

-- 34. See the highest NationalIDNumber (H) by each OrganizationLevel (H)
SELECT MAX(NationalIDNumber) AS "Max ID", OrganizationLevel 
FROM HumanResources.Employee 
GROUP BY OrganizationLevel

-- 35. See the lowest NationalIDNumber (H) by each OrganizationLevel (H), order by descending OrganizationLevel 
SELECT MIN(NationalIDNumber) AS "MIN ID", OrganizationLevel 
FROM HumanResources.Employee 
GROUP BY OrganizationLevel
ORDER BY OrganizationLevel DESC

-- 36. Show the highest and lowest NationalIDNumber (H) by each OrganizationLevel (H)
SELECT MAX(NationalIDNumber) AS "MAX", MIN(NationalIDNumber) AS "MIN", OrganizationLevel
FROM HumanResources.Employee
GROUP BY OrganizationLevel

-- 37. Show both the highest and lowest NationalIDNumber (H) (at the same table) of the OrganizationLevel (H) equal 3
SELECT MAX(NationalIDNumber) AS "VAL", OrganizationLevel
FROM HumanResources.Employee
GROUP BY OrganizationLevel
HAVING OrganizationLevel = 3
UNION ALL
SELECT MIN(NationalIDNumber) AS "VAL", OrganizationLevel
FROM HumanResources.Employee
GROUP BY OrganizationLevel
HAVING OrganizationLevel = 3

-- 38. Show the average of VacationHours (H)
SELECT AVG(VacationHours) AS "Average Value"
FROM HumanResources.Employee

-- 39. Show the sum, maximum and average of VacationHours (H) by each OrganizationLevel (H), order by ascending AVG VacationHours
SELECT SUM(VacationHours) AS "SUM", MAX(VacationHours) AS "MAX", AVG(VacationHours) AS "AVERAGE", OrganizationLevel
FROM HumanResources.Employee
GROUP BY OrganizationLevel
ORDER BY AVG(VacationHours)

-- 40. Show the count, minimum and average of SickLeaveHours (H) by each OrganizationLevel (H), order by descending count
SELECT COUNT(SickLeaveHours) AS "COUNT", MIN(SickLeaveHours) AS "MIN", AVG(SickLeaveHours) AS "AVERAGE", OrganizationLevel
FROM HumanResources.Employee
GROUP BY OrganizationLevel
ORDER BY COUNT(SickLeaveHours) DESC

-- 41. Show the count of all the combination for each group Gender (H) + MaritalStatus (H) + Month of BirthDate (H), order by Month > Gender > MaritalStatus
SELECT COUNT(*) AS "Counter", Gender, MaritalStatus, DATEPART(MONTH, BirthDate) AS "Month Date"
FROM HumanResources.Employee
GROUP BY Gender, MaritalStatus, DATEPART(MONTH, BirthDate)
ORDER BY DATEPART(MONTH, BirthDate), Gender, MaritalStatus

-- 42. Show the count of all the combination for each group Gender (H) + MaritalStatus (H) + Year of BirthDate (H), order by Year > Gender > MaritalStatus
SELECT COUNT(*) AS "Counter", Gender, MaritalStatus, DATEPART(YEAR, BirthDate) AS "Month Date"
FROM HumanResources.Employee
GROUP BY Gender, MaritalStatus, DATEPART(YEAR, BirthDate)
ORDER BY DATEPART(YEAR, BirthDate), Gender, MaritalStatus

-- 43. Show the top 3 lowest COUNT for the combination of each group Gender (H) + Day of BirthDate (H)
SELECT TOP 3 COUNT(*) AS "COUNTER", Gender, DATEPART(Day, BirthDate) AS "DAY BORN"
FROM HumanResources.Employee
GROUP BY Gender, DATEPART(Day, BirthDate)
ORDER BY "COUNTER"

-- 44. Show top 4 highest AVERAGE SickLeaveHours (H) for the combination of each group OrganizationLevel (H) + Month of BirthDate (H)
SELECT TOP 4 AVG(SickLeaveHours) AS "AVG", OrganizationLevel, DATEPART(MONTH, BirthDate) AS "Month"
FROM HumanResources.Employee
GROUP BY OrganizationLevel, DATEPART(MONTH, BirthDate)
ORDER BY AVG(SickLeaveHours) DESC

-- 45. Show the top 3 highest COUNT and top 3 lowest COUNT of group Gender (H) + OrganizationLevel (H)
CREATE TABLE #Task_45_HI(
    Counter INT,
    Gender VARCHAR,
    OrganizationLevel INT
);
INSERT INTO #Task_45_HI(Counter, Gender, OrganizationLevel)
SELECT TOP 3 COUNT(*) AS "Counter", Gender, OrganizationLevel
FROM HumanResources.Employee
GROUP BY Gender, OrganizationLevel
ORDER BY COUNT(*) DESC;

CREATE TABLE #Task_45_LO(
    Counter INT,
    Gender VARCHAR,
    OrganizationLevel INT
);
INSERT INTO #Task_45_LO(Counter, Gender, OrganizationLevel)
SELECT TOP 3 COUNT(*) AS "Counter", Gender, OrganizationLevel
FROM HumanResources.Employee
GROUP BY Gender, OrganizationLevel
ORDER BY COUNT(*) ASC;

SELECT * FROM #Task_45_HI
UNION ALL 
SELECT * FROM #Task_45_LO

-- 46. Show the value counts for each group PersonType (P) + NameStyle (P)
SELECT COUNT(*) AS "Counter", PersonType, NameStyle
FROM Person.Person
GROUP BY PersonType, NameStyle

-- 47. See all the Employee who has FirstName (P) contains "y" and LastName contains "r"
SELECT *
FROM Person.Person
WHERE FirstName LIKE '%y%' AND LastName LIKE '%r%'

-- 48. See all the Employee who has FirstName (P) contains "ee" and LastName contains "a", order by descending BusinessEntityID
SELECT *
FROM Person.Person
WHERE FirstName LIKE '%ee%' AND LastName LIKE '%a%'
ORDER BY BusinessEntityID DESC

-- 49. See all the Employee who has [FirstName (P) contains "h" and LastName (P) contains "u"] or [FirstName (P) contains 'er']
SELECT *
FROM Person.Person
WHERE (FirstName LIKE '%h%' AND LastName LIKE '%u%') OR (FirstName LIKE '%er%')

-- 50. Show the value counts for each EmailPromotion (P), remove the one with lowest counts
SELECT TOP 2 COUNT(*) AS 'Counter', EmailPromotion
FROM Person.Person
GROUP BY EmailPromotion
ORDER BY 'Counter' DESC;