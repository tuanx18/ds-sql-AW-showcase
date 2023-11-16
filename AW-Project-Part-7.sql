-- Part 7: 15/11/2023

-- Tables used for practicing
-- List of ProductID Assigned with LocationID (PK: ProductiD + LocationID)
SELECT * FROM Production.ProductInventory
-- Keyword: I

-- List of Products (PK: ProductID)
SELECT * FROM Production.Product
-- Keyword: PR

-- List of Locations (PK: LocationID)
SELECT * FROM Production.Location
-- Keyword: L

-- List of Cost History (PK: ProductID + StartDate)
SELECT * FROM Production.ProductCostHistory
-- Keyword: CH

-- List of ListPrice History (PK: ProductID + StartDate)
SELECT * FROM Production.ProductListPriceHistory
-- Keyword: LH

----------------------------------------------------------------
-- ADVENTURE WORK PRACTICE PROJECT
-- TASK 301 TO 350
-- KNOWLEDGE COVERED: FUNCTION (Returns Values, Tables), Dynamic SQL, COALESCE, TRY_CAST, CROSS APPLY
----------------------------------------------------------------
-- Note: Put 2 'GO' Before and After any functions & stored procedures to avoid Syntax Error.

-- 301. Create a function that input a number, then it returns the Doubled value of that number, then show the Product (PR) table with the function used on SafetyStockLevel (PR)
GO
CREATE FUNCTION Function_301 (@num INT)
RETURNS INT 
AS
BEGIN
    RETURN @num * 2
END
GO

SELECT dbo.Function_301(SafetyStockLevel) AS DoubleSLL, *
FROM Production.Product

-- 302. Create a function that input a number, then it returns the Tripled value of that number, then show the Product (PR) table with the function used on ReorderPoint (PR)
GO
CREATE FUNCTION Function_302 (@num INT)
RETURNS INT
AS
BEGIN
    RETURN @num * 3
END
GO 

SELECT dbo.Function_302(ReorderPoint) AS TripledRP , *
FROM Production.Product
ORDER BY dbo.Function_302(ReorderPoint) DESC

-- 303. Create a function that input a number, then it returns the Quandrupled value of that number, then show the Product (PR) table with the function used on Sum of SafetyStockLevel and ReorderPoint (PR)
GO
CREATE FUNCTION Function_303 (@num INT) 
RETURNS INT
AS
BEGIN
    RETURN @num * 4
END
GO 

SELECT dbo.Function_303(SafetyStockLEvel + ReorderPoint) AS QuadSum, *
FROM Production.Product
ORDER BY dbo.Function_303(SafetyStockLEvel + ReorderPoint) DESC

-- 304. Create a function that input 2 numbers, then it returns the multiplication result of 2 numbers, then show list of ProductID (PR), SafetyStockLevel (PR) and the mulitplication result of the 2 cols
GO
CREATE FUNCTION Function_304 (@num1 INT, @num2 INT)
RETURNS INT
AS
BEGIN
    RETURN @num1 * @num2
END
GO 

SELECT ProductID, SafetyStockLevel, dbo.Function_304(ProductID, SafetyStockLevel) AS Multi2
FROM Production.Product

-- 305. Create a function that input 3 numbers, then it returns the multiplication result of 3 numbers, then show list of ProductID (PR), SafetyStockLevel (PR) , ReorderPoint (PR) and the function result
GO
CREATE FUNCTION Function_305 (@num1 INT, @num2 INT, @num3 INT)
RETURNS INT
AS
BEGIN
    RETURN @num1 * @num2 * @num3
END
GO 

SELECT ProductID, SafetyStockLevel, ReorderPoint, dbo.Function_305(ProductID, SafetyStockLevel, ReorderPoint) AS MultiResult
FROM Production.Product

-- 306. Create a function that input 2 numbers, then it returns the result of the sum of the 2 numbers divided by 5, then show the Bin (I), Quantity (I) and the function result used on 2 cols
GO
CREATE FUNCTION Function_306 (@num1 INT, @num2 INT)
RETURNS INT
AS
BEGIN
    RETURN (@num1 + @num2) / 5
END
GO 

SELECT Bin, Quantity, dbo.Function_306(Bin, Quantity) AS SumDiv5
FROM Production.ProductInventory

-- 307. Create a function that input 2 numbers, then it returns the result of the multiplication of the 2 numbers divided by 4, then show the Bin (I), Quantity (I) and the function result used on 2 cols
GO
CREATE FUNCTION Function_307(@num1 FLOAT, @num2 FLOAT)
RETURNS INT
AS
BEGIN
    RETURN @num1 * @num2 / 4
END
GO 

SELECT Bin, Quantity, dbo.Function_307(Bin, Quantity) AS MultiplyDiv4
FROM Production.ProductInventory

-- 308. Create a function that input 2 numbers, then it returns the result of the squared of first number 1, then minus the second one,
-- then show the ReorderPoint (PR), Quantity (I) and the function result used on 2 cols
GO
CREATE FUNCTION Function_308 (@num1 FLOAT, @num2 FLOAT)
RETURNS INT
AS
BEGIN
    RETURN @num1 * @num1 - @num2
END
GO 

SELECT PR.ReorderPoint, I.Quantity, dbo.Function_308(PR.ReorderPoint, I.Quantity) AS Result308
FROM Production.Product PR 
JOIN Production.ProductInventory I ON PR.ProductID = I.ProductID

-- 309. Create a function that input 2 numbers, then it returns the multiplication of the 2 numbers, then takes the square root of the multiplication as result,
-- then show the ProductID (CH), StandardCost (CH) and the function result used on 2 columns
GO
CREATE FUNCTION Function_309(@num1 FLOAT, @num2 FLOAT)
RETURNS FLOAT
AS
BEGIN
    RETURN SQRT(@num1 * @num2)
END
GO 

SELECT ProductID, StandardCost, dbo.Function_309(ProductID, StandardCost) AS SQRMultiplication
FROM Production.ProductCostHistory

-- 310. Create a function that input 2 numbers, then it returns the mulitplication of the 2 numbers, then divide by 6,
-- then show the ProductID (CH), StandardCost (CH) and the function result used on 2 columns
GO
CREATE FUNCTION Function_310 (@num1 FLOAT, @num2 FLOAT)
RETURNS FLOAT
AS
BEGIN
    RETURN @num1 * @num2 / 6
END
GO 

