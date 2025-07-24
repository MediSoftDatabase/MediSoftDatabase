-- USER table
CREATE TABLE USER (
    UserID NUMBER PRIMARY KEY,
    UserName VARCHAR2(50) NOT NULL,
    Password VARCHAR2(50) NOT NULL,
    Role VARCHAR2(20) CHECK (Role IN ('Doctor', 'Nurse', 'Pharmacist'))
);

-- PATIENT table
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

-- MEDICAL_RECORD table
CREATE TABLE MEDICAL_RECORD (
    MedicalRecordID NUMBER PRIMARY KEY,
    PatientID NUMBER REFERENCES PATIENT(PatientID),
    LabTestResultID NUMBER,
    NoAppointmentsHad NUMBER,
    Diagnosis VARCHAR2(500),
    Notes VARCHAR2(500)
);

-- LAB_TEST_RESULT table
CREATE TABLE LAB_TEST_RESULT (
    LabTestResultID NUMBER PRIMARY KEY,
    MedicalRecordID NUMBER REFERENCES MEDICAL_RECORD(MedicalRecordID),
    Diagnosis VARCHAR2(500),
    Notes VARCHAR2(500)
);

-- APPOINTMENT table
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

-- BILLING table
CREATE TABLE BILLING (
    BillingID NUMBER PRIMARY KEY,
    AppointmentID NUMBER REFERENCES APPOINTMENT(AppointmentID),
    PaymentAmount NUMBER(10,2),
    PaymentStatus VARCHAR2(20) CHECK (PaymentStatus IN ('Paid', 'Unpaid', 'Pending')),
    PaymentDate DATE,
    PaymentMethod VARCHAR2(30)
);

-- PRESCRIPTION table
CREATE TABLE PRESCRIPTION (
    PrescriptionID NUMBER PRIMARY KEY,
    UserID NUMBER REFERENCES USER(UserID),
    AppointmentID NUMBER REFERENCES APPOINTMENT(AppointmentID),
    MedicationName VARCHAR2(100),
    Dosage VARCHAR2(50),
    Duration VARCHAR2(50),
    IssuedDate DATE
);

-- PHARMACIST table
CREATE TABLE PHARMACIST (
    UserID NUMBER PRIMARY KEY REFERENCES USER(UserID),
    FullName VARCHAR2(100),
    CellphoneNumber VARCHAR2(20),
    EmailAddress VARCHAR2(100)
);

-- DOCTOR table
CREATE TABLE DOCTOR (
    UserID NUMBER PRIMARY KEY REFERENCES USER(UserID),
    FullName VARCHAR2(100),
    Specialization VARCHAR2(100),
    CellphoneNumber VARCHAR2(20),
    EmailAddress VARCHAR2(100),
    AppointmentsCompleted NUMBER
);

-- NURSE table
CREATE TABLE NURSE (
    UserID NUMBER PRIMARY KEY REFERENCES USER(UserID),
    DoctorID NUMBER REFERENCES DOCTOR(UserID),
    FullName VARCHAR2(100),
    CellphoneNumber VARCHAR2(20),
    EmailAddress VARCHAR2(100),
    AssignedWard VARCHAR2(50)
);
