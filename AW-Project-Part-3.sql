-- Part 3: 8/11/2023

-- Tables used for practicing
-- List of customers (PK: CustomerID)
SELECT * FROM Sales.Customer   
-- Keyword: C

-- List of stores (PK: BusinessEntityID)
SELECT * FROM Sales.Store          
-- Keyword: S

-- List of employees (PK: BusinessEntityID)
SELECT * FROM HumanResources.Employee       
-- Keyword: H

-- List of Vendors (PK: BusinessEntityID)
SELECT * FROM Purchasing.Vendor            
-- Keyword: V

-- List of Business Entity
SELECT * FROM Person.BusinessEntity         
-- Keyword: BE
----------------------------------------------------------------
-- ADVENTURE WORK PRACTICE PROJECT
-- TASK 101 TO 150
-- KNOWLEDGE COVERED: REPLACE, CTE, Multi-CTE, DATEPART, DATEDIFF, CAST, CASE/WHEN, NTILE, NEWID (Shuffle Random Order)
----------------------------------------------------------------

-- 101. Show all the value counts for all TerritoryID (C), sort from the smallest TerritoryID
SELECT TerritoryID, COUNT(*) AS 'Counter'
FROM Sales.Customer
GROUP BY TerritoryID
ORDER BY TerritoryID

-- 102. Show only the MAX and MIN counter of TerritoryID (C) groups.
WITH Task_102_max AS(
    SELECT TOP 1 TerritoryID, COUNT(*) AS 'Counter'
    FROM Sales.Customer
    GROUP BY TerritoryID
    ORDER BY COUNT(*) DESC
), Task_102_min AS(
    SELECT TOP 1 TerritoryID, COUNT(*) AS 'Counter'
    FROM Sales.Customer
    GROUP BY TerritoryID
    ORDER BY COUNT(*) ASC
)
SELECT * FROM Task_102_max
UNION 
SELECT * FROM Task_102_min;

-- 103. Check if the CustomerID (C) matches all AccountNumber (C) characters at the furthest right
WITH Task_103 AS(
    SELECT 
    CustomerID, 
    AccountNumber,
    CASE 
        WHEN RIGHT(AccountNumber, LEN(CustomerID)) = CustomerID THEN 1
        ELSE 0
    END AS 'Verification'
    FROM Sales.Customer
)
SELECT 
    SUM(CASE WHEN Verification = 0 THEN 1 ELSE 0 END) AS Count_0,
    SUM(CASE WHEN Verification = 1 THEN 1 ELSE 0 END) AS Count_1,
    CASE
        WHEN SUM(CASE WHEN Verification = 1 THEN 1 ELSE 0 END) = 0 THEN NULL
        ELSE CAST(SUM(CASE WHEN Verification = 0 THEN 1 ELSE 0 END) AS DECIMAL) / SUM(CASE WHEN Verification = 1 THEN 1 ELSE 0 END)
    END AS Ratio
FROM Task_103

-- 104. Show all the value counts for all StoreID (C)
SELECT StoreID, COUNT(*) AS 'Counter'
FROM Sales.Customer
GROUP BY StoreID
ORDER BY StoreID

-- 105. Show all StoreID (C) with 1 or 3 in Counter
SELECT StoreID, COUNT(*) AS 'Counter'
FROM Sales.Customer
GROUP BY StoreID
HAVING COUNT(*) = 1 OR COUNT(*) = 3 
ORDER BY StoreID

-- 106. See all the Customer (C) who has TerritoryID (C) is between 6 and 8, and has the AccountNumber (C) starts with AW
SELECT *
FROM Sales.Customer
WHERE TerritoryID BETWEEN 6 AND 8 AND AccountNumber LIKE 'AW%'

-- 107. See all the Customer (C) who has the Lowest StoreID that is not NULL 
-- (There are multiple records that share the same StoreID)
WITH Lowest_StoreID_107 AS(
    SELECT TOP 1 StoreID
    FROM Sales.Customer
    WHERE StoreID IS NOT NULL
    ORDER BY StoreID
)
SELECT *
FROM Sales.Customer
WHERE StoreID = (SELECT StoreID FROM Lowest_StoreID_107)

