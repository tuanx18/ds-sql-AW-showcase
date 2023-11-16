-- Part 2: 7/11/2023

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
-- TASK 51 TO 100
-- KNOWLEDGE COVERED: CTE, Multi-CTE, DATEPART, DATEDIFF, ROUND, CAST, Subqueries, Temporary tables
----------------------------------------------------------------

-- 51. Show the value counts of Title (P) with the PersonType (P) is "IN" and  EmailPromotion is (0)
SELECT COUNT(*) AS "Counter", Title
FROM Person.Person
WHERE PersonType = 'IN' AND EmailPromotion = 0
GROUP BY Title

-- 52. Show the value counts of Title (P) with the PersonType (P) is "EM" and  EmailPromotion is NOT (0), order by smallest COUNT
SELECT COUNT(*) AS "Counter", Title
FROM Person.Person
WHERE PersonType = 'EM' AND EmailPromotion <> 0
GROUP BY Title
ORDER BY 'Counter' ASC

-- 53. See all the Person that has LastName (P) starts with T or [FirstName (P) end with "n" and EmailPromotion (P) is 0]
SELECT *
FROM Person.Person 
WHERE (LastName LIKE 'T%') OR (FirstName LIKE '%n' AND EmailPromotion = 0)

-- 54. Show the value counts for Month of ModifiedDate (P), only keep the Count greater than 1600
SELECT COUNT(*) AS 'Counter', DATEPART(MONTH, ModifiedDate) AS 'MONTH'
FROM Person.Person
GROUP BY DATEPART(MONTH, ModifiedDate)
HAVING COUNT(*) > 1600

-- 55. Show the value counts for Year of ModifiedDate (P), only keep the Count greater than 222
SELECT COUNT(*) AS 'Counter', DATEPART(YEAR, ModifiedDate)
FROM Person.Person
GROUP BY DATEPART(YEAR, ModifiedDate)
HAVING COUNT(*) > 222

-- 56. Show all the distinct values for MiddleName (P)
SELECT DISTINCT MiddleName
FROM Person.Person

-- 57. Show the sum of BusinessEntityID (P) for each group Year of Modified Date + EmailPromotion, only keep the one with the SUM in 50000 and 93000
SELECT SUM(BusinessEntityID) AS 'TOTAL', DATEPART(YEAR, ModifiedDate) AS 'Year Edit', EmailPromotion
FROM Person.Person
GROUP BY DATEPART(YEAR, ModifiedDate), EmailPromotion
HAVING SUM(BusinessEntityID) BETWEEN 50000 AND 93000

-- 58. Show the sum of BusinessEntityID (P) for each group Month of Modified Date + EmailPromotion, only keep the one with the SUM in 3000000 and 4000000
SELECT SUM(BusinessEntityID) AS 'TOTAL', DATEPART(MONTH, ModifiedDate) AS 'Year Edit', EmailPromotion
FROM Person.Person
GROUP BY DATEPART(MONTH, ModifiedDate), EmailPromotion
HAVING SUM(BusinessEntityID) BETWEEN 3000000 AND 4000000

-- 59. Show the value counts for Year of ModifiedDate (E), only get the year 2007 to 2009
SELECT COUNT(*) AS 'COUNT', DATEPART(YEAR, ModifiedDate) AS 'YEAR'
FROM Person.EmailAddress
GROUP BY DATEPART(YEAR, ModifiedDate)
HAVING DATEPART(YEAR, ModifiedDate) BETWEEN 2007 AND 2009

-- 60. See all the Employee with EmailAddress (E) contains "ev" or "ea", which has the Year of ModifiedDate (E) is 2009
SELECT *
FROM Person.EmailAddress
WHERE (EmailAddress LIKE '%ev%' OR EmailAddress LIKE '%ea%') AND DATEPART(YEAR, ModifiedDate) = 2009

-- 61. See the top 2 highest BusinessEntityID Employee with EmailAddress (E) contains "on", which has the Year of ModifiedDate (E) is in 2010 and 2013
SELECT TOP 2*
FROM Person.EmailAddress
WHERE EmailAddress LIKE '%on%' AND DATEPART(YEAR, ModifiedDate) BETWEEN 2010 AND 2013
ORDER BY BusinessEntityID DESC

-- 62. See all the Employee with EmailAddress (E) contains "a" and "ee", which has the YEAR of ModifiedDate (E) is 2008
SELECT *
FROM Person.EmailAddress
WHERE EmailAddress LIKE '%a%' AND EmailAddress LIKE '%ee%' AND DATEPART(YEAR, ModifiedDate) = 2008