SELECT ProductID, StandardCost, ROUND(dbo.Function_310(ProductID, StandardCost), 3) AS Result310
FROM Production.ProductCostHistory

-- 311. Create a function that input 2 numbers, then it returns the devision of the 2 numbers, then show the ReorderPoint (PR), ListPrice (PR) and the function result used on 2 columns,
-- Case: if the second number is zero, use 1 as default
GO
CREATE FUNCTION Function_311 (@num1 FLOAT, @num2 FLOAT)
RETURNS FLOAT
AS
BEGIN
    RETURN ROUND(@num1 / @num2, 3)
END
GO 

SELECT ReorderPoint, ListPrice, 
    CASE
        WHEN ListPrice < 1 THEN dbo.Function_311(ReorderPoint, 1)
        ELSE dbo.Function_311(ReorderPoint, ListPrice)
    END AS Result_311
FROM Production.Product

-- 312. Create a function that input 2 numbers, then it returns the devision of the 2 numbers, if the second number is zero, change it to 1 to do the division,
-- then show the ReorderPoint (PR), StandardCost (PR), ListPrice (PR) and the function result used on pair of column 1+2 and column 1+3
GO
CREATE FUNCTION Function_312(@num1 FLOAT, @num2 FLOAT)
RETURNS FLOAT
AS
BEGIN
    DECLARE @result FLOAT
    SET @result =
        CASE
            WHEN @num2 = 0 THEN @num1
            ELSE @num1 / @num2 
        END
    RETURN @result
END
GO 

SELECT ReorderPoint, StandardCost, ListPrice, 
    dbo.Function_312(ReorderPoint, StandardCost) AS R_S, 
    dbo.Function_312(ReorderPoint, ListPrice) AS R_L
FROM Production.Product

-- 313. Create a function that input 4 numbers, then it returns the sum of 3 first numbers, divides by the fourth one, in case the fourth one is a zero, it will be altered to 2 as default,
-- then show the Number of characters in Name (PR), ReorderPoint (PR), SafetyStockLEvel (PR), ListPrice (PR) and the function result used on all columns
GO
CREATE FUNCTION Function_313(@num1 FLOAT, @num2 FLOAT, @num3 FLOAT, @num4 FLOAT)
RETURNS FLOAT
AS
BEGIN
    DECLARE @result FLOAT
    SET @result =
        CASE
            WHEN @num4 = 0 THEN  (@num1 + @num2 + @num3) / 2
            ELSE (@num1 + @num2 + @num3) / @num4
        END
    RETURN @result
END
GO

SELECT LEN(Name) AS LengthName, ReorderPoint, SafetyStockLevel, ListPrice, dbo.Function_313(LEN(Name), ReorderPoint, SafetyStockLevel, ListPrice) AS Result313
FROM Production.Product

-- 314. Create a function that input 5 numbers, then it returns the multiplication of 3 first numbers, minus the multiplication of the 4th and 5th, 
-- then show the ProductID (PR), Number of characters in Name (PR), four last digits of ProductNumber (PR), SafetyStockLevel (PR), ReorderPoint (PR) 
-- and the 6th column as function result used on all 5 first column 
-- NOTE: Only choose records where 4 last digits of ProductName is NUMERIC
GO
CREATE FUNCTION Function_314(@num1 FLOAT, @num2 FLOAT, @num3 FLOAT, @num4 FLOAT, @num5 FLOAT) 
RETURNS FLOAT
AS
BEGIN
    RETURN (@num1 * @num2 * @num3) - (@num4 * @num5)
END
GO 

WITH Data_314 AS(
    SELECT ProductID, LEN(Name) AS LengthName, RIGHT(ProductNumber, 4) AS ProductNumber4, SafetyStockLevel, ReOrderPoint
    FROM Production.Product
    WHERE ISNUMERIC(RIGHT(ProductNumber, 4)) = 1
)
SELECT *, dbo.Function_314(ProductID, LengthName, ProductNumber4, SafetyStockLevel, ReOrderPoint) AS Result_314
FROM Data_314

-- 315. Create a function that input 5 numbers, then it returns the tripled of multiplication of 3 first numbers, minus the multiplication of (fourth and fifth number)), 
-- (case: if the function result is less than 0, returns the ABSOLUTE value; if the function result is greater than 40000, returns 40000)
-- then show the ProductID (PR), Number of characters in Name (PR), four last digits of ProductNumber (PR), SafetyStockLevel (PR), ReorderPoint (PR) 
-- and the function result used on all columns
-- NOTE: Only choose records where 4 last digits of ProductName is NUMERIC
GO
CREATE FUNCTION Function_315(@num1 FLOAT, @num2 FLOAT, @num3 FLOAT, @num4 FLOAT, @num5 FLOAT)
RETURNS FLOAT
AS
BEGIN
    DECLARE @result FLOAT
    SET @result =
        CASE
            WHEN 3 * @num1 * @num2 * @num3 - (@num4 * @num5) < 0 THEN ABS(3 * @num1 * @num2 * @num3 - (@num4 * @num5))
            WHEN 3 * @num1 * @num2 * @num3 - (@num4 * @num5) > 40000 THEN 40000
            ELSE 3 * @num1 * @num2 * @num3 - (@num4 * @num5) 
        END
    RETURN @result
END
GO 

WITH Data_315 AS(
    SELECT ProductID, LEN(Name) AS LengthName, RIGHT(ProductNumber, 4) AS ProductNumber4, SafetyStockLevel, ReOrderPoint
    FROM Production.Product
    WHERE ISNUMERIC(RIGHT(ProductNumber, 4)) = 1
)
SELECT *, dbo.Function_315(ProductID, LengthName, ProductNumber4, SafetyStockLevel, ReOrderPoint) AS Result_315
FROM Data_315

-- 316. Create a procedure that used ProductID (PR), Number of characters in Name (PR), four last digits of ProductNumber (PR), SafetyStockLevel (PR), ReorderPoint (PR) 
-- and the function #315's result as then 6th column, the procedure has the mission to shows all column ordering from the highest result to lowest result, the ones with result 0, will be terminated from ranking
GO
CREATE PROCEDURE Procedure_316
AS 
WITH DS_316 AS(
SELECT ProductID, LEN(Name) AS LengthName, RIGHT(ProductNumber, 4) AS ProductNumber4, SafetyStockLevel, ReOrderPoint
FROM Production.Product
WHERE ISNUMERIC(RIGHT(ProductNumber, 4)) = 1
) 
SELECT *, dbo.Function_315(ProductID, LengthName, ProductNumber4, SafetyStockLevel, ReOrderPoint) AS Result316
FROM DS_316
GO

