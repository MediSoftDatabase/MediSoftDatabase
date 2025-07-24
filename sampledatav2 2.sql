DROP TABLE PRESCRIPTION CASCADE CONSTRAINTS;
DROP TABLE LAB_TEST_RESULT CASCADE CONSTRAINTS;
DROP TABLE MEDICAL_RECORD CASCADE CONSTRAINTS;
DROP TABLE BILLING CASCADE CONSTRAINTS;
DROP TABLE APPOINTMENT CASCADE CONSTRAINTS;
DROP TABLE PHARMACIST CASCADE CONSTRAINTS;
DROP TABLE NURSE CASCADE CONSTRAINTS;
DROP TABLE DOCTOR CASCADE CONSTRAINTS;
DROP TABLE PATIENT CASCADE CONSTRAINTS;
DROP TABLE USER CASCADE CONSTRAINTS;

DROP SEQUENCE user_seq;
DROP SEQUENCE patient_seq;
DROP SEQUENCE appointment_seq;
DROP SEQUENCE billing_seq;
DROP SEQUENCE prescription_seq;
DROP SEQUENCE medical_record_seq;
DROP SEQUENCE lab_test_result_seq;

--USER table--
CREATE TABLE USER (
    UserID NUMBER PRIMARY KEY,
    UserName VARCHAR2(50) NOT NULL,
    Password VARCHAR2(50) NOT NULL,
    Role VARCHAR2(20) CHECK (Role IN ('Doctor', 'Nurse', 'Pharmacist'))
);
--PATIENT table --
CREATE TABLE PATIENT (
    PatientID NUMBER PRIMARY KEY,
    MedicalRecordID NUMBER,
    FullName VARCHAR2(100),
    DOB DATE,
    Gender VARCHAR2(10) CHECK (Gender IN ('Male', 'Female', 'Other')),
    CellphoneNumber VARCHAR2(20),
    EmailAddress VARCHAR2(100),
    Address VARCHAR2(200),
    NextOfKin VARCHAR2(100),
    BloodType VARCHAR2(3) CHECK (BloodType IN ('A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'))
);

-- MEDICAL_RECORD table --
CREATE TABLE MEDICAL_RECORD (
    MedicalRecordID NUMBER PRIMARY KEY,
    PatientID NUMBER REFERENCES PATIENT(PatientID),
    LabTestResultID NUMBER,
    NoAppointmentsHad NUMBER,
    Diagnosis VARCHAR2(500),
    Notes VARCHAR2(500)
);

-- LAB_TEST_RESULT table --
CREATE TABLE LAB_TEST_RESULT (
    LabTestResultID NUMBER PRIMARY KEY,
    MedicalRecordID NUMBER REFERENCES MEDICAL_RECORD(MedicalRecordID),
    Diagnosis VARCHAR2(500),
    Notes VARCHAR2(500)
);

-- APPOINTMENT table--
CREATE TABLE APPOINTMENT (
    AppointmentID NUMBER PRIMARY KEY,
    PatientID NUMBER REFERENCES PATIENT(PatientID),
    UserID NUMBER REFERENCES USER(UserID),
    BillingID NUMBER,
    AppointmentType VARCHAR2(50),
    DateAndTime TIMESTAMP,
    Status VARCHAR2(20),
    Notes VARCHAR2(500)
);

-- BILLING table--
CREATE TABLE BILLING (
    BillingID NUMBER PRIMARY KEY,
    AppointmentID NUMBER REFERENCES APPOINTMENT(AppointmentID),
    PaymentAmount NUMBER(10,2),
    PaymentStatus VARCHAR2(20) CHECK (PaymentStatus IN ('Paid', 'Unpaid', 'Pending')),
    PaymentDate DATE,
    PaymentMethod VARCHAR2(30)
);

