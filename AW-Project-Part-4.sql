-- Part 4: 9/11/2023

-- Tables used for practicing
-- List of Employees Assigned with Departments/Shifts (PK: BusinessEntityID + DepartmentID + ShiftID)
SELECT * FROM HumanResources.EmployeeDepartmentHistory
-- Keyword: A

-- List of Employees in Human Resources (PK: BusinessEntityID)
SELECT * FROM HumanResources.Employee
-- Keyword: H

-- List of Departments (PK: DepartmentID)
SELECT * FROM HumanResources.Department
-- Keyword: D

-- List of Shifts (PK: ShiftID)
SELECT * FROM HumanResources.Shift
-- Keyword: SH

-- List of Employee Paying Rate (PK: BusinessEntityID + RateExchangeDate)
SELECT * FROM HumanResources.EmployeePayHistory;
-- Keyword: P
----------------------------------------------------------------
-- ADVENTURE WORK PRACTICE PROJECT
-- TASK 151 TO 200
-- KNOWLEDGE COVERED: CTE, Subqueries, EXISTS, PIVOT, CASE/WHEN, RANK(), PARTITION
----------------------------------------------------------------

-- 151. List all NationalIDNumber (H) of Employee who have DepartmentID (A) equal 15
-- Must use: JOIN
SELECT H.NationalIDNumber
FROM HumanResources.Employee H 
JOIN HumanResources.EmployeeDepartmentHistory A 
ON H.BusinessEntityID = A.BusinessEntityID
WHERE A.DepartmentID = 15

-- 152. List all NationalIDNumber (H) of Employee who have DepartmentID (A) equal 15
-- Must use: EXISTS
SELECT H.NationalIDNumber
FROM HumanResources.Employee H
WHERE EXISTS(
    SELECT A.BusinessEntityID 
    FROM HumanResources.EmployeeDepartmentHistory A
    WHERE A.BusinessEntityID = H.BusinessEntityID AND A.DepartmentID = 15
)

