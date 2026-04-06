# Retail Data Warehouse (DWBI Assignment)

This repository contains the design and implementation of a retail Data Warehouse project for DWBI coursework. The solution integrates multiple data sources, builds a star schema, and implements ETL workflows to populate and maintain dimensional and fact tables.

## Project Scope

- Assignment 1: Data Warehouse design, sources, architecture, and schema
- Assignment 2: ETL implementation, dimension/fact loading, and accumulating fact updates

## Dataset and Sources

The project uses retail transactional data from two primary source types:

- CSV source: customer master data ([DataSource/customers.csv](DataSource/customers.csv))
- Database source: products and transactions from operational retail tables (exported CSVs under [DataSource/db-to-csv/](DataSource/db-to-csv/))

Main staging/profile artifacts are stored in:

- [data-profiling/](data-profiling/)
- [db/](db/)

## Data Warehouse Model

The warehouse follows a star schema centered on `Fact_Sales`.

### Fact Table

- `Fact_Sales`
  - `CustomerKey`
  - `ProductKey`
  - `DateKey`
  - `GeographyKey`
  - `Quantity`
  - `TotalAmount`

### Dimension Tables

- `Dim_Customer` (SCD Type 2)
  - `CustomerKey`, `CustomerID`, `CustomerName`, `Country`, `CustomerSegment`, `RegistrationDate`, `StartDate`, `EndDate`, `IsCurrent`
- `Dim_Product`
  - `ProductKey`, `StockCode`, `Description`, `SubCategory`, `Category`
- `Dim_Date`
  - `DateKey`, `FullDate`, `Day`, `Month`, `Year`, `Quarter`, `MonthName`
- `Dim_Geography`
  - `GeographyKey`, `Country`

## ETL Implementation

ETL is implemented to:

- Extract from staging and source outputs
- Transform and standardize dimensional/fact attributes
- Load dimensions and fact tables in dependency order

Typical load order:

1. `Dim_Date`
2. `Dim_Product`
3. `Dim_Customer` (SCD Type 2 handling)
4. `Dim_Geography`
5. `Fact_Sales`

Fact enrichment includes calculated amount:

```sql
TotalAmount = Quantity * UnitPrice
```

## Accumulating Fact Enhancement

`Fact_Sales` is extended to support accumulating updates with:

- `accm_txn_create_time`
- `accm_txn_complete_time`
- `txn_process_time_hours`

Update logic example:

```sql
UPDATE Fact_Sales
SET
    accm_txn_complete_time = ?,
    txn_process_time_hours = DATEDIFF(HOUR, accm_txn_create_time, ?)
WHERE SalesKey = ?;
```

## Repository Structure

- [DataSource/](DataSource/) -> Source files (customer CSV and DB exports)
- [data-profiling/](data-profiling/) -> XML profiling and source snapshots
- [db/](db/) -> SQL scripts for staging and DW setup
- [RetailCube/](RetailCube/) -> SSAS cube project files

## Key Deliverables

- Star schema DW design
- SCD Type 2 implementation for customer dimension
- Multi-source ETL pipeline
- Fact table loading with lookups and derived measures
- Accumulating fact table update process

## Conclusion

- 📄 [**Document 1 → Assignment 1 (DW Design + Sources + Architecture)**](Document1.pdf)
- 📄 [**Document 2 → Assignment 2 (ETL + Implementation + Accumulation)**](Document2.pdf)
