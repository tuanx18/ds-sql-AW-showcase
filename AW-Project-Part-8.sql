-- Part 8: 17/11/2023

-- Tables used for practicing
-- List of Customers (PK: CustomerID)
SELECT * FROM Sales.Customer
-- Keyword: C

-- List of Territories (PK: TerritoryID)
SELECT * FROM Sales.SalesTerritory
-- Keyword: T

----------------------------------------------------------------
-- ADVENTURE WORK PRACTICE PROJECT
-- TASK 351 TO 400
-- KNOWLEDGE COVERED: Subqueries, Loops using WHILE, Conditions using IF, WHERE EXISTS, BIT
----------------------------------------------------------------
-- Note: Put 2 'GO' Before and After any functions & stored procedures to avoid Syntax Error.

-- 351. Create a table that contains an ID field that goes from 1 to 100
CREATE TABLE Table100ID (AutoIndex INT)

DECLARE @IncreaseNo INT;
SET @IncreaseNo = 1
WHILE @IncreaseNo <= 100
BEGIN
    INSERT INTO Table100ID VALUES (@IncreaseNo)
    SET @IncreaseNo = @IncreaseNo + 1  
END

SELECT * FROM Table100ID

-- 352. Create a table that contains an ID field that goes from 1 to 5000
CREATE TABLE Table5000ID (AutoIndex INT)

DECLARE @var352 INT;
SET @var352 = 1
WHILE @var352 <= 5000
BEGIN
    INSERT INTO Table5000ID VALUES (@var352)
    SET @var352 = @var352 + 1  
END

SELECT * FROM Table5000ID

-- 353. Create a table that contains an ID field that goes from 1 to 5000, but without numbers from 1600 to 2200
CREATE TABLE Table5000IDExclusive (AutoIndex INT)

DECLARE @var353 INT;
SET @var353 = 1
WHILE @var353 < 1600
BEGIN
    INSERT INTO Table5000IDExclusive VALUES (@var353)
    SET @var353 = @var353 + 1  
END
DECLARE @var353b INT;
SET @var353b = 2201
WHILE @var353b < 5000
BEGIN
    INSERT INTO Table5000IDExclusive VALUES (@var353b)
    SET @var353b = @var353b + 1  
END

SELECT * FROM Table5000IDExclusive

-- 354. Create a table that contains an ID field that goes from 1 to 4999, but with only odd number
CREATE TABLE Table4999Odd (AutoID INT)

DECLARE @var354 INT
SET @var354 = 1
WHILE @var354 < 4999
BEGIN
    IF @var354 % 2 = 1
    BEGIN 
        INSERT INTO Table4999Odd VALUES (@var354)
    END
    SET @var354 = @var354 + 1
END

SELECT * FROM Table4999Odd

-- 355. Create a table that contains an ID field that goes from 0 to 5000, but with only even number
CREATE TABLE Table5000Even (AutoID INT)

DECLARE @var355 INT
SET @var355 = 0
WHILE @var355 < 5000
BEGIN
    IF @var355 % 2 = 0
    BEGIN 
        INSERT INTO Table5000Even VALUES (@var355)
    END
    SET @var355 = @var355 + 1
END

SELECT * FROM Table5000Even

-- 356.  Create a table that contains an ID field that goes from 1 to 5000, but with only number that is divisible by 4
CREATE TABLE Division4 (AutoID INT)

DECLARE @var356 INT
SET @var356 = 1
WHILE @var356 <= 5000
BEGIN 
    IF @var356 % 4 = 0
    BEGIN
        INSERT INTO Division4 VALUES (@var356)
    END
    SET @var356 = @var356 + 1
END

SELECT * FROM Division4

-- 357.  Create a table that contains an ID field that goes from 1 to 5000, but with only number that is not divisible by 6
CREATE TABLE NotDivisible6 (AutoID INT)

DECLARE @var407 INT
SET @var407 = 1
WHILE @var407 < 5000
BEGIN
    IF @var407 % 6 <> 0
    BEGIN
        INSERT INTO NotDivisible6 VALUES (@var407)    
    END
    SET @var407 = @var407 + 1
END

SELECT * FROM NotDivisible6

-- 358. Create a table that contains an ID field that goes from 1 to 1000, and another field that is the doubled value of the ID
CREATE TABLE Table1000Double (AutoID INT, Doubled INT)

DECLARE @var358 INT
SET @var358 = 1
WHILE @var358 < 1000
BEGIN
    INSERT INTO Table1000Double VALUES (@var358, @var358 * 2)
    SET @var358 = @var358 + 1
END

SELECT * FROM Table1000Double

-- 359. Create a table that contains an ID field that goes from 1 to 2000, and another field that is the ID to the power of 2
CREATE TABLE Table2000Squared (AutoID INT, Squared INT)

DECLARE @var359 INT
SET @var359 = 1
WHILE @var359 < 2000
BEGIN
    INSERT INTO Table2000Squared VALUES (@var359, @var359 * @var359)
    SET @var359 = @var359 + 1
END

SELECT * FROM Table2000Squared

-- 360. Create a table that contains an ID field that goes from 1 to 2000, and 2 other fields: tripled value of ID, half of the ID
CREATE TABLE Table2000TripHalf (AutoID FLOAT, Tripled FLOAT, Half FLOAT)