-- 63. Show all the Employee that has BusinessEntityID (E) equal to their EmailAddressID, order from the highest BusinessEntityID
SELECT *
FROM Person.EmailAddress
WHERE BusinessEntityID = EmailAddressID
ORDER BY BusinessEntityID DESC

-- 64. Show all the Employee that has BusinessEntityID (E) NOT equal to their EmailAddressID, order by Year of ModifiedDate (E)
SELECT *
FROM Person.EmailAddress
WHERE BusinessEntityID <> EmailAddressID
ORDER BY DATEPART(YEAR, ModifiedDate)

-- 65. Show all the Employee that has BusinessEntityID (E) equal to their EmailAddressID, and EmailAddress (E) has 24-26 characters
SELECT *, LEN(CONVERT(VARCHAR, EmailAddress)) AS 'Number of Characters'
FROM Person.EmailAddress
WHERE BusinessEntityID = EmailAddressID AND LEN(CONVERT(VARCHAR, EmailAddress)) BETWEEN 24 AND 26

-- 66. Show all data of Person (P) who has EmailAddress (E) at exactly 25 characters or 28 characters, order by highest Day of ModifiedDate (P)
SELECT *
FROM Person.EmailAddress
WHERE LEN(CONVERT(varchar, EmailAddress)) = 25 OR LEN(CONVERT(varchar, EmailAddress)) = 28
ORDER BY DATEPART(DAY, ModifiedDate) DESC

-- 67. Show all data of Person (P) who has EmailAddress (E) at exactly 26 characters, PersonType (P) is NOT "EM"
SELECT P.*, LEN(CONVERT(varchar, E.EmailAddress)) AS 'Length of Email'
FROM Person.Person P
JOIN Person.EmailAddress E
ON P.BusinessEntityID = E.BusinessEntityID
WHERE LEN(CONVERT(varchar, E.EmailAddress)) = 26 AND NOT P.PersonType = 'EM'

-- 68. Show all data of Person (P) who has 3-digit FirstName (P) and 24-digit EmailAddressID (E)
SELECT P.*, LEN(CONVERT(varchar, E.EmailAddress)) AS 'Length of Email'
FROM Person.Person P
JOIN Person.EmailAddress E
ON P.BusinessEntityID = E.BusinessEntityID
WHERE LEN(CONVERT(varchar,P.FirstName)) = 3 AND LEN(CONVERT(varchar, E.EmailAddress)) = 24

-- 69. Show all data of Person (P) who greater than 4-digit FirstName (P) and less than 29-digit EmailAddressID (E), order by length of LastName (P)
SELECT P.*
FROM Person.Person P
JOIN Person.EmailAddress E
ON P.BusinessEntityID = E.BusinessEntityID
WHERE LEN(CONVERT(varchar, P.FirstName)) > 4 AND LEN(CONVERT(varchar, E.EmailAddress)) = 29
ORDER BY LEN(CONVERT(VARCHAR, P.LastName))

-- 70. Show all data of Person (P) who greater or equal than 6-digit LastName (P) and less than 6-digit OrganizationNode (H), order by Month of BirthDate (H)
SELECT P.*, DATEPART(MONTH, H.BirthDate) AS 'Month Date'
FROM Person.Person P 
JOIN HumanResources.Employee H
ON P.BusinessEntityID = H.BusinessEntityID
WHERE LEN(CONVERT(varchar, LastName)) >= 6 AND LEN(CONVERT(varchar, OrganizationNode)) < 6
ORDER BY DATEPART(MONTH, H.BirthDate)

-- 71. Show all data of Employee (H) who has NationalIDNumber (H) starts with '80', has 25 to 28-digit EmailAddress (E) and EmailPromotion is 0-1 (P), order by ascending LastName (P)
SELECT H.*, LEN(CONVERT(VARCHAR, E.EmailAddress)) AS 'Length of Email', P.EmailPromotion AS 'Email Promo'
FROM HumanResources.Employee H 
JOIN Person.Person P ON H.BusinessEntityID = P.BusinessEntityID
JOIN Person.EmailAddress E ON H.BusinessEntityID = E.BusinessEntityID
WHERE H.NationalIDNumber LIKE '80%' AND LEN(CONVERT(VARCHAR, E.EmailAddress)) BETWEEN 25 AND 28 AND P.EmailPromotion BETWEEN 0 AND 1
ORDER BY P.LastName ASC

