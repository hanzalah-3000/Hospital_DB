--a 
INSERT INTO Contract VALUES
(1036, 'Nurse', 15000, 3, 'Temporary', 40,null);
INSERT INTO Staff VALUES
(10036, 'Denzel', 'Creed', '524 Halley St', 31458367, '1975-02-15', 'Male', 123036, 1036);
INSERT INTO Qualification VALUES
(6038, '2017-05-15', 'Bachelor of Science in Nursing', 'Harvard University', 10036);
INSERT INTO WorkExperience VALUES
(6121, 'Medicare Hospital', 'Junior Nurse', '2019-05-15', '2020-09-22', 10036);

INSERT INTO Contract VALUES
(1037, 'Janitor', 10000, 2, 'Temporary', 42,null);
INSERT INTO Staff VALUES
(10037, 'Hailey', 'Watson', '994 Eden St', 31458367, '1991-12-25', 'Female', 123037, 1037);

UPDATE Contract
SET WardNumber= 2007
WHERE ContractID IN
(SELECT ContractID
FROM Staff
WHERE FirstName='Denzel' AND LastName='Creed');

UPDATE Contract
SET CurrentSalary= 20000,SalaryScale=3
WHERE ContractID IN
(SELECT ContractID
FROM Staff
WHERE FirstName='Hailey' AND LastName='Watson');

-- b
SELECT *
FROM Staff 
WHERE StaffNumber
IN
(SELECT StaffNumber
FROM Qualification
WHERE Type='Bachelor of Medicine'
UNION
SELECT StaffNumber
FROM WorkExperience);

-- c
SELECT Ward.WardNumber,Ward.WardName,Staff.*
FROM Ward 
LEFT JOIN Contract 
LEFT JOIN Staff
ON Contract.ContractID= Staff.ContractID
ON Contract.WardNumber = Ward.WardNumber;

-- f
SELECT * 
FROM Patients
WHERE PatientNumber
IN
(SELECT Appointment.PatientNumber
FROM Appointment
LEFT JOIN Ward
ON Appointment.WardRecommended=Ward.WardNumber
WHERE Ward.WardName='Out Patient Clinic');

-- h
SELECT * 
FROM Patients
WHERE PatientNumber
IN
(SELECT AdmissionList.InPatientNumber
FROM AdmissionList
LEFT JOIN Ward
ON AdmissionList.WardNumber=Ward.WardNumber
WHERE Ward.WardName='Psychiatry' AND AdmissionList.ActualDateToLeave IS null);

-- i
SELECT * 
FROM Patients
WHERE PatientNumber
IN
(SELECT WaitingList.InPatientNumber
FROM WaitingList
LEFT JOIN Ward
ON WaitingList.RequiredWard=Ward.WardNumber
WHERE Ward.WardName='Psychiatry');

-- j
INSERT INTO PatientMedication VALUES
(9530, 5022, 4012, '2023-09-01', '2023-09-03'),
(9531, 5022, 4013, '2023-09-01', '2023-09-03'),
(9532, 5022, 4014, '2023-09-01', '2023-09-03');

UPDATE PatientMedication
SET FinishDate='2023-09-05'
WHERE MedicationID= 9532;

-- k
SELECT PatientMedication.MedicationID,PatientMedication.StartDate,PatientMedication.FinishDate,PharmaceuticalSupplies.DrugName
FROM PatientMedication 
INNER JOIN Patients 
ON PatientMedication.PatientNumber = Patients.PatientNumber
INNER JOIN PharmaceuticalSupplies 
ON PatientMedication.DrugNumber = PharmaceuticalSupplies.DrugNumber
WHERE Patients.FirstName = 'Selena' AND Patients.LastName='Rodriguez';

-- m
INSERT INTO WardRequisition VALUES
(9616, 10013, 2008, 3004, null, 50, '2023-09-20', '2023-09-21'),
(9617, 10013, 2008, 3007, null, 50, '2023-09-20', '2023-09-21'),
(9618, 10013, 2008, null, 4011, 50, '2023-09-21', null),
(9619, 10013, 2008, null, 4015, 50, '2023-09-22', null),
(9620, 10016, 2009, null, 4007, 50, '2023-09-28', '2023-09-29'),
(9621, 10016, 2009, 3001, null, 50, '2023-09-29', '2023-09-30');

UPDATE WardRequisition
SET DateDelivered='2023-10-01'
WHERE RequisitionNumber in (9618,9619);

-- n
SELECT WardRequisition.RequisitionNumber, Surgical_NonSurgicalSupplies.ItemName,PharmaceuticalSupplies.DrugName,WardRequisition.QuantityRequired,WardRequisition.DateOrdered,WardRequisition.DateDelivered
FROM WardRequisition 
INNER JOIN Ward  
ON WardRequisition.WardNumber = Ward.WardNumber
LEFT JOIN Surgical_NonSurgicalSupplies 
ON WardRequisition.ItemNumber = Surgical_NonSurgicalSupplies.ItemNumber
LEFT JOIN PharmaceuticalSupplies  
ON WardRequisition.DrugNumber = PharmaceuticalSupplies.DrugNumber
WHERE Ward.WardName = 'Intensive Care';