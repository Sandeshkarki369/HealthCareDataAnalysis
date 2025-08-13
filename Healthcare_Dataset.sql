

Select * From dbo.healthcare_dataset


-- 1. group patients by gender, age range, and insurance
SeLeCt  
    Gender,
    CASE  
        WHEN datediff(year, DOB, Visit_Date) < 18 THEN 'Under 18'
        WHEN DATEDIFF(YEAR, dob, visit_date) BETWEEN 18 AND 39 THEN '18-39'
        WHEN DATEDIFF(YEAR, Dob, visit_date) BETWEEN 40 AND 64 THEN '40-64'
        ELSE '65+'  
    end as Age_Range,
    insurance_Type,
    count(distinct Patient_ID) AS Patient_Count
From dbo.healthcare_dataset
group BY 
    gender,
    CASE  
        WHEN datediff(YEAR, dob, visit_date) < 18 THEN 'Under 18'
        WHEN datediff(year, dob, visit_date) BETWEEN 18 AND 39 THEN '18-39'
        WHEN datediff(YEAR, DOB, visit_date) BETWEEN 40 AND 64 THEN '40-64'
        ELSE '65+'  
    END,
    Insurance_Type
order by Age_Range, GENDER;


-- 2. count visits by month to see seasonal patterns
SELECT  
    datename(MONTH, Visit_date) AS Month_Name,
    Count(*) AS Visit_count
from dbo.healthcare_dataset
GROUP BY DATENAME(MONTH, visit_date), Month(visit_date)
ORDER BY MONTH(VISIT_DATE);


-- 3. average charge per visit
select  
    round(avg(Total_charge), 2) as Avg_Charge_Per_Visit
From dbo.healthcare_dataset;


-- 4. average lab results by diagnosis (ignores 0 values)
SELECT  
    Diagnosis_Code,
    diagnosis_Description,
    ROUND(avg(nullif(Lab_Result, 0)), 2) AS avg_LAB_result
from dbo.healthcare_dataset
GROUP by diagnosis_code, diagnosis_description
order by Avg_LAB_RESULT DESC;


-- 5. visits and unique patients per provider
select  
    Provider_name,
    count(*) AS total_visits,
    count(distinct patient_id) AS Unique_Patients
From dbo.Healthcare_dataset
GROUP by provider_Name
Order BY total_visits desc;


-- 6. total revenue by insurance type
SELECT  
    Insurance_type,
    sum(TOTAL_CHARGE) AS Total_Revenue
from dbo.healthcare_dataset
GROUP BY insurance_type
order by total_revenue DESC;


-- 7. top 10 diagnoses by number of visits
select  
    diagnosis_Code,
    diagnosis_description,
    count(*) as Visit_count
From dbo.healthcare_dataset
group by Diagnosis_code, diagnosis_description
order by visit_count desc
OFFSET 0 ROWS fetch next 10 ROWS ONLY;


-- 8. average patient age per diagnosis
SELECT  
    diagnosis_description,
    round(avg(datediff(YEAR, DOB, visit_date)), 1) AS Average_age
from dbo.Healthcare_dataset
GROUP BY diagnosis_description
order by average_age DESC;