DECLARE @var360 FLOAT
SET @var360 = 1
WHILE @var360 < 2000
BEGIN
    INSERT INTO Table2000TripHalf VALUES (@var360, @var360 * 3, @var360 / 2)
    SET @var360 = @var360 + 1
END

SELECT * FROM Table2000TripHalf

-- 361. Create a table that contains an ID field that goes from 1 to 2000, and another field that is the closest number to the ID that is divisible by 3
CREATE TABLE Table2000ClostestD3 (AutoID INT, ClosestD3 INT)

DECLARE @var361 INT
SET @var361 = 1
WHILE @var361 < 2000
BEGIN
    IF @var361 % 3 = 1
    BEGIN
        INSERT INTO Table2000ClostestD3 VALUES (@var361, @var361 - 1)
    END

    IF @var361 % 3 = 2
    BEGIN
        INSERT INTO Table2000ClostestD3 VALUES (@var361, @var361 + 1)
    END

        IF @var361 % 3 = 0
    BEGIN
        INSERT INTO Table2000ClostestD3 VALUES (@var361, @var361)
    END
    
    SET @var361 = @var361 + 1
END

SELECT * FROM Table2000ClostestD3

-- 362. Create a table that contains an ID field that goes from 1 to 2000, and another field that is the sum of all IDs (above that ID) combined
CREATE TABLE Table2000SumAbove (AutoID INT, SumAbove INT)
INSERT INTO Table2000SumAbove VALUES (0, 0)

DECLARE @var362 INT
SET @var362 = 1
DECLARE @sumabove INT
WHILE @var362 < 2000
BEGIN
    SET @sumabove = (SELECT SUM(AutoID) FROM Table2000SumAbove) 
    INSERT INTO Table2000SumAbove VALUES (@var362, @sumabove)
    SET @var362 = @var362 + 1
END

SELECT * FROM Table2000SumAbove

CREATE TABLE Table2000AVGAbove (AutoID FLOAT, AvgAbove FLOAT)
INSERT INTO Table2000AVGAbove VALUES (0, 0)

DECLARE @var363 FLOAT
SET @var363 = 1
DECLARE @avgabove FLOAT
WHILE @var363 < 2000
BEGIN
    SET @avgabove = (SELECT AVG(AutoID) FROM Table2000AVGAbove) 
    INSERT INTO Table2000AVGAbove VALUES (@var363, @avgabove)
    SET @var363 = @var363 + 1
END

SELECT * FROM Table2000AVGAbove

-- 364. Create a table that contains an ID field that goes from 1 to 300, but with only number divisible by 7, then find all information of customer (C) who has CustomerID (C) match the new table
CREATE TABLE Table300D7 (AutoID INT)

DECLARE @var364 INT
SET @var364 = 1
WHILE @var364 < 300
BEGIN
    IF @var364 % 7 = 0
    BEGIN
    INSERT INTO Table300D7 VALUES (@var364)
    END
    SET @var364 = @var364 + 1
END

SELECT * 
FROM Sales.Customer C 
JOIN Table300D7 T364 ON C.CustomerID = T364.AutoID

-- 365. Create a table that contains an ID field that goes from 1 to 770, but with only number not divisible by both 3 and 5, 
-- then find all information of customer (C) who has CustomerID (C) match the new table
CREATE TABLE Table770N35 (AutoID INT)

DECLARE @var365 INT
SET @var365 = 1
WHILE @var365 < 770
BEGIN
    IF @var365 % 3 = 0 OR @var365 % 5 = 0
    BEGIN
        INSERT INTO Table770N35 VALUES (@var365)
    END
    SET @var365 = @var365 + 1
END

SELECT * 
FROM Sales.Customer C 
JOIN Table770N35 T365 ON C.CustomerID = T365.AutoID

-- 366. Create a table that contains an ID field that goes from 1 to 585, but with only number not divisible by either 11 or 13, 
-- then find all information of customer (C) who has CustomerID (C) match the new table
CREATE TABLE Table366 (AutoID INT)

DECLARE @var366 INT
SET @var366 = 1
WHILE @var366 < 585
BEGIN
    IF @var366 % 11 <> 0 AND @var366 % 13 <>  0
    BEGIN
        INSERT INTO Table366 VALUES (@var366)
    END
    SET @var366 = @var366 + 1
END

SELECT * 
FROM Sales.Customer C 
JOIN Table366 T366 ON C.CustomerID = T366.AutoID

-- 367. Create a table that contains an ID field that goes from 1 to 1100, but with only numbers that are the squared result of any integers (such as 4, 9, 16, 25), 
-- then find all information of customer (C) who has CustomerID (C) match the new table
DROP TABLE Table367
CREATE TABLE Table367 (AutoID FLOAT)

DECLARE @var367 FLOAT
SET @var367 = 1
WHILE @var367 * @var367 < 585
BEGIN
    INSERT INTO Table367 VALUES (@var367 * @var367)
    SET @var367 = @var367 + 1
END

SELECT * FROM Table367

SELECT * 
FROM Sales.Customer C 
JOIN Table367 T367 ON C.CustomerID = T367.AutoID

-- 368. Create a table that contains an ID field that goes from 1 to 690, but with only numbers that are the squared result of any integers (such as 4, 9, 16, 25), 
-- then find all information of customer (C) who has both CustomerID (C) and TerritoryID (C) match the new table
CREATE TABLE Table368 (AutoID FLOAT)