-- PRESCRIPTION table--
CREATE TABLE PRESCRIPTION (
    PrescriptionID NUMBER PRIMARY KEY,
    UserID NUMBER REFERENCES USER(UserID),
    AppointmentID NUMBER REFERENCES APPOINTMENT(AppointmentID),
    MedicationName VARCHAR2(100),
    Dosage VARCHAR2(50),
    Duration VARCHAR2(50),
    IssuedDate DATE
);

-- PHARMACIST table--
CREATE TABLE PHARMACIST (
    UserID NUMBER PRIMARY KEY REFERENCES USER(UserID),
    FullName VARCHAR2(100),
    CellphoneNumber VARCHAR2(20),
    EmailAddress VARCHAR2(100)
);

-- DOCTOR table--
CREATE TABLE DOCTOR (
    UserID NUMBER PRIMARY KEY REFERENCES USER(UserID),
    FullName VARCHAR2(100),
    Specialization VARCHAR2(100),
    CellphoneNumber VARCHAR2(20),
    EmailAddress VARCHAR2(100),
    AppointmentsCompleted NUMBER
);

-- NURSE table--
CREATE TABLE NURSE (
    UserID NUMBER PRIMARY KEY REFERENCES USER(UserID),
    DoctorID NUMBER REFERENCES DOCTOR(UserID),
    FullName VARCHAR2(100),
    CellphoneNumber VARCHAR2(20),
    EmailAddress VARCHAR2(100),
    AssignedWard VARCHAR2(50)
);

-- Insert into USER
INSERT INTO "USER" VALUES (4, 'nurse_annie', 'nurse123', 'Nurse');
INSERT INTO "USER" VALUES (5, 'pharm_sam', 'pharma456', 'Pharmacist');
INSERT INTO "USER" VALUES (6, 'dr_brown', 'doc789', 'Doctor');
INSERT INTO "USER" VALUES (7, 'dr_jane', 'admin123', 'Doctor');
INSERT INTO "USER" VALUES (8, 'dr_lee', 'doclee88', 'Doctor');

CREATE SEQUENCE patient_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE billing_seq START WITH 1 INCREMENT BY 1;

-- Insert into PATIENT
INSERT INTO PATIENT VALUES (patient_seq.NEXTVAL, 2, 'James Smith', DATE '1990-03-15', 'Male', '0721123456', 'james.smith@gmail.com', '123 Main Street', 'Sarah Smith', 'B+');
INSERT INTO PATIENT VALUES (7, 3, 'Anna Bell', DATE '1985-07-22', 'Female', '0742233445', 'anna.bell@gmail.com', '456 Queen Ave', 'Tom Bell', 'O-');
INSERT INTO PATIENT VALUES (8, 4, 'Mark Lee', DATE '1995-10-12', 'Male', '0719876543', 'mark.lee@gmail.com', '789 King Rd', 'Sue Lee', 'AB+');
INSERT INTO PATIENT VALUES (9, 5, 'Cindy Jacobs', DATE '2000-01-08', 'Female', '0793322114', 'cindy.j@gmail.com', '22 River St', 'Ken Jacobs', 'A+');
INSERT INTO PATIENT VALUES (10, 6, 'George White', DATE '1988-12-30', 'Male', '0736655432', 'g.white@gmail.com', '88 Ocean View', 'Laura White', 'O+');

-- Insert into MEDICAL_RECORD
INSERT INTO MEDICAL_RECORD VALUES (2, 2, 2, 1, 'Flu and mild fever', 'Patient recovering well');
INSERT INTO MEDICAL_RECORD VALUES (3, 3, 3, 1, 'High cholesterol', 'Diet plan advised');
INSERT INTO MEDICAL_RECORD VALUES (4, 4, 4, 2, 'Allergic rhinitis', 'Prescribed antihistamines');
INSERT INTO MEDICAL_RECORD VALUES (5, 5, 5, 2, 'Migraine history', 'Monitored for progress');
INSERT INTO MEDICAL_RECORD VALUES (6, 6, 6, 3, 'Post-surgical care', 'Healing well');

