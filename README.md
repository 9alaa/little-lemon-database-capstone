# Little Lemon Database Engineer Capstone — Submission package

## Included
- `01_schema.sql`: MySQL relational schema, 5 tables and foreign keys.
- `02_seed.sql`: illustrative sample records for local tests (not Coursera supplied booking records).
- `03_required_procedures.sql`: all five named stored procedures requested in rubric.
- `05_procedure_tests.sql`: sample calls (NOT recorded execution results).
- `ER_Diagram.png` / `.svg`: generated relational diagram; `.dot` source.
- `booking_client.py`, `booking_operations.py`: starter Python connector code.
- `LittleLemon_US_Prepared.csv`: US-filtered source sales data, first/last name and profit columns.

## Run (MySQL must be installed and started)
```
mysql -u root -p < 01_schema.sql
mysql -u root -p < 02_seed.sql
mysql -u root -p < 03_required_procedures.sql
mysql -u root -p < 05_procedure_tests.sql
```
Check Python connection configuration before running the Python scripts.

## Tableau (NOT COMPLETED)
Import the provided CSV into Tableau Desktop or Tableau Public web authoring, then create and save worksheets and a dashboard. Include the saved `.twb`/`.twbx` and actual screenshots in the final GitHub submission. The CSV alone is not a Tableau workbook. Data source filter is United States; `Profit = [Sales] - [Cost]`. Field names in the supplied Excel data include `Customer Name` rather than `Full Name`.

## IMPORTANT
This package is **prepared source files**, not evidence that MySQL procedures, Python connections, or Tableau workbooks have been run and tested. The rubric requires a GitHub repo link and actual Tableau workbook. Upload files to GitHub only after testing and completing the Tableau portion.