-- 72. Show all data of Employee (H) who has NationalIDNumber (H) starts with '6' and Suffix (P) is 'Jr.', order by ascending LastName (P)
SELECT H.*
FROM HumanResources.Employee H 
JOIN Person.Person P ON H.BusinessEntityID = P.BusinessEntityID
WHERE H.NationalIDNumber LIKE '6%' AND P.Suffix = 'Jr.' 
ORDER BY P.LastName ASC

-- 73. Show all the value counts for each combination of group Gender (H) + Suffix (P) + PersonType (P)
SELECT COUNT(*) AS 'Counter', H.Gender, P.Suffix, P.PersonType
FROM HumanResources.Employee H 
JOIN Person.Person P ON H.BusinessEntityID = P.BusinessEntityID
GROUP BY H.Gender, P.Suffix, P.PersonType

-- 74. Show all the value counts for each combination of group MartialStatus (H) + EmailPromotion (P) + PersonType (P), only keep the counts less than 16
SELECT COUNT(*) AS 'Counter', H.MaritalStatus, P.EmailPromotion, P.PersonType
FROM HumanResources.Employee H 
JOIN Person.Person P ON H.BusinessEntityID = P.BusinessEntityID
GROUP BY H.MaritalStatus, P.EmailPromotion, P.PersonType
HAVING COUNT(*) < 16

-- 75. Show all the value counts for each combination of group MartialStatus (H) + PersonType (P), which the Person has the length of LastName (P) in the range from 5 to 8
SELECT COUNT(*) AS 'Counter', H.MaritalStatus, P.PersonType
FROM HumanResources.Employee H 
JOIN Person.Person P ON H.BusinessEntityID = P.BusinessEntityID
WHERE LEN(CONVERT(varchar, P.LastName)) BETWEEN 5 AND 8
GROUP BY H.MaritalStatus, P.PersonType

-- 76. Show all the value counts for each combination of group Gender (H) + PersonType (P), which the Person has the length of EmailAddress (E) in the range from 24 to 30 characters
SELECT COUNT(*) AS 'Counter', H.Gender, P.PersonType
FROM HumanResources.Employee H 
JOIN Person.Person P ON H.BusinessEntityID = P.BusinessEntityID
JOIN Person.EmailAddress E ON H.BusinessEntityID = E.BusinessEntityID
WHERE LEN(CONVERT(varchar, E.EmailAddress)) BETWEEN 24 AND 30
GROUP BY H.Gender, P.PersonType

-- 77. Show all the value counts for each combination of group Gender (H) + PersonType (P) + Month of ModifiedDate (E), which the Person has the length of EmailAddress (P) in the range from 24 to 30 characters
SELECT COUNT(*) AS 'Counter', H.Gender, P.PersonType, DATEPART(MONTH, E.ModifiedDate) AS 'Month Editted'
FROM HumanResources.Employee H 
JOIN Person.Person P ON H.BusinessEntityID = P.BusinessEntityID
JOIN Person.EmailAddress E ON H.BusinessEntityID = E.BusinessEntityID
WHERE LEN(CONVERT(varchar, E.EmailAddress)) BETWEEN 24 AND 30
GROUP BY H.Gender, P.PersonType, DATEPART(MONTH, E.ModifiedDate)

-- 78. See all data of Employee (P) who has the same length of FirstName (P) and LastName (P) and has VacationHours (H) less than AVERAGE, sort from the biggest VacationHours (H)
SELECT P.*, H.VacationHours 
FROM Person.Person P
JOIN HumanResources.Employee H ON H.BusinessEntityID = P.BusinessEntityID
WHERE LEN(CONVERT(varchar, P.FirstName)) = LEN(CONVERT(varchar, P.LastName)) AND H.VacationHours < 
(SELECT AVG(VacationHours)
FROM HumanResources.Employee)
ORDER BY H.VacationHours DESC

-- 79. See all data of Employee (P) who has the length of FirstName (P) is less than LastName (P) and has SickLeaveHours (H) greater than AVERAGE, sort from the biggest SickLeaveHours (H)
SELECT P.*, H.SickLeaveHours
FROM Person.Person P 
JOIN HumanResources.Employee H ON P.BusinessEntityID = H.BusinessEntityID
WHERE LEN(CONVERT(varchar, P.FirstName)) < LEN(CONVERT(varchar, P.LastName)) AND H.SickLeaveHours <
(SELECT AVG(SickLeaveHours)
FROM HumanResources.Employee) 
ORDER BY H.SickLeaveHours DESC