EXEC Procedure_316

-- 317. Create a function that returns 35% of the value of the input number, rounded to the nearest hundrends, then used the function to test on column: 4 digits to the right of ProductNumber (PR)
-- only calculate of those with last 4-digit as numeric type
GO
CREATE FUNCTION Function_317 (@num1 FLOAT) 
RETURNS INT
AS
BEGIN
    RETURN ROUND((0.35 * @num1), -2)
END
GO 

SELECT RIGHT(ProductNumber, 4) AS ProductNumber4, dbo.Function_317(RIGHT(ProductNumber, 4)) AS Result317
FROM Production.Product
WHERE ISNUMERIC(RIGHT(ProductNumber, 4)) = 1

-- 318. Create a function that returns 186% of the value of the input number, rounded to the nearest hundrends, then used the function to test on column: 4 digits to the right of ProductNumber (PR)
-- only calculate of those with last 4-digit as numeric type
GO
CREATE FUNCTION Function_318 (@num1 FLOAT)
RETURNS FLOAT
AS
BEGIN
    RETURN ROUND(1.86 * @num1, -2)
END
GO 

SELECT RIGHT(ProductNumber, 4) AS ProductNumber4, dbo.Function_318(RIGHT(ProductNumber, 4)) AS Result318
FROM Production.Product
WHERE ISNUMERIC(RIGHT(ProductNumber, 4)) = 1

-- 319. Create a function that returns 12467% of the value of the input number, rounded to the nearest thousands, then used the function to test on column: 3 digits to the right of ProductNumber (PR)
-- only calculate of those with last 4-digit as numeric type
GO
CREATE FUNCTION Function_319(@num1 FLOAT)
RETURNS FLOAT
AS
BEGIN
    RETURN ROUND((124.67 * @num1), -3)
END
GO 

SELECT RIGHT(ProductNumber, 3) AS ProductNumber3, dbo.Function_319(RIGHT(ProductNumber, 3)) AS Result319
FROM Production.Product
WHERE ISNUMERIC(RIGHT(ProductNumber, 3)) = 1

-- 320. Display the ProductID (PR), ProductNumber (PR), Name (PR), function #317, #318, #319 results using last 4 digits of ProductNumber, only calculate of those with last 4-digit as numeric type
WITH DS_320 AS(
SELECT ProductID, RIGHT(ProductNumber, 4) AS ProductNumber4, Name
FROM Production.Product
WHERE ISNUMERIC(RIGHT(ProductNumber, 4)) = 1
)
SELECT *, dbo.Function_317(ProductNumber4) AS Res317, dbo.Function_318(ProductNumber4) AS Res318, dbo.Function_319(ProductNumber4) AS Res319
FROM DS_320

-- 321. Create a function that calculate the sum of 3 input numbers, only if all 3 numbers are numeric type, then test 2 sets of columns in Product (PR) table, one that does the calculation, one is not
DROP FUNCTION Function_321
GO
CREATE FUNCTION Function_321(@num1 VARCHAR(200), @num2 VARCHAR(200), @num3 VARCHAR(200))
RETURNS VARCHAR(1000)
AS
BEGIN
    DECLARE @result VARCHAR(100)
    SET @result =
        CASE 
            WHEN (COALESCE(TRY_CAST(@num1 AS Float), 69) = TRY_CAST(@num1 AS Float)
            AND COALESCE(TRY_CAST(@num2 AS Float), 69) = TRY_CAST(@num2 AS Float)
            AND COALESCE(TRY_CAST(@num3 AS Float), 69) = TRY_CAST(@num3 AS Float))
            THEN 
                CAST(@num1 AS FLOAT) * CAST(@num2 AS FLOAT) * CAST(@num3 AS FLOAT)
            ELSE 
                '0'
        END
    RETURN @result
END
GO 

SELECT ProductID, SafetyStockLevel, ReOrderPoint, dbo.Function_321(ProductID, SafetyStockLevel, ReOrderPoint) AS Result321
FROM Production.Product

SELECT Name, ProductNumber, SafetyStockLevel, dbo.Function_321(ProductNumber, SafetyStockLevel, Name) AS Result321
FROM Production.Product

-- 322. Create a function that calculate the multiplication of 3 inputs, if a column is varchar-typed, then it will be count as 10, 
-- then test 2 sets of columns in Product (PR) table, one that does the calculation, the other one is not
DROP FUNCTION Function_322
GO
CREATE FUNCTION Function_322(@num1 VARCHAR(200), @num2 VARCHAR(200), @num3 VARCHAR(200))
RETURNS VARCHAR(100)
AS
BEGIN
    RETURN COALESCE(TRY_CAST(@num1 AS FLOAT), 10) * COALESCE(TRY_CAST(@num2 AS FLOAT), 10) * COALESCE(TRY_CAST(@num3 AS FLOAT), 10) 
END
GO 

SELECT ProductID, SafetyStockLevel, ReOrderPoint, dbo.Function_322(ProductID, SafetyStockLevel, ReOrderPoint) AS Result322
FROM Production.Product

SELECT Name, ProductNumber, SafetyStockLevel, dbo.Function_322(ProductNumber, SafetyStockLevel, Name) AS Result322
FROM Production.Product

-- 323. Create a function that calculate the average of 3 inputs, if a column is varchar-typed, then it will be altered to the length of the record, 
-- then test 2 sets of columns in Product (PR) table, one that does the calculation, the other one is not
GO
CREATE FUNCTION Avgoftest2_LenVarchar(@input1 VARCHAR(1000))
RETURNS INT 
AS
BEGIN
    RETURN COALESCE(TRY_CAST(@input1 AS INT), 1)
END
GO

GO
CREATE FUNCTION Function_323(@num1 VARCHAR(200), @num2 VARCHAR(200), @num3 VARCHAR(200))
RETURNS VARCHAR(200)
AS
BEGIN
    RETURN (COALESCE(TRY_CAST(@num1 AS FLOAT), LEN(@num1)) + COALESCE(TRY_CAST(@num2 AS FLOAT), LEN(@num2)) + COALESCE(TRY_CAST(@num3 AS FLOAT), LEN(@num3))) / 3
