# Inventory Movements Analysis

## Overview

This project analyzes an inventory movements dataset using PostgreSQL and Tableau to solve business questions related to inventory management, stock discrepancies, and relationship between various columns.
---

## Setup

### Prerequisites

- PostgreSQL 18 or later
- DBeaver Community Edition
- Tableau Public/Desktop

### Setup Steps

1. Clone or download this repository.
2. Create a PostgreSQL database with `inventory_movements.csv`
3. Open DBeaver and connect to the PostgreSQL database.
4. Execute the `script1.sql` for the query statements.
5. Open the Tableau workbook (`.twb` or `.twbx`).
6. Connect Tableau to the PostgreSQL database and refresh the data source if required.

---

## Approach

The project follows a structured data analytics workflow. The inventory movements dataset was imported into PostgreSQL using DBeaver, where SQL was used to query the data and answer business questions. This included checking for data quality issues, identifying patterns, and monitoring KPIs. The results were then visualized in Tableau through an interactive dashboard designed to help users monitor inventory health, identify high-risk SKUs, evaluate warehouse performance, and detect potential data quality issues.

---

## Files

- `script1.sql` – Queries
- `inventory movements dashboard.twbx` – Tableau dashboard

---

## Author

Gaurang Soni
