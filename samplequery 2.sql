-- 1. List all appointments for a specific patient
SELECT * FROM APPOINTMENT WHERE PatientID = 101;

-- 2. Show unpaid bills
SELECT * FROM BILLING WHERE PaymentStatus = 'Pending';

-- 3. Prescriptions issued by a doctor
SELECT * FROM PRESCRIPTION WHERE UserID = 1;

-- 4. Lab test results of a patient
SELECT * FROM LAB_TEST_RESULT WHERE MedicalRecordID = 201;

-- 5. Doctors with more than 10 completed appointments
SELECT * FROM DOCTOR WHERE AppointmentsCompleted > 10;
