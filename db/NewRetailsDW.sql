CREATE DATABASE RetailDW;
GO

USE RetailDW;
GO

CREATE TABLE Dim_Product (
    ProductKey INT IDENTITY(1,1) PRIMARY KEY,
    StockCode VARCHAR(50),
    Description VARCHAR(50),
    SubCategory VARCHAR(50),
    Category VARCHAR(50)
);
GO

CREATE TABLE Dim_Customer (
    CustomerKey INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT,
    CustomerName VARCHAR(50),
    CustomerSegment VARCHAR(50),
    RegistrationDate DATE,
    StartDate DATE NULL,
    EndDate DATE NULL,
    IsCurrent BIT DEFAULT 1
);
GO

CREATE TABLE Dim_Geography (
    GeographyKey INT IDENTITY(1,1) PRIMARY KEY,
    Country VARCHAR(50)
);
GO

CREATE TABLE Dim_Date (
    DateKey INT PRIMARY KEY,
    FullDate DATE,
    Day INT,
    Month INT,
    Year INT,
    Quarter INT,
    MonthName VARCHAR(20)
);
GO

CREATE TABLE Fact_Sales (
    SalesKey INT IDENTITY(1,1) PRIMARY KEY,
    CustomerKey INT,
    ProductKey INT,
    DateKey INT,
    GeographyKey INT NULL,
    InvoiceNo NVARCHAR(50),
    txn_id NVARCHAR(50),
    Quantity INT,
    TotalAmount DECIMAL(18,2),
    accm_txn_create_time DATETIME,
    accm_txn_complete_time DATETIME NULL,
    txn_process_time_hours INT NULL,

    FOREIGN KEY (CustomerKey) REFERENCES Dim_Customer(CustomerKey),
    FOREIGN KEY (ProductKey) REFERENCES Dim_Product(ProductKey),
    FOREIGN KEY (DateKey) REFERENCES Dim_Date(DateKey),
    FOREIGN KEY (GeographyKey) REFERENCES Dim_Geography(GeographyKey)
);
GO

ALTER TABLE Dim_Date
ALTER COLUMN MonthName NVARCHAR(30);

DELETE FROM Fact_Sales;
DELETE FROM Dim_Geography;
DELETE FROM Dim_Customer;
DELETE FROM Dim_Product;
DELETE FROM Dim_Date;

ALTER TABLE Dim_Customer ALTER COLUMN CustomerName VARCHAR(255);
ALTER TABLE Dim_Customer ALTER COLUMN CustomerSegment VARCHAR(100);
ALTER TABLE Dim_Customer ALTER COLUMN RegistrationDate DATE;
ALTER TABLE Dim_Geography ALTER COLUMN Country VARCHAR(100);
ALTER TABLE Dim_Customer ALTER COLUMN StartDate DATETIME NULL;
ALTER TABLE Dim_Customer ALTER COLUMN EndDate DATETIME NULL;

SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Dim_Customer';

DROP TABLE IF EXISTS Dim_Customer;

CREATE TABLE Dim_Customer (
    CustomerKey INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT,
    CustomerName VARCHAR(255),
    CustomerSegment VARCHAR(100),
    RegistrationDate DATE,
    StartDate DATETIME NULL,
    EndDate DATETIME NULL,
    IsCurrent BIT DEFAULT 1
);