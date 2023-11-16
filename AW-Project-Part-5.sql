-- Part 5: 11/11/2023

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
-- TASK 201 TO 250
-- KNOWLEDGE COVERED: FUNCTIONS (return Tables)
----------------------------------------------------------------
-- Note: Put 2 'GO' Before and After any functions to avoid Syntax Error.

-- 201. Create a function that display all employee's BusinessEntityID (H) based on a parameter OrganizationLevel (H)
GO
CREATE FUNCTION GetBEID_By_OrganizationLevel(@OrganizationLevel INT)
RETURNS TABLE
AS
RETURN 
(
    SELECT BusinessEntityID, OrganizationLevel
    FROM HumanResources.Employee
    WHERE OrganizationLevel = @OrganizationLevel
);
GO

-- 202. Use the function from task #201 with 2 as the parameter
SELECT * FROM GetBEID_By_OrganizationLevel(2)

-- 203. Create a function that display all employee's LoginID (H)(Only the part after the slash '\') based on a parameter Gender (H)
GO
CREATE FUNCTION LoginIDByGender(@gender VARCHAR(1))
RETURNS TABLE
AS
RETURN 
(
    SELECT SUBSTRING(LoginID, CHARINDEX('\', LoginID) + 1, LEN(LoginID)) AS New_LoginID, Gender
    FROM HumanResources.Employee
    WHERE Gender = @gender
);
GO

-- 204. Find all parameters that return records for the function #203, then use the function for ALL parameters found.
SELECT COUNT(*), Gender 
FROM HumanResources.Employee
GROUP BY Gender

SELECT * FROM LoginIDByGender('F')
SELECT * FROM LoginIDByGender('M')

-- 205. Create a function that display all employee's BusinessEntityID (H), based on a parameter Year of Birthdate (H)
GO
CREATE FUNCTION BEIDByYearBorn(@YearBorn INT)
RETURNS TABLE
AS
RETURN 
(
    SELECT BusinessEntityID, DATEPART(YEAR, BirthDate) AS YearBorn
    FROM HumanResources.Employee
    WHERE DATEPART(YEAR, BirthDate) = @YearBorn
);
GO

SELECT * FROM BEIDByYearBorn(1972)

-- 206. Create a function that display all employee's NationalIDNumber (H), based on a parameter Age (2023 - Birthdate) (H)
GO
CREATE FUNCTION NationIDByAge(@age INT)
RETURNS TABLE
AS
RETURN 
(
    SELECT NationalIDNumber, DATEDIFF(YEAR, BirthDate, '2023') AS Age, BirthDate
    FROM HumanResources.Employee
    WHERE DATEDIFF(YEAR, BirthDate, '2023') = @age
);
GO

SELECT * FROM NationIDByAge(45)

-- 207. Create a function that display all employee's BusinessEntityID (H), LoginID (H), Gender (H), based on 2 parameters Day + Month for BirthDate (H)
GO
CREATE FUNCTION Function_207(@dayBirth INT, @monthBirth INT)
RETURNS TABLE
AS
RETURN 
(
    SELECT BusinessEntityID, LoginID, Gender, BirthDate
    FROM HumanResources.Employee
    WHERE DATEPART(DAY, BirthDate) = @dayBirth
    AND DATEPART(MONTH, BirthDate) = @monthBirth
);
GO

SELECT * FROM Function_207(5, 12)

-- 208. Find the combination of the Day/Month that appears the most in employee's BirthDate (H), then use it as the parameter for the function #207
SELECT COUNT(*) AS Counter, DATEPART(DAY, BirthDate) AS DayBorn, DATEPART(MONTH, BirthDate) AS MonthBorn
FROM HumanResources.Employee
GROUP BY DATEPART(DAY, BirthDate), DATEPART(MONTH, BirthDate)
ORDER BY COUNT(*) DESC

SELECT * FROM Function_207(10, 2)

-- 209. Find ALL the combinations of the Day/Month that appears the least in employee's BirthDate (H), then use them as the parameter for the function #207
SELECT COUNT(*) AS Counter, DATEPART(DAY, BirthDate) AS DayBorn, DATEPART(MONTH, BirthDate) AS MonthBorn
FROM HumanResources.Employee
GROUP BY DATEPART(DAY, BirthDate), DATEPART(MONTH, BirthDate)
ORDER BY COUNT(*) ASC

SELECT * FROM Function_207(3, 1)
SELECT * FROM Function_207(11, 1)

-- 210. Create a function that input a character to display all employee's NationalIDNumber (H), JobTitle (H) of those who have that character in JobTitle (H)
GO
CREATE FUNCTION JobTitle_By_1Char(@Job_Char VARCHAR(1))
RETURNS TABLE
AS
RETURN 
(
    SELECT NationalIDNumber, JobTitle
    FROM HumanResources.Employee
    WHERE JobTitle LIKE '%' + @Job_Char + '%'
);
GO
SELECT * FROM JobTitle_By_1Char('E')

-- 211. Create a function that input set of 2 characters as 1 parameter to display all employee's NationalIDNumber (H), JobTitle (H)
-- of those who have that 2 characters consecutively in JobTitle (H)
GO
CREATE FUNCTION JobTitle_By_2Char(@Job_Char VARCHAR(2))
RETURNS TABLE
AS
RETURN 
(
    SELECT NationalIDNumber, JobTitle
    FROM HumanResources.Employee
    WHERE JobTitle LIKE '%' + @Job_Char + '%'
);
GO
SELECT * FROM JobTitle_By_2Char('me')

-- 212. Create a function that input 2 one-character as 2 parameters to display all employee's LoginID (H), Age (2023 - BirthDate), JobTitle (H) 
-- of those who have both that 2 characters anywhere in JobTitle (H)
GO
CREATE FUNCTION Function_212(@char1 VARCHAR(1), @char2 VARCHAR(1))
RETURNS TABLE
AS
RETURN 
(
    SELECT LoginID, DATEDIFF(YEAR, BirthDate, '2023-11-11') AS Age, JobTitle
    FROM HumanResources.Employee
    WHERE CHARINDEX(@char1, JobTitle) > 0 AND CHARINDEX(@char2, JobTitle) > 0
);
GO

SELECT * FROM Function_212('F', 'S')

-- 213. Create a function that input 3 two-character as 3 parameters to display all employee's LoginID (H), Age (2023 - BirthDate), JobTitle (H) 
-- of those who have any of those two-characters anywhere in JobTitle (H)
GO
CREATE FUNCTION Function_213(@word1 VARCHAR(2), @word2 VARCHAR(2), @word3 VARCHAR(2))
RETURNS TABLE
AS 
RETURN
(
    SELECT LoginID, DATEDIFF(YEAR, BirthDate, '2023-11-11') AS Age, JobTitle
    FROM HumanResources.Employee
    WHERE JobTitle LIKE '%' + @word1  + '%'
    OR JobTitle LIKE '%' + @word2  + '%'
    OR JobTitle LIKE '%' + @word3  + '%'
)
GO

SELECT * FROM Function_213('em', 'fu', 'lo')

-- 214. Create a funtion that input a set of 2 numbers that returns all BusinessEntityID (H), OrganizationLevel (H) of those who have that both number sets in NationalIDNumber (H)
GO
CREATE FUNCTION Function_214(@num1 INT, @num2 INT)
RETURNS TABLE
AS
RETURN 
(
    SELECT BusinessEntityID, NationalIDNumber, OrganizationLevel
    FROM HumanResources.Employee
    WHERE CAST(NationalIDNumber AS VARCHAR) LIKE '%' + CAST(@num1 AS VARCHAR) + '%' AND CAST(NationalIDNumber AS VARCHAR) LIKE '%' + CAST(@num2 AS VARCHAR) + '%'
);
GO

SELECT * FROM Function_214(773, 42)

-- 215. Create a funtion that input a 3-digit number (must be greater than 666 to proceed) that returns all NationalIDNumber (H), Length of JobTitle (H), HireDate (H)
-- of those who have that number set in NationalIDNumber (H)
GO
CREATE FUNCTION Function_215(@num INT)
RETURNS TABLE
AS
RETURN 
(
    SELECT NationalIDNumber, LEN(JobTitle) AS JobLength, HireDate
    FROM HumanResources.Employee
    WHERE CAST(NationalIDNumber AS VARCHAR) LIKE '%' + CAST(@num AS VARCHAR) + '%'
    AND LEN(@num) = 3 AND @num > 666
);
GO

SELECT * FROM Function_215(1111)    -- Should not return anything
SELECT * FROM Function_215(277)     -- Should not return anything
SELECT * FROM Function_215(955)

-- 216. Create a function that input a 4-digit number (must be greater than 2345 to proceed) that returns all NationalIDNumber (H), BusinessEntityID (H), HireDate (H)
-- of those who have the NationalIDNumber (H) within 1 range (above or below) to that number
GO
CREATE FUNCTION Function_216(@num INT)
RETURNS TABLE
AS
RETURN 
(
    SELECT NationalIDNumber, LEN(JobTitle) AS JobLength, HireDate
    FROM HumanResources.Employee
    WHERE (CAST(NationalIDNumber AS VARCHAR) LIKE '%' + CAST(@num AS VARCHAR) + '%'
    OR CAST(NationalIDNumber AS VARCHAR) LIKE '%' + CAST((@num + 1) AS VARCHAR) + '%'
    OR CAST(NationalIDNumber AS VARCHAR) LIKE '%' + CAST((@num - 1) AS VARCHAR) + '%')
    AND LEN(@num) = 4 AND @num > 2345
);
GO

SELECT * FROM Function_216(7731)    -- 1 record
SELECT * FROM Function_216(9695)    -- 2 records

-- 217. Create a function that input 1-character parameters that return BusinessEntityID (H), JobTitle (H) and number of characters appeared in JobTitle (H)
-- of those who have that exact character at least once in JobTitle (H), then use a function on the characters: 'H', 'U', and 'F'
GO
CREATE FUNCTION Function_217(@char VARCHAR(1))
RETURNS TABLE
AS
RETURN 
(
    SELECT BusinessEntityID, JobTitle, LEN(JobTitle) AS JobLength
    FROM HumanResources.Employee
    WHERE JobTitle LIKE '%' + @char + '%'
);
GO

SELECT * FROM Function_217('H')
SELECT * FROM Function_217('U')
SELECT * FROM Function_217('F')

-- 218. Create a function that input a parameter number for ShiftID (A), to display all employee's data (H) with that ShiftID (A)
GO
CREATE FUNCTION Function_218(@shiftID INT)
RETURNS TABLE
AS
RETURN 
(
    SELECT A.ShiftID, H.*
    FROM HumanResources.Employee H
    JOIN HumanResources.EmployeeDepartmentHistory A ON A.BusinessEntityID = H.BusinessEntityID
    WHERE A.ShiftID = @shiftID
);
GO

SELECT * FROM Function_218(3)

-- 219. Create a function that input 2 parameters as DepartmentID (A) and ShiftID (A), to display all employee's data (H) with that 2 fields (A)
GO
CREATE FUNCTION Function_219(@departmentID INT, @shiftID INT)
RETURNS TABLE
AS
RETURN 
(
    SELECT A.DepartmentID, A.ShiftID, H.*
    FROM HumanResources.Employee H
    JOIN HumanResources.EmployeeDepartmentHistory A ON A.BusinessEntityID = H.BusinessEntityID
    WHERE A.DepartmentID = @departmentID AND A.ShiftID = @shiftID
);
GO

SELECT * FROM Function_219(14, 1)

-- 220. Create a function that input 3 parameter as MaritalStatus (H), Gender (H) and ShiftID (A), to display all employee's data (H) + Deparment GroupName (D) with that 3 fields (A)
GO
CREATE FUNCTION Function_220(@marital VARCHAR(1), @gender VARCHAR(1), @shiftID INT)
RETURNS TABLE
AS
RETURN 
(
    SELECT A.ShiftID, D.GroupName, H.*
    FROM HumanResources.Employee H
    JOIN HumanResources.EmployeeDepartmentHistory A ON A.BusinessEntityID = H.BusinessEntityID
    JOIN HumanResources.Department D ON A.DepartmentID = D.DepartmentID
    WHERE H.MaritalStatus = @marital AND H.Gender = @gender AND A.ShiftID = @shiftID
);
GO

SELECT * FROM Function_220('S', 'F', 1)
SELECT * FROM Function_220('M', 'M', 2)

-- 221. Create a function that input 7 parameters: a number for first digits of NationalIDNumber (H), 1-character that might appear in a JobTitle (H), Gender (H), MaritalStatus (H),
-- a number for VacationHours (H)(return records with VacationHours > n), a number for SickLeaveHours (H)(return records with SickLeaveHours <= n), ShiftID (A)
GO
CREATE FUNCTION Function_221(@nationNum INT, @job1char VARCHAR(1), @gender VARCHAR(1), @marital VARCHAR(1), @vacation INT, @sickleave INT, @shiftID INT)
RETURNS TABLE
AS
RETURN 
(
    SELECT H.NationalIDNumber, H.JobTitle, H.Gender , H.MaritalStatus, H.VacationHours, H.SickLeaveHours, A.ShiftID
    FROM HumanResources.Employee H
    JOIN HumanResources.EmployeeDepartmentHistory A ON A.BusinessEntityID = H.BusinessEntityID
    WHERE 
        LEFT(H.NationalIDNumber, 2) = @nationNum 
        AND H.JobTitle LIKE '%' + @job1char + '%' 
        AND H.MaritalStatus = @marital
        AND H.Gender = @gender 
        AND H.VacationHours > @vacation 
        AND H.SickLeaveHours <= @sickleave 
        AND A.ShiftID = @shiftID
);
GO

SELECT * FROM Function_221(69, 'S', 'F', 'M', 3, 40, 1)

-- 222. Try the function with these 2 sets of parameter: (71, W, F, M, 75, 60, 2) and (94, 4, M, M, 40, 53, 2)
SELECT * FROM Function_221(71, 'W', 'F', 'M', 75, 60, 2)
SELECT * FROM Function_221(94, '4', 'M', 'M', 40, 53, 2)

-- 223. Create a function that input 2 parameters as the Minimum and Maximum for Age (2023 - BirthDate (H)), to display all employee's data (H)
GO
CREATE FUNCTION Function_223(@minAge INT, @maxAge INT)
RETURNS TABLE
AS
RETURN 
(
    SELECT *, DATEDIFF(YEAR, BirthDate, '2023-11-11') AS Age
    FROM HumanResources.Employee
    WHERE DATEDIFF(YEAR, BirthDate, '2023-11-11') >= @minAge 
    AND DATEDIFF(YEAR, BirthDate, '2023-11-11') <= @maxAge
);
GO

SELECT * FROM Function_223(43, 45)
SELECT * FROM Function_223(45, 40)

-- 224. Create a function that input 2 parameters 2 numbers as Range for Age (2023 - BirthDate (H)), to display all employee's data (H) have Age between that 2 numbers
GO
CREATE FUNCTION Function_224(@age1 INT, @age2 INT)
RETURNS TABLE
AS
RETURN 
(
    SELECT *, DATEDIFF(YEAR, BirthDate, '2023-11-11') AS Age
    FROM HumanResources.Employee
    WHERE DATEDIFF(YEAR, BirthDate, '2023-11-11') BETWEEN @age1 AND @age2
    UNION
    SELECT *, DATEDIFF(YEAR, BirthDate, '2023-11-11') AS Age
    FROM HumanResources.Employee
    WHERE DATEDIFF(YEAR, BirthDate, '2023-11-11') BETWEEN @age2 AND @age1
);
GO

SELECT * FROM Function_224(43, 45)
SELECT * FROM Function_224(45, 40)

-- 225. Create a function that input a number, that return all employee's BusinessEntityID, LoginID (H)(after '\') of who have Day Age (from BirthDate (H) to 2023-11-11) CLOSEST to that INPUT NUMBER
GO
CREATE FUNCTION Function_225(@num INT)
RETURNS TABLE
AS
RETURN 
(
    WITH DayAgeRange AS(
        SELECT BusinessEntityID, SUBSTRING(LoginID, CHARINDEX('\', LoginID) + 1, LEN(LoginID)) AS New_LoginID, DATEDIFF(DAY, BirthDate, '2023-11-11') AS DayAge, 
            ABS(@num - DATEDIFF(DAY, BirthDate, '2023-11-11')) AS RangeDayAge
        FROM HumanResources.Employee
    )
    SELECT *
    FROM DayAgeRange
    WHERE RangeDayAge = (SELECT MIN(RangeDayAge) FROM DayAgeRange)
);
GO

SELECT * FROM Function_225(17000)

-- 226. Create a function that input a number, that returns all employee's data (H) and their DepartmentID (A) + ShiftID (A) of who have a greater Credit (new column) than that INPUT NUMBER
-- (Credit = [number of characters in LoginID (H) + number of characters in JobTitle (H)] x Month of StartDate (A)), then test the function with the parameter '500'
GO
CREATE FUNCTION Function_226(@credit INT)
RETURNS TABLE
AS
RETURN 
(
    SELECT H.*, A.DepartmentID, A.ShiftID, (LEN(H.LoginID) + LEN(H.JobTitle)) * DATEPART(MONTH, A.StartDate) AS Credit
    FROM HumanResources.Employee H
    JOIN HumanResources.EmployeeDepartmentHistory A ON A.BusinessEntityID = H.BusinessEntityID
    WHERE (LEN(H.LoginID) + LEN(H.JobTitle)) * DATEPART(MONTH, A.StartDate) > @credit
);
GO

SELECT * FROM Function_226(500);

-- 227. Find the number parameter that returns EXACTLY 5 records for function in #226, then test the function with it
WITH CreditRank AS(
    SELECT H.*, A.DepartmentID, A.ShiftID, (LEN(H.LoginID) + LEN(H.JobTitle)) * DATEPART(MONTH, A.StartDate) AS Credit, 
        RANK() OVER (ORDER BY ((LEN(H.LoginID) + LEN(H.JobTitle)) * DATEPART(MONTH, A.StartDate)) DESC) AS Ranking
    FROM HumanResources.Employee H
    JOIN HumanResources.EmployeeDepartmentHistory A ON A.BusinessEntityID = H.BusinessEntityID
)
SELECT * FROM CreditRank
WHERE Ranking <= 5
ORDER BY Ranking

SELECT * FROM Function_226(647);

-- 228. Create a function that input a number, that return all employee's BusinessEntityID, LoginID (H) of who have NationalIDNumber with INPUT Number as both starting number and ending number 
GO
CREATE FUNCTION Function_228(@num INT)
RETURNS TABLE
AS
RETURN 
(
    SELECT BusinessEntityID, NationalIDNumber, LoginID
    FROM HumanResources.Employee
    WHERE LEFT(NationalIDNumber, LEN(@num)) = @num
    AND RIGHT(NationalIDNumber, LEN(@num)) = @num
)
GO

SELECT * FROM Function_228(1)

-- 229. Create a function that input a number, that return all employee's BusinessEntityID, LoginID (H) of who have NationalIDNumber with INPUT Number as either starting number or ending number 
GO
CREATE FUNCTION Function_229(@num INT)
RETURNS TABLE
AS
RETURN 
(
    SELECT BusinessEntityID, NationalIDNumber, LoginID
    FROM HumanResources.Employee
    WHERE LEFT(NationalIDNumber, LEN(@num)) = @num
    OR RIGHT(NationalIDNumber, LEN(@num)) = @num
)
GO

SELECT * FROM Function_229(3)

-- 230. Create a function that input a number, that return all employee's BusinessEntityID, LoginID (H), DepartmentID (A) 
-- of who have that INPUT NUMBER as the length for LoginID (H) or that INPUT NUMBER appears anywhere on NationalIDNumber (H)
GO
CREATE FUNCTION Function_230(@num INT)
RETURNS TABLE
AS
RETURN 
(
    SELECT H.BusinessEntityID, H.NationalIDNumber, H.LoginID, A.DepartmentID
    FROM HumanResources.Employee H
    JOIN HumanResources.EmployeeDepartmentHistory A ON H.BusinessEntityID = A.BusinessEntityID
    WHERE LEN(H.LoginID) = @num OR CAST(H.NationalIDNumber AS varchar) LIKE '%' + CAST(@num AS varchar) + '%'
)
GO

SELECT * FROM Function_230(27)

-- 231. Create a function that input a number that return the record counter in employee's table (H) with that INPUT NUMBER as the DepartmentID GROUP (A)
GO
CREATE FUNCTION Function_231(@departmentID INT) 
RETURNS TABLE
AS
RETURN 
(
    WITH Task_231 AS(
        SELECT H.*, A.DepartmentID
        FROM HumanResources.Employee H
        JOIN HumanResources.EmployeeDepartmentHistory A ON H.BusinessEntityID = A.BusinessEntityID
        WHERE A.DepartmentID =  @departmentID
    )
    SELECT COUNT(*) AS Counter, DepartmentID
    FROM Task_231
    GROUP BY DepartmentID
);
GO

SELECT * FROM Function_231(11)

-- 232. Create a function that input a number that return the total number of characters in LoginID (H) and total Day in BirthDate (H)(for all records altogether using GROUP BY)
--  with that INPUT NUMBER as the OrganizationLevel GROUP (A)
GO
CREATE FUNCTION Function_232(@organLvl INT)
RETURNS TABLE
AS
RETURN 
(
    WITH Task_232_Group AS(
        SELECT H.LoginID, LEN(H.LoginID) AS Length_Login, DATEPART(DAY, H.BirthDate) AS Day_BirthDate, H.OrganizationLevel
        FROM HumanResources.Employee H
        JOIN HumanResources.EmployeeDepartmentHistory A ON H.BusinessEntityID = A.BusinessEntityID
        WHERE H.OrganizationLevel = @organLvl
    )
    SELECT SUM(Length_Login) AS Total_Login, SUM(Day_BirthDate) AS Total_Day, OrganizationLevel
    FROM Task_232_Group
    GROUP BY OrganizationLevel
);
GO

SELECT * FROM Function_232(4);

-- 233. Find the 2 OrganizationLevel GROUP (H, NON NULL) with Highest and Lowest total number of characters in LoginID, 
-- then modify the function #232 to input 2 GROUP parameters at once to use the numbers for the function
WITH Task_232_Group AS(
    SELECT H.LoginID, LEN(H.LoginID) AS Length_Login, DATEPART(DAY, H.BirthDate) AS Day_BirthDate, H.OrganizationLevel
    FROM HumanResources.Employee H
    JOIN HumanResources.EmployeeDepartmentHistory A ON H.BusinessEntityID = A.BusinessEntityID
    WHERE H.OrganizationLevel IS NOT NULL
), Task_232_SumGroup AS(
    SELECT SUM(Length_Login) AS Total_Login, SUM(Day_BirthDate) AS Total_Day, OrganizationLevel
    FROM Task_232_Group
    GROUP BY OrganizationLevel
), Task_233_Min AS(
    SELECT MIN(Total_Login) AS MINTotal_Login
    FROM Task_232_SumGroup
), Task_233_Max AS(
    SELECT MAX(Total_Login) AS MAXTotal_Login
    FROM Task_232_SumGroup
) 
SELECT SG.*
FROM Task_232_SumGroup SG 
RIGHT JOIN Task_233_Min MIN ON Min.MINTotal_Login = SG.Total_Login
UNION 
SELECT SG.*
FROM Task_232_SumGroup SG 
RIGHT JOIN Task_233_Max MAX ON Max.MAXTotal_Login = SG.Total_Login

-- 234. Create a function that input 2 numbers for DepartmentID (A) and OrganizationLevel (H), that return the total Age (2023 - BirthDate (H)) and average VacationHours (H) for that GROUP
GO
CREATE FUNCTION Function_234(@organLvl INT, @organLvl2 INT)
RETURNS TABLE
AS
RETURN 
(
    WITH Task_232_Group AS(
        SELECT H.LoginID, LEN(H.LoginID) AS Length_Login, DATEPART(DAY, H.BirthDate) AS Day_BirthDate, H.OrganizationLevel
        FROM HumanResources.Employee H
        JOIN HumanResources.EmployeeDepartmentHistory A ON H.BusinessEntityID = A.BusinessEntityID
        WHERE H.OrganizationLevel = @organLvl
        OR H.OrganizationLevel = @organLvl2
    )
    SELECT SUM(Length_Login) AS Total_Login, SUM(Day_BirthDate) AS Total_Day, OrganizationLevel
    FROM Task_232_Group
    GROUP BY OrganizationLevel
);
GO

SELECT * FROM Function_234(4, 1);

-- 235. Create a function that input 3 parameters: Minimum for Month of HireDate (H), Maximum for Month of HireDate (H) and DepartmentID (A),   
-- that return the total AbsenceHours for all records in that specific GROUP (AbsenceHours = VacationHours (H) + SickLeaveHours (H))
GO
CREATE FUNCTION Function_235(@minHire INT, @maxHire INT, @departmentID INT)
RETURNS TABLE
AS
RETURN 
(
    WITH Join_Table AS (
        SELECT H.BusinessEntityID, A.DepartmentID, DATEPART(MONTH, H.VacationHours) + DATEPART(MONTH, H.SickLeaveHours) AS AbsenceHours, H.HireDate
        FROM HumanResources.Employee H
        JOIN HumanResources.EmployeeDepartmentHistory A ON A.BusinessEntityID = H.BusinessEntityID
    )
    SELECT * 
    FROM Join_Table
    WHERE 
        DATEPART(MONTH, HireDate) >= @minHire
        AND DATEPART(MONTH, HireDate) <= @maxHire
        AND DepartmentID = @departmentID
);
GO

SELECT * FROM Function_235(1, 12, 16);

-- 236. Knowing Minimum and Maximum for Month of HireDate (H) are 1/4, find the GROUP of ShiftID (A) and DepartmentID (A) with the highest AbsenceHours (#235) then apply to function #235
WITH Join_Table_236 AS(
    SELECT H.BusinessEntityID, A.ShiftID , A.DepartmentID, DATEPART(MONTH, H.VacationHours) + DATEPART(MONTH, H.SickLeaveHours) AS AbsenceHours, H.HireDate
    FROM HumanResources.Employee H
    JOIN HumanResources.EmployeeDepartmentHistory A ON A.BusinessEntityID = H.BusinessEntityID
), MaxAbsence_236 AS(
    SELECT ShiftID, DepartmentID, MAX(AbsenceHours) AS MaxHours
    FROM Join_Table_236
    WHERE DATEPART(MONTH, HireDate) >= 1 AND DATEPART(MONTH, HireDate) <= 4
    GROUP BY ShiftID, DepartmentID
), Rank_236 AS(
    SELECT *, RANK() OVER (ORDER BY MaxHours DESC) AS Ranking
    FROM MaxAbsence_236
)
SELECT * FROM Rank_236
WHERE Ranking = 1

-- 237. Rewrite the function #235 with an extra parameter as the RANK (total 4 parameters), the new function should return the GROUP with that specific number of ranking (based on AbsenceHours)
GO
CREATE FUNCTION Function_237(@minHire INT, @maxHire INT, @departmentID INT, @ranking INT)
RETURNS TABLE
AS
RETURN 
(
    WITH Join_Table AS (
        SELECT H.BusinessEntityID, A.DepartmentID, DATEPART(MONTH, H.VacationHours) + DATEPART(MONTH, H.SickLeaveHours) AS AbsenceHours, H.HireDate
        FROM HumanResources.Employee H
        JOIN HumanResources.EmployeeDepartmentHistory A ON A.BusinessEntityID = H.BusinessEntityID
    ), Rank_237 AS(
        SELECT *, RANK() OVER (ORDER BY AbsenceHours DESC) AS Ranking
        FROM Join_Table
        WHERE 
            DATEPART(MONTH, HireDate) >= @minHire
            AND DATEPART(MONTH, HireDate) <= @maxHire
            AND DepartmentID = @departmentID
    )
    SELECT *
    FROM Rank_237
    WHERE Ranking = @ranking
);
GO

SELECT * FROM Function_237(1, 6, 16, 2);

-- 238. Create a function that input 3 parameters as MaritalStatus (H), Gender (H) and 'Ranking' (RANK based on (MartitalStatus >> Gender with Order of Descending NationalIDNumber (H))), 
-- that return the employee's record counter (H), total AbsenceHours, the GROUP (Concat MartialStatus/Gender; example: 'S-M') and the ranking number based on that GROUP
GO
CREATE FUNCTION Function_238(@martial VARCHAR(1), @gender VARCHAR(1), @ranking INT)
RETURNS TABLE
AS
RETURN 
(
    WITH Ranking_238 AS(
        SELECT NationalIDNumber, MaritalStatus, Gender, RANK() OVER (PARTITION BY MaritalStatus, Gender ORDER BY NationalIDNumber DESC) AS Ranking
        FROM HumanResources.Employee
        WHERE MaritalStatus = @martial AND Gender = @gender
    )
    SELECT NationalIDNumber, CONCAT(MaritalStatus, '-', Gender) AS GroupName, Ranking
    FROM Ranking_238
    WHERE Ranking = @ranking
);
GO

SELECT * FROM Function_238('S', 'M', 7)

-- 239. Modify function #238 so instead of inputing (MaritalStatus, Gender, Ranking), it takes (MaritalStatus, Gender, Min Ranking, Max Ranking) as INPUT,
-- this function returns all records within Ranking Range
GO
CREATE FUNCTION Function_239(@martial VARCHAR(1), @gender VARCHAR(1), @minRank VARCHAR(1), @maxRank INT)
RETURNS TABLE
AS
RETURN 
(
    WITH Ranking_239 AS(
        SELECT NationalIDNumber, MaritalStatus, Gender, RANK() OVER (PARTITION BY MaritalStatus, Gender ORDER BY NationalIDNumber DESC) AS Ranking
        FROM HumanResources.Employee
        WHERE MaritalStatus = @martial AND Gender = @gender
    )
    SELECT NationalIDNumber, CONCAT(MaritalStatus, '-', Gender) AS GroupName, Ranking
    FROM Ranking_239
    WHERE Ranking >= @minRank AND Ranking <= @maxRank
);
GO

SELECT * FROM Function_239('S', 'M', 4, 8)

-- 240. Create a function that input a number, that returns all the employee's records (H) of who have the input number as RANKING, based on the DepartmentID (A) > Descending BusinessEntityID (H) order
GO
CREATE FUNCTION Function_240(@ranking INT)
RETURNS TABLE
AS
RETURN 
(
    WITH Ranking_240 AS(
        SELECT H.*, A.DepartmentID, RANK() OVER (ORDER BY A.DepartmentID, H.BusinessEntityID DESC) AS Ranking
        FROM HumanResources.Employee H 
        JOIN HumanResources.EmployeeDepartmentHistory A ON A.BusinessEntityID = H.BusinessEntityID
    )
    SELECT *
    FROM Ranking_240
    WHERE Ranking = @ranking
);
GO

SELECT * FROM Function_240(4)

-- 241. Create a function that input a number, that returns all the employee's records (H) of who have the ranking number,
-- group by DepartmentID (A), ranking based on the DepartmentID (A) > Descending BusinessEntityID (H) order
GO
CREATE FUNCTION Function_241(@ranking INT)
RETURNS TABLE
AS
RETURN 
(
    WITH Ranking_241 AS(
        SELECT H.*, A.DepartmentID, RANK() OVER (PARTITION BY A.DepartmentID ORDER BY A.DepartmentID, H.BusinessEntityID DESC) AS Ranking
        FROM HumanResources.Employee H 
        JOIN HumanResources.EmployeeDepartmentHistory A ON A.BusinessEntityID = H.BusinessEntityID
    )
    SELECT *
    FROM Ranking_241
    WHERE Ranking = @ranking
);
GO

SELECT * FROM Function_241(2)

-- 242. Create a function that input a number (maximum 9-digit), that returns all the employee's BusinessEntityID (H), NationalIDNumber (H), BirthDate (H) which satisfies the condition:
-- (Condition of INPUT: 1-digit: OrganizationLevel (H) = @n; 2-digit: Day in BirthDate (H) = @n; 4-digit: Year in BirthDate; 
-- More than 7-digit: Length of NationalIDNumber > @n; ELSE returns NOTHING)
GO
CREATE FUNCTION Function_242(@num INT)
RETURNS TABLE
AS
RETURN 
(
    SELECT BusinessEntityID, NationalIDNumber, BirthDate, OrganizationLevel
    FROM HumanResources.Employee
    WHERE 
        CASE
            WHEN LEN(@num) = 1 AND OrganizationLevel = @num THEN 1
            WHEN LEN(@num) = 2 AND DATEPART(DAY, BirthDate) = @num THEN 1
            WHEN LEN(@num) = 4 AND DATEPART(YEAR, BirthDate) = @num THEN 1
            WHEN LEN(@num) > 7 AND NationalIDNumber >= @num THEN 1
            ELSE 0
        END = 1
);
GO

SELECT * FROM Function_242(3)
SELECT * FROM Function_242(15)
SELECT * FROM Function_242(1985)
SELECT * FROM Function_242(958942112)
SELECT * FROM Function_242(666666)

-- 243. Create a function that input a varchar, that returns all the employee's BusinessEntityID (H), NationalIDNumber (H), BirthDate (H) which satisfies the condition
-- (Condition of INPUT: 1-digit INT: OrganizationLevel (H) = @n; 2-digit INT: Day in BirthDate (H) = @n; 4-digit INT: Year in BirthDate; 
-- More than 7-digit INT: Length of NationalIDNumber > @n; VARCHAR: JobTitle contains '@n'; ELSE returns NOTHING)
GO
CREATE FUNCTION Function_243(@varinput VARCHAR(10))
RETURNS TABLE
AS
RETURN 
(
    SELECT BusinessEntityID, NationalIDNumber, BirthDate, OrganizationLevel
    FROM HumanResources.Employee
    WHERE 
        CASE 
            WHEN LEN(@varinput) = 1 AND TRY_CAST(OrganizationLevel AS INT) = TRY_CAST(@varinput AS INT) THEN 1
            WHEN LEN(@varinput) = 2 AND DATEPART(DAY, BirthDate) = TRY_CAST(@varinput AS INT) THEN 1
            WHEN LEN(@varinput) = 4 AND DATEPART(YEAR, BirthDate) = TRY_CAST(@varinput AS INT) THEN 1
            WHEN LEN(@varinput) > 7 AND NationalIDNumber >= TRY_CAST(@varinput AS INT) THEN 1
            WHEN (JobTitle LIKE '%' + @varinput + '%') THEN 1
            ELSE 0
        END = 1
);
GO

SELECT * FROM Function_243(3)
SELECT * FROM Function_243(22)
SELECT * FROM Function_243(1972)
SELECT * FROM Function_243(777888999)
SELECT * FROM Function_243(241567)
SELECT * FROM Function_243('men')

-- 244. Create a function that input a number (less than 100), that returns the employee's table (H) that split into that exact amount of GROUP based on the descending BusinessEnityID order
GO
CREATE FUNCTION Function_244(@split INT)
RETURNS TABLE
AS
RETURN 
(
    SELECT NTILE(@split) OVER (ORDER BY BusinessEntityID) AS Group_Number, *
    FROM HumanResources.Employee
    WHERE @split < 100
);
GO

SELECT * FROM Function_244(15)

-- 245. Create a function that input 2 numbers (both less than 100), that returns all the employee's records (H) of who have the ranking number @a,
-- and the table must be split into that @b amount of GROUP based on the descending NationalIDNumber order
GO
CREATE FUNCTION Function_245(@ranking INT, @split INT)
RETURNS TABLE
AS
RETURN 
(
    WITH Split_245 AS(
        SELECT NTILE(@split) OVER (ORDER BY NationalIDNumber DESC) AS Group_Number, *
        FROM HumanResources.Employee
        WHERE @split < 100 
    ), Rank_245 AS(
    SELECT RANK() OVER (PARTITION BY Group_Number ORDER BY NationalIDNumber DESC) AS Ranking, *
    FROM Split_245
    )
    SELECT * 
    FROM Rank_245
    WHERE Ranking = @ranking
);
GO

SELECT * FROM Function_245(1, 7)

-- 246. Create a function that input 3 numbers, that returns all the employee's records (H) of who have the ranking number @a,
-- and the table must be split into that @b amount of GROUP (NationalityIDNumber < @c) based on the descending NationalityIDNumber order.
GO
CREATE FUNCTION Function_246(@ranking INT, @split INT, @c INT)
RETURNS TABLE
AS
RETURN 
(
    WITH Split_246 AS(
        SELECT NTILE(@split) OVER (ORDER BY NationalIDNumber DESC) AS Group_Number, *
        FROM HumanResources.Employee
        WHERE @split < 100 AND NationalIDNumber < @c
    ), Rank_246 AS(
    SELECT RANK() OVER (PARTITION BY Group_Number ORDER BY NationalIDNumber DESC) AS Ranking, *
    FROM Split_246
    )
    SELECT * 
    FROM Rank_246
    WHERE Ranking = @ranking
);
GO

SELECT * FROM Function_246(1, 3, 444444000)

-- 247. Create a function that input 4 numbers, that returns all the employee's records (H) of who have the ranking number @a,
-- and the table must be split into that @b amount of GROUP (NationalityIDNumber < @c) based on the descending NationalityIDNumber order.
-- @d is the length of JobTitle (H) (filter before paritioning)
GO
CREATE FUNCTION Function_247(@ranking INT, @split INT, @c INT, @lengthJob INT)
RETURNS TABLE
AS
RETURN 
(
    WITH Split_247 AS(
        SELECT NTILE(@split) OVER (ORDER BY NationalIDNumber DESC) AS Group_Number, *
        FROM HumanResources.Employee
        WHERE @split < 100 AND NationalIDNumber < @c AND LEN(JobTitle) = 28
    ), Rank_247 AS(
    SELECT RANK() OVER (PARTITION BY Group_Number ORDER BY NationalIDNumber DESC) AS Ranking, *
    FROM Split_247
    )
    SELECT * 
    FROM Rank_247
    WHERE Ranking = @ranking
);
GO

SELECT * FROM Function_247(1, 3, 444444000, 28)

-- 248. Create a function that input 2 numbers (0 < @a <= 16), that returns the total Age (2023 - BirthDate (H)) of DepartmentID GROUP @a (A),
-- and @b is the ID for the aggregate function (1: SUM, 2: MIN, 3: MAX, 4: AVG, Other: COUNT) which is used to calculate the Age
-- Must use: GROUP BY
GO
CREATE FUNCTION Function_248(@departmentID INT, @agg INT)
RETURNS TABLE
AS
RETURN 
(
    WITH Data_248 AS(
        SELECT DATEDIFF(YEAR, H.BirthDate, '2023-11-11') AS Age, A.DepartmentID
        FROM HumanResources.Employee H 
        JOIN HumanResources.EmployeeDepartmentHistory A ON A.BusinessEntityID = H.BusinessEntityID
        WHERE A.DepartmentID = @departmentID
    )
    SELECT 
        CASE 
            WHEN @agg = 1 THEN SUM(Age)
            WHEN @agg = 2 THEN MIN(Age)
            WHEN @agg = 3 THEN MAX(Age)
            WHEN @agg = 4 THEN AVG(Age)
            ELSE COUNT(Age)
        END AS Agg_Result, DepartmentID
        FROM Data_248
        GROUP BY DepartmentID
);
GO

SELECT * FROM Function_248(1, 1)
SELECT * FROM Function_248(1, 2)
SELECT * FROM Function_248(16, 4)

-- 249. Create a function that input 2 numbers , that returns the total Age (2023 - BirthDate (H)) of DepartmentID GROUP @a (A),
-- and @b is the ID for the aggregate function (1: SUM, 2: MIN, 3: MAX, 4: AVG, Other: COUNT) which is used to calculate the Length of JobTitle (H)
GO
CREATE FUNCTION Function_249(@departmentID INT, @agg INT)
RETURNS TABLE
AS
RETURN 
(
    WITH Data_249 AS(
        SELECT LEN(H.JobTitle) AS LengthJob, A.DepartmentID, H.JobTitle
        FROM HumanResources.Employee H 
        JOIN HumanResources.EmployeeDepartmentHistory A ON A.BusinessEntityID = H.BusinessEntityID
        WHERE A.DepartmentID = @departmentID
    )
    SELECT 
        CASE 
            WHEN @agg = 1 THEN SUM(LengthJob)
            WHEN @agg = 2 THEN MIN(LengthJob)
            WHEN @agg = 3 THEN MAX(LengthJob)
            WHEN @agg = 4 THEN AVG(LengthJob)
            ELSE COUNT(LengthJob)
        END AS Agg_Result, DepartmentID
        FROM Data_249
        GROUP BY DepartmentID
);
GO

SELECT * FROM Function_248(2, 4)
SELECT * FROM Function_248(10, 777)
SELECT * FROM Function_248(12, 3)

-- 250. Create a function that input 3 numbers, that returns BusinessEntityID (H), NationalIDNumber (H) and LoginID (H)(after '\'), 
-- of those with @a as DepartmentID (A), @b as PayFrequency (P)(1 or 2) and @c as VacationHours (H)(choose all records with 10 above or below @c)
-- Must use: WHERE EXISTS; Must not use: JOIN
GO
CREATE FUNCTION Function_250(@departmentID INT, @payFreq INT, @vacation INT)
RETURNS TABLE
AS
RETURN 
(
    SELECT H.BusinessEntityID, H.NationalIDNumber, SUBSTRING(H.LoginID, CHARINDEX('\', H.LoginID) + 1, LEN(H.LoginID)) AS New_LoginID
    FROM HumanResources.Employee H 
    WHERE EXISTS(
        SELECT 1 
        FROM HumanResources.EmployeeDepartmentHistory A
        WHERE EXISTS(
            SELECT * 
            FROM HumanResources.EmployeePayHistory P
            WHERE A.BusinessEntityID = H.BusinessEntityID
            AND H.BusinessEntityID = P.BusinessEntityID
            AND A.DepartmentID = @departmentID
            AND P.PayFrequency = @payFreq
            AND H.VacationHours BETWEEN (@vacation - 10) AND (@vacation + 10)
        )
    )
);
GO

SELECT * FROM Function_250(16, 2, 95)