DECLARE @var368 FLOAT
SET @var368 = 1
WHILE @var368 * @var368 < 690
BEGIN
    INSERT INTO Table368 VALUES (@var368 * @var368)
    SET @var368 = @var368 + 1
END

SELECT * 
FROM Sales.Customer C 
WHERE TerritoryID IN (SELECT AutoID FROM Table368)
AND CustomerID IN (SELECT AutoID FROM Table368)

-- 369. Create a table that contains an ID field that goes from 1 to 4000, but with only numbers that are the squared result of any integers (such as 4, 9, 16, 25), 
-- then find all information of customer (C) who has either CustomerID (C) or TerritoryID (C) match the new table
CREATE TABLE Table369 (AutoID FLOAT)

DECLARE @var369 FLOAT
SET @var369 = 1
WHILE @var369 * @var369 < 4000
BEGIN
    INSERT INTO Table369 VALUES (@var369 * @var369)
    SET @var369 = @var369 + 1
END

SELECT * 
FROM Sales.Customer C 
JOIN Table369 T369 ON C.CustomerID = T369.AutoID
UNION
SELECT * 
FROM Sales.Customer C 
JOIN Table369 T369 ON C.TerritoryID = T369.AutoID

-- 370. Create a table that contains an ID field that goes from 1 to 15000, but with only numbers that are the power of 3 result of any integers (such as 8, 27, 64, 125), 
-- then find all information of customer (C) who has either CustomerID (C) or TerritoryID (C) match the new table
CREATE TABLE Table370 (AutoID INT)

DECLARE @var370 INT
SET @var370 = 1
WHILE POWER(@var370, 3) < 15000
BEGIN
    INSERT INTO Table370 VALUES (POWER(@var370, 3))
    SET @var370 = @var370 + 1
END

SELECT *
FROM Sales.Customer
WHERE CustomerID IN (SELECT AutoID FROM Table370)
OR TerritoryID IN (SELECT AutoID FROM Table370)

-- 371. Create a table that contains an ID field that goes from 1 to 12500, but with only numbers that are the power of 3 result of any integers (such as 8, 27, 64, 125), 
-- then find all information of customer (C) who has either CustomerID (C) or TerritoryID (C) and StoreID (C) match the new table
CREATE TABLE Table371 (AutoID INT)

DECLARE @var371 INT
SET @var371 = 1
WHILE POWER(@var371, 3) < 12500
BEGIN
    INSERT INTO Table371 VALUES (POWER(@var371, 3))
    SET @var371 = @var371 + 1
END

SELECT * 
FROM Sales.Customer
WHERE CustomerID IN (SELECT AutoID FROM Table371)
OR TerritoryID IN (SELECT AutoID FROM Table371)
OR StoreID IN (SELECT AutoID FROM Table371)

-- 372. Create a table that contains an ID field that goes from 1 to 36000, but with only numbers that are the power of 3 result of any integers (such as 8, 27, 64, 125), 
-- then find all information of customer (C) who has all CustomerID (C), TerritoryID (C) and StoreID (C) NOT match the new table
CREATE TABLE Table372 (AutoID INT)

DECLARE @var372 INT
SET @var372 = 1
WHILE POWER(@var372, 3) < 36000
BEGIN
    INSERT INTO Table372 VALUES (POWER(@var372, 3))
    SET @var372 = @var372 + 1
END

SELECT * 
FROM Sales.Customer
WHERE NOT CustomerID IN (SELECT AutoID FROM Table372)
AND NOT TerritoryID IN (SELECT AutoID FROM Table372)
AND NOT StoreID IN (SELECT AutoID FROM Table372)

-- 373. Create a table that contains an ID field that goes from 1 to 11140, but with only numbers that are the squared result OR the power of 3 result of any integers (such as 4, 8, 9, 16, 25, 27),
-- then find all information of customer (C) who has either CustomerID (C) or TerritoryID (C) and StoreID (C) match the new table 
CREATE TABLE Table373 (AutoID INT)

DECLARE @var373a INT
SET @var373a = 1
WHILE POWER(@var373a, 3) < 11140
BEGIN
    INSERT INTO Table373 VALUES (POWER(@var373a, 3))
    SET @var373a = @var373a + 1
END

DECLARE @var373b INT
SET @var373b = 1
WHILE POWER(@var373b, 2) < 11140
BEGIN
    INSERT INTO Table373 VALUES (POWER(@var373b, 2))
    SET @var373b = @var373b + 1
END

SELECT * 
FROM Sales.Customer
WHERE CustomerID IN (SELECT AutoID FROM Table373)
OR TerritoryID IN (SELECT AutoID FROM Table373)
OR StoreID IN (SELECT AutoID FROM Table373)

-- 374. Create a table that contains an ID field that goes from 1 to 2480, but with only the numbers that is not divisible by any of the numbers 3, 5, 7, 11, 13,
-- then split the records into 12 parts order by the DESCENDING index, then find all information of customer (C) who has CustomerID (C) match the new table and find which part they are in
CREATE TABLE Table374 (AutoID INT)