END
GO

SELECT ProductID, SafetyStockLevel, ReOrderPoint, dbo.Function_323(ProductID, SafetyStockLevel, ReOrderPoint) AS Result323
FROM Production.Product

SELECT Name, ProductNumber, SafetyStockLevel, dbo.Function_323(ProductNumber, SafetyStockLevel, Name) AS Result323
FROM Production.Product

-- 324. Create a function that takes 5 input variables, that returns the multiplication of all numeric values, then divides by 2 for every varchar-typed value,
-- then test the function using Product (PR) table with these cases: 5 INT columns; 1 INT columns and 4 VARCHAR columns
GO
CREATE FUNCTION Function_324(@num1 VARCHAR(200), @num2 VARCHAR(200), @num3 VARCHAR(200), @num4 VARCHAR(200), @num5 VARCHAR(200))
RETURNS VARCHAR(200)
AS
BEGIN
    RETURN (COALESCE(TRY_CAST(@num1 AS FLOAT), 0.5) * COALESCE(TRY_CAST(@num2 AS FLOAT), 0.5) * COALESCE(TRY_CAST(@num3 AS FLOAT), 0.5) * COALESCE(TRY_CAST(@num4 AS FLOAT), 0.5) * COALESCE(TRY_CAST(@num5 AS FLOAT), 0.5))
END
GO

SELECT SafetyStockLevel, ReOrderPoint, LEN(Name) AS LengthName, ProductID, LEN(ProductNumber) AS LengthPN,
    dbo.Function_324(SafetyStockLevel, ReOrderPoint, LEN(Name), ProductID, LEN(ProductNumber)) AS Result324
FROM Production.Product

SELECT SafetyStockLevel, Name, ProductID, rowguid, ModifiedDate,
    dbo.Function_324(SafetyStockLevel, Name, ProductNumber, rowguid, ModifiedDate) AS Result324
FROM Production.Product

-- 325. Create a function that takes 5 input variables, that returns the multiplication of all numeric values, then divides by the length of all characters for every varchar-typed value,
-- then test the function using Product (PR) table with these cases: 3 INT columns + 2 VARCHAR columns; 1 INT columns and 4 VARCHAR columns
GO
CREATE FUNCTION Function_325(@num1 VARCHAR(200), @num2 VARCHAR(200), @num3 VARCHAR(200), @num4 VARCHAR(200), @num5 VARCHAR(200))
RETURNS VARCHAR(200)
AS
BEGIN
    RETURN (COALESCE(TRY_CAST(@num1 AS FLOAT), 1 / LEN(@num1)) * COALESCE(TRY_CAST(@num2 AS FLOAT), 1 / LEN(@num2)) * COALESCE(TRY_CAST(@num3 AS FLOAT), 1 / LEN(@num3))
     * COALESCE(TRY_CAST(@num4 AS FLOAT), 1 / LEN(@num4)) * COALESCE(TRY_CAST(@num5 AS FLOAT), 1 / LEN(@num5)))
END
GO

SELECT SafetyStockLevel, ReOrderPoint, LEN(Name) AS LengthName, ProductID, LEN(ProductNumber) AS LengthPN,
    dbo.Function_325(SafetyStockLevel, ReOrderPoint, LEN(Name), ProductID, LEN(ProductNumber)) AS Result325
FROM Production.Product

SELECT SafetyStockLevel, Name, ProductID, rowguid, ModifiedDate,
    dbo.Function_325(SafetyStockLevel, Name, ProductNumber, rowguid, ModifiedDate) AS Result325
FROM Production.Product

-- 326. Create a function that takes 2 to 5 inputs, that returns the total of all inputs, divided by 2, the function works even if there is not enough variables,
-- then test the function using Product (PR) table with these cases: 2 INT column, 3 INT columns, 5 INT columns
DROP FUNCTION Function_326
GO
CREATE FUNCTION Function_326(@num1 INT = 0, @num2 INT = 0, @num3 INT = 0, @num4 INT = 0, @num5 INT = 0)
RETURNS INT
AS
BEGIN
    DECLARE @result INT;
    SET @result = @num1 + @num2 + @num3 + @num4 + @num5;
    RETURN @result;
END
GO

SELECT ProductID, LocationID, dbo.Function_326(ProductID, LocationID, default, default, default) AS Result326
FROM Production.ProductInventory

SELECT ProductID, LocationID, Bin, dbo.Function_326(ProductID, LocationID, Bin, default, default) AS Result326
FROM Production.ProductInventory

SELECT ProductID, LocationID, Bin, Quantity, DATEPART(DAY, ModifiedDate) AS DayModified, dbo.Function_326(ProductID, LocationID, Bin, Quantity, DATEPART(DAY, ModifiedDate)) AS Result326
FROM Production.ProductInventory

