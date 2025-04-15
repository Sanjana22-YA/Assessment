CREATE TABLE Patient (
    patient_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    gender VARCHAR(10) NOT NULL,
    date_of_birth DATE NOT NULL,
    contact_number VARCHAR(15) UNIQUE
);

CREATE TABLE Appointment (
    appointment_id INT PRIMARY KEY,
    patient_id INT,
    doctor_name VARCHAR(100),
    appointment_date DATE,
    department VARCHAR(50),
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id)
);

--2.Alter the Appointment table to add a new column status VARCHAR(20).
ALTER TABLE Appointment ADD COLUMN status VARCHAR(20);

--3.Insert sample data into both tables for 5 patients and 5 appointments.
--Patient table
INSERT INTO Patient (patient_id, name, gender, date_of_birth, contact_number)
VALUES 
    (1, 'John Doe', 'Male', '1980-05-15', '1234567890'),
    (2, 'Jane Smith', 'Female', '1990-08-20', '9876543210'),
    (3, 'Alice Johnson', 'Female', '1975-03-10', '4567891230'),
    (4, 'Bob Brown', 'Male', '1965-12-25', '7891234560'),
    (5, 'Emily Davis', 'Female', '2000-07-05', '3216549870');

-- Appointment table
INSERT INTO Appointment (appointment_id, patient_id, doctor_name, appointment_date, department, status)
VALUES 
    (1, 1, 'Dr. Smith', '2025-04-01', 'Cardiology', 'Completed'),
    (2, 2, 'Dr. Adams', '2025-04-02', 'Neurology', 'Pending'),
    (3, 3, 'Dr. Smith', '2025-04-03', 'ENT', 'Completed'),
    (4, 4, 'Dr. Brown', '2025-04-04', 'Orthopedics', 'Cancelled'),
    (5, 5, 'Dr. Adams', '2025-04-05', 'Cardiology', 'Completed');

--4.Update the department of an appointment where appointment_id = 2 to 'Neurology'.
UPDATE Appointment
SET department = 'Neurology'
WHERE appointment_id = 2;

--5.Delete the patient whose name = 'John Doe'.
-- Deleteappointments for the patient
DELETE FROM Appointment
WHERE patient_id = 1;

-- Now delete the patient
DELETE FROM Patient
WHERE patient_id = 1;

--6.Retrieve all patient names along with their appointment date and doctor name.
SELECT p.name AS patient_name,a.appointment_date,a.doctor_name
FROM Patient p
JOIN  Appointment a
ON p.patient_id = a.patient_id;

--7.List all patients who have appointments in the 'Cardiology' department.
SELECT  p.name AS patient_name
FROM Patient p
JOIN  Appointment a
ON p.patient_id = a.patient_id
WHERE a.department = 'Cardiology';

--8.Get patient details who have an appointment with doctor 'Dr. Smith':
SELECT  p.*
FROM Patient p
JOIN  Appointment a
ON p.patient_id = a.patient_id
WHERE a.doctor_name = 'Dr. Smith';

--9.Display appointment details where the patient's age is greater than 60:
SELECT a.*
FROM  Appointment a
JOIN Patient p
ON  a.patient_id = p.patient_id
WHERE (p.date_of_birth) > 60;

--10.Find patients who have more than one appointment (use GROUP BY and HAVING).
SELECT p.name AS patient_name,
COUNT(a.appointment_id) AS appointment_count
FROM Patient p
JOIN Appointment a
ON p.patient_id = a.patient_id
GROUP BY p.name
HAVING COUNT(a.appointment_id) > 1;

--11.Find the patient(s) who have the most number of appointments.
SELECT p.name AS patient_name,
COUNT(a.appointment_id) AS appointment_count
FROM Patient p
JOIN Appointment a
ON  p.patient_id = a.patient_id
GROUP BY  p.name
HAVING  COUNT

--12.List patients who do not have any appointments.
SELECT  p.name AS patient_name
FROM Patient p
LEFT JOIN Appointment a
ON p.patient_id = a.patient_id
WHERE a.appointment_id IS NULL;

--13.Show the name and age of all patients (calculate age from date_of_birth).
SELECT name AS patient_name,
FROM Patient;

--14.List appointments made in the last 30 days from today’s date.
SELECT *
FROM Appointment
WHERE appointment_date >= CURRENT_DATE - INTERVAL '30 days';

--15.Count the number of appointments per department:
SELECT  department,
COUNT(appointment_id) AS appointment_count
FROM Appointment
GROUP BY department;

--1.Find the name(s) of patient(s) who have taken appointments in all departments
--available in the Appointment table.
SELECT p.name AS patient_name
FROM  Patient p
JOIN Appointment a
ON p.patient_id = a.patient_id
GROUP BY p.name
HAVING COUNT(DISTINCT a.department) = (SELECT COUNT(DISTINCT department) FROM Appointment);

--2.Retrieve the patient(s) who had their first-ever appointment with doctor 'Dr. Smith':
SELECT p.name AS patient_name,
MIN(a.appointment_date) AS first_appointment_date
FROM  Patient p
JOIN Appointment a
ON p.patient_id = a.patient_id
WHERE a.doctor_name = 'Dr. Smith'
GROUP BY p.name;

--3.Find the doctors who have consulted at least 3 different patients
-- across more than one department.
SELECT doctor_name
FROM Appointment
GROUP BY doctor_name
HAVING COUNT(DISTINCT patient_id) >= 3 AND COUNT(DISTINCT department) > 1;

--4.Identify patients who had appointments in the last week of each month for the past 3 months.
SELECT p.name AS patient_name,
a.appointment_date
FROM Patient p
JOIN Appointment a
ON p.patient_id = a.patient_id
WHERE
	
	
--5.List the top 3 patients who have had the highest number of appointments.

SELECT p.name AS patient_name,
COUNT(a.appointment_id) AS appointment_count
FROM Patient p
JOIN Appointment a
ON a.patient_id = p.patient_id
GROUP BY p.name
ORDER BY appointment_count DESC
LIMIT 3;



select * from patient;
	select * from Appointment;