DECLARE @var374 INT
SET @var374 = 1
WHILE @var374 < 2480
BEGIN
    IF @var374 % 3 <> 0 AND @var374 % 5 <> 0 AND @var374 % 7 <> 0 AND @var374 % 11 <> 0 AND @var374 % 13 <> 0
    BEGIN
        INSERT INTO Table374 VALUES (@var374)
    END
    SET @var374 = @var374 + 1
END

SELECT NTILE(12) OVER (ORDER BY CustomerID DESC) AS Group_Number, * 
FROM Sales.Customer
WHERE CustomerID IN (SELECT AutoID FROM Table374)

-- 375. Create a table that contains an ID field that goes from 1 to 1800, but with only the numbers that is not divisible by any of the numbers 3, 5, 17, 20,
-- then split the records into 7 parts order by the index, then find all information of customer (C) who has CustomerID (C) match the new table and find which part they are in,
-- group all the Customer records based on their part then find the SUM of the StoreID (C)
CREATE TABLE Table375 (AutoID INT)

DECLARE @var375 INT
SET @var375 = 1
WHILE @var375 < 1800
BEGIN
    IF @var375 % 3 <> 0 AND @var375 % 5 <> 0 AND @var375 % 17 <> 0 AND @var375 % 20 <> 0
    BEGIN
        INSERT INTO Table375 VALUES (@var375)
    END
    SET @var375 = @var375 + 1
END

WITH Task_375_Grouped AS(
    SELECT NTILE(7) OVER (ORDER BY CustomerID) AS Group_Number, * 
    FROM Sales.Customer
    WHERE CustomerID IN (SELECT AutoID FROM Table375)
)
SELECT SUM(StoreID) AS SumStoreID, Group_Number
FROM Task_375_Grouped
GROUP BY Group_Number

-- 376. Create a table that contains an ID field that goes from 1 to 2400, but with only the numbers that is divisible by any of the numbers 2, 5, 9, 29, 59,
-- then split the records into 3 parts order by the index, then find all information of customer (C) who has CustomerID (C) match the new table and find which part they are in,
-- group all the Customer records based on their part then find the total times of the letter 'f' appears on rowguid (C)
CREATE TABLE Table376 (AutoID INT)

DECLARE @var376 INT
SET @var376 = 1
WHILE @var376 < 2400
BEGIN
    IF @var376 % 2 = 0 OR @var376 % 5 = 0 OR @var376 % 9 = 0 OR @var376 % 29 = 0 OR @var376 % 59 = 0
    BEGIN
        INSERT INTO Table376 VALUES (@var376)
    END
    SET @var376 = @var376 + 1
END

WITH Task_376_Grouped AS(
    SELECT NTILE(3) OVER (ORDER BY CustomerID) AS Group_Number, LEN(rowguid) - LEN(REPLACE(rowguid, 'f', '')) AS Counter_F, *
    FROM Sales.Customer
    WHERE CustomerID IN (SELECT AutoID FROM Table376)
)
SELECT SUM(Counter_F) AS All_F, Group_Number
FROM Task_376_Grouped
GROUP BY Group_Number

-- 377. Create a table that contains an ID field that goes from 1 to 1420, but with only the numbers that contains a number 3 on it,
-- then split the records into 5 RANDOM parts with Shuffled records, then find all information of customer (C) who has CustomerID (C) match the new table and find which part they are in,
-- group all the Customer records based on their part then find the total times of the letter 'b' and 'd' appear on rowguid (C)
CREATE TABLE Table377 (AutoID INT)

DECLARE @var377 INT
SET @var377 = 1
WHILE @var377 < 1420
BEGIN
    IF CAST(@var377 AS varchar) LIKE '%3%'
    BEGIN
        INSERT INTO Table377 VALUES (@var377)
    END
    SET @var377 = @var377 + 1
END

WITH Task_377_Grouped AS(
    SELECT NTILE(5) OVER (ORDER BY NEWID()) AS Group_Number, LEN(rowguid) - LEN(REPLACE(REPLACE(rowguid, 'b', ''), 'd', '')) AS Counter_BD, * 
    FROM Sales.Customer
    WHERE CustomerID IN (SELECT AutoID FROM Table377)
)
SELECT SUM(Counter_BD) AS Total_BD, Group_Number
FROM Task_377_Grouped
GROUP BY Group_Number


-- 378. Create a table that contains an ID field that goes from 2 to 500 (only even numbers), 
-- then build a function that get the result of 750% of the value, then minus 5, apply the function for the second field of the table based on the ID
CREATE TABLE Table378 (AutoID FLOAT)

DECLARE @var378 FLOAT
SET @var378 = 2
WHILE @var378 < 500
BEGIN
    INSERT INTO Table378 VALUES (@var378)
    SET @var378 = @var378 + 2
END

GO
CREATE FUNCTION Function378 (@num FLOAT)
RETURNS FLOAT
AS
BEGIN
    RETURN @num * 7.5 - 5
END
GO

SELECT *, dbo.Function378(AutoID) AS NewID
FROM Table378

-- 379. Create a table that contains an ID field that goes from 1 to 6000 (only numbers divisible by 15 or 25), 
-- then find all information of customer (C) who has all CustomerID (C), TerritoryID (C) and StoreID (C) NOT match the new table,
-- build a function that get the result of the multiplication of the 3 input numbers divide by 5, apply the function with CustomerID, StoreID and TerritoryID (C)
CREATE TABLE Table379 (AutoID INT)