-- 327. Create a dynamic SQL that takes Product Table (PR) joining with the Assigned Table (I) as the base. Then the procedure takes names of 2 INT columns from each table, 
-- then it displays the 2 columns, along with 2 new columns as the result of function that doubled the value (#301)
DECLARE @column1 VARCHAR(100)
SET @column1 = 'I.Quantity'
DECLARE @column2 VARCHAR(100)
SET @column2 = 'PR.SafetyStockLevel'
DECLARE @sql_327 VARCHAR(1000)
SET @sql_327 = 'SELECT ' + @column1 + ' , ' + @column2 + ' ,  dbo.Function_301(' +  @column1 + ') AS Double1, dbo.Function_301(' + @column2 + ') AS Double2
FROM Production.ProductInventory I 
JOIN Production.Product PR ON I.ProductID = PR.ProductID'

PRINT @sql_327
EXEC(@sql_327)

-- 328. Create a dynamic SQL that takes Product Table (PR) as the base. Then the procedure takes names of 3 INT columns from the table, 
-- then it displays the 3 columns, along with 3 new columns as the result of function that tripled the values
DECLARE @column328a VARCHAR(100)
SET @column328a = 'ProductID'
DECLARE @column328b VARCHAR(100)
SET @column328b = 'ReorderPoint'
DECLARE @column328c VARCHAR(1000)
SET @column328c = 'SafetyStockLevel'
DECLARE @sql_328 VARCHAR(1000)
SET @sql_328 = 'SELECT ' + @column328a + ', ' + @column328b + ', ' + @column328c + ', dbo.Function_302(' + @column328a + '), dbo.Function_302(' + @column328b + '), dbo.Function_302(' + @column328c + ')
FROM Production.Product'

PRINT @sql_328
EXEC(@sql_328)

-- 329. Create a dynamic SQL that takes Product Table (PR) as the base. Then the procedure takes names of 3 INT columns from the table, 
-- then it displays the 3 columns, along with 3 new columns as the result of SUM for each pair of the original 3 columns 
DECLARE @column329a VARCHAR(100)
SET @column329a = 'SafetyStockLevel'
DECLARE @column329b VARCHAR(100)
SET @column329b = 'ReOrderPoint'
DECLARE @column329c VARCHAR(100)
SET @column329c = 'LEN(Name)'
DECLARE @sql_329 VARCHAR(1000)
SET @sql_329 = 'SELECT ' + @column329a + ', ' + @column329b + ', ' + @column329c + ', 
    ' + @column329a + '+ ' + @column329b + ' AS SumAB,
    ' + @column329a + '+ ' + @column329c + ' AS SumAC,
    ' + @column329b + '+ ' + @column329c + ' AS SumBC
FROM Production.Product
'
PRINT @sql_329
EXEC(@sql_329)

-- 330. Create a dynamic SQL that takes Product Table (PR) joining with the Assigned Table (I) as the base. Then the procedure takes names of 3 INT columns from any tables, 
-- then it displays the 3 columns, along with 6 new columns as the result of HALF-DIVISION (num1 / num2 / 2) function for each pair of the original 3 columns
DECLARE @column330a VARCHAR(100)
SET @column330a = 'PR.SafetyStockLevel'
DECLARE @column330b VARCHAR(100)
SET @column330b = 'PR.ReOrderPoint'
DECLARE @column330c VARCHAR(100)
SET @column330c = 'I.Quantity'
DECLARE @sql_330 VARCHAR(1000)
SET @sql_330 = 'SELECT ' + @column330a + ', ' + @column330b + ', ' + @column330c + ', 
    ' + @column330a + '/' + @column330b + '/2 AS HdAB,
    ' + @column330a + '/' + @column330c + '/2 AS HdAC,
    ' + @column330b + '/' + @column330c + '/2 AS HdBC
FROM Production.ProductInventory I 
JOIN Production.Product PR ON I.ProductID = PR.ProductID
WHERE ' +  @column330b + '<> 0 AND ' + @column330c + '<>0'

PRINT @sql_330
EXEC(@sql_330)

-- 331. Create a dynamic SQL that takes Product Table (PR) joining with the Assigned Table (I) as the base. Then the procedure takes names of 4 INT columns from any tables, 
-- then it displays the 4 columns, along with 4 new columns as the result of MULTIPLICATION OF 3 numbers (#305) function for each set of the original 3 columns
DECLARE @column331a VARCHAR(100)
SET @column331a = 'PR.SafetyStockLevel'
DECLARE @column331b VARCHAR(100)
SET @column331b = 'PR.ReOrderPoint'
DECLARE @column331c VARCHAR(100)
SET @column331c = 'I.Quantity'
DECLARE @column331d VARCHAR(100)
SET @column331d = 'I.Bin'
DECLARE @sql_331 VARCHAR(1000)
SET @sql_331 = 'SELECT ' + @column331a + ', ' + @column331b + ', ' + @column331c + ', ' + @column331d + ',
    dbo.Function_305(' + @column331a + ', ' + @column331b + ', ' + @column331c + ') AS ResultABC,
    dbo.Function_305(' + @column331a + ', ' + @column331c + ', ' + @column331d + ') AS ResultACD,
    dbo.Function_305(' + @column331a + ', ' + @column331b + ', ' + @column331d + ') AS ResultABD,
    dbo.Function_305(' + @column331b + ', ' + @column331c + ', ' + @column331d + ') AS ResultBCD
FROM Production.ProductInventory I 
JOIN Production.Product PR ON I.ProductID = PR.ProductID'

PRINT @sql_331
EXEC(@sql_331)

-- 332. Create a dynamic SQL that takes Product Table (PR) joining with the Assigned Table (I) as the base. Then the procedure takes names of 3 ANY-TYPED columns from any tables, 
-- then it displays the 3 columns, along with 3 new columns as the result of MULTIPLICATION OF 2 numbers function for each pair of the original 3 columns, 
-- if the type of the column is varchar, then use the count of characters
GO
CREATE FUNCTION Function_332(@input1 VARCHAR(100), @input2 VARCHAR(100))
RETURNS FLOAT
AS
BEGIN
    RETURN COALESCE(TRY_CAST(@input1 AS FLOAT), LEN(@input1)) * COALESCE(TRY_CAST(@input2 AS FLOAT), LEN(@input2))
END
GO

DECLARE @column332a VARCHAR(100)
SET @column332a = 'PR.Name'
DECLARE @column332b VARCHAR(100)
SET @column332b = 'PR.ProductNumber'
DECLARE @column332c VARCHAR(100)
SET @column332c = 'I.Quantity'
DECLARE @sql_332 VARCHAR(1000)
SET @sql_332 = 'SELECT ' + @column332a + ', ' + @column332b + ', ' + @column332c + ', 
    dbo.Function_332(' + @column332a + ', ' + @column332b + ') AS ResultAB,
    dbo.Function_332(' + @column332a + ', ' + @column332c + ') AS ResultAC,
    dbo.Function_332(' + @column332b + ', ' + @column332c + ') AS ResultBC
FROM Production.ProductInventory I 
JOIN Production.Product PR ON I.ProductID = PR.ProductID'

PRINT @sql_332
EXEC(@sql_332)

-- 333. Create a dynamic SQL that takes Product Table (PR) joining with the Assigned Table (I) as the base. Then the procedure takes names of 3 ANY-TYPED columns from any tables, 
-- then it displays the 3 columns, along with 3 new columns as the result of MULTIPLICATION OF 2 numbers function for each pair of the original 3 columns, 
-- if the type of the column is varchar, then the result of function related will be eliminated
GO
CREATE FUNCTION Function_333(@input1 VARCHAR(100), @input2 VARCHAR(100))
RETURNS FLOAT
AS
BEGIN
    RETURN COALESCE(TRY_CAST(@input1 AS FLOAT), 0) * COALESCE(TRY_CAST(@input2 AS FLOAT), 0)
END
GO

DECLARE @column333a VARCHAR(100)
SET @column333a = 'PR.Name'
DECLARE @column333b VARCHAR(100)
SET @column333b = 'PR.ProductNumber'
DECLARE @column333c VARCHAR(100)
SET @column333c = 'I.Quantity'
DECLARE @sql_333 VARCHAR(1000)
SET @sql_333 = 'WITH DS_333 AS (
        SELECT ' + @column333a + ', ' + @column333b + ', ' + @column333c + ', 
            dbo.Function_333(' + @column333a + ', ' + @column333b + ') AS ResultAB,
            dbo.Function_333(' + @column333a + ', ' + @column333c + ') AS ResultAC,
            dbo.Function_333(' + @column333b + ', ' + @column333c + ') AS ResultBC
        FROM Production.ProductInventory I 
        JOIN Production.Product PR ON I.ProductID = PR.ProductID)
    SELECT * FROM DS_333
    WHERE ResultAB <> 0 AND ResultAC <> 0 AND ResultBC <> 0'

PRINT @sql_333
EXEC(@sql_333)

-- 334. Create a dynamic SQL that create a function, the function has the mission to multiplies with the INPUT number
DECLARE @num334 VARCHAR(100)
SET @num334 = 77
DECLARE @sql_334 VARCHAR(1000)
SET @sql_334 = 'CREATE FUNCTION Function_334 (@input INT)
RETURNS INT
AS
BEGIN
    RETURN @input * ' + @num334 + ' 
END'
EXEC(@sql_334)

SELECT ProductID, dbo.Function_334(ProductID) AS FunctionResult
FROM Production.Product

-- 335. Create a dynamic SQL that create a function, the function has the mission to calculate the average with the 3 INPUT numbers
DECLARE @sql_335 VARCHAR(1000)
SET @sql_335 = 'CREATE FUNCTION Function_335 (@input1 INT, @input2 INT, @input3 INT)
RETURNS INT
AS
BEGIN
    RETURN (@input1 + @input2 + @input3) / 3
END'
EXEC(@sql_335)

SELECT dbo.Function_335(15, 20, 40) AS AVG3

-- 336. Create a dynamic SQL that create a function, the function has the mission to calculate the 24.75% of total of the 3 INPUT numbers
DECLARE @sql_336 VARCHAR(1000)
SET @sql_336 = 'CREATE FUNCTION Function_336 (@input1 FLOAT, @input2 FLOAT, @input3 FLOAT)
RETURNS FLOAT
AS
BEGIN
    RETURN (@input1 + @input2 + @input3) * 0.2475
END'
EXEC(@sql_336)

SELECT dbo.Function_336(102, 512, 444) AS Result336

-- 337. Create a dynamic SQL that create a function, the function has the mission to calculate the total length of characters of the 4 varchar values
DECLARE @sql_337 VARCHAR(1000)
SET @sql_337 = 'CREATE FUNCTION Function_337 (@input1 VARCHAR(1000), @input2 VARCHAR(1000), @input3 VARCHAR(1000), @input4 VARCHAR(1000))
RETURNS INT
AS
BEGIN
    RETURN (LEN(@input1) + LEN(@input2) + LEN(@input3) + LEN(@input4))
END'
EXEC(@sql_337)

SELECT dbo.Function_337('Hustle', 'Kungfu Panda', 182613, 'Mission Impossible') AS Result337

-- 338. Create a dynamic SQL that create a function, the function has the mission to calculate the total length of characters of the 7 varchar values
DECLARE @sql_338 VARCHAR(1000)
SET @sql_338 = 'CREATE FUNCTION Function_338 (@input1 VARCHAR(1000), @input2 VARCHAR(1000), @input3 VARCHAR(1000), @input4 VARCHAR(1000), @input5 VARCHAR(1000), @input6 VARCHAR(1000), @input7 VARCHAR(1000))
RETURNS INT
AS
BEGIN
    RETURN (LEN(@input1) + LEN(@input2) + LEN(@input3) + LEN(@input4) + LEN(@input5) + LEN(@input6) + LEN(@input7))
END'
EXEC(@sql_338)

SELECT dbo.Function_338('Hustle', 'Kungfu Panda', 182613, 'Mission Impossible', 'Oops I did it again', 0.1236721, 'asudghiasdu') AS Result338

-- 339. Create a dynamic SQL that create a function, the function has the mission to calculate the total length of characters of the 4 varchar values, 
-- if the value is numeric, then just use the number for calculating the total
DECLARE @sql_339 VARCHAR(1000)
SET @sql_339 = 'CREATE FUNCTION Function_339 (@input1 VARCHAR(1000), @input2 VARCHAR(1000), @input3 VARCHAR(1000), @input4 VARCHAR(1000))
RETURNS INT
AS
BEGIN
    RETURN COALESCE(TRY_CAST(@input1 AS FLOAT), LEN(@input1)) + COALESCE(TRY_CAST(@input2 AS FLOAT), LEN(@input2)) + COALESCE(TRY_CAST(@input3 AS FLOAT), LEN(@input3)) + COALESCE(TRY_CAST(@input4 AS FLOAT), LEN(@input4))
END'
EXEC(@sql_339)

SELECT dbo.Function_339('Hustle', 'Kungfu Panda', 182613, 'Mission Impossible') AS Result339

-- 340. Create a dynamic SQL that create a function, the function has the mission to calculate the total length of characters of the 4 varchar values, 
-- if the value is numeric, then use 70% of the value for calculation
DECLARE @sql_340 VARCHAR(1000)
SET @sql_340 = 'CREATE FUNCTION Function_340 (@input1 VARCHAR(1000), @input2 VARCHAR(1000), @input3 VARCHAR(1000), @input4 VARCHAR(1000))
RETURNS FLOAT
AS
BEGIN
    DECLARE @num1 FLOAT
    SET @num1 = 
        CASE
            WHEN TRY_CAST(@input1 AS FLOAT) IS NULL THEN LEN(@input1)
            ELSE CAST(@input1 AS FLOAT) * 0.7
        END

    DECLARE @num2 FLOAT
    SET @num2 = 
        CASE
            WHEN TRY_CAST(@input2 AS FLOAT) IS NULL THEN LEN(@input2)
            ELSE CAST(@input2 AS FLOAT) * 0.7
        END

    DECLARE @num3 FLOAT
    SET @num3 = 
        CASE
            WHEN TRY_CAST(@input3 AS FLOAT) IS NULL THEN LEN(@input3)
            ELSE CAST(@input3 AS FLOAT) * 0.7
        END

    DECLARE @num4 FLOAT
    SET @num4 = 
        CASE
            WHEN TRY_CAST(@input4 AS FLOAT) IS NULL THEN LEN(@input4)
            ELSE CAST(@input4 AS FLOAT) * 0.7
        END
    
    RETURN @num1 + @num2 + @num3 + @num4
END'
EXEC(@sql_340)

SELECT dbo.Function_340('Hustle', 'Kungfu Panda', 182613, 'Mission Impossible') AS Result340

-- 341. Create a dynamic SQL that create a function, the function has the mission to calculate the total length of characters of the 4 varchar values, 
-- if the value is numeric, use 40% of the value if the value is greater than 100, use 525% of the value if the value is less or equal 100
DECLARE @sql_341 VARCHAR(MAX)
SET @sql_341 = 'CREATE FUNCTION Function_341 (@input1 VARCHAR(1000), @input2 VARCHAR(1000), @input3 VARCHAR(1000), @input4 VARCHAR(1000))
RETURNS FLOAT
AS
BEGIN
    DECLARE @num1 FLOAT
    SET @num1 = 
        CASE
            WHEN TRY_CAST(@input1 AS FLOAT) IS NULL THEN LEN(@input1)
            WHEN CAST(@input1 AS FLOAT) > 100 THEN CAST(@input1 AS FLOAT) * 0.4
            ELSE CAST(@input1 AS FLOAT) * 5.25
        END

    DECLARE @num2 FLOAT
    SET @num2 = 
        CASE
            WHEN TRY_CAST(@input2 AS FLOAT) IS NULL THEN LEN(@input2)
            WHEN CAST(@input2 AS FLOAT) > 100 THEN CAST(@input2 AS FLOAT) * 0.4
            ELSE CAST(@input2 AS FLOAT) * 5.25
        END

    DECLARE @num3 FLOAT
    SET @num3 = 
        CASE
            WHEN TRY_CAST(@input3 AS FLOAT) IS NULL THEN LEN(@input3)
            WHEN CAST(@input3 AS FLOAT) > 100 THEN CAST(@input3 AS FLOAT) * 0.4
            ELSE CAST(@input3 AS FLOAT) * 5.25
        END

    DECLARE @num4 FLOAT
    SET @num4 = 
        CASE
            WHEN TRY_CAST(@input4 AS FLOAT) IS NULL THEN LEN(@input4)
            WHEN CAST(@input4 AS FLOAT) > 100 THEN CAST(@input4 AS FLOAT) * 0.4
            ELSE CAST(@input4 AS FLOAT) * 5.25
        END
    
    RETURN @num1 + @num2 + @num3 + @num4
END'

PRINT @sql_341
EXEC(@sql_341)

SELECT dbo.Function_341('Hustle', 55, 1823, 'Mission Impossible') AS Result341
SELECT 6 + 55 * 5.25 + 1823 * 0.4 + 18

-- 342. Create a function that multiply a value by 10000, then it loops dividing the result by 4 until it is less than 50, then apply it with ListPrice (LH)
GO
CREATE FUNCTION Function_342(@num FLOAT)
RETURNS FLOAT
BEGIN
    DECLARE @num10000 FLOAT
    SET @num10000 = @num * 10000
    WHILE @num10000 > 50
    BEGIN
        SET @num10000 = @num10000 / 4
    END
    RETURN @num10000
END
GO

SELECT ListPrice, dbo.Function_342(ListPrice) AS Result342
FROM Production.ProductListPriceHistory

-- 343. Create a function that multiply a value by 2800, then it loops dividing the calculation of divides by 3 and plus 2 (value / 3 + 2) until it is less than 10,
-- then apply it with each SUM of StardardCost (CH) based on each ProductID (CH)
GO
CREATE FUNCTION Function_343(@num FLOAT)
RETURNS FLOAT
BEGIN
    DECLARE @num2800 FLOAT
    SET @num2800 = @num * 10000
    WHILE @num2800 > 10
    BEGIN
        SET @num2800 = @num2800 / 3 + 2
    END
    RETURN @num2800
END
GO

WITH DS_343 AS(
    SELECT ProductID, SUM(StandardCost) AS TotalSC
    FROM Production.ProductCostHistory
    GROUP BY ProductID
)
SELECT ProductID, TotalSC, dbo.Function_343(TotalSC) AS Result343
FROM DS_343

-- 344. Create a function that multiply the first input value with the second input value (both numeric). In case the second number is less than 2, 
-- then takes the first number multiplies by 2 instead of second number. The multiplication process (num1 x num2) will be looped until the absolute of the value greater than 15000,
-- apply the function with ProductID (I) and Bin (I)
GO
CREATE FUNCTION Function_344(@num1 FLOAT, @num2 FLOAT)
RETURNS FLOAT
AS
BEGIN
    SET @num2 =
    CASE 
        WHEN @num2 < 2 THEN 2 
        ELSE @num2
    END

    DECLARE @result FLOAT
    SET @result = @num1 * @num2
    WHILE @result < 15000
    BEGIN
        SET @result = @result * @num2
    END 
    RETURN @result
END
GO

SELECT ProductID, Bin, dbo.Function_344(ProductID, Bin) AS Result344
FROM Production.ProductInventory

-- 345. Create a function that multiply the first input value with the number of characters on second input value (1st numeric, 2nd varchar), if the length of 2nd number is less than 2, 
-- then takes the first number multiplies by 2 instead of it. The multiplication process (num1 x len(input2)) will be looped until the absolute of the value greater than 15000,
-- apply the function with ProductID (PR) and Name (PR)
GO
CREATE FUNCTION Function_345(@num1 FLOAT, @input2 VARCHAR(1000))
RETURNS FLOAT
AS
BEGIN
    DECLARE @num2 FLOAT
    SET @num2 = 
    CASE 
        WHEN LEN(@input2) < 2 THEN 2 
        ELSE LEN(@input2)
    END

    DECLARE @result FLOAT
    SET @result = @num1 * @num2
    WHILE @result < 15000
    BEGIN
        SET @result = @result * @num2
    END 
    RETURN @result
END
GO

SELECT ProductID, Name, dbo.Function_345(ProductID, Name) AS Result345
FROM Production.Product

-- 346. Create a function that get the multiplication of 4 values, then the result keep dividing by 1.28 until the result is less than 10,
-- apply the function with SafetyStockLevel, ReorderPoint, Length of Name and ProductID (all in PR table)
GO
CREATE FUNCTION Function_346(@num1 FLOAT, @num2 FLOAT, @num3 FLOAT, @num4 FLOAT)
RETURNS FLOAT
AS
BEGIN
    DECLARE @result FLOAT
    SET @result = @num1 * @num2 * @num3 * @num4
    WHILE @result > 10
    BEGIN 
        SET @result = @result / 1.28
    END
    RETURN @result 
END
GO

SELECT SafetyStockLevel, ReorderPoint, LEN(Name) AS LengthName, ProductID, dbo.Function_346(SafetyStockLevel, ReorderPoint, LEN(Name), ProductID) AS Result346
FROM Production.Product

-- 347. Create a function that get the multiplication of 3 values, then the result keep dividing by 2.056 and plus 22 after each division until the result is less than 100,
-- apply the function with SafetyStockLevel, ReorderPoint and ProductID (all in PR table)
GO
CREATE FUNCTION Function_347(@num1 FLOAT, @num2 FLOAT, @num3 FLOAT)
RETURNS FLOAT
AS
BEGIN
    DECLARE @result FLOAT
    SET @result = @num1 * @num2 * @num3
    WHILE @result > 100
    BEGIN 
        SET @result = @result / 2.056 + 22
    END
    RETURN @result 
END
GO

SELECT SafetyStockLevel, ReorderPoint, ProductID, dbo.Function_347(SafetyStockLevel, ReorderPoint, ProductID) AS Result347
FROM Production.Product

-- 348. Create a function (5 variables) that get the multiplication of 4 values, then the result keep dividing by the length of 5 value (if 5th value is less than 2, then use 2) 
-- until the result is less than 80.
-- Apply the function with SafetyStockLevel, ReorderPoint, MakeFlag plus 3, FinishedGoodsFlag plus 4.5, and ProductID (all in PR table)
GO
CREATE FUNCTION Function_348(@num1 FLOAT, @num2 FLOAT, @num3 FLOAT, @num4 FLOAT, @var5 VARCHAR(1000))
RETURNS FLOAT
AS
BEGIN
    DECLARE @num5 FLOAT
    SET @num5 = 
    CASE 
        WHEN LEN(@var5) < 2 THEN 2
        ELSE LEN(@var5)
    END

    DECLARE @result FLOAT
    SET @result = @num1 * @num2 * @num3 * @num4

    WHILE @result > 80
    BEGIN 
        SET @result = @result / @num5
    END
    RETURN @result 
END
GO

WITH DS_348 AS(
    SELECT SafetyStockLevel, ReorderPoint, MakeFlag + 3 AS MakeFlag, FinishedGoodsFlag + 4.5 AS FinishedGoodsFlag, ProductID
    FROM Production.Product
)
SELECT *, dbo.Function_348(SafetyStockLevel, ReorderPoint, MakeFlag, FinishedGoodsFlag, ProductID) AS Result348
FROM DS_348

-- 349. Create a function that divide a number by 1.05 until the result is 1-digit or 2-digit, the function returns 2 results: 1st for the final result, 2 for loop counter (each division count as 1)
GO
CREATE FUNCTION Function_349(@num FLOAT)
RETURNS @final349 TABLE (
    Value1 FLOAT,
    Value2 INT
)
AS
BEGIN
    DECLARE @result FLOAT
    SET @result = @num
    DECLARE @time INT
    SET @time = 0
    WHILE @result >= 100
    BEGIN
        SET @result = @result / 1.05
        SET @time = @time + 1
    END

    INSERT INTO @final349 (Value1, Value2)
    VALUES (@result, @time)

    RETURN
END
GO

SELECT * FROM Function_349(4444);    -- Test with value 4444

WITH DS_349 AS(                      -- Test with table
SELECT RIGHT(ProductNumber, 4) AS PN4
FROM Production.Product     
WHERE ISNUMERIC(RIGHT(ProductNumber, 4)) = 1
)
SELECT F.*
FROM DS_349 PR
CROSS APPLY Function_349(PR.PN4) F

-- 350. Create a function that get the multiplication of 4 values, then the result keep dividing by the length of 5 values (if length less than 2, then use 2) and plus 30 after each division
-- until the result is a 1-digit or 2-digit or 3-digit number
-- Final function's return (3 numbers): Mulitplication of first 4 values, Final result after doing the division loops, Number of LOOPS occured
-- apply the function with SafetyStockLevel, ReorderPoint, MakeFlag plus 7, FinishedGoodsFlag plus 1.67, and ProductNumber (all in PR table)
GO
CREATE FUNCTION Function_350(@num1 FLOAT, @num2 FLOAT, @num3 FLOAT, @num4 FLOAT, @var5 VARCHAR(1000))
RETURNS @final350 TABLE(
    Value1 FLOAT,
    Value2 FLOAT,
    Value3 INT
) 
AS
BEGIN
    DECLARE @num5 FLOAT
    SET @num5 = 
        CASE
            WHEN LEN(@var5) < 2 THEN 2
            ELSE LEN(@var5)
        END
    DECLARE @time INT
    SET @time = 0
    DECLARE @firstresult FLOAT
    SET @firstresult = @num1 * @num2 * @num3 * @num4
    DECLARE @result FLOAT
    SET @result = @firstresult

    WHILE @result >= 1000
    BEGIN
        SET @result = @result / @num5 + 30
        SET @time = @time + 1
    END

    INSERT INTO @final350 (Value1, Value2, Value3) VALUES (@firstresult, @result, @time)
    RETURN 
END
GO

/* Test Function_350 with 1 number */
SELECT * FROM Function_350(34, 54, 452, 1236, 'The Observable Universe');       

/* Test Function_350 with table */
WITH DS_350 AS(
    SELECT SafetyStockLevel, ReorderPoint, MakeFlag + 7 AS MakeFlag, FinishedGoodsFlag + 1.67 AS FinishedGoodsFlag, ProductNumber 
    FROM Production.Product
)
SELECT F.* 
FROM DS_350 PR 
CROSS APPLY Function_350(SafetyStockLevel, ReorderPoint, MakeFlag, FinishedGoodsFlag, ProductNumber) F
ORDER BY 1 DESC