-- 153. List all LoginID (H) (Only the part after the slash '\'), Age (2023 - BirthDate (H)) who have DepatmentID (A) matches with ShiftID (A)
-- Must use: JOIN
SELECT 
    SUBSTRING(H.LoginID, CHARINDEX('\', H.LoginID) + 1, LEN(H.LoginID)) AS New_LoginID, 
    DATEDIFF(YEAR, BirthDate, '2023-11-9') AS Age
FROM HumanResources.Employee H
JOIN HumanResources.EmployeeDepartmentHistory A 
ON A.BusinessEntityID = H.BusinessEntityID
WHERE A.DepartmentID = A.ShiftID

-- 154. List all LoginID (H) (Only the part after the slash '\'), Age (2023 - BirthDate (H)) who have DepatmentID (A) matches with ShiftID (A)
-- Must use: EXISTS
SELECT 
    SUBSTRING(H.LoginID, CHARINDEX('\', H.LoginID) + 1, LEN(H.LoginID)) AS New_LoginID, 
    DATEDIFF(YEAR, BirthDate, '2023-11-9') AS Age
FROM HumanResources.Employee H
WHERE EXISTS (
    SELECT *
    FROM HumanResources.EmployeeDepartmentHistory A 
    WHERE A.BusinessEntityID = H.BusinessEntityID AND A.DepartmentID = A.ShiftID
)

-- 155. List all LoginID (H) (Only the part after the slash '\'), Sum Of VacationHours (H) + SickLeaveHours (H) 
-- who have ShiftID (A) = 2 and NOT have DepartmentID (A) in one of these: 3, 6, 9, 10, 16
-- Must use: JOIN
SELECT 
    SUBSTRING(H.LoginID, CHARINDEX('\', H.LoginID) + 1, LEN(H.LoginID)) AS New_LoginID,
    H.VacationHours + H.SickLeaveHours AS Total_Hours,
    A.DepartmentID,
    A.ShiftID
FROM HumanResources.Employee H
JOIN HumanResources.EmployeeDepartmentHistory A ON H.BusinessEntityID = A.BusinessEntityID
WHERE A.ShiftID = 2 AND NOT A.DepartmentID IN (3, 6, 9, 10, 16)

-- 156. List all LoginID (H) (Only the part after the slash '\'), Sum Of VacationHours (H) + SickLeaveHours (H) 
-- who have ShiftID (A) = 2 and NOT have DepartmentID (A) in one of these: 3, 6, 9, 10, 16
-- Must use: EXISTS
SELECT SUBSTRING(H.LoginID, CHARINDEX('\', H.LoginID) + 1, LEN(H.LoginID)) AS New_LoginID
FROM HumanResources.Employee H
WHERE EXISTS (
    SELECT *
    FROM HumanResources.EmployeeDepartmentHistory A
    WHERE A.BusinessEntityID = H.BusinessEntityID
    AND A.ShiftID = 2
    AND NOT A.DepartmentID IN (3, 6, 9, 10, 16)
)

-- 157. List all BusinessEntityID (H), NationalIDNumber (H), OrganizationLevel (H), ShiftID (A)
-- who have OrganizationLevel (H) as an Odd number, ShiftID (A) as an Even number and DepartmentID (A) divisible by 5 or 7 
-- Must use: JOIN
SELECT H.BusinessEntityID, H.NationalIDNumber, H.OrganizationLevel, A.ShiftID, A.DepartmentID
FROM HumanResources.Employee H
JOIN HumanResources.EmployeeDepartmentHistory A ON A.BusinessEntityID = H.BusinessEntityID
WHERE H.OrganizationLevel % 2 = 1 AND A.ShiftID % 2 = 0 AND (A.DepartmentID % 5 = 0 OR A.DepartmentID % 7 = 0)

-- 158. List all BusinessEntityID (H), NationalIDNumber (H), OrganizationLevel (H), ShiftID (A)
-- who have OrganizationLevel (H) as an Odd number, ShiftID (A) as an Even number and DepartmentID (A) divisible by 5 or 7 
-- Must use: EXISTS
SELECT H.BusinessEntityID
FROM HumanResources.Employee H
WHERE EXISTS (
    SELECT *
    FROM HumanResources.EmployeeDepartmentHistory A 
    WHERE A.BusinessEntityID = H.BusinessEntityID
    AND H.OrganizationLevel % 2 = 1
    AND A.ShiftID % 2 = 0
    AND (A.DepartmentID % 5 = 0 OR A.DepartmentID % 7 = 0)
)

-- 159. List all BusinessEntityID (H), LoginID (H) (Only the part after the slash '\'), JobTitle (H), Department Name (D)
-- who have ShiftID (A) greater or equal 2, GroupName (D) NOT containing "Develop"
-- Must use: JOIN
SELECT H.BusinessEntityID, SUBSTRING(H.LoginID, CHARINDEX('\', H.LoginID) + 1, LEN(H.LoginID)) AS New_LoginID, H.JobTitle, D.Name
FROM HumanResources.Employee H
JOIN HumanResources.EmployeeDepartmentHistory A ON A.BusinessEntityID = H.BusinessEntityID
JOIN HumanResources.Department D ON A.DepartmentID = D.DepartmentID
WHERE A.ShiftID >= 2 AND NOT D.GroupName LIKE '%Develop%'

-- 160. List all BusinessEntityID (H), LoginID (H) (Only the part after the slash '\'), JobTitle (H)
-- who have ShiftID (A) greater or equal 2, GroupName (D) NOT containing "Develop" and EndDate (A) is NOT NULL
-- Must use: EXISTS
SELECT H.BusinessEntityID, SUBSTRING(H.LoginID, CHARINDEX('\', H.LoginID) + 1, LEN(H.LoginID)) AS New_LoginID, H.JobTitle
FROM HumanResources.Employee H
WHERE EXISTS(
    SELECT *
    FROM HumanResources.EmployeeDepartmentHistory A
    WHERE EXISTS(
        SELECT *
        FROM HumanResources.Department D 
        WHERE H.BusinessEntityID = A.BusinessEntityID
        AND A.DepartmentID = D.DepartmentID
        AND A.ShiftID >= 2
        AND NOT D.GroupName LIKE '%Develop%'
    )
)

-- 161. List all BusinessEntityID (A) who have the Credit (Rate (P) x PayFrequency (P) - VacationHours (H)) greater than 100
-- Must use: JOIN
SELECT 
    A.BusinessEntityID, 
    P.Rate * P.PayFrequency - H.VacationHours AS Credit
FROM HumanResources.EmployeeDepartmentHistory A
JOIN HumanResources.EmployeePayHistory P ON A.BusinessEntityID = P.BusinessEntityID
JOIN HumanResources.Employee H ON A.BusinessEntityID = H.BusinessEntityID
WHERE P.Rate * P.PayFrequency - H.VacationHours > 100

-- 162. List all BusinessEntityID (A) who have the (Rate (P) x PayFrequency (P) - VacationHours (H)) greater than 100
-- Must use: EXISTS
SELECT 
    A.BusinessEntityID
FROM HumanResources.EmployeeDepartmentHistory A
WHERE EXISTS(
    SELECT 1 FROM HumanResources.EmployeePayHistory P 
    WHERE EXISTS(
        SELECT 1 FROM HumanResources.Employee H 
        WHERE H.BusinessEntityID = P.BusinessEntityID
        AND P.BusinessEntityID = A.BusinessEntityID
        AND P.Rate * P.PayFrequency - H.VacationHours > 100
    )
)

-- 163. List all the Employee LoginID (H) (Only the part after the slash '\') (H), NationalIDNumber (H), JobTitle (H)
-- who have the LuckyNumber (DepartmentID (A) + ShiftID (A) + Month of StartDate (A) * PayFrequency (P)) > 40
-- Must use: JOIN
SELECT 
    SUBSTRING(H.LoginID, CHARINDEX('\', H.LoginID) + 1, LEN(H.LoginID)) AS New_LoginID,
    H.NationalIDNumber,
    H.JobTitle,
    A.DepartmentID + A.ShiftID + DATEPART(MONTH, StartDate) * P.PayFrequency AS LuckyNumber
FROM HumanResources.Employee H
JOIN HumanResources.EmployeeDepartmentHistory A ON A.BusinessEntityID = H.BusinessEntityID
JOIN HumanResources.EmployeePayHistory P ON P.BusinessEntityID = H.BusinessEntityID
WHERE A.DepartmentID + A.ShiftID + DATEPART(MONTH, StartDate) * P.PayFrequency > 40

-- 164. List all the Employee LoginID (H) (Only the part after the slash '\') (H), NationalIDNumber (H), JobTitle (H)
-- who have the LuckyNumber (DepartmentID (A) + ShiftID (A) + Month of StartDate (A) * PayFrequency (P)) > 40
-- Must use: EXISTS
SELECT SUBSTRING(H.LoginID, CHARINDEX('\', H.LoginID) + 1, LEN(H.LoginID)) AS New_LoginID, H.NationalIDNumber, H.JobTitle
FROM HumanResources.Employee H 
WHERE EXISTS (
    SELECT * 
    FROM HumanResources.EmployeeDepartmentHistory A 
    WHERE EXISTS (
        SELECT *
        FROM HumanResources.EmployeePayHistory P 
        WHERE P.BusinessEntityID = A.BusinessEntityID
        AND A.BusinessEntityID = H.BusinessEntityID
        AND A.DepartmentID + A.ShiftID + DATEPART(MONTH, A.StartDate) * P.PayFrequency > 40
    )
)

-- 165. List all the Employee LoginID (H) (Only the part after the slash '\') (H), Age (H) (2023 - BirthDate)
-- who have the LuckyNumber (Month Day of BirthDate (H) * ShiftID (A) * (1 + BusinessEntityID (A) % 3)) greater than 200
-- Must use: JOIN
SELECT 
    SUBSTRING(H.LoginID, CHARINDEX('\', H.LoginID) + 1, LEN(H.LoginID)) AS New_LoginID, 
    DATEDIFF(YEAR, H.BirthDate, '2023-11-9') AS AGE,
    DATEPART(DAY, H.BirthDate) * A.ShiftID * (1 + (A.BusinessEntityID % 3)) AS LuckyNumber
FROM HumanResources.Employee H
JOIN HumanResources.EmployeeDepartmentHistory A ON H.BusinessEntityID = A.BusinessEntityID
WHERE DATEPART(DAY, H.BirthDate) * A.ShiftID * (1 + (A.BusinessEntityID % 3)) > 200

-- 166. List all the Employee LoginID (H) (Only the part after the slash '\') (H), Age (H) (2023 - BirthDate)
-- who have the LuckyNumber (Month Day of BirthDate (H) * ShiftID (A) * (1 + BusinessEntityID (A) % 3)) > 75
-- Must use: EXISTS
SELECT
    SUBSTRING(H.LoginID, CHARINDEX('\', H.LoginID) + 1, LEN(H.LoginID)) AS New_LoginID, 
    DATEDIFF(YEAR, H.BirthDate, '2023-11-9') AS AGE
FROM HumanResources.Employee H 
WHERE EXISTS(
    SELECT 1
    FROM HumanResources.EmployeeDepartmentHistory A
    WHERE A.BusinessEntityID = H.BusinessEntityID
    AND DATEPART(DAY, H.BirthDate) * A.ShiftID * (1 + (A.BusinessEntityID % 3)) > 200
)

-- 167. List all the Employee LoginID (H) (Only the part after the slash '\'), MaritalStatus (H), Gender (H) who have the Credit lower than 300
-- (Credit = 500 - VacationHours (H) - SickLeaveHours (H) - Rate (P), minus 30% if OrganizationLevel is 1, minus 50% if OrganizationLevel is 2)
-- Must use: JOIN
WITH Task_167_Credit AS(
    SELECT 
        SUBSTRING(H.LoginID, CHARINDEX('\', H.LoginID) + 1, LEN(H.LoginID)) AS New_LoginID, 
        H.MaritalStatus,
        H.Gender,
        CASE 
            WHEN H.OrganizationLevel = 1 THEN 0.7
            WHEN H.OrganizationLevel = 2 THEN 0.5
            ELSE 1
        END AS OrganizationDecrease,
        P.Rate, H.VacationHours, H.SickLeaveHours
    FROM HumanResources.Employee H
    JOIN HumanResources.EmployeeDepartmentHistory A ON H.BusinessEntityID = A.BusinessEntityID
    JOIN HumanResources.EmployeePayHistory P ON P.BusinessEntityID = H.BusinessEntityID
)
SELECT DISTINCT New_LoginID
FROM Task_167_Credit
WHERE (500 - VacationHours - SickLeaveHours - Rate) * OrganizationDecrease < 300

-- 168. List all the Employee LoginID (H) (Only the part after the slash '\'), MaritalStatus (H), Gender (H) who have the Credit lower than 300
-- (Credit = 500 - VacationHours (H) - SickLeaveHours (H) - Rate (P), minus 30% if OrganizationLevel is 1, minus 50% if OrganizationLevel is 2)
-- Must use: EXISTS
WITH Task_168 AS(
    SELECT SUBSTRING(H.LoginID, CHARINDEX('\', H.LoginID) + 1, LEN(H.LoginID)) AS New_LoginID, 
    H.MaritalStatus, H.Gender, H.BusinessEntityID, H.VacationHours, H.SickLeaveHours,
        CASE 
            WHEN OrganizationLevel = 1 THEN 0.7
            WHEN OrganizationLevel = 2 THEN 0.5
            ELSE 1
        END AS OrganizationDecrease
    FROM HumanResources.Employee H
)
SELECT H.New_LoginID, H.MaritalStatus, H.Gender, H.OrganizationDecrease
FROM Task_168 H
WHERE EXISTS(
    SELECT 1
    FROM HumanResources.EmployeeDepartmentHistory A 
    WHERE EXISTS(
        SELECT 1
        FROM HumanResources.EmployeePayHistory P
        WHERE H.BusinessEntityID = A.BusinessEntityID
        AND A.BusinessEntityID = P.BusinessEntityID
        AND ((500 - H.VacationHours - H.SickLeaveHours - P.Rate) * H.OrganizationDecrease) < 300
    )
)

-- 169. List all the Employee LoginID (H) (Only the part after the slash '\') who have the Credit lower than 40 or higher than 2000
-- (Credit = (Length of NationalIDNumber (H) + Length of LoginID (H)) x Month of BirthDate (H), bonus 100% if Rate (P) x Frequency (P) > 40, bonus 700% if Rate (P) x Frequency (P) > 60)
-- Must use: JOIN
WITH Task_169_Calculate AS(
    SELECT 
        SUBSTRING(H.LoginID, CHARINDEX('\', H.LoginID) + 1, LEN(H.LoginID)) AS New_LoginID,
        CASE
            WHEN P.Rate * P.PayFrequency > 60 THEN (LEN(H.NationalIDNumber) + LEN(H.LoginID)) * DATEPART(MONTH, H.BirthDate) * 8
            WHEN P.Rate * P.PayFrequency > 40 THEN (LEN(H.NationalIDNumber) + LEN(H.LoginID)) * DATEPART(MONTH, H.BirthDate) * 2
            ELSE (LEN(H.NationalIDNumber) + LEN(H.LoginID)) * DATEPART(MONTH, H.BirthDate)
        END AS Credit
    FROM HumanResources.Employee H
    JOIN HumanResources.EmployeePayHistory P 
    ON H.BusinessEntityID = P.BusinessEntityID
)
SELECT DISTINCT * FROM Task_169_Calculate
WHERE Credit < 40 OR Credit > 2000
ORDER BY New_LoginID

-- 170. List all the Employee LoginID (H) (Only the part after the slash '\') who have the Credit lower than 40 or higher than 2000
-- (Credit = (Length of NationalIDNumber (H) + Length of LoginID (H)) x Month of BirthDate (H), bonus 100% if Rate (P) x PayFrequency (P) > 40, bonus 700% if Rate (P) x PayFrequency (P) > 60)
-- Must use: EXISTS
WITH Task_170_Bonus AS(
    SELECT 
        *,
        CASE 
            WHEN Rate * PayFrequency > 60 THEN 8
            WHEN Rate * PayFrequency > 40 THEN 2
            ELSE 1
        END AS Multiply_Bonus
    FROM HumanResources.EmployeePayHistory
)
SELECT DISTINCT SUBSTRING(H.LoginID, CHARINDEX('\', H.LoginID) + 1, LEN(H.LoginID)) AS New_LoginID
FROM HumanResources.Employee H
WHERE EXISTS(
    SELECT 1 FROM Task_170_Bonus P 
    WHERE (H.BusinessEntityID = P.BusinessEntityID
    AND (LEN(H.NationalIDNumber) + LEN(H.LoginID)) * DATEPART(MONTH, H.BirthDate) * P.Multiply_Bonus < 40)
    OR (H.BusinessEntityID = P.BusinessEntityID
    AND (LEN(H.NationalIDNumber) + LEN(H.LoginID)) * DATEPART(MONTH, H.BirthDate) * P.Multiply_Bonus > 2000)
)

-- 171. List all the Employee LoginID (H) (Only the part after the slash '\') who have a Credit higher than 200
-- (Credit = (ShiftID (A) * SickLeaveHours (H) + Job_Bonus)), (Job_Bonus: For each E in JobTitle (H) + 5, each A: + 8, each O: + 10)
-- Must use: JOIN
WITH Task_171_Bonus AS(
    SELECT 
        SUBSTRING(H.LoginID, CHARINDEX('\', H.LoginID) + 1, LEN(H.LoginID)) AS New_LoginID,
        (LEN(H.JobTitle) - LEN(REPLACE(H.JobTitle, 'E', ''))) * 5 AS Bonus_E,
        (LEN(H.JobTitle) - LEN(REPLACE(H.JobTitle, 'A', ''))) * 8 AS Bonus_A,
        (LEN(H.JobTitle) - LEN(REPLACE(H.JobTitle, 'A', ''))) * 10 AS Bonus_O,
        A.ShiftID, H.SickLeaveHours
    FROM HumanResources.Employee H
    JOIN HumanResources.EmployeeDepartmentHistory A ON A.BusinessEntityID = H.BusinessEntityID
) 
SELECT New_LoginID, ShiftID * SickLeaveHours + Bonus_E + Bonus_A + Bonus_O AS Credit
FROM Task_171_Bonus
WHERE (ShiftID * SickLeaveHours + Bonus_E + Bonus_A + Bonus_O) > 200;

-- 172. List all the Employee LoginID (H) (Only the part after the slash '\') who have a Credit higher than 200
-- (Credit = (ShiftID (A) * SickLeaveHours + Job_Bonus)), (Job_Bonus: For each E in JobTitle (H) + 5, each A: + 8, each O: + 10)
-- Must use: EXISTS
WITH Task_171_Bonus AS(
        SELECT 
        SUBSTRING(H.LoginID, CHARINDEX('\', H.LoginID) + 1, LEN(H.LoginID)) AS New_LoginID,
        (LEN(H.JobTitle) - LEN(REPLACE(H.JobTitle, 'E', ''))) * 5 AS Bonus_E,
        (LEN(H.JobTitle) - LEN(REPLACE(H.JobTitle, 'A', ''))) * 8 AS Bonus_A,
        (LEN(H.JobTitle) - LEN(REPLACE(H.JobTitle, 'A', ''))) * 10 AS Bonus_O,
        H.SickLeaveHours, H.BusinessEntityID
    FROM HumanResources.Employee H
)
SELECT *
FROM Task_171_Bonus H
WHERE EXISTS(
    SELECT *
    FROM HumanResources.EmployeeDepartmentHistory A 
    WHERE A.BusinessEntityID = H.BusinessEntityID
    AND (A.ShiftID * H.SickLeaveHours + H.Bonus_A + H.Bonus_E + H.Bonus_O) > 200
)

-- 173. Pivot the data in Employee Department History table (A) to see the SUM of BusinessEntityID (A) for each ShiftID (A)
SELECT [1], [2], [3]
FROM (
    SELECT BusinessEntityID, ShiftID
    FROM HumanResources.EmployeeDepartmentHistory
) AS SourceData
PIVOT (
    SUM(BusinessEntityID)
    FOR ShiftID IN ([1], [2], [3])
) AS Pivot_173;

-- 174. Pivot the data in Employee Department History table (A) to see the SUM of Month's Day of in ModifiedDate (A) for each ShiftID (A)
SELECT *
FROM (
    SELECT DATEPART(DAY, ModifiedDate) AS Day_Editted, ShiftID
    FROM HumanResources.EmployeeDepartmentHistory
) AS SourceData
PIVOT (
    SUM(Day_Editted)
    FOR ShiftID IN ([1], [2], [3])
) AS Pivot_174

-- 175. Pivot the data in Employee Department History table (A) to see the Average of Day of Month in ModifiedDate (A) for each ShiftID (A)
SELECT *
FROM (
    SELECT ShiftID, DATEPART(DAY, ModifiedDate) AS Day_Editted
    FROM HumanResources.EmployeeDepartmentHistory
) AS SourceData
PIVOT(
    AVG(Day_Editted) 
    FOR ShiftID IN ([1], [2], [3])
) AS Pivot_175

-- 176. Pivot the data in Employee table (H) to see the Count of records on each Month of BirthDate (H)
SELECT *
FROM (
    SELECT BusinessEntityID, DATEPART(MONTH, BirthDate) AS BirthMonth
    FROM HumanResources.Employee
) AS SourceData
PIVOT (
    COUNT(BusinessEntityID)
    FOR BirthMonth IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12])
) AS Pivot_table_176;

-- 177. Pivot the data in Employee table (H) to see the Count of records on each WeekDay of BirthDate (H)
SELECT *
FROM (
    SELECT BusinessEntityID, DATEPART(WEEKDAY, BirthDate) AS BirthWeekDay
    FROM HumanResources.Employee
) AS SourceData
PIVOT (
    COUNT(BusinessEntityID)
    FOR BirthWeekDay IN ([1], [2], [3], [4], [5], [6], [7])
) AS Pivot_table_177

-- 178. Pivot the data in Employee table (H) to see the Sum of VacationHours (H) on each Month of BirthDate (H)
SELECT *
FROM (
    SELECT DATEPART(MONTH, BirthDate) AS BirthMonth, VacationHours
    FROM HumanResources.Employee
) AS SourceData
PIVOT (
    SUM(VacationHours)
    FOR BirthMonth IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12])
) AS Pivot_table_178;

-- 179. Pivot the data in Employee Department History (A) to see the Count of records for each DepartmentID (A)
SELECT *
FROM (
    SELECT BusinessEntityID, DepartmentID
    FROM HumanResources.EmployeeDepartmentHistory
) AS SourceData
PIVOT (
    COUNT(BusinessEntityID)
    FOR DepartmentID IN ([1], [2], [3], [4])
) AS Pivot_table_179

-- 180. Pivot the data in Employee Department History (A) to see the Count of records for each ShiftID (A)
SELECT *
FROM (
    SELECT BusinessEntityID, ShiftID
    FROM HumanResources.EmployeeDepartmentHistory
) AS SourceData
PIVOT (
    COUNT(BusinessEntityID)
    FOR ShiftID IN ([1], [2], [3])
) AS Pivot_table_180

-- 181. Pivot the data in Employee Department History (A) to see the Sum of Rate (P) for each ShiftID (A)
SELECT *
FROM (
    SELECT A.ShiftID, P.Rate
    FROM HumanResources.EmployeeDepartmentHistory A 
    JOIN HumanResources.EmployeePayHistory P 
    ON A.BusinessEntityID = P.BusinessEntityID
) AS SourceData
PIVOT (
    SUM(Rate)
    FOR ShiftID IN ([1], [2], [3])
) AS Pivot_181

-- 182. Pivot the data in Employee (H) to see the Total Number of characters on GroupName (D) for each MaritalStatus (H), using 2 JOINS: H > A > D
SELECT *
FROM (
    SELECT LEN(D.GroupName) AS LengthGName, H.MaritalStatus
    FROM HumanResources.Employee H 
    JOIN HumanResources.EmployeeDepartmentHistory A ON A.BusinessEntityID = H.BusinessEntityID
    JOIN HumanResources.Department D ON A.DepartmentID = D.DepartmentID
) AS SourceData
PIVOT (
    SUM(LengthGName)
    FOR MaritalStatus IN ([S], [M])
) AS Pivot_182

-- 183. Pivot the data in Employee (H) to see the Total Hours of EndTime (SH) for each MaritalStatus (H), using 2 JOINS: H > A > SH
SELECT *
FROM (
    SELECT DATEPART(HOUR, SH.EndTime) AS End_Hours, H.MaritalStatus
    FROM HumanResources.Employee H 
    JOIN HumanResources.EmployeeDepartmentHistory A ON A.BusinessEntityID = H.BusinessEntityID
    JOIN HumanResources.Shift SH ON A.ShiftID = SH.ShiftID
) AS SourceData
PIVOT (
    SUM(End_Hours)
    FOR MaritalStatus IN ([S], [M])
) AS Pivot_183

-- 184.  Pivot the data in Employee (H) to see the Highest (Rate x PayFrequency) (P) for each Gender (H)
SELECT *
FROM (
    SELECT H.Gender, P.Rate * P.PayFrequency AS PayUnit
    FROM HumanResources.Employee H
    JOIN HumanResources.EmployeePayHistory P ON H.BusinessEntityID = P.BusinessEntityID
) AS SourceData
PIVOT (
    MAX(PayUnit)
    FOR Gender IN ([F], [M])
) AS Pivot_184

-- 185.  Pivot the data in Employee (H) to see the Lowest Credit (VacationHours (H) + SickLeaveHours (H)) for each Gender (H)
SELECT *
FROM (
    SELECT Gender, VacationHours + SickLeaveHours AS Credit
    FROM HumanResources.Employee
) AS SourceData
PIVOT (
    MIN(Credit)
    FOR Gender IN ([F], [M])
) AS Pivot_table_185

-- 186.  Pivot the data in Employee (H) to see the Highest Credit (VacationHours (H) + SickLeaveHours (H), [Credit x2 if DepartmentID (A) is in 8 to 12]) for each Gender (H)
SELECT *
FROM (
    SELECT H.Gender, 
        CASE
            WHEN A.DepartmentID BETWEEN 8 AND 12 THEN (VacationHours + SickLeaveHours) * 2
            ELSE VacationHours + SickLeaveHours
        END AS Credit
    FROM HumanResources.Employee H
    JOIN HumanResources.EmployeeDepartmentHistory A ON A.BusinessEntityID = H.BusinessEntityID
) AS SourceData
PIVOT (
    MAX(Credit)
    FOR Gender IN ([F], [M])
) AS Pivot_table_186

-- 187.  Pivot the data in Employee (H) to see the Highest Loyal_Point (VacationHours < 50: +100, VacationHours < 30: + 240, VacationHours < 10: + 600)
-- (SickLeaveHours > 60: - 80, SickLeaveHours < 25: + 350)(+ 15% for each E appear in rowguid (H)) for each ShiftID (A)
WITH Task_187 AS (
    SELECT A.ShiftID,
        CASE 
            WHEN H.VacationHours < 10 THEN 600
            WHEN H.VacationHours < 10 THEN 240
            WHEN H.VacationHours < 10 THEN 100
            ELSE 0
        END AS Vacation_Bonus,
        CASE 
            WHEN H.SickLeaveHours > 60 THEN -80
            WHEN H.SickLeaveHours < 25 THEN +350
            ELSE 0
        END AS Sick_Bonus,
        LEN(rowguid) - LEN(REPLACE(rowguid, 'E', '')) AS Counter_E
    FROM HumanResources.Employee H
    JOIN HumanResources.EmployeeDepartmentHistory A ON H.BusinessEntityID = A.BusinessEntityID 
)
SELECT *
FROM (
    SELECT ShiftID, (Vacation_Bonus + Sick_Bonus + 0.15 * (Vacation_Bonus + Sick_Bonus)) AS Credit
    FROM Task_187
) AS SourceData
PIVOT (
    SUM(Credit)
    FOR ShiftID IN ([1], [2], [3])
) AS Pivot_table_187;

-- 188.  Pivot the data in Employee (H) to see the Highest Loyal_Point (1-digit VacationHours: + 500, SickLeaveHours smaller than Average: + 290, Each P or H in JobTitle: + 10%) for each ShiftID (A)
WITH Task_188_Avg AS(
    SELECT AVG(SickLeaveHours) AS Avg_Sick
    FROM HumanResources.Employee
), Task_188 AS (
    SELECT
        A.ShiftID,
        CASE 
            WHEN LEN(H.VacationHours) = 1 THEN 500
            ELSE 0
        END AS VacationBonus,
        CASE 
            WHEN H.SickLeaveHours < (SELECT Avg_Sick FROM Task_188_Avg) THEN 290
            ELSE 0
        END AS SickBonus,
        LEN(H.JobTitle) - LEN(REPLACE(REPLACE(H.JobTitle, 'P', ''), 'H', '')) AS JobTitleBonus  
    FROM HumanResources.Employee H
    JOIN HumanResources.EmployeeDepartmentHistory A ON H.BusinessEntityID = A.BusinessEntityID
)
SELECT * 
FROM (
    SELECT ShiftID, (VacationBonus + SickBonus) + (0.1 * JobTitleBonus * (VacationBonus + SickBonus)) AS LoyalPoint
    FROM Task_188
) AS SourceData
PIVOT (
    MAX(LoyalPoint)
    FOR ShiftID IN ([1], [2], [3])
) AS Pivot_table_188

-- 189. Show the Rank of Employee (H) on each Gender group (H), ranking based on Descending NationalIDNumber (H)
SELECT 
    BusinessEntityID,
    NationalIDNumber,
    Gender,
    RANK() OVER (PARTITION BY Gender ORDER BY NationalIDNumber DESC) AS Ranking
FROM HumanResources.Employee

-- 190. Show the Rank of Employee (H) on each OrganizationLevel (H)(NULL not counted), ranking based on Gender (H) > MaritalStatus (H) > Descending NationalIDNumber (H)
SELECT BusinessEntityID, NationalIDNumber, OrganizationLevel, 
    RANK() OVER (PARTITION BY OrganizationLevel ORDER BY Gender, MaritalStatus, NationalIDNumber DESC) AS Ranking
FROM HumanResources.Employee H
WHERE OrganizationLevel IS NOT NULL 

-- 191. Show the Rank of Employee (H) on each OrganizationLevel (H)(NULL not counted), ranking based on Descending ShiftID (A) > Descending NationalIDNumber (H)
SELECT H.BusinessEntityID, H.NationalIDNumber, H.OrganizationLevel, A.ShiftID,
    RANK() OVER (PARTITION BY H.OrganizationLevel ORDER BY A.ShiftID DESC, H.NationalIDNumber DESC) AS Ranking
FROM HumanResources.Employee H
JOIN HumanResources.EmployeeDepartmentHistory A ON H.BusinessEntityID = A.BusinessEntityID
WHERE OrganizationLevel IS NOT NULL 

-- 192. Show the Rank of Employee (H) on each MartitalStatus group (H) > Gender group (H), ranking based on Descending DepartmentID (A) > Day Joined (Number of day since StartDate (A))
SELECT H.BusinessEntityID, H.MaritalStatus, H.Gender, DATEDIFF(DAY, A.StartDate, '2023-11-9') AS DayJoined,
    RANK() OVER (PARTITION BY H.MaritalStatus, H.Gender ORDER BY A.DepartmentID DESC, DATEDIFF(DAY, A.StartDate, '2023-11-9')) AS Ranking
FROM HumanResources.Employee H
JOIN HumanResources.EmployeeDepartmentHistory A ON H.BusinessEntityID = A.BusinessEntityID
WHERE OrganizationLevel IS NOT NULL 

-- 193. Show only the Employee (H) Rank 3 and 5 from each OrganizationLevel (H), ranking based on Descending DepartmentID (A) > Descending Day Age (From BirthDate (H) to 2023-11-9)
WITH Task_193_Ranking AS(
    SELECT H.BusinessEntityID, H.OrganizationLevel, DATEDIFF(DAY, H.BirthDate, '2023-11-9') AS DayAge,
        RANK() OVER (PARTITION BY H.OrganizationLevel ORDER BY A.DepartmentID DESC, DATEDIFF(DAY, H.BirthDate, '2023-11-9') DESC) AS Ranking
    FROM HumanResources.Employee H
    JOIN HumanResources.EmployeeDepartmentHistory A ON H.BusinessEntityID = A.BusinessEntityID
    WHERE OrganizationLevel IS NOT NULL 
)
SELECT *
FROM Task_193_Ranking
WHERE Ranking = 3 OR Ranking = 5

-- 194. Show the number of characters of JobTitle (H) for each employee (H) in rank 1 from each Gender group (H), 
-- ranking based on ShiftID (A) > Length of LoginID (H) > BusinessEntityID
WITH Task_194_Ranking AS(
    SELECT H.BusinessEntityID, H.JobTitle, H.Gender, RANK() OVER (PARTITION BY H.Gender ORDER BY A.ShiftID, LEN(H.LoginID), H.BusinessEntityID) AS Ranking
    FROM HumanResources.Employee H 
    JOIN HumanResources.EmployeeDepartmentHistory A ON H.BusinessEntityID = A.BusinessEntityID
)
SELECT LEN(JobTitle) AS Char_JobTitle, Ranking
FROM Task_194_Ranking
WHERE Ranking = 1

-- 195. Calculate the TOTAL and AVERAGE of Characters of JobTitle (H) for each ShiftID (A), ranking based on Age (2023 - BirthDate (H)) > Descending NationalIDNumber (H)
WITH Task_195_Ranking AS(
    SELECT H.BusinessEntityID, H.JobTitle, A.ShiftID, 
    RANK() OVER (PARTITION BY A.ShiftID ORDER BY DATEDIFF(YEAR, H.BirthDate, '2023-11-9'), H.NationalIDNumber DESC) AS Ranking
    FROM HumanResources.Employee H 
    JOIN HumanResources.EmployeeDepartmentHistory A ON H.BusinessEntityID = A.BusinessEntityID
)
SELECT SUM(LEN(JobTitle)) AS SumJobChars,  AVG(LEN(JobTitle)) AS AvgJobChars, ShiftID
FROM Task_195_Ranking
GROUP BY ShiftID;

-- 196. Calculate the SUM and AVERAGE of VacationHours (H) and SickLeaveHours (H) for each DepartmentID (A), ranking based on NationalIDNumber (H), 
-- only include the DepartmentID that has a greater SickLeaveHours than Average
WITH Task_196_Ranking AS(
    SELECT H.BusinessEntityID, H.VacationHours, H.SickLeaveHours, A.DepartmentID, H.NationalIDNumber,
    RANK() OVER (PARTITION BY A.DepartmentID ORDER BY H.NationalIDNumber) AS Ranking
    FROM HumanResources.Employee H 
    JOIN HumanResources.EmployeeDepartmentHistory A ON H.BusinessEntityID = A.BusinessEntityID
)
SELECT DepartmentID, SUM(VacationHours) AS Vacation_SUM, SUM(SickLeaveHours) AS Sick_SUM, AVG(VacationHours) AS Vacation_AVG, AVG(SickLeaveHours) AS Sick_AVG
FROM Task_196_Ranking
GROUP BY DepartmentID;

-- 197. Find the MAX NationalIDNumber (H) for each OrganizationLevel (H), ranking based on DepartmentID (A) > Descending Day Joined (Number of day since StartDate (A))
WITH Task_197_Ranking AS(
    SELECT H.BusinessEntityID, H.NationalIDNumber, A.DepartmentID, H.OrganizationLevel,
    RANK() OVER (PARTITION BY A.DepartmentID ORDER BY A.DepartmentID, DATEDIFF(DAY, StartDate, '2023-11-9')) AS Ranking
    FROM HumanResources.Employee H 
    JOIN HumanResources.EmployeeDepartmentHistory A ON H.BusinessEntityID = A.BusinessEntityID
)
SELECT OrganizationLevel, MAX(NationalIDNumber) AS Max_ID
FROM Task_197_Ranking
GROUP BY OrganizationLevel;

-- 198. Find all the Employee (H) who is closest to the Average BusinessEntityID (H) on each MartitalStatus group (H) > Gender group (H), 
-- ranking based on DepartmentID (A) > Descending NationalIDNumber (H)
WITH Task_198_Ranking AS(
    SELECT H.BusinessEntityID, H.MaritalStatus, H.Gender, A.DepartmentID, H.NationalIDNumber,
        RANK() OVER (PARTITION BY H.MaritalStatus, H.Gender ORDER BY A.DepartmentID, H.NationalIDNumber DESC) AS Ranking
    FROM HumanResources.Employee H 
    JOIN HumanResources.EmployeeDepartmentHistory A ON A.BusinessEntityID = H.BusinessEntityID
), Task_198_Group AS(
    SELECT AVG(BusinessEntityID) AS AVG_ID, MaritalStatus, Gender
    FROM Task_198_Ranking
    GROUP BY MaritalStatus, Gender
), Task_198_Merge AS(
    SELECT G.AVG_ID, R.*, ABS(G.AVG_ID - R.BusinessEntityID) AS ABSRange_AVG, G.AVG_ID - R.BusinessEntityID AS Range_AVG
    FROM Task_198_Ranking R
    LEFT JOIN Task_198_Group G 
    ON (R.MaritalStatus = G.MaritalStatus AND R.Gender = G.Gender) 
), Task_198_MinRange AS(
    SELECT MIN(ABSRange_AVG) AS Min_range, MaritalStatus, Gender
    FROM Task_198_Merge
    GROUP BY MaritalStatus, Gender
)
SELECT M.BusinessEntityID, M.MaritalStatus, M.Gender
FROM Task_198_Merge M
RIGHT JOIN Task_198_MinRange RG ON (RG.Min_range = M.ABSRange_AVG AND RG.Gender = M.Gender AND RG.MaritalStatus = M.MaritalStatus)

-- 199. Calculate the total Credit (new column) for each DepartmentID, ranking based on DepartmentID (A) > Gender (H) > MaritalStatus (H) > ShiftID (A) > Descending BusinessEntityID
-- (Credit = Length of LoginID (H) * OrganizationLevel (H) (NULL excluded) * DepartmentID (A) / ShiftID (A))
WITH Task_199_Ranking AS(
    SELECT A.DepartmentID, H.BusinessEntityID, H.LoginID, H.OrganizationLevel,
        RANK() OVER (PARTITION BY A.DepartmentID ORDER BY A.DepartmentID, H.Gender, H.MaritalStatus, A.ShiftID, H.BusinessEntityID DESC) AS Ranking,
        LEN(H.LoginID) * H.OrganizationLevel * A.DepartmentID / A.ShiftID AS Credit
    FROM HumanResources.Employee H 
    JOIN HumanResources.EmployeeDepartmentHistory A ON A.BusinessEntityID = H.BusinessEntityID
    WHERE H.OrganizationLevel IS NOT NULL
)
SELECT SUM(Credit) AS TotalCredit, DepartmentID
FROM Task_199_Ranking  
GROUP BY DepartmentID;

-- 200. Find the NationalIDNumber (H) of Employee with the Credit (new column) nearest to 15%, 25% and 45% MAX Credit for each DepartmentID (A), 
-- ranking based on Descending DepartmentID (A) > Descending NationalIDNumber (H)
-- (Credit = (VacationHours (H) + 50% of SickLeaveHours), (Bonus: Month of BirthDate = 2: +100%, Month 4-5-6: +85%, Month >= 11: + 42%)
WITH Task_200_Data AS(
    SELECT A.DepartmentID, H.NationalIDNumber, H.VacationHours, SickLeaveHours, 
        CASE 
            WHEN DATEPART(MONTH, H.BirthDate) = 2 THEN 2
            WHEN DATEPART(MONTH, H.BirthDate) BETWEEN 4 AND 6 THEN 1.85
            WHEN DATEPART(MONTH, H.BirthDate) > 11 THEN 1.42
            ELSE 1
        END AS MonthBonus
    FROM HumanResources.Employee H 
    JOIN HumanResources.EmployeeDepartmentHistory A ON A.BusinessEntityID = H.BusinessEntityID
), Task_200_Ranking AS(
    SELECT *, RANK() OVER (PARTITION BY DepartmentID ORDER BY DepartmentID DESC, NationalIDNumber DESC) AS Ranking,
        (VacationHours + 0.5 * SickLeaveHours) * MonthBonus AS Credit
    FROM Task_200_Data
), Task_200_MaxCred AS(
    SELECT DepartmentID, MAX(Credit) AS MaxCredit, 0.15 * MAX(Credit) AS Credit15, 0.25 * MAX(Credit) AS Credit25, 0.45 * MAX(Credit) AS Credit45
    FROM Task_200_Ranking
    GROUP BY DepartmentID
), Task_200_MergeGroup AS(
    SELECT R.DepartmentID, R.NationalIDNumber, R.Credit, MC.MaxCredit, 
    MC.Credit15, ABS(MC.Credit15 - R.Credit) AS Range_15,
    MC.Credit25, ABS(MC.Credit25 - R.Credit) AS Range_25,
    MC.Credit45, ABS(MC.Credit45 - R.Credit) AS Range_45
    FROM Task_200_Ranking R
    LEFT JOIN Task_200_MaxCred MC ON MC.DepartmentID = R.DepartmentID
), Task_200_SortMinMax AS(
    SELECT MIN(Range_15) AS Min15, MIN(Range_25) AS Min25, MIN(Range_45) AS Min45, DepartmentID
    FROM Task_200_MergeGroup
    GROUP BY DepartmentID
), Task_200_Joined AS(
    SELECT MG.DepartmentID, MG.NationalIDNumber, MG.Credit, MG.Credit15, MG.Credit25, MG.Credit45
    FROM Task_200_MergeGroup MG
    LEFT JOIN Task_200_SortMinMax SMM ON MG.DepartmentID = SMM.DepartmentID
)
SELECT * FROM Task_200_Joined
ORDER BY DepartmentID