DECLARE @var379 INT
SET @var379 = 1
WHILE @var379 < 6000
BEGIN
    IF @var379 % 15 = 0 OR @var379 % 25 = 0
    BEGIN
        INSERT INTO Table379 VALUES (@var379)
    END
    SET @var379 = @var379 + 1
END

GO
CREATE FUNCTION Function379 (@num1 FLOAT, @num2 FLOAT, @num3 FLOAT)
RETURNS FLOAT
AS
BEGIN
    RETURN ROUND((@num1 * @num2 * @num3 / 5), 1)
END
GO

SELECT dbo.Function379(CustomerID, TerritoryID, StoreID) AS FunctionResult, *
FROM Sales.Customer
WHERE CustomerID NOT IN (SELECT AutoID FROM Table379)
AND TerritoryID NOT IN (SELECT AutoID FROM Table379)
AND StoreID NOT IN (SELECT AutoID FROM Table379)

-- 380. Create a table that contains an ID field that goes from 600 to 1000 (only numbers that have 5 or 8 as the rightest digit), 
-- then find all information of customer who has StoreID (C) matches the new table,
-- build a function that get the result of the square root of the multiplication of the 2 inputs (round 2 decimals), apply the function with CustomerID and TerritoryID (C)
CREATE TABLE Table380 (AutoID INT)

DECLARE @var380 INT
SET @var380 = 600
WHILE @var380 < 1000
BEGIN
    IF RIGHT(@var380, 1) = 5 OR RIGHT(@var380, 1) = 8
    BEGIN
        INSERT INTO Table380 VALUES (@var380)
    END
    SET @var380 = @var380 + 1
END

GO
CREATE FUNCTION Function380 (@num1 FLOAT, @num2 FLOAT)
RETURNS FLOAT
AS
BEGIN
    RETURN ROUND(SQRT(@num1 * @num2), 2)
END
GO

SELECT dbo.Function380(CustomerID, TerritoryID) AS FunctionResult, *
FROM Sales.Customer
WHERE StoreID IN (SELECT AutoID FROM Table380)

-- 381. Create a table that contains an ID field that goes from 300 to 2000 (only numbers with 2-digit number on the rightest divisible by 3), 
-- then find all information of customer (C) who has either CustomerID or StoreID (C) matches the new table,
-- build a function that get the result of the square root of the multiplication of the 2 inputs divides by the number of digits of the result, 
-- apply the function with CustomerID and TerritoryID (C)
CREATE TABLE Table381 (AutoID INT)

DECLARE @var381 INT
SET @var381 = 300
WHILE @var381 < 2000
BEGIN
    IF RIGHT(@var381, 2) % 3 = 0 
    BEGIN
        INSERT INTO Table381 VALUES (@var381)
    END
    SET @var381 = @var381 + 1
END

GO
CREATE FUNCTION Function381 (@num1 FLOAT, @num2 FLOAT)
RETURNS FLOAT
AS
BEGIN
    DECLARE @result FLOAT
    SET @result = SQRT(@num1 * @num2) / CAST(SQRT(@num1 * @num2) AS INT)

    RETURN @result
END
GO

SELECT ROUND(dbo.Function381(CustomerID, TerritoryID), 3) AS FunctionResult, *
FROM Sales.Customer
WHERE CustomerID IN (SELECT AutoID FROM Table381)
OR StoreID IN (SELECT AutoID FROM Table381)

-- 382. Create a table that contains an ID field that goes from 100 to 999 (only numbers with sum of digits greater than 10),
-- then find all information of customer (C) who has both CustomerID (C) and 3 left-digits of SalesYTD (T) match with the table
CREATE TABLE Table382 (AutoID INT)

DECLARE @var382 INT
SET @var382 = 100
WHILE @var382 < 999
BEGIN
    IF ((@var382 / 100) + ((@var382 / 10) % 10) + (@var382 % 10)) > 10
    BEGIN
        INSERT INTO Table382 VALUES (@var382)
    END
    SET @var382 = @var382 + 1
END

SELECT C.*, T.SalesYTD, LEFT(CAST(T.SalesYTD AS INT), 3) AS Left3
FROM Sales.Customer C 
JOIN Sales.SalesTerritory T ON T.TerritoryID = C.TerritoryID
WHERE C.CustomerID IN (SELECT AutoID FROM Table382)
AND LEFT(CAST(T.SalesYTD AS INT), 3) IN (SELECT AutoID FROM Table382)

-- 383. Create a table that contains an ID field that goes from 100 to 999 (only numbers with sum of digits is even),
-- then find all information of customer (C) who has both CustomerID (C) and 3 left-digits of SaleLastYear (T) match with the table
CREATE TABLE Table383 (AutoID INT)

DECLARE @var383 INT
SET @var383 = 100
WHILE @var383 < 999
BEGIN
    IF ((@var383 / 100) + ((@var383 / 10) % 10) + (@var383 % 10)) % 2 = 0
    BEGIN
        INSERT INTO Table383 VALUES (@var383)
    END
    SET @var383 = @var383 + 1
END

