-- question 1
SELECT 
    CONCAT(first_name, ' ', last_name) AS provider_name,
    provider_specialty
FROM 
    hospital_db.providers;


/* CONCAT(first_name, ' ', last_name): Combines the first_name and last_name with a space in between to create a full name, aliased as provider_name.
provider_specialty: Directly selects the specialty of each provider.
FROM hospital_db.providers: Specifies the table from which to retrieve the data.*/


-- Question 2:

SELECT 
    p.patient_id,
    p.first_name,
    p.last_name,
    pr.provider_specialty
FROM 
    hospital_db.patients p
INNER JOIN 
    hospital_db.visits v ON p.patient_id = v.patient_id
INNER JOIN 
    hospital_db.providers pr ON v.provider_id = pr.provider_id;


/* INNER JOIN: This is used to combine rows from patients, visits, and providers where there is a match.
ON Clauses:
p.patient_id = v.patient_id: Links patients to their visits.
v.provider_id = pr.provider_id: Links visits to the providers.
Selected Columns: The query retrieves the patient_id, first_name, and last_name from the patients table, along with the provider_specialty from the providers table.*/


-- Question 3.

SELECT 
    p.patient_id,
    p.first_name,
    p.last_name,
    v.date_of_visit
FROM 
    hospital_db.patients p
LEFT JOIN 
    hospital_db.visits v ON p.patient_id = v.patient_id;

/* LEFT JOIN: This type of join returns all records from the left table (patients), along with the matching records from the right table (visits). If there are no matches, the result will still include the patient, but the columns from visits will show NULL.
Selected Columns: The query retrieves patient_id, first_name, and last_name from the patients table, and date_of_visit from the visits table.*/


-- Question 4

SELECT 
    CONCAT(pr.first_name, ' ', pr.last_name) AS provider_name,
    COUNT(v.visit_id) AS visit_count
FROM 
    hospital_db.providers pr
LEFT JOIN 
    hospital_db.visits v ON pr.provider_id = v.provider_id
GROUP BY 
    provider_name;


/* CONCAT(pr.first_name, ' ', pr.last_name): Combines the first and last names of the provider into a single column called provider_name.
COUNT(v.visit_id): Counts the number of visits associated with each provider. If a provider has no visits, the count will be 0 due to the LEFT JOIN.
LEFT JOIN: This ensures that all providers are listed, even those who have not had any visits.
GROUP BY provider_name: Groups the results by the provider’s name to calculate the count of visits for each provider.*/



-- Question 5

SELECT 
    p.patient_id,
    p.first_name,
    p.last_name,
    a.admission_date
FROM 
    hospital_db.patients p
JOIN 
    hospital_db.visits v ON p.patient_id = v.patient_id
JOIN 
    hospital_db.admissions a ON v.visit_id = a.admission_id  -- Assuming each visit that has an admission is recorded here
WHERE 
    a.admission_date IS NOT NULL;  -- This ensures we only get visits that resulted in an admission

/*Join Logic: This query joins the patients, visits, and admissions tables as before.
Admission Condition: The WHERE clause checks that there is an admission_date present, implying that the visit resulted in an admission.
Columns Selected: The query selects patient_id, first_name, last_name, and admission_date.*/

-- Question 6, Bonus question

SELECT 
    p.first_name AS patient_first_name,
    p.last_name AS patient_last_name,
    p.date_of_birth,
    CONCAT(pr.first_name, ' ', pr.last_name) AS provider_name,  -- Combining provider's first and last name
    v.date_of_visit,
    v.blood_pressure_systolic,
    v.blood_pressure_diastolic,
    v.visit_status,
    a.admission_date  -- Retained admission_date only
FROM 
    hospital_db.patients p
JOIN 
    hospital_db.visits v ON p.patient_id = v.patient_id
JOIN 
    hospital_db.providers pr ON v.provider_id = pr.provider_id
JOIN 
    hospital_db.admissions a ON v.visit_id = a.admission_id
WHERE 
    a.admission_date IS NOT NULL  -- Assuming you want to check if there was an admission
ORDER BY 
    v.date_of_visit DESC;



    

/* explanation of the SQL query:

Select Columns:

The query starts by specifying the columns to retrieve from the database.
It selects the patient's first name, last name, and date of birth.
It combines the provider's first and last names into a single field called "provider name."
It also retrieves the date of the visit, blood pressure readings (both systolic and diastolic), the status of the visit, and the admission date.
From Clause:

The query uses the "patients" table as the primary source of data and gives it an alias (short name) for easier reference.
Joins:

The query connects to the "visits" table based on matching patient IDs. This means it will only pull visits that are linked to patients in the database.
It then joins the "providers" table to get information about the healthcare providers who attended to the patients during their visits.
Finally, it connects to the "admissions" table to get details about the admissions related to those visits.
Filtering Results:

The query includes a condition that ensures only visits with a valid admission date are included in the results. This means it filters out any visits that did not result in an admission.
Ordering the Results:

The results are sorted so that the most recent visits appear first, based on the visit date.
Overall, this query gathers detailed information about patients, their visits, the providers involved, and any related admissions, while ensuring the data is relevant and up-to-date.*/