-- 80. See the Employee (P) data of TOP 2 lowest NationalIDNumber (H) who has the length of FirstName (P) is less than LastName (P) and has SickLeaveHours (P) greater than AVERAGE
SELECT TOP 2 H.NationalIDNumber, P.*
FROM Person.Person P 
JOIN HumanResources.Employee H ON P.BusinessEntityID = H.BusinessEntityID
WHERE LEN(CONVERT(varchar, P.FirstName)) < LEN(CONVERT(varchar, P.LastName)) AND H.SickLeaveHours >
(SELECT AVG(SickLeaveHours)
FROM HumanResources.Employee) 
ORDER BY H.NationalIDNumber

-- 81. See the Employee (P) data of TOP 2 highest NationalIDNumber (H) who has the length of FirstName (P) is less than LastName (P) and has SickLeaveHours (P) less than AVERAGE
SELECT TOP 2 H.NationalIDNumber, P.*
FROM Person.Person P 
JOIN HumanResources.Employee H ON P.BusinessEntityID = H.BusinessEntityID
WHERE LEN(CONVERT(varchar, P.FirstName)) < LEN(CONVERT(varchar, P.LastName)) AND H.SickLeaveHours <
(SELECT AVG(SickLeaveHours)
FROM HumanResources.Employee) 
ORDER BY H.NationalIDNumber

-- 82. Show all the Employee data (H) who has a NationalIDNumber (H) greater than 3/4 of the Maximum NationalIDNumber
SELECT *
FROM HumanResources.Employee
WHERE NationalIDNumber > (3.0 / 4 * (SELECT CAST(MAX(NationalIDNumber) AS FLOAT) FROM HumanResources.Employee))

-- 83. Show all the Employee data (H) who has a VacationHours (H) less than 15% of the Maximum VacationHours and has the PersonType (P) "EM"
SELECT H.*, P.PersonType
FROM HumanResources.Employee H
JOIN Person.Person P ON H.BusinessEntityID = P.BusinessEntityID
WHERE H.VacationHours < (15.0 / 100 *(SELECT CAST(MAX(VacationHours) AS FLOAT) FROM HumanResources.Employee)) 
AND P.PersonType = 'EM'

-- 84. Show all the Employee data (H) who has a SickLeaveHours (H) equal to the minimum value of SickLeaveHours and has the PersonType (P) "EM" or "IN"
SELECT H.*, P.PersonType
FROM HumanResources.Employee H 
JOIN Person.Person P ON H.BusinessEntityID = P.BusinessEntityID
WHERE H.SickLeaveHours = (SELECT MIN(SickLeaveHours) FROM HumanResources.Employee)
AND (P.PersonType = 'EM' OR P.PersonType = 'IN')

-- 85. Show all the Employee data (H) who has a SickLeaveHours (H) equal to the SECOND minimum value of SickLeaveHours and has the PersonType (P) "EM" or "IN"
CREATE TABLE #Task_85(
    SickLeaverHours INT
);
INSERT INTO #Task_85 (SickLeaverHours)
SELECT DISTINCT SickLeaveHours
FROM HumanResources.Employee
ORDER BY SickLeaveHours
OFFSET 1 ROW;

SELECT H.*, P.PersonType
FROM HumanResources.Employee H 
JOIN Person.Person P ON H.BusinessEntityID = P.BusinessEntityID
WHERE H.SickLeaveHours =
(SELECT MIN(SickLeaverHours)
FROM #Task_85)
AND (P.PersonType = 'EM' OR  P.PersonType = 'IN')

-- 86. Show all the Employee data (H) who has a SickLeaveHours (H) equal to the one of the 3 MAXIMUM value of SickLeaveHours and has the PersonType (P) "EM", order by BirthDate (H)
CREATE TABLE #Task_86(
    SickLeaveHours INT
);
INSERT INTO #Task_86 (SickLeaveHours)
SELECT DISTINCT TOP 3 SickLeaveHours
FROM HumanResources.Employee
ORDER BY SickLeaveHours DESC

SELECT H.*, P.PersonType
FROM HumanResources.Employee H
JOIN Person.Person P ON H.BusinessEntityID = P.BusinessEntityID
RIGHT JOIN #Task_86 TEMP ON TEMP.SickLeaveHours = H.SickLeaveHours
WHERE P.PersonType = 'EM'