-- 108. See all the Customer (C) who has the Highest StoreID and Lowest StoreID (NULL not count) 
-- (There are multiple records that share the same StoreID)
WITH Lowest_StoreID_107 AS(
    SELECT TOP 1 StoreID
    FROM Sales.Customer
    WHERE StoreID IS NOT NULL
    ORDER BY StoreID
), Highest_StoreID_107 AS(
    SELECT TOP 1 StoreID
    FROM Sales.Customer
    WHERE StoreID IS NOT NULL
    ORDER BY StoreID DESC
)
SELECT *
FROM Sales.Customer
WHERE StoreID = (SELECT StoreID FROM Lowest_StoreID_107)
OR StoreID = (SELECT StoreID FROM Highest_StoreID_107)

-- 109. Show all business with the Name (S) contains "Bike", and SalesPersonID contains "79"
SELECT *
FROM Sales.Store
WHERE Name LIKE '%Bike%' AND SalesPersonID LIKE '%79%'

-- 110. Show all data of Employee (H) and Business (S) at one single table
SELECT *
FROM HumanResources.Employee H 
FULL JOIN Sales.Store S ON H.BusinessEntityID = S.BusinessEntityID

-- 111. Show all the Business Name (S) that has Length of Name (S) higher than 13, order by the Name (S) descending
SELECT *
FROM Sales.Store
WHERE LEN(Name) > 13
ORDER BY Name DESC

