-- Part 6: 13/11/2023

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
-- TASK 251 TO 300
-- KNOWLEDGE COVERED: Dynamic SQL, Stored Procedures, DECLARE, SET Variables, EXEC
----------------------------------------------------------------
-- Note: Put 2 'GO' Before and After any functions & stored procedures to avoid Syntax Error.

-- 251. Create a procedure to show entire employee's data table (H)
GO
CREATE PROCEDURE SelectAllEmployee
AS
SELECT * FROM HumanResources.Employee
GO

EXEC SelectAllEmployee

-- 252. Create a procedure to show entire assigned department/shift data table (A)
GO
CREATE PROCEDURE SelectAllAssigned
AS
SELECT * FROM HumanResources.EmployeeDepartmentHistory
GO

EXEC SelectAllAssigned

-- 253. Create a procedure to show entire employee's paying history table (P) of who has BusinessEntityID (P) greater than 100
GO
CREATE PROCEDURE SelectAllPay
AS
SELECT *
FROM HumanResources.EmployeePayHistory 
WHERE BusinessEntityID > 100
GO

EXEC SelectAllPay

-- 254. Create a procedure to show employee's data table (H), along with their departmentID (A), order by Descending DeparmentID (A) > BusinessEntityID (H)
GO
CREATE PROCEDURE Procedure_254
AS
SELECT A.DepartmentID, H.*
FROM HumanResources.Employee H 
JOIN HumanResources.EmployeeDepartmentHistory A 
ON H.BusinessEntityID = A.BusinessEntityID
ORDER BY A.DepartmentID DESC, H.BusinessEntityID
GO

EXEC Procedure_254

-- 255. Create a procedure to show employee's data table (H), along with their departmentID (A), shiftID (A) and paying Rate (P) of who has 8-digit NationalIDNumber (H)
GO
CREATE PROCEDURE Procedure_255
AS 
SELECT A.DepartmentID, A.ShiftID, P.Rate, H.*
FROM HumanResources.Employee H 
JOIN HumanResources.EmployeeDepartmentHistory A ON A.BusinessEntityID = H.BusinessEntityID
JOIN HumanResources.EmployeePayHistory P ON P.BusinessEntityID = H.BusinessEntityID
WHERE LEN(H.NationalIDNumber) = 8
GO

EXEC Procedure_255

-- 256. Create a procedure to show employee's data table (H), Shift StartTime (SH), Shift EndTime (SH)
GO
CREATE PROCEDURE Procedure_256
AS
SELECT SH.StartTime, SH.EndTime, H.*
FROM HumanResources.Employee H 
JOIN HumanResources.EmployeeDepartmentHistory A ON H.BusinessEntityID = A.BusinessEntityID
JOIN HumanResources.Shift SH ON SH.ShiftID = A.ShiftID
GO 

EXEC Procedure_256

-- 257. Create a procedure to show employee's data table (H), Department Name (D), Department GroupName (D)
GO
CREATE PROCEDURE Procedure_257
AS
SELECT D.DepartmentID, D.GroupName, H.*
FROM HumanResources.Employee H 
JOIN HumanResources.EmployeeDepartmentHistory A ON A.BusinessEntityID = H.BusinessEntityID
JOIN HumanResources.Department D ON D.DepartmentID = A.DepartmentID 
GO

EXEC Procedure_257

