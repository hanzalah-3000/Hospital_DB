CREATE TABLE Ward (
    WardNumber INTEGER PRIMARY KEY,
    WardName VARCHAR,
    Location VARCHAR,
    TotalBeds INTEGER,
    TelephoneExtension INTEGER
);

CREATE TABLE Contract (
    ContractID INTEGER PRIMARY KEY,
    PositionHeld VARCHAR,
    CurrentSalary INTEGER,
    SalaryScale INTEGER,
    ContractType VARCHAR,
    HoursPerWeek INTEGER,
    WardNumber INTEGER REFERENCES Ward(WardNumber)
);

CREATE TABLE Staff (
    StaffNumber INTEGER PRIMARY KEY,
    FirstName VARCHAR,
    LastName VARCHAR,
    Address VARCHAR,
    PhoneNumber INTEGER,
    DateOfBirth DATE,
    Sex VARCHAR,
    NationalInsuranceNumber INTEGER,
    ContractID INTEGER REFERENCES Contract(ContractID)   
);

CREATE TABLE Qualification (
    QualificationID INTEGER PRIMARY KEY,
    DateOfQualification DATE,
    Type VARCHAR,
    Institution VARCHAR,
    StaffNumber INTEGER REFERENCES Staff(StaffNumber)
);

CREATE TABLE WorkExperience (
    WorkExperienceID INTEGER PRIMARY KEY,
    OrganizationName VARCHAR,
    Position VARCHAR,
    StartDate DATE,
    FinishDate DATE,
    StaffNumber INTEGER REFERENCES Staff(StaffNumber)
);

CREATE TABLE NextOfKin (
    NextOfKinID INTEGER PRIMARY KEY,
    FullName VARCHAR,
    Relationship VARCHAR,
    Address VARCHAR,
    PhoneNumber INTEGER
);

CREATE TABLE LocalDoctor (
    ClinicNumber INTEGER PRIMARY KEY,
    FullName VARCHAR,
    Address VARCHAR,
    PhoneNumber INTEGER
);

CREATE TABLE Patients (
    PatientNumber INTEGER PRIMARY KEY,
    FirstName VARCHAR,
    LastName VARCHAR,
    Address VARCHAR,
    PhoneNumber INTEGER,
    DateOfBirth DATE,
    Sex VARCHAR,
    MaritalStatus VARCHAR,
    RegistrationDate DATE,
    NextOfKinID INTEGER REFERENCES NextOfKin(NextOfKinID),
    ClinicNumber INTEGER REFERENCES LocalDoctor(ClinicNumber)
);

CREATE TABLE Appointment (
    AppointmentNumber INTEGER PRIMARY KEY,
    AppointmentDate DATE,
    AppointmentTime TIME,
    ExaminationRoom VARCHAR,
    WardRecommended INTEGER REFERENCES Ward(WardNumber),
    PatientNumber INTEGER REFERENCES Patients(PatientNumber),
    ConsultantStaffID INTEGER REFERENCES Staff(StaffNumber)
);

CREATE TABLE WaitingList (
    WaitingID INTEGER PRIMARY KEY,
    InPatientNumber INTEGER REFERENCES Patients(PatientNumber),
    RequiredWard INTEGER REFERENCES Ward(WardNumber),
    DatePlacedInList DATE,
    ExpectedStay VARCHAR
);

CREATE TABLE AdmissionList (
    AdmissionID INTEGER PRIMARY KEY,
    InPatientNumber INTEGER REFERENCES Patients(PatientNumber),
    WardNumber INTEGER REFERENCES Ward(WardNumber),
    DatePlacedInWard DATE,
    ExpectedDateToLeave DATE,
    ActualDateToLeave DATE,
    BedNumber INTEGER
);

CREATE TABLE OutPatientRecord (
    RecordID INTEGER PRIMARY KEY,
    AppointmentDate DATE,
    AppointmentTime TIME,
    PatientNumber INTEGER REFERENCES Patients(PatientNumber)
);

CREATE TABLE Supplier (
    SupplierNumber INTEGER PRIMARY KEY,
    Name VARCHAR,
    Address VARCHAR,
    Telephone INTEGER,
    FaxNumber INTEGER
);

CREATE TABLE Surgical_NonSurgicalSupplies (
    ItemNumber INTEGER PRIMARY KEY,
    ItemName VARCHAR,
    ItemDescription VARCHAR,
    QuantityInStock INTEGER,
    ReorderLevel INTEGER,
    CostPerUnit INTEGER,
    SupplierNumber INTEGER REFERENCES Supplier(SupplierNumber)
);

CREATE TABLE PharmaceuticalSupplies (
    DrugNumber INTEGER PRIMARY KEY,
    DrugName VARCHAR,
    Description VARCHAR,
    Dosage VARCHAR,
    MethodOfAdministration VARCHAR,
    QuantityInStock INTEGER,
    ReorderLevel INTEGER,
    CostPerUnit INTEGER,
    SupplierNumber INTEGER REFERENCES Supplier(SupplierNumber)
);

CREATE TABLE PatientMedication (
    MedicationID INTEGER PRIMARY KEY,
    PatientNumber INTEGER REFERENCES Patients(PatientNumber),
    DrugNumber INTEGER REFERENCES PharmaceuticalSupplies(DrugNumber),
    StartDate DATE,
    FinishDate DATE
);

CREATE TABLE WardRequisition (
    RequisitionNumber INTEGER PRIMARY KEY,
    ChargeNurseID INTEGER REFERENCES Staff(StaffNumber),
    WardNumber INTEGER REFERENCES Ward(WardNumber),
    ItemNumber INTEGER REFERENCES Surgical_NonSurgicalSupplies(ItemNumber),
    DrugNumber INTEGER REFERENCES PharmaceuticalSupplies(DrugNumber),
    QuantityRequired INTEGER,
    DateOrdered DATE,
    DateDelivered DATE
);
