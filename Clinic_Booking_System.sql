-- Clinic Booking System Database
-- MySQL script to create tables with constraints and relationships

-- Ensure the database uses InnoDB for foreign key support
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS DoctorSpecializations, Appointments, Doctor, Patients, Clinics, Specializations;
SET FOREIGN_KEY_CHECKS = 1;

-- Create Clinics table
CREATE TABLE Clinics (
    ClinicID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    Phone VARCHAR(20) NOT NULL
) ENGINE=InnoDB;

-- Create Patients table
CREATE TABLE Patients (
    PatientID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Phone VARCHAR(20) NOT NULL,
    DateOfBirth DATE NOT NULL
) ENGINE=InnoDB;

-- Create Doctors table
CREATE TABLE Doctors (
    DoctorID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Phone VARCHAR(20) NOT NULL,
    ClinicID INT NOT NULL,
    FOREIGN KEY (ClinicID) REFERENCES Clinics(ClinicID) ON DELETE RESTRICT
) ENGINE=InnoDB;

-- Create Specializations table
CREATE TABLE Specializations (
    SpecializationID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL UNIQUE
) ENGINE=InnoDB;

-- Create DoctorSpecializations junction table (Many-to-Many)
CREATE TABLE DoctorSpecializations (
    DoctorID INT NOT NULL,
    SpecializationID INT NOT NULL,
    PRIMARY KEY (DoctorID, SpecializationID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID) ON DELETE CASCADE,
    FOREIGN KEY (SpecializationID) REFERENCES Specializations(SpecializationID) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Create Appointments table
CREATE TABLE Appointments (
    AppointmentID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    ClinicID INT NOT NULL,
    AppointmentDateTime DATETIME NOT NULL,
    Status ENUM('Scheduled', 'Completed', 'Cancelled') NOT NULL DEFAULT 'Scheduled',
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID) ON DELETE RESTRICT,
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID) ON DELETE RESTRICT,
    FOREIGN KEY (ClinicID) REFERENCES Clinics(ClinicID) ON DELETE RESTRICT
) ENGINE=InnoDB;