-- 87. Show the NationalIDNumber (H), FirstName (P), MiddleName (P), LastName (P) and Age (2023 - Year of BirthDate (H)), order by Age > LastName
SELECT H.NationalIDNumber, P.FirstName, P.MiddleName, P.LastName, (2023 - DATEPART(YEAR, H.BirthDate)) AS 'Age'
FROM HumanResources.Employee H 
JOIN Person.Person P ON H.BusinessEntityID = P.BusinessEntityID
ORDER BY 'Age', LastName

-- 88. Show the NationalIDNumber (H), FirstName (P), MiddleName (P), LastName (P), Age (2023 - Year of BirthDate (H)), EmailAddress (E), only show the ones who were born in month 9-12, order by Age > LastName
SELECT H.NationalIDNumber, P.FirstName, P.MiddleName, P.LastName, (2023 - DATEPART(YEAR, H.BirthDate)) AS 'Age', DATEPART(MONTH, H.BirthDate) AS 'Month'
FROM HumanResources.Employee H 
JOIN Person.Person P ON H.BusinessEntityID = P.BusinessEntityID
JOIN Person.EmailAddress E ON H.BusinessEntityID = E.BusinessEntityID
WHERE DATEPART(MONTH, H.BirthDate) BETWEEN 9 AND 12
ORDER BY 'Age', LastName

-- 89. Show the FirstName (P), MiddleName (P), LastName (P), Age (2023 - Year of BirthDate (H)), EmailAddress (E), only who do NOT has NULL Suffix (P), order by Age > LastName
SELECT P.FirstName, P.MiddleName, P.LastName, (2023 - DATEPART(YEAR, H.BirthDate)) AS 'Age', E.EmailAddress, P.Suffix
FROM HumanResources.Employee H 
JOIN Person.Person P ON H.BusinessEntityID = P.BusinessEntityID
JOIN Person.EmailAddress E ON H.BusinessEntityID = E.BusinessEntityID
WHERE P.Suffix IS NOT NULL
ORDER BY 'Age', LastName

-- 90. Show the FirstName (P), MiddleName (P), LastName (P), Age (2023 - Year of BirthDate (H)), EmailAddress (E), only who has NULL Suffix (P)
SELECT P.FirstName, P.MiddleName, P.LastName, (2023 - DATEPART(YEAR, H.BirthDate)) AS 'Age', E.EmailAddress, P.Suffix
FROM HumanResources.Employee H 
JOIN Person.Person P ON H.BusinessEntityID = P.BusinessEntityID
JOIN Person.EmailAddress E ON H.BusinessEntityID = E.BusinessEntityID
WHERE P.Suffix IS NULL

-- 91. Show the FirstName (P), MiddleName (P), LastName (P), Age (2023 - Year of BirthDate (H)), Month Age (11 - Month of BirthDate (H) + Age * 12)
SELECT P.FirstName, P.MiddleName, P.LastName, (2023 - DATEPART(YEAR, H.BirthDate)) AS 'Age', (11 - DATEPART(MONTH, H.BirthDate) + (2023 - DATEPART(YEAR, H.BirthDate)) * 12) AS 'Month AGE'
FROM HumanResources.Employee H 
JOIN Person.Person P ON H.BusinessEntityID = P.BusinessEntityID

-- 92. Show the BusinessEntityID (H), FirstName (P), MiddleName (P), LastName (P), Age of the ones who has Gender (H) "F" and MartialStatus (H) "S" and in OrganizationLevel (H) is in 1-3
SELECT H.BusinessEntityID, P.FirstName, P.MiddleName, P.LastName, (2023 - DATEPART(YEAR, H.BirthDate)) AS 'Age'
FROM HumanResources.Employee H 
JOIN Person.Person P ON H.BusinessEntityID = P.BusinessEntityID
WHERE H.Gender = 'F' AND H.MaritalStatus = 'S' AND H.OrganizationLevel BETWEEN 1 AND 3

-- 93. Show the BusinessEntityID (H), LastName (P), Age of the ones who has Gender (H) EQUAL TO MartialStatus (H) and OrganizationLevel (H) is 4
SELECT H.BusinessEntityID, P.LastName, (2023 - DATEPART(YEAR, H.BirthDate)) AS 'Age', H.OrganizationLevel
FROM HumanResources.Employee H 
JOIN Person.Person P ON H.BusinessEntityID = P.BusinessEntityID
WHERE H.Gender = H.MaritalStatus AND H.OrganizationLevel = 4

-- 94. Show the value counts for each Age (H*)
SELECT COUNT(*) AS 'Counter', (2023 - DATEPART(YEAR, BirthDate)) AS 'Age'
FROM HumanResources.Employee
GROUP BY (2023 - DATEPART(YEAR, BirthDate))