SELECT C.*, T.SalesLastYear, LEFT(CAST(T.SalesLastYear AS INT), 3) AS Left3
FROM Sales.Customer C 
JOIN Sales.SalesTerritory T ON T.TerritoryID = C.TerritoryID
WHERE C.CustomerID IN (SELECT AutoID FROM Table383)
AND LEFT(CAST(T.SalesLastYear AS INT), 3) IN (SELECT AutoID FROM Table383)

-- 384. Create a table that contains an ID field that goes from 100 to 999 (only numbers with sum of digits is NOT even),
-- then find all information of customer (C) who has all CustomerID (C), 3 left-digits of SaleLastYear and 3 left-digits of SalesYTD (T) match with the table
CREATE TABLE Table384 (AutoID INT)

DECLARE @var384 INT
SET @var384 = 100
WHILE @var384 < 999
BEGIN
    IF ((@var384 / 100) + ((@var384 / 10) % 10) + (@var384 % 10)) % 2 <> 0
    BEGIN
        INSERT INTO Table384 VALUES (@var384)
    END
    SET @var384 = @var384 + 1
END

SELECT C.*, T.SalesLastYear, LEFT(CAST(T.SalesLastYear AS INT), 3) AS Left3A, T.SalesYTD, LEFT(CAST(T.SalesYTD AS INT), 3) AS Left3B
FROM Sales.Customer C 
JOIN Sales.SalesTerritory T ON T.TerritoryID = C.TerritoryID
WHERE C.CustomerID IN (SELECT AutoID FROM Table384)
AND LEFT(CAST(T.SalesLastYear AS INT), 3) IN (SELECT AutoID FROM Table384)
AND LEFT(CAST(T.SalesYTD AS INT), 3) IN (SELECT AutoID FROM Table384)

-- 385. Create a table that contains an ID field that goes from 100 to 999 (only numbers with average of digits is in range 7 to 7.5),
-- then find all information of customer (C) who has either CustomerID (C) or 3 left-digits of SaleLastYear or 3 right-digits of ROUNDED SalesYTD (T) match with the table
CREATE TABLE Table385 (AutoID INT)

DECLARE @var385 INT
SET @var385 = 100
WHILE @var385 < 999
BEGIN
    IF (CAST(((@var385 / 100) + ((@var385 / 10) % 10) + (@var385 % 10)) AS float) / 3) BETWEEN 7 AND 7.5
    BEGIN
        INSERT INTO Table385 VALUES (@var385)
    END
    SET @var385 = @var385 + 1
END

SELECT C.*, T.SalesLastYear, LEFT(CAST(T.SalesLastYear AS INT), 3) AS Left3, T.SalesYTD, RIGHT(CAST(T.SalesYTD AS INT), 3) AS Right3
FROM Sales.Customer C 
JOIN Sales.SalesTerritory T ON T.TerritoryID = C.TerritoryID
WHERE C.CustomerID IN (SELECT AutoID FROM Table385)
OR LEFT(CAST(T.SalesLastYear AS INT), 3) IN (SELECT AutoID FROM Table385)
OR RIGHT(CAST(T.SalesYTD AS INT), 3) IN (SELECT AutoID FROM Table385)

-- 386. Create a table that contains an ID field with first 500 numbers that is either divisible by 6 or divisible by 7 or both
CREATE TABLE Table386 (AutoID INT)

DECLARE @var386 INT
SET @var386 = 6
DECLARE @varcount386 INT
SET @varcount386 = 0
WHILE @varcount386 < 500
BEGIN
    IF @var386 % 6 = 0 OR @var386 % 7 = 0
    BEGIN
        INSERT INTO Table386 VALUES (@var386)
        SET @varcount386 = @varcount386 + 1
    END
    SET @var386 = @var386 + 1
END 

SELECT * FROM Table386

-- 387. Create a table that contains an ID field with first 500 numbers that is either not divisible by both 3 and 5,
-- then find all information of customer (C) who has either CustomerID or TerritoryID (C) matches the new table
CREATE TABLE Table387 (AutoID INT)

DECLARE @var387 INT
SET @var387 = 6
DECLARE @varcount387 INT
SET @varcount387 = 0
WHILE @varcount387 < 500
BEGIN
    IF @var387 % 3 <> 0 AND @var387 % 5 <> 0
    BEGIN
        INSERT INTO Table387 VALUES (@var387)
        SET @varcount387 = @varcount387 + 1
    END
    SET @var387 = @var387 + 1
END 

SELECT * FROM Table387

-- 388. Create a table that contains an ID field with first 10 Prime numbers (2, 3, 5, ...)
DROP FUNCTION PrimeNumber
GO
CREATE FUNCTION PrimeNumber (@num INT)
RETURNS BIT
BEGIN
    DECLARE @boolean BIT
    DECLARE @div INT
    SET @div = 0

    DECLARE @begin INT
    SET @begin = 1
    WHILE @begin < @num
    BEGIN
        IF (@num % @begin) = 0
        BEGIN
            SET @div = @div + 1
        END
        SET @begin = @begin + 1
    END
    SET @boolean = CASE 
        WHEN @div > 1 THEN 0
        ELSE 1
    END
    RETURN @boolean
END
GO

CREATE TABLE Table388 (AutoID INT)

DECLARE @varcount388 INT
SET @varcount388 = 0
DECLARE @var388 INT
SET @var388 = 2
WHILE @varcount388 < 10
BEGIN
    IF dbo.PrimeNumber(@var388) = 1
    BEGIN
        INSERT INTO Table388 VALUES (@var388)
        SET @varcount388 = @varcount388 + 1
    END
    SET @var388 = @var388 + 1
