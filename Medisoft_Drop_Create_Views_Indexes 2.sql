
-- ===========================
-- Drop Existing Views (if any)
-- ===========================
DROP VIEW ActiveAppointments;
DROP VIEW PrescriptionOverview;
DROP VIEW BillingSummary;
DROP VIEW LabTestResultsByPatient;

-- ===========================
-- Drop Existing Indexes (if any)
-- ===========================
DROP INDEX idx_appointment_date;
DROP INDEX idx_prescription_medication;
DROP INDEX idx_billing_status;
DROP INDEX idx_patient_email;
DROP INDEX idx_doctor_specialization;

-- ===========================
-- Recreate Views for Medisoft
-- ===========================

-- View: Active Appointments with Patient & Doctor Info
CREATE OR REPLACE VIEW ActiveAppointments AS
SELECT 
    A.AppointmentID,
    P.FullName AS PatientName,
    D.FullName AS DoctorName,
    A.AppointmentType,
    A.DateAndTime,
    A.Status
FROM APPOINTMENT A
JOIN PATIENT P ON A.PatientID = P.PatientID
JOIN DOCTOR D ON A.UserID = D.UserID
WHERE A.Status = 'Scheduled';

-- View: Prescription Details With Pharmacist and Doctor
CREATE OR REPLACE VIEW PrescriptionOverview AS
SELECT 
    PR.PrescriptionID,
    P.FullName AS PatientName,
    D.FullName AS DoctorName,
    PR.MedicationName,
    PR.Dosage,
    PR.Duration,
    PR.IssuedDate
FROM PRESCRIPTION PR
JOIN APPOINTMENT A ON PR.AppointmentID = A.AppointmentID
JOIN PATIENT P ON A.PatientID = P.PatientID
JOIN DOCTOR D ON PR.UserID = D.UserID;

-- View: Billing Summary
CREATE OR REPLACE VIEW BillingSummary AS
SELECT 
    B.BillingID,
    P.FullName AS PatientName,
    B.PaymentAmount,
    B.PaymentStatus,
    B.PaymentMethod,
    B.PaymentDate
FROM BILLING B
JOIN APPOINTMENT A ON B.AppointmentID = A.AppointmentID
JOIN PATIENT P ON A.PatientID = P.PatientID;

-- View: Lab Test Results by Patient
CREATE OR REPLACE VIEW LabTestResultsByPatient AS
SELECT 
    P.FullName AS PatientName,
    L.Diagnosis,
    L.Notes
FROM LAB_TEST_RESULT L
JOIN MEDICAL_RECORD M ON L.MedicalRecordID = M.MedicalRecordID
JOIN PATIENT P ON M.PatientID = P.PatientID;

-- ===========================
-- Recreate Indexes for Medisoft
-- ===========================

-- Index on Appointment Date
CREATE INDEX idx_appointment_date
ON APPOINTMENT(DateAndTime);

-- Index on Prescription Medication Name
CREATE INDEX idx_prescription_medication
ON PRESCRIPTION(MedicationName);

-- Index on Billing Payment Status
CREATE INDEX idx_billing_status
ON BILLING(PaymentStatus);

-- Index on Patient Email Address
CREATE INDEX idx_patient_email
ON PATIENT(EmailAddress);

-- Index on Doctor Specialization
CREATE INDEX idx_doctor_specialization
ON DOCTOR(Specialization);
