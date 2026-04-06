# 📄 ✅ DOCUMENT 2 — ASSIGNMENT 2 (ETL IMPLEMENTATION)

## 🔹 1. Introduction

This assignment focuses on implementing the ETL (Extract, Transform, Load) process using SQL Server Integration Services (SSIS). The goal is to extract data from multiple sources, transform it into a suitable format, and load it into the Data Warehouse.

---

## 🔹 2. ETL Process Overview

The ETL process consists of three main steps:

- Extract data from staging tables
- Transform data into required format
- Load data into Data Warehouse tables

Two SSIS packages were created:

- Retail_Load_DW.dtsx
- Retail_Accumulating_Fact_Update.dtsx

The staging layer is created separately with `RetailStaging.sql`.

---

## 🔹 3. Load Data Warehouse Package

### Execution Order

1. Dim_Date
2. Dim_Product
3. Dim_Customer (SCD Type 2)
4. Dim_Geography
5. Fact_Sales

---

### Dim_Date Load

- Dates are generated using SQL query
- Loaded into Dim_Date
- Includes attributes such as year, month, and quarter

---

### Dim_Product Load

- Data extracted from `stg_Products`
- Loaded into Dim_Product
- Data cleaned and mapped

---

### Dim_Customer Load (SCD Type 2)

- Data extracted from `stg_Customer`
- Slowly Changing Dimension applied
- Tracks historical changes using:
  - StartDate
  - EndDate
  - IsCurrent

---

### Dim_Geography Load

- Extracts distinct country values
- Removes duplicates
- Loads into Dim_Geography

---

### Fact_Sales Load

- Extracts transactional data from `stg_Transactions`

- Performs lookups to get:
  - CustomerKey
  - ProductKey
  - DateKey
  - GeographyKey

- Calculates:
  - TotalAmount = Quantity × UnitPrice

- Loads into Fact_Sales

---

## 🔹 4. Accumulating Fact Table

The Fact_Sales table was extended to support accumulating fact functionality.

Additional columns:

- accm_txn_create_time
- accm_txn_complete_time
- txn_process_time_hours

---

## 🔹 5. Accumulation Package

A second SSIS package (`Retail_Accumulating_Fact_Update.dtsx`) was created to update the fact table.

### Process:

1. Load completion data from source
2. Match records using txn_id
3. Update:
   - accm_txn_complete_time
   - txn_process_time_hours

---

### SQL Update Logic

```sql
UPDATE Fact_Sales
SET
    accm_txn_complete_time = ?,
    txn_process_time_hours = DATEDIFF(HOUR, accm_txn_create_time, ?)
WHERE SalesKey = ?
```

---

## 🔹 6. Data Validation

After ETL execution:

- All dimension tables were validated
- Fact table data verified
- Accumulation updates checked

---

## 🔹 7. Key Features Implemented

- Multi-source ETL process
- SCD Type 2 implementation
- Lookup transformations
- Derived columns for calculations
- Accumulating fact table
- Data validation queries

---

## 🔹 8. Conclusion

The ETL process successfully transformed raw operational data into a structured Data Warehouse. The implementation supports analytical queries and provides a scalable solution for business intelligence.

---