END

SELECT * FROM Table388

-- 389. Create a table that contains an ID field with first 240 Prime numbers (2, 3, 5, ...), which do not have '1' as the rightest digit
CREATE TABLE Table389 (AutoID INT) 

DECLARE @varcount389 INT
SET @varcount389 = 0
DECLARE @var389 INT
SET @var389 = 2
WHILE @varcount389 < 240
BEGIN
    IF dbo.PrimeNumber(@var389) = 1 AND RIGHT(@var389, 1) <> 1
    BEGIN
        INSERT INTO Table389 VALUES (@var389)
        SET @varcount389 = @varcount389 + 1
    END
    SET @var389 = @var389 + 1
END

SELECT * FROM Table389

-- 390. Create a table that contains an ID field with first 329 Prime numbers (2, 3, 5, ...), which do not have '7' as the rightest digit and '3'  the leftest digit
CREATE TABLE Table390 (AutoID INT) 

DECLARE @varcount390 INT
SET @varcount390 = 0
DECLARE @var390 INT
SET @var390 = 2
WHILE @varcount390 < 329
BEGIN
    IF dbo.PrimeNumber(@var390) = 1 AND RIGHT(@var390, 1) <> 7 AND LEFT(@var390, 1) <> 3
    BEGIN
        INSERT INTO Table390 VALUES (@var390)
        SET @varcount390 = @varcount390 + 1
    END
    SET @var390 = @var390 + 1
END

SELECT * FROM Table390

-- 391. Create a table that contains an ID field with first all Prime numbers (2, 3, 5, ...) and have 2 digits 
CREATE TABLE Table391 (AutoID INT) 

DECLARE @varcount391 INT
SET @varcount391 = 0
DECLARE @var391 INT
SET @var391 = 2
WHILE @var391 < 100
BEGIN
    IF dbo.PrimeNumber(@var391) = 1 
    BEGIN
        INSERT INTO Table391 VALUES (@var391)
        SET @varcount391 = @varcount391 + 1
    END
    SET @var391 = @var391 + 1
END

SELECT * FROM Table391

-- 392. Create a table that contains an ID field with first all Prime numbers (2, 3, 5, ...) and have 3 digits,
-- then find all information of customer (C) who has CustomerID (C) matches with the table
CREATE TABLE Table392 (AutoID INT) 

DECLARE @varcount392 INT
SET @varcount392 = 0
DECLARE @var392 INT
SET @var392 = 100
WHILE LEN(@var392) = 3
BEGIN
    IF dbo.PrimeNumber(@var392) = 1
    BEGIN
        INSERT INTO Table392 VALUES (@var392)
        SET @varcount392 = @varcount392 + 1
    END
    SET @var392 = @var392 + 1
END

SELECT * 
FROM Sales.Customer
WHERE CustomerID IN (SELECT AutoID FROM Table392)

-- 393. Create a table that contains an ID field with first all Prime numbers (2, 3, 5, ...) and have 3 or 4 digits,
-- then find all information of customer (C) who has the result of (5 x CustomerID (C) - 1) or result of (3 x CustomerID (C) - 2) match with the table
CREATE TABLE Table393 (AutoID INT) 

DECLARE @varcount393 INT
SET @varcount393 = 0
DECLARE @var393 INT
SET @var393 = 100
WHILE LEN(@var393) = 3 OR LEN(@var393) = 4
BEGIN
    IF dbo.PrimeNumber(@var393) = 1
    BEGIN
        INSERT INTO Table393 VALUES (@var393)
        SET @varcount393 = @varcount393 + 1
    END
    SET @var393 = @var393 + 1
END

SELECT * 
FROM Sales.Customer
WHERE (CustomerID * 5 - 1) IN (SELECT AutoID FROM Table393)
OR (CustomerID * 3 - 2) IN (SELECT AutoID FROM Table393)

-- 394. Create a dynamic SQL that create a new table with @n number of records (as Index from 1, 2, 3...)
DECLARE @input394 VARCHAR(100)
SET @input394 = '1818'
DECLARE @sql_394 VARCHAR(1000)
SET @sql_394 = 'CREATE TABLE Table394 (AutoID INT)
DECLARE @var394 INT
SET @var394 = 1
WHILE @var394 < ' + @input394 + ' 
BEGIN
    INSERT INTO Table394 VALUES (@var394)
    SET @var394 = @var394 + 1
END'

PRINT(@sql_394)
EXEC(@sql_394)

SELECT * FROM Table394

-- 395. Create a dynamic SQL that create a new table with @n number of records that are odd (as Index from 1, 3, 5...)
DECLARE @input395 VARCHAR(100)
SET @input395 = '1818'
DECLARE @sql_395 VARCHAR(1000)
SET @sql_395 = 'CREATE TABLE Table395 (AutoID INT)
DECLARE @var395 INT
SET @var395 = 1
WHILE @var395 < ' + @input395 + ' 
BEGIN
    INSERT INTO Table395 VALUES (@var395)
    SET @var395 = @var395 + 2
END'

PRINT(@sql_395)
EXEC(@sql_395)

SELECT * FROM Table395