-- 112. Show all the LoginID (H) (only the username after the slash \) that who have VacationHours (H) greater than 69
SELECT DISTINCT SUBSTRING(LoginID, CHARINDEX('\', LoginID) + 1, LEN(LoginID)) AS LoginID, VacationHours
FROM HumanResources.Employee
WHERE VacationHours > 69

-- 113. Show all the LoginID (H) (only the username after the slash \) who have SickLeaveHours (H) lower or equal 32, obly get the ones in OrganizationLevel (H) is NOT NULL
SELECT DISTINCT SUBSTRING(LoginID, CHARINDEX('\', LoginID) + 1, LEN(LoginID)) AS LoginID, SickLeaveHours
FROM HumanResources.Employee
WHERE SickLeaveHours <= 32 AND OrganizationLevel IS NOT NULL

-- 114. Show the TOTAL character counts of LoginID (H) (only the username after the slash \) based by OrganizationLevel (H) Groups, order from the smallest group
SELECT SUM(LEN(SUBSTRING(LoginID, CHARINDEX('\', LoginID) + 1, LEN(LoginID)))) AS Character_Counter, OrganizationLevel
FROM HumanResources.Employee
GROUP BY OrganizationLevel

-- 115. Show the TOTAL character counts of LoginID (H) (only the username after the slash \) based by OrganizationLevel (H) + MaritalStatus (H) + Gender (H), order from the Biggest SUM group
SELECT OrganizationLevel, MaritalStatus, Gender, SUM(LEN(SUBSTRING(LoginID, CHARINDEX('\', LoginID) + 1, LEN(LoginID)))) AS Character_Counter
FROM HumanResources.Employee
GROUP BY OrganizationLevel, MaritalStatus, Gender

-- 116. Split the Employee (H) table into 4 groups, ranged from the one with the lowest VacationHours (H)
SELECT NTILE(4) OVER (ORDER By VacationHours) AS Group_Number, *
FROM HumanResources.Employee

-- 117. Split the Employee (H) table into 4 groups, ranged from the one with the lowest Gender (H) + SickLeaveHours (H)
SELECT NTILE(4) OVER (ORDER BY Gender, SickLeaveHours) AS Group_Number, *
FROM HumanResources.Employee

-- 118. Split the Employee (H) table into 7 groups, ranged from the one with the lowest characters in LoginID (H)
SELECT NTILE(7) OVER (ORDER BY LEN(LoginID)) AS Group_Number, LEN(LoginID) AS Length_LoginID, *
FROM HumanResources.Employee

-- 119. Split the Store (S) table into 9 groups, ranged from the one with the highest number of characters in Name (S)
SELECT NTILE(9) OVER (ORDER BY LEN(Name) DESC) AS Group_Number, LEN(Name) AS Length_Name, *
FROM Sales.Store

-- 120. Split the Employee (H) table into 5 groups, order by Age (H) (Datediff Year from 7/11/2023)
SELECT NTILE(5) OVER (ORDER BY DATEDIFF(YEAR, BirthDate, '2023-11-7')) AS Group_Number, DATEDIFF(YEAR, BirthDate, '2023-11-7') AS Age, *
FROM HumanResources.Employee

-- 121. Split the Employee (H) table into 3 groups, order by Descending Day Age (H) (Datediff Day from 7/11/2023)
SELECT NTILE(3) OVER (ORDER BY DATEDIFF(DAY, BirthDate, '2023-11-7') DESC) AS Group_Number, DATEDIFF(DAY, BirthDate, '2023-11-7') AS Day_Age, *
FROM HumanResources.Employee;

-- 122. Split the Employee (H) table into 3 groups, order by Descending Age (H) (Datediff Year from 7/11/2023) then show the highest and lowest Age (H) from each group (Multiple people shares the same Age)
WITH Task_122_Split AS(
    SELECT NTILE(3) OVER (ORDER BY DATEDIFF(YEAR, BirthDate, '2023-11-7') DESC) AS Group_Number, DATEDIFF(YEAR, BirthDate, '2023-11-7') AS Age, *
    FROM HumanResources.Employee
), Task_122_MinMax AS(
    SELECT MAX(Age) AS Max_Age, MIN(Age) AS Min_Age, Group_Number
    FROM Task_122_Split
    GROUP BY Group_Number
)
SELECT *
FROM Task_122_Split
JOIN Task_122_MinMax
ON Task_122_Split.Age = Task_122_MinMax.Max_Age
UNION
SELECT *
FROM Task_122_Split
JOIN Task_122_MinMax
ON Task_122_Split.Age = Task_122_MinMax.Min_Age

-- 123. Split the Vendor (V) table into 5 groups, order by Descending CreditRating (V) > Ascending ModifiedDate (V)
SELECT NTILE(5) OVER (ORDER BY CreditRating DESC, ModifiedDate) AS Group_Number, CreditRating, ModifiedDate, *
FROM Purchasing.Vendor;

-- 124. Split the Employee (H) table into 4 groups, order by Descending MaritalStatus (H) + Descending Gender (H), then calculate the Total of MILLISECONDs in ModifiedDate (BE)
WITH Task_124_Split AS(
    SELECT NTILE(4) OVER (ORDER BY H.MaritalStatus DESC, H.Gender DESC) AS Group_Number, DATEPART(MILLISECOND, BE.ModifiedDate) AS 'Millisecond' , H.*
    FROM HumanResources.Employee H
    JOIN Person.BusinessEntity BE ON H.BusinessEntityID = BE.BusinessEntityID
)
SELECT Group_Number, SUM(Millisecond) AS Total_Ms
FROM Task_124_Split
GROUP BY Group_Number;

-- 125. Split the Vendor (V) table into 4 groups, order by Descending Length of AccountNumber (V) + Ascending Length of Name (V), 
-- then calculate the Total and Average (Float) of Credit Rating (V) for each group
WITH Task_125 AS(
    SELECT NTILE(4) OVER (ORDER BY LEN(AccountNumber) DESC, LEN(Name) ASC) AS Group_Number, *
    FROM Purchasing.Vendor
)
SELECT SUM(CreditRating) AS  Total_Rating, AVG(CAST(CreditRating AS float)) AS AVG_Rating, Group_Number
FROM Task_125
GROUP BY Group_Number;

-- 126. Split Customer (C) into 8 parts, order by TerritoryID (C) > Descending StoreID (C) > CustomerID (C), then find the SUM of CustomerID (C) for each group
WITH Task_126 AS(
    SELECT NTILE(8) OVER (ORDER BY TerritoryID, StoreID DESC, CustomerID) AS Group_Number, * 
    FROM Sales.Customer
)
SELECT Group_Number, SUM(CustomerID) AS Sum_ID
FROM Task_126
GROUP BY Group_Number;

-- 127. Split the Store (S) table into 2 groups, order by SalesPersonID Descending (S) > rowguid (S), then apply Count, Sum (Length of Name (S)) each group
WITH Task_127 AS(
    SELECT NTILE(2) OVER (ORDER BY SalesPersonID DESC, rowguid) AS Group_Number, *
    FROM Sales.Store
)
SELECT COUNT(*) AS Counter, SUM(LEN(Name)) AS Length_Name, Group_Number
FROM Task_127
GROUP BY Group_Number;

-- 128. Split the Store (S) table into 3 groups, order by BusinessEntityID Descending (H), then find the longest Name (S) for each group
WITH Task_128 AS(
    SELECT NTILE(3) OVER (ORDER BY BusinessEntityID DESC) AS Group_Number, *
    FROM Sales.Store
)
SELECT Group_Number, MAX(LEN(Name)) AS Longest_Name
FROM Task_128
GROUP BY Group_Number

-- Shuffle Order --
-- 129. Split the Employee (H) table into 7 random groups, then find the Jobtitle (H) appears the most and least on each group
SELECT *
FROM HumanResources.Employee
ORDER BY NEWID()

-- 130. Split the Vendor (V) table into 10 random groups (Shuffle Order before Spliting), 
-- then show the number of characters of the longest Name (V), total length of the PurchasingWebServiceURL (V) from each group
WITH Task_130_ShuffleSplit AS(
    SELECT NTILE(10) OVER (ORDER BY NEWID()) AS Group_Number, *
    FROM Purchasing.Vendor
)   
SELECT Group_Number, MAX(LEN(Name)) AS Longest_Name, SUM(LEN(PurchasingWebServiceURL)) AS Sum_URL
FROM Task_130_ShuffleSplit
GROUP BY Group_Number;

-- 131. Split the Customer (C) table into 6 groups, apply descending order of rowguid (C), then find the Sum of TerritoryID (C) from each group
WITH Task_131 AS(
    SELECT NTILE(6) OVER (ORDER BY rowguid DESC) AS Group_Number, *
    FROM Sales.Customer
)
SELECT Group_Number, SUM(TerritoryID) AS Sum_Territory
FROM Task_131
GROUP BY Group_Number;

----- CASE/WHEN -----
-- 132. Split the Customer (C) table into 4 random groups, then find the total StoreScore (C)(4-digit StoreID = 10 points, 3-digit StoreID = 4 points, else 1)
WITH Task_132 AS(
    SELECT NTILE(4) OVER (ORDER BY NEWID()) AS Group_Number, 
        CASE
            WHEN LEN(StoreID) = 4 THEN 10
            WHEN LEN(StoreID) = 3 THEN 4
            ELSE 1
        END AS Store_Score, 
        *
    FROM Sales.Customer
)
SELECT Group_Number, SUM(Store_Score) AS Total_Score
FROM Task_132
GROUP BY Group_Number;

-- 133. Split the Customer (C) table into 10 random groups, then find the total CustomerLuck (For each number '6' in rowguid: +25 points, for each number '9': + 18 points), 
-- only get the 2 groups with HIGHEST CustomerLuck
WITH Task_133 AS(
    SELECT NTILE(10) OVER (ORDER BY NEWID()) AS Group_Number, 
        LEN(rowguid) - LEN(REPLACE(rowguid, '6', '')) AS Counter_6,
        LEN(rowguid) - LEN(REPLACE(rowguid, '9', '')) AS Counter_9,
        *
    FROM Sales.Customer
)
SELECT TOP 2 Group_Number, (SUM(Counter_6) * 25 + SUM(Counter_9) * 18) AS Total_CustomerLuck
FROM Task_133
GROUP BY Group_Number
ORDER BY Total_CustomerLuck DESC

-- 134. Show the New Customer (C) with a new "Rating" column knowing: If TerritoryID (C) is Odd: +1.1 rating, Even: -0.9 rating, 
-- If the StoreID is NOT missing, then multiply Rating with StoreID (C), Else multiply Rating by 300
SELECT 
    CASE
        WHEN TerritoryID % 2 = 0 AND StoreID IS NOT NULL THEN -0.9 * StoreID
        WHEN TerritoryID % 2 = 1 AND StoreID IS NOT NULL THEN 1.1 * StoreID
        WHEN TerritoryID % 2 = 0 AND StoreID IS NULL THEN -0.9 * 300
        ELSE 1.1 * 300
    END AS Rating, 
    *
FROM Sales.Customer;

-- 135. Use the #134 table to split into 9 parts ranking by the most rating
WITH Task_134 AS(
    SELECT 
        CASE
            WHEN TerritoryID % 2 = 0 AND StoreID IS NOT NULL THEN -0.9 * StoreID
            WHEN TerritoryID % 2 = 1 AND StoreID IS NOT NULL THEN 1.1 * StoreID
            WHEN TerritoryID % 2 = 0 AND StoreID IS NULL THEN -0.9 * 300
            ELSE 1.1 * 300
        END AS Rating, 
        *
    FROM Sales.Customer 
), Task_135_Split AS (
    SELECT NTILE(9) OVER (ORDER BY Rating) AS Group_Number, *
    FROM Task_134
)
SELECT Group_Number, SUM(Rating) AS Sum_Rating
FROM Task_135_Split
GROUP BY Group_Number
ORDER BY Sum_Rating DESC

-- 136. Show all the Employee (H) with Red Flag (If Vacation Hours (H) + SickLeaveHours (H) larger than 100 = RED), order the table from the one with the highest Age (2023 - BirthDate YEAR)
SELECT 
    CASE 
        WHEN VacationHours + SickLeaveHours > 100 THEN 'RED'
    END AS Flag, 
    (VacationHours + SickLeaveHours) AS Flag_Hour,
    DATEDIFF(YEAR, BirthDate, '2023-12-12') AS Age,
    *
FROM HumanResources.Employee
WHERE VacationHours + SickLeaveHours > 100
ORDER BY DATEDIFF(YEAR, BirthDate, '2023-12-12') DESC

-- 137. Show all the Employee (H) with Red Flag And Green Flag, Order by Flag (new column) > NationalIDNumber 
-- (IF ([VacationHours (H) + SickLeaveHours (H)] x OrganizationLevel is greater than 300 = RED,
-- IF an employee has RED flag but JobTitle (H) starts with "Production" or "Sales", RED will be changed to GREEN flag)
WITH Task_137 AS(
    SELECT 
        CASE 
            WHEN (VacationHours + SickLeaveHours) * OrganizationLevel > 300 AND (JobTitle LIKE 'Production%' OR JobTitle LIKE 'Sales%') THEN 'GREEN'
            WHEN (VacationHours + SickLeaveHours) * OrganizationLevel > 300 THEN 'RED'
        END AS Flag,
        (VacationHours + SickLeaveHours) * OrganizationLevel AS FlagPoint,
        *
    FROM HumanResources.Employee
)
SELECT *
FROM Task_137
WHERE Flag = 'RED' OR Flag = 'GREEN'
ORDER BY Flag, NationalIDNumber

-- 138. Use table from Task #137 but this time, DO NOT FILTER only the RED and GREEN. Records with No Flag will has WHITE flag now adn will be included in the table,
-- add a column to show Flag_Tag [NationalIDNumber (H) - Flag] (Example: 123456-RED). Show all records and their corresponding Flag_Tag
WITH Task_137_Recycled AS(
    SELECT 
        CASE 
            WHEN (VacationHours + SickLeaveHours) * OrganizationLevel > 300 AND (JobTitle LIKE 'Production%' OR JobTitle LIKE 'Sales%') THEN 'GREEN'
            WHEN (VacationHours + SickLeaveHours) * OrganizationLevel > 300 THEN 'RED'
        END AS Flag,
        (VacationHours + SickLeaveHours) * OrganizationLevel AS FlagPoint,
        *
    FROM HumanResources.Employee
), Task_138 AS(
    SELECT 
        CASE 
            WHEN Flag IS NULL THEN 'WHITE'
            ELSE Flag
        END AS New_Flag,
        *
    FROM Task_137_Recycled
)
SELECT CONCAT(NationalIDNumber, '-', New_Flag) AS Flag_Tag, *
FROM Task_138;

-- 139. Find the Vendor GROUP (V) with the most Vendor_Point (new column). Each letter E (both Uppercase and Lowercase) in Name (V) plus 0.9 points, 
-- Each A (upper and lower) plus 1.7 points, then multiply with Length of Name (V) will result Vendor_Point. Divide into 5 groups based on Descending Day of ModifiedDate (V)
WITH Table_139_Counter AS(
    SELECT 
        LEN(Name) - LEN(REPLACE(Name, 'E', '')) AS Counter_E,
        LEN(Name) - LEN(REPLACE(Name, 'A', '')) AS Counter_A,
        *
    FROM Purchasing.Vendor
), Table_139_Point AS(
    SELECT ((Counter_E * 0.9) + (Counter_A * 1.7)) AS Vendor_Point, *
    FROM Table_139_Counter
)
SELECT NTILE(5) OVER (ORDER BY DATEPART(DAY, ModifiedDate) DESC) AS Group_Number, DATEPART(DAY, ModifiedDate) AS Day_Editted, *
FROM Table_139_Point

-- 140. Show the BusinessEntityID (V), Name (V), and a column to show the multiplication of CreditRating (V) x Length of Name (V) x WeekDay of ModifiedDate
SELECT BusinessEntityID, Name,
    CreditRating * LEN(Name) * DATEPART(WEEKDAY, ModifiedDate) AS Result
FROM Purchasing.Vendor;

-- 141. Use table #140 to split into 3 Parts ranking from the largest multiplication result: "Amateur", "Intermediate" and "Advanced", 
-- then display the BusinessEntity (BE) added that new column
WITH Task_140 AS(
    SELECT BusinessEntityID, Name,
    CreditRating * LEN(Name) * DATEPART(WEEKDAY, ModifiedDate) AS Result
    FROM Purchasing.Vendor
), Task_141 AS(
    SELECT NTILE(3) OVER (ORDER BY Result DESC) AS Group_Name, *
    FROM Task_140
), Task_141_Rank AS(
    SELECT 
        CASE 
            WHEN Group_Name = 1 THEN 'Amateur'
            WHEN Group_Name = 2 THEN 'Intermediate'
            ELSE 'Advanced'
        END AS Group_Name_2,
        BusinessEntityID, Name, Result
    FROM Task_141
)
SELECT BE.*
FROM Person.BusinessEntity BE 
JOIN Task_141_Rank TEMP ON BE.BusinessEntityID = TEMP.BusinessEntityID

-- 142. Show the Employee NationalIDNumber (H), Age (Today - BirthDate (H)), JobTitle (H), Credit (New column)
-- Credit = Month Of BirthDate (H) x 20 (Special Case ~ MartitalStatus S: +100, Gender F: +80 ), Sort the table by highest Credit
SELECT NationalIDNumber, DATEDIFF(YEAR, BirthDate, '2023-11-8') AS Age, JobTitle, 
    CASE
        WHEN MaritalStatus = 'S' AND Gender = 'F' THEN 180 + DATEPART(MONTH, BirthDate) * 20
        WHEN MaritalStatus = 'S' AND NOT Gender ='F' THEN 100 + DATEPART(MONTH, BirthDate) * 20
        WHEN NOT MaritalStatus = 'S' AND Gender ='F' THEN 80 + DATEPART(MONTH, BirthDate) * 20
        ELSE DATEPART(MONTH, BirthDate) * 20
    END AS Credit
FROM HumanResources.Employee
ORDER BY Credit DESC

-- 143. Show the Employee's NationalIDNumber (H), Month Age (Today - BirthDate (H)), Length of JobTitle (H), Credit (New column)
-- Credit (DAY Of BirthDate (H) x 1.5, Special Case ~ [MaritalStatus = Gender]: Multiply Credit by 4), order from the Highest Credit
SELECT NationalIDNumber, DATEPART(MONTH, BirthDate) AS Month_Age, LEN(JobTitle) AS Length_Job,
    CASE 
        WHEN MaritalStatus = Gender THEN DATEPART(DAY, BirthDate) * 1.5 * 4
        ELSE DATEPART(DAY, BirthDate) * 1.5
    END AS Credit
FROM HumanResources.Employee
ORDER BY Credit DESC

-- 144. Show the Employee's NationalIDNumber (H), Day Age (Today - BirthDate (H)), Credit (new column)
-- Default Credit = 50 (JobTitle (H) contains "Designer": +60, OR contains "Supervisor": +90; MULTIPLY Credit by OrganizationLevel (H))
SELECT NationalIDNumber, DATEDIFF(DAY, BirthDate, '2023-11-8') AS Day_Age, BirthDate,
    CASE 
        WHEN JobTitle LIKE '%Desginer%' THEN 60 * OrganizationLevel + 50
        WHEN JobTitle LIKE '%Supervisor%' THEN 90 * OrganizationLevel + 50
        ELSE 50
    END AS Credit
FROM HumanResources.Employee

-- 145. Show the LoginID (H) (only the part after the slash "\"), Credit (new column) [Order by highest Credit]
-- Credit (Length of New LoginID (H) x 1.25 + Age (H) x 6 + Length of JobTitle (H) x 10)
SELECT SUBSTRING(LoginID, CHARINDEX('\', LoginID) + 1, LEN(LoginID)) AS New_LoginID,
    (LEN(SUBSTRING(LoginID, CHARINDEX('\', LoginID) + 1, LEN(LoginID))) * 1.25) + (DATEDIFF(YEAR, BirthDate, '2023-11-8')* 6) + (LEN(JobTitle) * 10) AS Credit
FROM HumanResources.Employee
ORDER BY Credit DESC

-- 146. Find the Mean point for Credit column in Task #145, then display all LoginID (H) that are in range of 5 (UP and DOWN) with Credit
WITH Task_145 AS(
    SELECT SUBSTRING(LoginID, CHARINDEX('\', LoginID) + 1, LEN(LoginID)) AS New_LoginID,
        (LEN(SUBSTRING(LoginID, CHARINDEX('\', LoginID) + 1, LEN(LoginID))) * 1.25) + (DATEDIFF(YEAR, BirthDate, '2023-11-8')* 6) + (LEN(JobTitle) * 10) AS Credit
    FROM HumanResources.Employee
), Task_145_AC AS(
    SELECT AVG(Credit) AS AVG_Credit
    FROM Task_145
)
SELECT A.*, MINCRE.AVG_Credit
FROM Task_145 A
RIGHT JOIN Task_145_AC MINCRE ON MINCRE.AVG_Credit - 5 < A.Credit
RIGHT JOIN Task_145_AC MAXCRE ON MAXCRE.AVG_Credit + 5 > A.Credit

-- 147. Order from the largest NationalIDNumber (H), split the table #145 into 15 groups
WITH Task_145 AS(
    SELECT SUBSTRING(LoginID, CHARINDEX('\', LoginID) + 1, LEN(LoginID)) AS New_LoginID,
        (LEN(SUBSTRING(LoginID, CHARINDEX('\', LoginID) + 1, LEN(LoginID))) * 1.25) + (DATEDIFF(YEAR, BirthDate, '2023-11-8')* 6) + (LEN(JobTitle) * 10) AS Credit
    FROM HumanResources.Employee
)
SELECT NTILE(15) OVER (ORDER BY NationalIDNumber DESC) AS Group_Number, H.NationalIDNumber, TEMP.*
FROM Task_145 TEMP
JOIN HumanResources.Employee H ON TEMP.New_LoginID = SUBSTRING(LoginID, CHARINDEX('\', LoginID) + 1, LEN(LoginID))

-- 148. Use table from task #147, for EACH GROUP, 
-- find the Credit Range (largest - smallest), Sum of Credit, The Closest Number to the Credit Range that is DIVISIBLE BY 5 
WITH Task_145 AS(
    SELECT SUBSTRING(LoginID, CHARINDEX('\', LoginID) + 1, LEN(LoginID)) AS New_LoginID,
        (LEN(SUBSTRING(LoginID, CHARINDEX('\', LoginID) + 1, LEN(LoginID))) * 1.25) + (DATEDIFF(YEAR, BirthDate, '2023-11-8')* 6) + (LEN(JobTitle) * 10) AS Credit
    FROM HumanResources.Employee
), Task_147 AS(
    SELECT NTILE(15) OVER (ORDER BY NationalIDNumber DESC) AS Group_Number, H.NationalIDNumber, TEMP.*
    FROM Task_145 TEMP
    JOIN HumanResources.Employee H ON TEMP.New_LoginID = SUBSTRING(LoginID, CHARINDEX('\', LoginID) + 1, LEN(LoginID))
), Task_148_Grouped AS(
    SELECT Group_Number, 
        MAX(Credit) - MIN(Credit) AS Range_Credit,
        CAST(ROUND(MAX(Credit) - MIN(Credit), 0) AS int) AS Range_Credit_Rounded, 
        SUM(Credit) AS Sum_Credit
    FROM Task_147
    GROUP BY Group_Number
)
SELECT 
    Group_Number, 
    Range_Credit,
    CASE 
        WHEN Range_Credit_Rounded % 5 <= 2 THEN Range_Credit_Rounded - (Range_Credit_Rounded % 5)
        ELSE Range_Credit_Rounded + 5 - (Range_Credit_Rounded % 5)
    END AS Closest_Number_Divisible_By_5,
    Sum_Credit
FROM Task_148_Grouped;

-- 149. Use table from task #147, for each row, round the 'Credit' column to the nearest integer, 
-- and then calculate the date that is the exact number of days in the past from today's date, and store this date in a new column.
WITH Task_145 AS(
    SELECT SUBSTRING(LoginID, CHARINDEX('\', LoginID) + 1, LEN(LoginID)) AS New_LoginID,
        (LEN(SUBSTRING(LoginID, CHARINDEX('\', LoginID) + 1, LEN(LoginID))) * 1.25) + (DATEDIFF(YEAR, BirthDate, '2023-11-8')* 6) + (LEN(JobTitle) * 10) AS Credit
    FROM HumanResources.Employee
), Task_147 AS(
    SELECT NTILE(15) OVER (ORDER BY NationalIDNumber DESC) AS Group_Number, H.NationalIDNumber, TEMP.*
    FROM Task_145 TEMP
    JOIN HumanResources.Employee H ON TEMP.New_LoginID = SUBSTRING(LoginID, CHARINDEX('\', LoginID) + 1, LEN(LoginID))
)
SELECT TEMP.Group_Number, TEMP.NationalIDNumber, TEMP.New_LoginID, 
    CAST(ROUND(TEMP.Credit, 0) AS int) AS Rounded_Credit, 
    DATEADD(DAY, -CAST(ROUND(TEMP.Credit, 0) AS int) , '2023-11-8') AS Past_Day
FROM Task_147 TEMP;

-- 150. Take table #149 and shuffle the index of the table. Then display all columns
WITH Task_145 AS(
    SELECT SUBSTRING(LoginID, CHARINDEX('\', LoginID) + 1, LEN(LoginID)) AS New_LoginID,
        (LEN(SUBSTRING(LoginID, CHARINDEX('\', LoginID) + 1, LEN(LoginID))) * 1.25) + (DATEDIFF(YEAR, BirthDate, '2023-11-8')* 6) + (LEN(JobTitle) * 10) AS Credit
    FROM HumanResources.Employee
), Task_147 AS(
    SELECT NTILE(15) OVER (ORDER BY NationalIDNumber DESC) AS Group_Number, H.NationalIDNumber, TEMP.*
    FROM Task_145 TEMP
    JOIN HumanResources.Employee H ON TEMP.New_LoginID = SUBSTRING(LoginID, CHARINDEX('\', LoginID) + 1, LEN(LoginID))
), Task_149 AS(
    SELECT TEMP.Group_Number, TEMP.NationalIDNumber, TEMP.New_LoginID, 
        CAST(ROUND(TEMP.Credit, 0) AS int) AS Rounded_Credit, 
        DATEADD(DAY, -CAST(ROUND(TEMP.Credit, 0) AS int) , '2023-11-8') AS Past_Day
    FROM Task_147 TEMP
)
SELECT *
FROM Task_149
ORDER BY NEWID()