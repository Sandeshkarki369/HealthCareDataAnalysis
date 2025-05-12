SELECT * 
FROM healthcare_datasetSELECT name, type
FROM sys.objects
WHERE name = 'Name2';-- Droping the Column with mixed up letters of uppercase-lowercaseALTER TABLE dbo.healthcare_dataset
DROP COLUMN Name2;

--Droping Tables
ALTER TABLE dbo.healthcare_dataset
DROP COLUMN Room_Number;

--Checking if there is any NULL values
SELECT *
FROM healthcare_dataset
WHERE Name IS NULL;

SELECT *
FROM healthcare_dataset
WHERE NAME IS NOT NULL;

-- Checking Duplicates based on 'Name' and 'Date_of_Admission'
SELECT Name, COUNT(*) as count
FROM healthcare_dataset
GROUP BY Name
HAVING COUNT(*) > 1;

SELECT Name, Date_of_Admission, COUNT(*) as count
FROM healthcare_dataset
GROUP BY Name, Date_of_Admission
HAVING COUNT(*) > 1;

-- Creating backup table before removing duplicates
SELECT *
INTO healthcare_dataset_backup
FROM healthcare_dataset;

-- Removing Duplicates from column 'Name' and 'Date_of_Admission'--using CTE and deleting with innerjoin
WITH cte AS (
  SELECT Name, Date_of_Admission, 
         ROW_NUMBER() OVER (PARTITION BY Name, Date_of_Admission 
		 ORDER BY (SELECT NULL))
		 AS row_num
  FROM healthcare_dataset
)
DELETE hd
FROM healthcare_dataset hd
INNER JOIN cte 
ON hd.Name = cte.Name 
AND hd.Date_of_Admission = cte.Date_of_Admission
WHERE cte.row_num > 1

-- 'Billing_Amount' change to 2 decimal values
UPDATE healthcare_dataset
SET Billing_Amount = CAST(Billing_Amount 
AS DECIMAL(10, 2))

SELECT DISTINCT Hospital
FROM healthcare_dataset
ORDER BY Hospital ASC

--Droping other Columns
ALTER TABLE healthcare_dataset
DROP COLUMN Date_of_Admission, Discharge_Date, Hospital, Doctor, Insurance_Provider

-- Checking if there is any duplicates remaining
SELECT Name, Billing_Amount, Age, COUNT(*) as count
FROM healthcare_dataset
GROUP BY Name, Billing_Amount, Age
HAVING COUNT(*) > 1

--Final lookup 
SELECT * 
FROM healthcare_dataset

SELECT DISTINCT Age
FROM healthcare_dataset
ORDER BY Age ASC

SELECT Age, COUNT(*) as count
FROM healthcare_dataset
GROUP BY Age
HAVING COUNT(*) > 1
ORDER BY Age ASC