-- 396. Create a dynamic SQL that create a new table with @n number of records that are divisible by 3 (as Index from 3, 6, 9...)
DECLARE @input396 VARCHAR(100)
SET @input396 = '100000'
DECLARE @sql_396 VARCHAR(1000)
SET @sql_396 = 'CREATE TABLE Table396 (AutoID INT)
DECLARE @var396 INT
SET @var396 = 3
WHILE @var396 < ' + @input396 + ' 
BEGIN
    INSERT INTO Table396 VALUES (@var396)
    SET @var396 = @var396 + 3
END'

PRINT(@sql_396)
EXEC(@sql_396)

SELECT * FROM Table396

-- 397. Create a table that contains an ID field with first 300 odd numbers with 4 digits and not divisible by 7, 
-- then find all information of customer (C) who has CustomerID x 9 (C) matches with the table using WHERE EXISTS command
CREATE TABLE Table397 (AutoID INT)

DECLARE @var397 INT
SET @var397 = 1000
DECLARE @varcount398 INT
SET @varcount398 = 0
WHILE @varcount398 < 300 AND @var397 < 10000
BEGIN
    IF (@var397 % 2 = 1) AND (@var397 % 7 <> 0)
    BEGIN
        INSERT INTO Table397 VALUES (@var397)
        SET @varcount398 = @varcount398 + 1
    END
    SET @var397 = @var397 + 1
END 

SELECT * 
FROM Sales.Customer C
WHERE EXISTS (
    SELECT 1
    FROM Table397 T397 
    WHERE C.CustomerID * 9 = T397.AutoID
)

-- 398. Create a table that contains an ID field with first 200 even numbers with 3 digits, not divisible by 12 and is not the squared result of any integer, 
-- then find all information of customer (C) who has CustomerID (C) matches with the table using WHERE EXISTS command
CREATE TABLE Table398 (AutoID INT)

DECLARE @var398 INT
SET @var398 = 100
DECLARE @varcount398 INT
SET @varcount398 = 0
WHILE @varcount398 < 200 AND @var398 < 1000
BEGIN
    IF (@var398 % 2 = 0) AND  (@var398 % 12 <> 0) AND (SQRT(@var398) * SQRT(@var398)) <> @var398
    BEGIN
        INSERT INTO Table398 VALUES (@var398)
        SET @varcount398 = @varcount398 + 1
    END
    SET @var398 = @var398 + 1
END 

SELECT * 
FROM Sales.Customer C
WHERE EXISTS (
    SELECT 1
    FROM Table398 T398 
    WHERE C.CustomerID = T398.AutoID
)

-- 399. Create a table that contains an ID field with first 800 even numbers with 3 or 4 digits, not divisible by 9, is not the squared result of of any integers, 
-- then find all information of customer (C) who has CustomerID (C) matches with the table using WHERE EXISTS command
CREATE TABLE Table399 (AutoID INT)

DECLARE @var399 INT
SET @var399 = 100
DECLARE @varcount399 INT
SET @varcount399 = 0
WHILE @varcount399 < 800 AND @var399 < 10000
BEGIN
    IF (@var399 % 2 = 0) AND  (@var399 % 9 <> 0) AND ((SQRT(@var399) * SQRT(@var399)) <> @var399) 
    BEGIN
        INSERT INTO Table399 VALUES (@var399)
        SET @varcount399 = @varcount399 + 1
    END
    SET @var399 = @var399 + 1
END 

SELECT * 
FROM Sales.Customer C
WHERE EXISTS (
    SELECT 1
    FROM Table399 T399
    WHERE C.CustomerID = T399.AutoID
)

-- 400. Create a table that contains an ID field with first 900 even numbers with 2 to 4 digits, not divisible by 7, is not the squared result OR power of 3 result of any integer, 
-- then find all information of customer (C) who has CustomerID (C) or the leftest 4-digit of SalesLastYear (T) matches with the table using WHERE EXISTS command
CREATE TABLE Table400A (AutoID INT)

DECLARE @var400a INT
SET @var400a = 10
DECLARE @varcount400 INT
SET @varcount400 = 0
WHILE @varcount400 < 900 AND @var400a < 10000
BEGIN
    IF (@var400a % 2 = 0) AND  (@var400a % 9 <> 0) AND ((SQRT(@var400a) * SQRT(@var400a)) <> @var400a) 
    BEGIN
        INSERT INTO Table400A VALUES (@var400a)
        SET @varcount400 = @varcount400 + 1
    END
    SET @var400a = @var400a + 1
END 

CREATE TABLE Table400B (AutoID INT)

DECLARE @var400b INT
SET @var400b = 1
WHILE POWER(@var400b, 3) < 10000
BEGIN
    INSERT INTO Table400B VALUES (POWER(@var400b, 3))
    SET @var400b = @var400b + 1
END

WITH Table400 AS(
    SELECT * FROM Table400A
    UNION 
    SELECT * FROM Table400B
)
SELECT * 
FROM Sales.Customer C
WHERE EXISTS (
    SELECT 1
    FROM Table400 T400
    WHERE EXISTS (
        SELECT 1
        FROM Sales.SalesTerritory T
        WHERE C.TerritoryID = T.TerritoryID
        AND (C.CustomerID = T400.AutoID) OR (LEFT(CAST(T.SalesLastYear AS int), 4) = T400.AutoID)
    )
)