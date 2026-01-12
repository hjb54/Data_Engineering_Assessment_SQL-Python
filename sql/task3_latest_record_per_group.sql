-- Purpose: Return the latest contact record per (employee_id, contact_type)
-- Concepts: CTE, ROW_NUMBER(), multi-key deduplication

WITH desc_version AS( -- making temp data called desc_version 
  SELECT *, -- selecting all columns 
    ROW_NUMBER() OVER( -- assigning numbers to rows within the following groups 
      PARTITION BY employee_id, contact_type -- making aforementioned groups: all unique combos of employee_id and contact_type 
      ORDER BY version_number DESC -- sorting by descending version_number since most recent = highest version number 
    ) AS rownumber -- pretty much adds a new column with row number for each row 
  FROM employee_contacts -- source data 
) 
SELECT * FROM desc_version WHERE rownumber = 1; -- returns all columns for the latest version for each unique combo. DESC sorting puts the highest version number in row 1 for each group. 