-- 95. Show the value counts for each Day Age (H*) (Number of Days until today's date 11-6-2023), sort from the youngest
SELECT COUNT(*) AS 'Counter', DATEDIFF(DAY, BirthDate, '2023-11-07') AS 'Day Age', BirthDate
FROM HumanResources.Employee
GROUP BY DATEDIFF(DAY, 2023-11-07, BirthDate), BirthDate
ORDER BY 'Day Age'

-- 96. Show the value counts for each Day Age (H*) (Number of Days until today's date 11-6-2023), only keep the Day with the value counts greater than 1
SELECT COUNT(*) AS 'Counter', DATEDIFF(DAY, BirthDate, '2023-11-07') AS 'Day Age', BirthDate
FROM HumanResources.Employee
GROUP BY DATEDIFF(DAY, 2023-11-07, BirthDate), BirthDate
HAVING COUNT(*) > 1
ORDER BY 'Day Age'

-- 97. Show the total numbers of characters for all EmailAddress (E) based on OrganizationLevel (H)
SELECT H.OrganizationLevel, SUM(LEN(E.EmailAddress)) AS 'Total Character Count'
FROM HumanResources.Employee H
JOIN Person.EmailAddress E ON H.BusinessEntityID = E.BusinessEntityID
GROUP BY H.OrganizationLevel

-- 98. Show the total and average numbers of characters for all EmailAddress (E) based on OrganizationLevel (H) + PersonType (P), order be OrganizationLevel > PersonType
SELECT SUM(LEN(E.EmailAddress)) AS 'Total Character Count', ROUND(AVG(CAST(LEN(E.EmailAddress) AS FLOAT)) ,2) AS 'Average Character Count' , H.OrganizationLevel, P.PersonType
FROM HumanResources.Employee H 
JOIN Person.Person P ON H.BusinessEntityID = P.BusinessEntityID
JOIN Person.EmailAddress E ON H.BusinessEntityID = E.BusinessEntityID
GROUP BY H.OrganizationLevel, P.PersonType
ORDER BY H.OrganizationLevel, P.PersonType

-- 99. Show value counts, max, min, average, sum of Characters of LoginID (H) for the combination of the group OrganizationLevel (H) + PersonType (P) + Gender (H) + EmailPromotion (P), order by OrganizationLevel > COUNT
WITH #Task_99 AS(
    SELECT 
        LoginID, 
        CASE
            WHEN CHARINDEX('\', LoginID) > 0 THEN SUBSTRING(LoginID, CHARINDEX('\', LoginID) + 1, LEN(LoginID))
            ELSE LoginID
        END AS 'NewLoginID'
    FROM HumanResources.Employee
)
SELECT 
    COUNT(*) AS 'Counter', 
    MAX(LEN(TEMP.NewLoginID)) AS 'Max Length', 
    MIN(LEN(TEMP.NewLoginID)) AS 'Min Length', 
    ROUND(AVG(CAST(LEN(CONVERT(varchar, TEMP.NewLoginID)) AS float)), 3) AS 'AVG Length',
    SUM(LEN(CONVERT(varchar, TEMP.NewLoginID))) AS 'Sum Length',
    H.OrganizationLevel,
    P.PersonType,
    H.Gender,
    P.EmailPromotion
FROM HumanResources.Employee H 
JOIN Person.Person P ON H.BusinessEntityID = P.BusinessEntityID
JOIN #Task_99 TEMP ON TEMP.LoginID = H.LoginID
GROUP BY H.OrganizationLevel, P.PersonType, H.Gender, P.EmailPromotion
ORDER BY H.OrganizationLevel, COUNT(*)

/* 100. Show value counts, SUM of Characters of LastName (P), for the combination of the group 
OrganizationLevel (H) + Gender (H) + PersonType (P), Only keep the one with SUM of LastName (P) less than 100 , order by OrganizationLevel > COUNT */
SELECT COUNT(*) AS 'Counter', SUM(LEN(P.LastName)) AS 'Total Characters', H.OrganizationLevel, H.Gender, P.PersonType
FROM HumanResources.Employee H
JOIN Person.Person P ON H.BusinessEntityID = P.BusinessEntityID
GROUP BY H.OrganizationLevel, H.Gender, P.PersonType
HAVING SUM(LEN(P.LastName)) < 100
ORDER BY H.OrganizationLevel, COUNT(*)