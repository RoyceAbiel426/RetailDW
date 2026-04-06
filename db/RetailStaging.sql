IF DB_ID(N'RetailStaging') IS NULL
BEGIN
    EXEC(N'CREATE DATABASE RetailStaging');
END;
GO

USE RetailStaging;
GO

DROP TABLE IF EXISTS dbo.stg_FactCompletionUpdates;
DROP TABLE IF EXISTS dbo.stg_Transactions;
DROP TABLE IF EXISTS dbo.stg_Products;
DROP TABLE IF EXISTS dbo.stg_ProductCategories;
DROP TABLE IF EXISTS dbo.stg_Customer;
GO

CREATE TABLE dbo.stg_Customer (
    CustomerID VARCHAR(50) NULL,
    CustomerName VARCHAR(255) NULL,
    Country VARCHAR(100) NULL,
    CustomerSegment VARCHAR(100) NULL,
    RegistrationDate VARCHAR(50) NULL
);
GO

CREATE TABLE dbo.stg_ProductCategories (
    CategoryID VARCHAR(50) NULL,
    CategoryName VARCHAR(50) NULL,
    SubCategoryID VARCHAR(50) NULL,
    SubCategoryName VARCHAR(50) NULL
);
GO

CREATE TABLE dbo.stg_Products (
    StockCode VARCHAR(50) NULL,
    Description VARCHAR(255) NULL,
    SubCategory VARCHAR(100) NULL,
    Category VARCHAR(100) NULL
);
GO

CREATE TABLE dbo.stg_Transactions (
    InvoiceNo VARCHAR(50) NULL,
    StockCode VARCHAR(50) NULL,
    Description VARCHAR(255) NULL,
    Quantity INT NULL,
    InvoiceDate DATETIME NULL,
    UnitPrice DECIMAL(18, 2) NULL,
    CustomerID INT NULL
);
GO

CREATE TABLE dbo.stg_FactCompletionUpdates (
    txn_id VARCHAR(50) NULL,
    accm_txn_complete_time VARCHAR(50) NULL
);
GO