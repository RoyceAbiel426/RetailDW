# 📄 ✅ DOCUMENT 1 — ASSIGNMENT 1 (DATA WAREHOUSE DESIGN)

## 🔹 1. Introduction

This project focuses on designing and implementing a Data Warehouse solution using an OLTP dataset. The selected dataset represents retail transactional data, which includes customer information, product details, and sales transactions. The objective is to transform operational data into a structured Data Warehouse that supports analytical processing and decision-making.

---

## 🔹 2. Dataset Selection

The dataset used in this project is based on an Online Retail system. It contains transactional records such as invoices, product purchases, customer details, and timestamps. This dataset is suitable for a Data Warehouse implementation because:

- It follows an OLTP structure
- Contains time-based transactional data
- Includes multiple related entities (customers, products, transactions)
- Supports analytical queries such as sales trends and customer behavior

---

## 🔹 3. Data Sources

Two different types of data sources were used in this project:

### Source 1: CSV File (Customer Data)

The `customers.csv` file contains customer master data, including:

- CustomerID
- CustomerName
- Country
- CustomerSegment
- RegistrationDate

This file is loaded into a staging table (`stg_Customer`) and later used to populate the **Dim_Customer** table using Slowly Changing Dimension (Type 2).

---

### Source 2: Operational Database (RetailOLTP)

The operational database contains the following tables:

#### Products Table

- StockCode
- Description
- SubCategory
- Category

This data is used to populate the **Dim_Product** dimension.

---

#### Transactions Table

- InvoiceNo
- StockCode
- Quantity
- UnitPrice
- InvoiceDate
- CustomerID

This table is used to populate the **Fact_Sales** table.

---

### Derived Data Source

The **Dim_Geography** table is created using the Country attribute from customer data. It stores distinct country values for geographical analysis.

---

## 🔹 4. Data Warehouse Design

The Data Warehouse follows a **Star Schema** design.

### Fact Table

**Fact_Sales**

- CustomerKey
- ProductKey
- DateKey
- GeographyKey
- Quantity
- TotalAmount

---

### Dimension Tables

#### Dim_Customer (SCD Type 2)

- CustomerKey
- CustomerID
- CustomerName
- Country
- CustomerSegment
- RegistrationDate
- StartDate
- EndDate
- IsCurrent

---

#### Dim_Product

- ProductKey
- StockCode
- Description
- SubCategory
- Category

---

#### Dim_Date

- DateKey
- FullDate
- Day
- Month
- Year
- Quarter
- MonthName

---

#### Dim_Geography

- GeographyKey
- Country

---

## 🔹 5. Architecture

The system follows a layered architecture:

```text
Data Sources → Staging Layer → ETL Process → Data Warehouse → Reporting
```

- Data Sources: CSV and OLTP Database
- Staging Layer: Intermediate storage for cleaning
- ETL Layer: Transformation using SSIS
- Data Warehouse: Structured dimensional model
- Reporting Layer: Analytical queries

---

## 🔹 6. Key Design Features

- Use of Star Schema for simplicity
- Implementation of SCD Type 2 for customer history
- Separation of dimensions and fact tables
- Inclusion of time dimension for analysis
- Use of surrogate keys

---