-- 258. Create a procedure to show BusinessEntityID (H), LoginID (H)(part after slash '\'), OrganizationLevel (H), DepartmentID (A), Age (2023 - BirthDate (H)) of who has Age greater than 48
GO
CREATE PROCEDURE Procedure_258
AS
SELECT H.BusinessEntityID, SUBSTRING(H.LoginID, CHARINDEX('\', H.LoginID) + 1, LEN(H.LoginID)) AS New_LoginID, H.OrganizationLevel, A.DepartmentID, DATEDIFF(YEAR, H.BirthDate, '2023-11-13') AS Age
FROM HumanResources.Employee H 
JOIN HumanResources.EmployeeDepartmentHistory A ON A.BusinessEntityID = H.BusinessEntityID
WHERE DATEDIFF(YEAR, H.BirthDate, '2023-11-13') > 48
GO

EXEC Procedure_258

-- 259. Create a procedure to show BusinessEntityID (H), NationalIDNumber (H), OrganizationLevel (H), DepartmentID (A), Age (2023 - BirthDate (H)), WeekDay in BirthDate (H)
-- of who was born in a Thursday or a Friday
GO
CREATE PROCEDURE Procedure_259
AS
SELECT H.BusinessEntityID, H.NationalIDNumber, H.OrganizationLevel, A.DepartmentID, DATEDIFF(YEAR, H.BirthDate, '2023-11-13') AS Age, DATEPART(WEEKDAY, H.BirthDate) AS BirthWeekDay
FROM HumanResources.Employee H
JOIN HumanResources.EmployeeDepartmentHistory A ON A.BusinessEntityID = H.BusinessEntityID
WHERE DATEPART(WEEKDAY, H.BirthDate) = 5
OR DATEPART(WEEKDAY, H.BirthDate)  = 6
GO

EXEC Procedure_259

-- 260. Create a procedure to show NationalIDNumber (H), Department ID (A), ShiftID (A), Shift Length (EndTime (SH) - StartTime (SH)), Payment (as Pay Rate (P) x PayFrequency (P))
-- of who has a Payment with greater or equal 3 digits
GO 
CREATE PROCEDURE Procedure_260
AS
SELECT H.NationalIDNumber, A.DepartmentID, A.ShiftID, ABS(DATEDIFF(HOUR, StartTime, EndTime)) AS ShiftLength, P.Rate * P.PayFrequency AS Payment
FROM HumanResources.Employee H 
JOIN HumanResources.EmployeeDepartmentHistory A ON H.BusinessEntityID = A.BusinessEntityID
JOIN HumanResources.EmployeePayHistory P ON H.BusinessEntityID = P.BusinessEntityID
JOIN HumanResources.Shift SH ON SH.ShiftID = A.ShiftID
WHERE LEN(P.Rate * P.PayFrequency) >= 3
GO

EXEC Procedure_260

-- 261. Create a procedure that show all employee's BusinessEntityID (H), LoginID (H), Gender (H) of those who has Day of BirthDate (H) + Month of BirthDate (H) in range 30 to 35 (inclusive)
GO
CREATE PROCEDURE Procedure_261
AS 
SELECT BusinessEntityID, LoginID, Gender, DATEPART(DAY, BirthDate) + DATEPART(MONTH, BirthDate) AS DayandMonth
FROM HumanResources.Employee
WHERE DATEPART(DAY, BirthDate) + DATEPART(MONTH, BirthDate) BETWEEN 30 AND 35
GO

EXEC Procedure_261

-- 262. Create a procedure that shows all NationalIDNumber (H), BusinessEntityID (H), HireDate (H), DepartmentID (A), Department Name (D)
-- of those who have the NationalIDNumber (H) contain any numbers from 444 to 449
GO
CREATE PROCEDURE Procedure_262
AS
SELECT H.NationalIDNumber, H.BusinessEntityID, H.HireDate, A.DepartmentID, D.Name
FROM HumanResources.Employee H 
JOIN HumanResources.EmployeeDepartmentHistory A ON A.BusinessEntityID = H.BusinessEntityID
JOIN HumanResources.Department D ON A.DepartmentID = D.DepartmentID
WHERE CAST(H.NationalIDNumber AS VARCHAR) LIKE '%44[4-9]%'
GO 

EXEC Procedure_262

-- 263. Create a procedure that shows all BusinessEntityID (H), OrganizationLevel (H), HireDate (H), DepartmentID (A), Shift Name (SH)
-- of those who have the length of loginID (H) is between 25 and 28 (inclusive), the Gender (H) is the same as MaritalStatus (H), and NationalIDNumber (H) contains any number from 5100 to 5399
GO
CREATE PROCEDURE Procedure_263
AS
SELECT H.BusinessEntityID, H.NationalIDNumber, H.OrganizationLevel, H.HireDate, A.DepartmentID, SH.Name, H.Gender, H.MaritalStatus, LEN(H.LoginID) AS LengthLogin
FROM HumanResources.Employee H 
JOIN HumanResources.EmployeeDepartmentHistory A ON A.BusinessEntityID = H.BusinessEntityID
JOIN HumanResources.Shift SH ON SH.ShiftID = A.ShiftID
WHERE LEN(H.LoginID) BETWEEN 25 AND 28
AND H.Gender = H.MaritalStatus
AND CAST(H.NationalIDNumber AS VARCHAR) LIKE '%5[1-3][0-9][0-9]%'
GO

EXEC Procedure_263;

-- 264. Create a procedure that shows all BusinessEntityID (H), Age (2023 - BirthDate (H)), Payment (Rate (P) x PayFrequency (P)), TotalHours (VacationHours (H) + SickLeaveHours (H))
-- of those who have the Result of [Payment x TotalHours x NationalIDNumber] contains any number from 76000 to 78000 OR any number from 99000 to 99999
GO
CREATE PROCEDURE Procedure_264
AS
WITH Result_264 AS(
    SELECT H.BusinessEntityID, H.NationalIDNumber, DATEDIFF(YEAR, H.BirthDate, '2023-11-13') AS Age, P.Rate * P.PayFrequency AS Payment, H.VacationHours * H.SickLeaveHours AS TotalHours
    FROM HumanResources.Employee H 
    JOIN HumanResources.EmployeePayHistory P ON H.BusinessEntityID = P.BusinessEntityID
)
SELECT *, Payment * TotalHours * NationalIDNumber AS Result
FROM Result_264
WHERE (Payment * TotalHours * NationalIDNumber) LIKE '%7[6-7][0-9][0-9][0-9]%'
OR (Payment * TotalHours * NationalIDNumber) LIKE '%78000%'
OR (Payment * TotalHours * NationalIDNumber) LIKE '%99[0-9][0-9][0-9]%'
GO 

EXEC Procedure_264

-- 265. Create a procedure that displays sum of BusinessEntityID (H) and total number of characters in LoginID (H) based on Gender (H) group
GO
CREATE PROCEDURE Procedure_265
AS
SELECT SUM(BusinessEntityID) AS SumEntity, SUM(LEN(LoginID)) AS SumLogin, Gender
FROM HumanResources.Employee 
GROUP BY Gender
GO

EXEC Procedure_265

-- 266. Create a procedure that displays average of VacationHours (H) and minimum number of characters in LoginID (H) based on MaritalStatus (H) + OrganizationLevel (H) group
GO
CREATE PROCEDURE Procedure_266
AS 
SELECT AVG(VacationHours) AS AvgVacation, MIN(LoginID) AS MinLength, MaritalStatus, OrganizationLevel
FROM HumanResources.Employee
GROUP BY MaritalStatus, OrganizationLevel
GO

EXEC Procedure_266

-- 267. Create a procedure that displays total of (VacationHours (H) + SickLeaveHours (H)) and maximum number of characters in LoginID (H) based on Gender (H) + OrganizationLevel (H) group
GO
CREATE PROCEDURE Procedure_267
AS
SELECT Gender, OrganizationLevel, SUM(VacationHours + SickLeaveHours) AS SumHours, MAX(LEN(LoginID)) AS MaxLogin
FROM HumanResources.Employee
GROUP BY Gender, OrganizationLevel
GO

EXEC Procedure_267

-- 268. Create a procedure that displays total of ((VacationHours (H) + SickLeaveHours (H)) * DepartmentID (A)) based on OrganizationLevel (H) + ShiftID (A) group
GO
CREATE PROCEDURE Procedure_268
AS
SELECT H.OrganizationLevel, A.ShiftID, SUM((H.VacationHours + H.SickLeaveHours) * A.DepartmentID) AS Result
FROM HumanResources.Employee H
JOIN HumanResources.EmployeeDepartmentHistory A ON H.BusinessEntityID = A.BusinessEntityID
GROUP BY H.OrganizationLevel, A.ShiftID
GO

EXEC Procedure_268

-- 269. Create a procedure that displays the value counts based on OrganizationLevel (H) + ShiftID (A) + DepartmentID (A) group, but only with OrganizationLevel greater than 3
GO
CREATE PROCEDURE Procedure_269
AS
SELECT H.OrganizationLevel, A.ShiftID, A.DepartmentID, COUNT(*) AS Counter
FROM HumanResources.Employee H
JOIN HumanResources.EmployeeDepartmentHistory A ON H.BusinessEntityID = A.BusinessEntityID
WHERE H.OrganizationLevel > 3
GROUP BY H.OrganizationLevel, A.ShiftID, A.DepartmentID
GO

EXEC Procedure_269

-- 270. Create a procedure that displays the value counts based on OrganizationLevel (H) + ShiftID (A) + MartialStatus (H) group, keeping only group with count smaller or equal 5 values
GO
CREATE PROCEDURE Procedure_270
AS
SELECT H.OrganizationLevel, A.ShiftID, H.MaritalStatus, COUNT(*) AS Counter
FROM HumanResources.Employee H 
JOIN HumanResources.EmployeeDepartmentHistory A ON H.BusinessEntityID = A.BusinessEntityID
GROUP BY H.OrganizationLevel, A.ShiftID, H.MaritalStatus
HAVING COUNT(*) <= 5
GO

EXEC Procedure_270

-- 271. Create a procedure that displays employee's BusinessEntityID (H), LoginID (H), Age (2023 - BirthDate (H)) of who with Age equal to a dynamic variable (@age)
GO
CREATE PROCEDURE Procedure_271 
    @age INT
AS
SELECT BusinessEntityID, LoginID, DATEDIFF(YEAR, BirthDate, '2023-11-13') AS Age
FROM HumanResources.Employee
WHERE DATEDIFF(YEAR, BirthDate, '2023-11-13') = @age
GO

-- 272. Executive the procedure #271 with 3 variables 
EXEC Procedure_271 @age = 71
EXEC Procedure_271 @age = 55
EXEC Procedure_271 @age = 42

-- 273. Create a procedure that input a 3-digit number (must be greater than 700 to proceed) that returns all NationalIDNumber (H), Length of JobTitle (H), WeekDay of HireDate (H)
-- of those who have that number set in NationalIDNumber (H)
GO
CREATE PROCEDURE Procedure_273
    @num INT
AS 
SELECT NationalIDNumber, LEN(JobTitle) AS JobLength, DATEPART(WEEKDAY, HireDate) AS WeekDayHire
FROM HumanResources.Employee
WHERE CAST(NationalIDNumber AS VARCHAR) LIKE '%' + CAST(@num AS VARCHAR) + '%'
AND @num >= 700 AND LEN(@num) = 3
GO 

EXEC Procedure_273 @num = 800

-- 274. Create a procedure that input a 4-digit number (must be greater than 7171 to proceed) that returns all NationalIDNumber (H), BusinessEntityID (H), LoginID (after slash '\')
-- of those who have the NationalIDNumber (H) within 2 range (above or below) to that number, order by descending BusinessEntityID (H)
GO
CREATE PROCEDURE Procedure_274
    @num INT
AS
SELECT NationalIDNumber, BusinessEntityID, SUBSTRING(LoginID, CHARINDEX('\', LoginID) + 1, LEN(LoginID)) AS New_LoginID
FROM HumanResources.Employee
WHERE (CAST(NationalIDNumber AS VARCHAR) LIKE '%' + CAST(@num AS VARCHAR) + '%'
OR CAST(NationalIDNumber AS VARCHAR) LIKE '%' + CAST((@num - 1) AS VARCHAR) + '%'
OR CAST(NationalIDNumber AS VARCHAR) LIKE '%' + CAST((@num - 2) AS VARCHAR) + '%'
OR CAST(NationalIDNumber AS VARCHAR) LIKE '%' + CAST((@num + 1) AS VARCHAR) + '%'
OR CAST(NationalIDNumber AS VARCHAR) LIKE '%' + CAST((@num + 2) AS VARCHAR) + '%')
AND @num > 7171 AND LEN(@num) = 4
GO

EXEC Procedure_274 @num = 7890

-- 275. Create a procedure that input 1-character parameter that returns BusinessEntityID (H), DepartmentID (A), JobTitle (H) and number of characters appeared in JobTitle (H)
-- of those who have that exact character at least once in JobTitle (H)
GO
CREATE PROCEDURE Procedure_275
    @num INT
AS
SELECT H.BusinessEntityID, A.DepartmentID, H.JobTitle, LEN(H.JobTitle) AS JobLength
FROM HumanResources.Employee H
JOIN HumanResources.EmployeeDepartmentHistory A ON A.BusinessEntityID = H.BusinessEntityID
WHERE @num <= 9
AND CAST(LEN(H.JobTitle) AS VARCHAR) LIKE '%' + CAST(@num AS VARCHAR) + '%'
GO

EXEC Procedure_275 @num = 2

-- 276. Create a procedure that input 7 parameters: a number for first digits of NationalIDNumber (H), 1-character that might appear in a JobTitle (H), Gender (H), MaritalStatus (H),
-- a number for VacationHours (H)(return records with VacationHours > n), a number for SickLeaveHours (H)(return records with SickLeaveHours <= n), ShiftID (A), order by column 4th,
-- the procedure return all the employee's data (H)
GO
CREATE PROCEDURE Procedure_276
    @firstdigitsNation INT,
    @charJob VARCHAR(1),
    @gender VARCHAR(1),
    @marital VARCHAR(1),
    @minVacation INT,
    @maxSick INT,
    @shift INT
AS
SELECT A.ShiftID, H.*
FROM HumanResources.Employee H 
JOIN HumanResources.EmployeeDepartmentHistory A ON H.BusinessEntityID = A.BusinessEntityID
WHERE CAST(H.NationalIDNumber AS VARCHAR) LIKE CASt(@firstdigitsNation AS varchar) + '%'
    AND H.JobTitle LIKE '%' + @charJob + '%'
    AND H.Gender = @gender
    AND H.MaritalStatus = @marital
    AND H.VacationHours > @minVacation
    AND H.SickLeaveHours <= @maxSick
    AND A.ShiftID = @shift
ORDER BY 4
GO

EXEC Procedure_276 @firstdigitsNation = 8, @charJob = 'R', @gender = 'F', @marital = 'S', @minVacation = 60, @maxSick = 55, @shift = 1

-- 277. Create a procedure that input 2 parameters 2 numbers as Inclusive Range for Age (2023 - BirthDate (H)), to display all employee's data (H) have Age between that 2 numbers 
-- the procedure then return all column from table employee (H)
GO
CREATE PROCEDURE Procedure_277
    @min INT,
    @max INT
AS 
SELECT DATEDIFF(YEAR, BirthDate, '2023-11-13') AS Age, *
FROM HumanResources.Employee
WHERE DATEDIFF(YEAR, BirthDate, '2023-11-13') >= @min
AND DATEDIFF(YEAR, BirthDate, '2023-11-13') <= @max
GO

EXEC Procedure_277 @min = 58, @max = 62

-- 278. Create a procedure that input a number, that return all employee's BusinessEntityID, LoginID (H)(after '\') of who have Day Age (from BirthDate (H) to 2023-11-11) CLOSEST to the parameter
GO
CREATE PROCEDURE Procedure_278
    @paramAge INT
AS
WITH AgeParam AS(
SELECT DATEDIFF(DAY, BirthDate, '2023-11-13') AS DayAge, BusinessEntityID, SUBSTRING(LoginID, CHARINDEX('\', LoginID) + 1, LEN(LoginID)) AS New_LoginID,
    ABS(DATEDIFF(DAY, BirthDate, '2023-11-13') - @paramAge) AS RangetoDayAge
FROM HumanResources.Employee 
), Ranking_DayAge AS(
SELECT RANK() OVER (ORDER BY RangetoDayAge ASC) AS Ranking, *
FROM AgeParam
)
SELECT *
FROM Ranking_DayAge
WHERE Ranking = 1
GO

EXEC Procedure_278 @paramAge = 24705

-- 279. Create a procedure that input a number, that returns all employee's data (H) and their DepartmentID (A) + ShiftID (A) of who have a greater Credit (new column) than that INPUT NUMBER
-- (Credit = [number of characters in LoginID (H) + number of characters in JobTitle (H)] x Month of StartDate (A)), then test the procedure with the parameter '400'
GO
CREATE PROCEDURE Procedure_279
    @credit INT
AS
SELECT (LEN(H.LoginID) + LEN(H.JobTitle) * DATEPART(MONTH, A.StartDate)) AS Credit, H.*
FROM HumanResources.Employee H 
JOIN HumanResources.EmployeeDepartmentHistory A ON A.BusinessEntityID = H.BusinessEntityID
WHERE (LEN(H.LoginID) + LEN(H.JobTitle) * DATEPART(MONTH, A.StartDate)) > @credit
GO

EXEC Procedure_279 @credit = 400

-- 280. Modify the procedure #279 so it takes a parameter @ranking instead of @credit, that returns the record with the exact ranking equal @ranking (rank based on Credit)
GO
CREATE PROCEDURE Procedure_280
    @ranking INT
AS
WITH Ranking_280 AS(
SELECT (LEN(H.LoginID) + LEN(H.JobTitle) * DATEPART(MONTH, A.StartDate)) AS Credit, 
    RANK() OVER (ORDER BY (LEN(H.LoginID) + LEN(H.JobTitle) * DATEPART(MONTH, A.StartDate)) DESC) AS Ranking,
    H.*
FROM HumanResources.Employee H 
JOIN HumanResources.EmployeeDepartmentHistory A ON A.BusinessEntityID = H.BusinessEntityID
)
SELECT *
FROM Ranking_280
WHERE Ranking = @ranking
GO

EXEC Procedure_280 @ranking = 6

-- 281. Create a procedure that input a number, that return all employee's BusinessEntityID, LoginID (H) 
-- of who have NationalIDNumber (H) with INPUT Number as both starting number and ending number
GO
CREATE PROCEDURE Procedure_281
    @startendNation INT
AS
SELECT BusinessEntityID, LoginID, NationalIDNumber
FROM HumanResources.Employee
WHERE CAST(NationalIDNumber AS varchar) LIKE CAST(@startendNation AS varchar) + '%'
AND CAST(NationalIDNumber AS varchar) LIKE '%' + CAST(@startendNation AS varchar) 
GO

EXEC Procedure_281 @startendNation = 24

-- 282. Find the maximum and minimum of total of every digits in NationalIDNumber (H)
GO
CREATE FUNCTION GetSumDigits (@number VARCHAR(255))
RETURNS INT
AS
BEGIN 
    DECLARE @sum INT = 0;
    DECLARE @i INT = 1;
    WHILE @i <= LEN(@number)
    BEGIN
        -- Add the value of the current digit to the sum
        SET @sum = @sum + CAST(SUBSTRING(@number, @i, 1) AS INT);
        SET @i = @i + 1;
    END
    RETURN @sum
END
GO

SELECT dbo.GetSumDigits(NationalIDNumber) AS SumDigits, NationalIDNumber, BusinessEntityID
FROM HumanResources.Employee
ORDER BY dbo.GetSumDigits(NationalIDNumber)

-- 283. Create a procedure that input a number, that returns the BusinessEntityID (H), LoginID (H), Age (2023 - BirthDate (H)) 
-- that have the sum of all digits in a NationalIDNumber equal the INPUT
GO
CREATE PROCEDURE Procedure_283
    @sumdigits INT
AS
SELECT dbo.GetSumDigits(NationalIDNumber) AS SumDigit, BusinessEntityID, LoginID, DATEDIFF(YEAR, BirthDate, '2023-11-13') AS Age
FROM HumanResources.Employee
WHERE dbo.GetSumDigits(NationalIDNumber) = @sumdigits
GO

EXEC Procedure_283 @sumdigits = 57

-- 284. Create a procedure that input a number, that returns all employee's BusinessEntityID, LoginID (H), DepartmentID (A) in decesding DepartmentID (A) order
-- of who have that INPUT NUMBER as the length for LoginID (H) or that INPUT NUMBER appears anywhere on NationalIDNumber (H)
GO
CREATE PROCEDURE Procedure_284
    @num INT
AS
SELECT H.BusinessEntityID, H.LoginID, A.DepartmentID, H.NationalIDNumber, LEN(H.LoginID) AS LengthLogin
FROM HumanResources.Employee H
JOIN HumanResources.EmployeeDepartmentHistory A ON H.BusinessEntityID = A.BusinessEntityID
WHERE LEN(H.LoginID) = @num OR CAST(H.NationalIDNumber AS varchar) LIKE '%' + CAST(@num AS varchar) + '%'
ORDER BY A.DepartmentID DESC 
GO

EXEC Procedure_284 @num = 21

-- 285. Create a procedure that input a number, that returns all the employee's records (H) of who have the input number as RANKING, 
-- which ranking based on the DepartmentID (A) > Descending BusinessEntityID (H) order
GO
CREATE PROCEDURE Procedure_285 
    @ranking INT
AS
WITH Ranking_285 AS(
    SELECT RANK() OVER (ORDER BY A.DepartmentID, H.BusinessEntityID DESC) AS Ranking, A.DepartmentID, H.*
    FROM HumanResources.Employee H 
    JOIN HumanResources.EmployeeDepartmentHistory A ON A.BusinessEntityID = H.BusinessEntityID
)
SELECT * 
FROM Ranking_285
WHERE Ranking = @ranking
GO

EXEC Procedure_285 @ranking = 1

-- 286. Create a procedure that input 2 numbers: @ranking and @department. The procedure returns all the employee's records (H) of who have @ranking as RANKING and @department as DepartmentID (A)
-- group partitioned by DepartmentID (A), ranking based on the DepartmentID (A) > Descending BusinessEntityID (H) order
GO
CREATE PROCEDURE Procedure_286
    @ranking INT,
    @department INT
AS
WITH Task_286_Ranking AS(
    SELECT RANK() OVER (PARTITION BY A.DepartmentID ORDER BY A.DepartmentID, H.BusinessEntityID DESC) AS Ranking, A.DepartmentID, H.*
    FROM HumanResources.Employee H
    JOIN HumanResources.EmployeeDepartmentHistory A ON A.BusinessEntityID = H.BusinessEntityID
)
SELECT *
FROM Task_286_Ranking
WHERE Ranking = @ranking AND DepartmentID = @department
GO

EXEC Procedure_286 @ranking = 3, @department = 10

-- 287. Create a procedure that input a number (maximum 9-digit), that returns all the employee's BusinessEntityID (H), NationalIDNumber (H), Age (2023 - Bdate) which satisfies the condition:
-- (Condition of INPUT: 1-digit: OrganizationLevel (H) = @n; 2-digit: Day in BirthDate (H) = @n; 4-digit: Year in BirthDate; 
-- More than 7-digit: NationalIDNumber; ELSE returns NOTHING)
GO
CREATE PROCEDURE Procedure_287
    @num9 INT
AS
SELECT BusinessEntityID, NationalIDNumber, DATEDIFF(YEAR, BirthDate, '2023-11-13') AS Age
FROM HumanResources.Employee
WHERE 
    (LEN(@num9) = 1 AND OrganizationLevel = @num9)
    OR (LEN(@num9) = 2 AND DATEPART(DAY, BirthDate) = @num9) 
    OR (LEN(@num9) = 4 AND DATEPART(YEAR, BirthDate) = @num9) 
    OR (LEN(@num9) >= 7 AND LEN(@num9) <= 9 AND NationalIDNumber = @num9)
GO

EXEC Procedure_287 @num9 = 3
EXEC Procedure_287 @num9 = 31
EXEC Procedure_287 @num9 = 1985
EXEC Procedure_287 @num9 = 695256908
EXEC Procedure_287 @num9 = 55555

-- 288. Create a dynamic SQL containing variable @table_name, that shows all records from the table @table_name, then test the dynamic SQL 
DECLARE @table_H VARCHAR(1000)
SET @table_H = 'HumanResources.Employee'
DECLARE @table_A VARCHAR(1000)
SET @table_A = 'HumanResources.EmployeeDepartmentHistory'
DECLARE @sql_288 VARCHAR(1000)
SET @sql_288 = 'SELECT * FROM '

PRINT(@sql_288 + @table_H)
EXEC (@sql_288 + @table_A)

-- 289. Create a dynamic SQL containing variables @table_name and @column, that shows all records from column BusinessEntityID (H) from employee's table (H)
DECLARE @table_name VARCHAR(1000)
SET @table_name = 'HumanResources.Employee'
DECLARE @column VARCHAR(1000)
SET @column = 'BusinessEntityID'
DECLARE @sql_289 VARCHAR(1000)
SET @sql_289 = 'SELECT ' + @column + ' FROM ' + @table_name

EXEC(@sql_289)

-- 290. Create a dynamic SQL containing variables @column1, @column2, @department, that shows all record from any 2 columns from employee's table (H) 
-- that have the @department as DepartmentID (A)
DECLARE @column1 VARCHAR(222)
SET @column1 = 'LoginID'
DECLARE @column2 VARCHAR(222)
SET @column2 = 'Gender'
DECLARE @sql_290 VARCHAR(1000)
SET @sql_290 = 'SELECT ' + @column1 + ', ' + @column2 + ' FROM HumanResources.Employee'

EXEC(@sql_290)

-- 291. Create a dynamic SQL containing variables @column, @condition1, @condition2, that shows all LoginID (H), NationalIDNumber (H) and an extra column @column from the same table
-- , which satisfies BOTH of the 2 conditions @condition1 and @condition2
DECLARE @column291 VARCHAR(1000)
SET @column291 = 'BirthDate'
DECLARE @condition1 VARCHAR(1000)
SET @condition1 = 'DATEDIFF(YEAR, BirthDate, ' + 'GETDATE()' + ') = 40'
DECLARE @condition2 VARCHAR(1000)
SET @condition2 = 'dbo.GetSumDigits(NationalIDNumber) > 20'
DECLARE @sql_291 VARCHAR(1000)
SET @sql_291 = 'SELECT LoginID, NationalIDNumber, ' + @column291 + ' FROM HumanResources.Employee
WHERE ' + @condition1 + ' AND ' + @condition2

EXEC (@sql_291)

-- 292. Create a dynamic SQL containing variables @aggregate, @groupcol, that shows the use of aggragate function @aggregate with column Age (2023 - BirthDate (H))
-- (Aggregate varibles: SUM, MIN, MAX, AVG, COUNT)
DECLARE @aggregate292 VARCHAR(5)
SET @aggregate292 = 'SUM'
DECLARE @sql_292 VARCHAR(1000)
SET @sql_292 = 'SELECT ' + @aggregate292 + '(DATEDIFF(YEAR, BirthDate, GetDate())) AS TotalYearAge' + ' FROM HumanResources.Employee'

EXEC (@sql_292)

-- 293. Create a dynamic SQL containing variables @table_name, @joincolumn, that shows the Employee Department table (A), which connected to table @table_name using column @joincolumn
DECLARE @table_293 VARCHAR(50)
SET @table_293 = 'HumanResources.Employee'
DECLARE @joincolumn_293 VARCHAR(50)
SET @joincolumn_293 = 'BusinessEntityID'
DECLARE @sql_293 VARCHAR(1000)
SET @sql_293 = 'SELECT A.* FROM HumanResources.EmployeeDepartmentHistory A 
JOIN ' + @table_293 + ' ON A.' + @joincolumn_293 + ' = ' + @table_293 + '.' + @joincolumn_293

EXEC (@sql_293)

-- 294. Create a dynamic SQL containing variables @table_name, @partitionby, @orderby, @sort, that shows entire table @table_name, 
-- but with ranking number partitioned by @partitionby (can be more than 1 column), and the partition order is @orderby, with @sort is the VIEW Order of the table after ranking
DECLARE @table_294 VARCHAR(50)
SET @table_294 = 'HumanResources.Employee'
DECLARE @partitionby VARCHAR(100)
SET @partitionby = 'OrganizationLevel'
DECLARE @orderby VARCHAR(100)
SET @orderby = 'NationalIDNumber DESC, LEN(JobTitle)'
DECLARE @sort VARCHAR(100)
SET @sort = 'BusinessEntityID DESC'
DECLARE @sql_294 VARCHAR(1000)
SET @sql_294 = 'SELECT RANK() OVER (PARTITION BY ' + @partitionby + ' ORDER BY ' + @orderby + ') AS Ranking, *
FROM ' + @table_294 + ' ORDER BY ' + @sort

EXEC (@sql_294)

-- 295. Create a dynamic SQL containing variables @organcase1, @organcase2, @organcase3, @organcase4, that shows the entire employee's table (H)
-- with 4 organization cases (OrganizationLevel = 1, 2, 3, 4) as 4 new custom names for each OrganizationLevel
DECLARE @organcase1 VARCHAR(100)
SET @organcase1 = 'Level One'
DECLARE @organcase2 VARCHAR(100)
SET @organcase2 = 'Level Two'
DECLARE @organcase3 VARCHAR(100)
SET @organcase3 = 'Level Three'
DECLARE @organcase4 VARCHAR(100)
SET @organcase4 = 'Level MAX'
DECLARE @sql_295 VARCHAR(1000)
SET @sql_295 = 'SELECT 
    CASE
        WHEN OrganizationLevel = 1 THEN ''' + @organcase1 + '''
        WHEN OrganizationLevel = 2 THEN ''' + @organcase2 + '''
        WHEN OrganizationLevel = 3 THEN ''' + @organcase3 + '''
        WHEN OrganizationLevel = 4 THEN ''' + @organcase4 + '''
        ELSE CAST(OrganizationLevel AS VARCHAR)
    END AS NewOrgan
    , *
FROM HumanResources.Employee'

EXEC (@sql_295)
 
-- 296. Create a dynamic SQL containing variable @creditformula, that shows BusinessEntityID (H), LoginID (H), Credit (new column)
-- with @creditformula is the Formula to calculate the Credit (usable numeric column: BusinessEntityID, OrganizationLevel, NationalIDNumber, VacationHours, SickLeaveHours),
-- the table is ordered from the highest Credit
DECLARE @creditformula VARCHAR(100)
SET @creditformula = 'BusinessEntityID * LEN(LoginID) * OrganizationLevel' 
DECLARE @sql_296 VARCHAR(1000)
SET @sql_296 = 'SELECT BusinessEntityID, LoginID, ' + @creditformula + ' AS Credit
FROM HumanResources.Employee
ORDER BY ' + @creditformula + ' DESC'

EXEC (@sql_296)

-- 297. Create a dynamic SQL containing variables @table_name, @minrow, @maxrow, that show all records from @table_name whose order will be shuffled,
-- @minrow and @maxrow will be the range of indexes for the records of the table after shuffling, the command returns the whole table data
DECLARE @table_297 VARCHAR(100)
SET @table_297 = 'HumanResources.Employee'
DECLARE @minrow VARCHAR(100)
SET @minrow = '5'
DECLARE @maxrow VARCHAR(100)
SET @maxrow = '9'
DECLARE @sql_297 VARCHAR(1000)
SET @sql_297 = 'WITH Ranking_297 AS(
SELECT RANK() OVER (ORDER BY NEWID()) AS Ranking, *
FROM ' + @table_297 + '
)
SELECT * FROM Ranking_297
WHERE Ranking >= ' + @minrow + '
AND Ranking <= ' + @maxrow

EXEC (@sql_297)

-- 298. Create a dynamic SQL containing variables @age, @aggregateid, that returns the Age (GETDATE - BirthDate (H)) of DepartmentID GROUP BY DepartmentID (A),
-- and @aggregateid is the ID for the aggregate function (1: SUM, 2: MIN, 3: MAX, 4: AVG, Other: COUNT) which is used to calculate the Age
DECLARE @aggregateid VARCHAR(1)
SET @aggregateid = '1'
DECLARE @sql_298 VARCHAR(1000)
SET @sql_298 = 'SELECT 
    CASE 
        WHEN ' + @aggregateid + ' = 1 THEN SUM(DATEDIFF(YEAR, BirthDate, GETDATE()))
        WHEN ' + @aggregateid + ' = 2 THEN MIN(DATEDIFF(YEAR, BirthDate, GETDATE()))
        WHEN ' + @aggregateid + ' = 3 THEN MAX(DATEDIFF(YEAR, BirthDate, GETDATE()))
        WHEN ' + @aggregateid + ' = 4 THEN AVG(DATEDIFF(YEAR, BirthDate, GETDATE()))
        ELSE COUNT(*)
    END AS Aggregate_Age, 
    A.DepartmentID
FROM HumanResources.Employee H 
JOIN HumanResources.EmployeeDepartmentHistory A ON A.BusinessEntityID = H.BusinessEntityID
GROUP BY A.DepartmentID'

EXEC (@sql_298)

-- 299. Create a dynamic SQL containing variables @age, @ranking, @aggregateid, that returns the Age = @age (2023 - BirthDate (H)) of DepartmentID GROUP BY DepartmentID (A),
-- and @aggregateid is the ID for the aggregate function (1: SUM, 2: MIN, 3: MAX, 4: AVG, Other: COUNT) which is used to calculate the Age,
-- and show the group with the rank = @ranking , ranking based on the aggregate ascending order
DECLARE @aggregateid2 VARCHAR(1)
SET @aggregateid2 = '3'
DECLARE @ranking_299 VARCHAR(2)
SET @ranking_299 = '5'
DECLARE @sql_299 VARCHAR(1000)
SET @sql_299 = ' WITH Aggregate_299 AS( 
    SELECT 
    CASE 
        WHEN ' + @aggregateid2 + ' = 1 THEN SUM(DATEDIFF(YEAR, BirthDate, GETDATE()))
        WHEN ' + @aggregateid2 + ' = 2 THEN MIN(DATEDIFF(YEAR, BirthDate, GETDATE()))
        WHEN ' + @aggregateid2 + ' = 3 THEN MAX(DATEDIFF(YEAR, BirthDate, GETDATE()))
        WHEN ' + @aggregateid2 + ' = 4 THEN AVG(DATEDIFF(YEAR, BirthDate, GETDATE()))
        ELSE COUNT(*)
    END AS Aggregate_Age,
    A.DepartmentID
    FROM HumanResources.Employee H 
    JOIN HumanResources.EmployeeDepartmentHistory A ON A.BusinessEntityID = H.BusinessEntityID
    GROUP BY A.DepartmentID
), Ranking_299 AS(
    SELECT RANK() OVER (ORDER BY Aggregate_Age) AS Ranking, * FROM Aggregate_299
)
SELECT * FROM Ranking_299 
WHERE Ranking = ' + @ranking_299

EXEC (@sql_299)

-- 300. Create a dynamic SQL containing variable @dayage, that returns employee's NationalIDNumber (H), Day Age (BirthDate (H) to 2023-11-13), OrganizationLevel,
-- that employee has the Day Age closest to @dayage
DECLARE @dayage2 VARCHAR(10)
SET @dayage2 = '18000'
DECLARE @sql_300 VARCHAR(1000)
SET @sql_300 = 'WITH Ranking_300 AS(
    SELECT NationalIDNumber, DATEDIFF(DAY, BirthDate, GETDATE()) AS DayAge, OrganizationLevel, ABS(' + @dayage2 + '- DATEDIFF(DAY, BirthDate, GETDATE())) AS RangeDayAge,
        RANK() OVER (ORDER BY (ABS(' + @dayage2 + ' - DATEDIFF(DAY, BirthDate, GETDATE())))) AS Ranking
    FROM HumanResources.Employee
)
SELECT * FROM Ranking_300
WHERE Ranking = 1'

EXEC (@sql_300)