-- Insert into APPOINTMENT
INSERT INTO APPOINTMENT VALUES (2, 2, 6, 2, 'Checkup', TO_TIMESTAMP('2025-05-15 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Completed', 'Routine yearly checkup');
INSERT INTO APPOINTMENT VALUES (4, 3, 4, 3, 'Consultation', TO_TIMESTAMP('2025-05-16 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'Scheduled', 'Dietary advice');
INSERT INTO APPOINTMENT VALUES (5, 4, 3, 4, 'Follow-up', TO_TIMESTAMP('2025-05-17 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Completed', 'Allergy check');
INSERT INTO APPOINTMENT VALUES (6, 5, 5, 5, 'Neurology', TO_TIMESTAMP('2025-05-18 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Scheduled', 'Migraine assessment');
INSERT INTO APPOINTMENT VALUES (7, 6, 2, 6, 'Post-op', TO_TIMESTAMP('2025-05-19 08:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'Completed', 'Stitch removal');

-- Insert into BILLING
INSERT INTO BILLING VALUES (2, 2, 500.00, 'Paid', DATE '2025-05-15', 'Cash');
INSERT INTO BILLING VALUES (3, 3, 300.00, 'Pending', NULL, 'Card');
INSERT INTO BILLING VALUES (4, 401, 450.00, 'Paid', DATE '2025-05-17', 'EFT');
INSERT INTO BILLING VALUES (5, 402, 700.00, 'Pending', NULL, 'Medical Aid');
INSERT INTO BILLING VALUES (6, 4, 850.00, 'Paid', DATE '2025-05-19', 'Card');

-- Insert into PRESCRIPTION
INSERT INTO PRESCRIPTION VALUES (1, 6, 2, 'Paracetamol', '500mg', '5 days', DATE '2025-05-15');
INSERT INTO PRESCRIPTION VALUES (2, 6, 3, 'Atorvastatin', '10mg', '30 days', DATE '2025-05-16');
INSERT INTO PRESCRIPTION VALUES (3, 6, 4, 'Loratadine', '10mg', '7 days', DATE '2025-05-17');
INSERT INTO PRESCRIPTION VALUES (4, 6, 5, 'Sumatriptan', '50mg', '10 days', DATE '2025-05-18');
INSERT INTO PRESCRIPTION VALUES (5, 8, 6, 'Ibuprofen', '400mg', '3 days', DATE '2025-05-19');

-- Insert into PHARMACIST
INSERT INTO PHARMACIST VALUES (1, 'Devine Shakes', '0831562223', 'devine.shakes@medisoft.com');

-- Insert into DOCTOR
INSERT INTO DOCTOR VALUES (2, 'Dr. John Brown', 'General Physician', '0763456789', 'john.brown@medisoft.com', 115);
INSERT INTO DOCTOR VALUES (3, 'Dr. Lee Chan', 'Surgeon', '0737896543', 'lee.chan@medisoft.com', 80);

-- Insert into NURSE
INSERT INTO NURSE VALUES (4, 2, 'Annie Jacobs', '0783456721', 'annie.j@medisoft.com', 'Ward B');
INSERT INTO NURSE VALUES (9, 3, 'Sandra McShane', '0744567832', 'jane.mcshane@medisoft.com', 'Ward B');

INSERT INTO "USER" VALUES (9, 'nurse_sandra', 'sandra123', 'Nurse');

-- 1. List all patients with their assigned doctor and appointment date x
SELECT P.FullName AS PatientName, D.FullName AS DoctorName, A.DateAndTime
FROM PATIENT P
JOIN APPOINTMENT A ON P.PatientID = A.PatientID
JOIN DOCTOR D ON A.UserID = D.UserID;

-- 2. View unpaid bills with patient names X
SELECT P.FullName, B.PaymentAmount, B.PaymentStatus
FROM BILLING B
JOIN APPOINTMENT A ON B.AppointmentID = A.AppointmentID
JOIN PATIENT P ON A.PatientID = P.PatientID;


-- 3. List all prescriptions for a specific patient
SELECT P.FirstName, P.LastName AS FullName, R.MedicationName, R.Dosage, R.IssuedDate
FROM PRESCRIPTION R
JOIN PATIENT P ON P.PatientID = R.PatientID
WHERE P.FirstName = 'Mark' AND P.LastName = 'Lee';


-- 4. View lab test results for each patient x
SELECT P.FullName, L.Diagnosis, L.Notes
FROM LAB_TEST_RESULT L
JOIN MEDICAL_RECORD M ON L.MedicalRecordID = M.MedicalRecordID
JOIN PATIENT P ON M.PatientID = P.PatientID;

-- 1. Show top 5 recent appointments x
SELECT * FROM (
  SELECT * FROM APPOINTMENT
  ORDER BY DateAndTime DESC
)
WHERE ROWNUM <= 5;


-- 2. Show only names and blood type of 10 patients x
SELECT FullName, BloodType
FROM (
    SELECT FullName, BloodType
    FROM PATIENT
)
WHERE ROWNUM <= 10;


-- 3. List 3 most expensive payments x
SELECT PaymentAmount, PaymentMethod 
FROM (
    SELECT PaymentAmount, PaymentMethod 
    FROM BILLING
    ORDER BY PaymentAmount DESC
)
WHERE ROWNUM <= 3;


-- 4. Display doctor names and number of appointments completed x
SELECT FullName, AppointmentsCompleted
FROM (
    SELECT FullName, AppointmentsCompleted
    FROM DOCTOR
    ORDER BY AppointmentsCompleted DESC
)
WHERE ROWNUM <= 4;


-- 1. Sort patients by name x
SELECT FullName, DOB FROM PATIENT
ORDER BY FullName ASC;

-- 2. Sort doctors by specialization x
SELECT FullName, Specialization FROM DOCTOR
ORDER BY Specialization;

-- 3. Sort appointments by status x
SELECT * FROM APPOINTMENT
ORDER BY Status;

-- 4. Sort bills by amount descending x
SELECT * FROM BILLING
ORDER BY PaymentAmount DESC;

-- 1. Search patients by name x
SELECT * FROM PATIENT
WHERE FullName LIKE 'A%';

-- 2. Doctors with specialization in 'Cardiology' or 'Neurology' x
SELECT * FROM DOCTOR
WHERE Specialization = 'Surgeon' OR Specialization = 'General Physician';

-- 3. Patients born after 2000 and with blood type A+ x
SELECT * 
FROM PATIENT
WHERE DOB > TO_DATE('2000-01-01', 'YYYY-MM-DD') 
AND BloodType = 'A+';


-- 4. Appointments that are either 'Completed' or 'Cancelled' x
SELECT * FROM APPOINTMENT
WHERE Status = 'Completed' OR Status = 'Cancelled';


-- 1. Uppercase patient names x
SELECT UPPER(FullName) AS NameUpper FROM PATIENT;

-- 2. Show first 3 letters of each doctor’s name x
SELECT SUBSTR(FullName, 1, 3) AS Abbrev FROM DOCTOR;

-- 3. Count characters in patient address x
SELECT FullName, LENGTH(Address) AS AddressLength FROM PATIENT;

-- 4. Concatenate patient full name and email x
SELECT FullName || ' <' || EmailAddress || '>' AS Contact FROM PATIENT;

-- 1. Round payment amount to nearest 10 x
SELECT ROUND(PaymentAmount, -1) AS RoundedPayment FROM BILLING;

-- 2. Truncate to 1 decimal x
SELECT TRUNC(PaymentAmount, 1) AS TruncatedAmount FROM BILLING;

-- 3. Round dosage value xx
SELECT 
    CASE 
        WHEN REGEXP_LIKE(Dosage, '^\d+(\.\d+)?$') THEN ROUND(Dosage, 0)
        ELSE NULL
    END AS RoundedDosage
FROM PRESCRIPTION;

-- 4. Truncate duration to whole number xx
SELECT 
    CASE 
        WHEN REGEXP_LIKE(Duration, '^\d+(\.\d+)?$') THEN TRUNC(TO_NUMBER(Duration), 0)
        ELSE NULL  -- or some default value like 0 or 'N/A'
    END AS TruncatedDuration
FROM PRESCRIPTION;

--Date functions
-- 1. Get current date x
SELECT TRUNC(SYSDATE) AS Today FROM DUAL;

-- 2. Calculate patient age x
SELECT FullName, 
       FLOOR(MONTHS_BETWEEN(SYSDATE, DOB) / 12) AS Age 
FROM PATIENT;

-- 3. Appointments scheduled this week x
SELECT * 
FROM APPOINTMENT
WHERE TRUNC(DateAndTime, 'IW') = TRUNC(SYSDATE, 'IW');


-- 4. Days since payment made xx
SELECT PaymentDate, 
       TRUNC(SYSDATE - PaymentDate) AS DaysAgo
FROM BILLING;



--Aggregate functions
-- 1. Total number of patients X
SELECT COUNT(*) AS TotalPatients FROM PATIENT;

-- 2. Average payment amount X
SELECT AVG(PaymentAmount) FROM BILLING;

-- 3. Maximum dosage prescribed X
SELECT MAX(Dosage) FROM PRESCRIPTION;

-- 4. Minimum patient age x
SELECT MIN(TRUNC(MONTHS_BETWEEN(SYSDATE, DOB) / 12)) AS Youngest
FROM PATIENT;

--Group by and having
s


-- 2. Average payment per method x
SELECT PaymentMethod, AVG(PaymentAmount) AS AvgAmount
FROM BILLING
GROUP BY PaymentMethod;

-- 3. Doctors with more than 10 appointments xx
SELECT UserID AS DoctorID, COUNT(*) AS Appointments
FROM APPOINTMENT
GROUP BY UserID
HAVING COUNT(*) > 10;


-- 4. Prescriptions per medication X
SELECT MedicationName, COUNT(*) AS TimesPrescribed
FROM PRESCRIPTION
GROUP BY MedicationName;

--Joins
-- 1. Patient with their latest appointment date x
SELECT P.FullName, MAX(A.DateAndTime) AS LastAppointment
FROM PATIENT P
JOIN APPOINTMENT A ON P.PatientID = A.PatientID
GROUP BY P.FullName;

-- 2. Billing status with appointment and patient info x
SELECT P.FullName, A.DateAndTime, B.PaymentStatus
FROM BILLING B
JOIN APPOINTMENT A ON B.AppointmentID = A.AppointmentID
JOIN PATIENT P ON A.PatientID = P.PatientID;

-- 3. Prescription with doctor name x
SELECT PR.MedicationName, D.FullName AS Doctor
FROM PRESCRIPTION PR
JOIN DOCTOR D ON PR.UserID = D.UserID;

-- 4. Appointments handled by nurses X
SELECT N.FullName AS Nurse, D.FullName AS Doctor
FROM NURSE N
JOIN DOCTOR D ON N.DoctorID = D.UserID;

--Sub-queries
-- 1. Patients who have appointments x
SELECT FullName FROM PATIENT
WHERE PatientID IN (SELECT PatientID FROM APPOINTMENT);

-- 2. Doctors who prescribed 'Paracetamol' xx
SELECT FullName FROM DOCTOR
WHERE UserID IN (
    SELECT UserID FROM PRESCRIPTION WHERE MedicationName = 'Paracetamol'
);

-- 3. Appointments with unpaid billing xx
SELECT * FROM APPOINTMENT
WHERE AppointmentID IN (
    SELECT AppointmentID FROM BILLING WHERE PaymentStatus = 'Unpaid'
);

-- 4. Patients with lab results X
SELECT FullName 
FROM PATIENT
WHERE PatientID IN (
    SELECT PatientID 
    FROM MEDICAL_RECORD
    WHERE MedicalRecordID IN (
        SELECT MedicalRecordID 
        FROM LAB_TEST_RESULT
    )
);


