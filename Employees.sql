-- <EMPLOYEE SKILL MANAGEMENT AND PROJECT ALLOCATION SYSTEM>

-- Creating the Employees database
CREATE DATABASE Employees;

-- Use the Employees database
USE Employees; 

-- EMPLOYEE TABLE
-- Create the Employees table
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(50) NOT NULL,
    JobTitle VARCHAR(50) NOT NULL,
    Department VARCHAR(20) NOT NULL,
    ExperienceYears INT CHECK (ExperienceYears >= 0),
    Location VARCHAR(100) NOT NULL,
    Email VARCHAR(50) UNIQUE NOT NULL CHECK (Email REGEXP '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.com$'),
    PhoneNumber VARCHAR(10) UNIQUE NOT NULL CHECK (PhoneNumber REGEXP '^[0-9]{10}$')
);

-- Insert data into Employees
INSERT INTO Employees (Name, JobTitle, Department, ExperienceYears, Location, Email, PhoneNumber) VALUES
    ('Thanuja', 'Developer', 'Full Stack Java', 7, 'Pune', 'thanuja@gmail.com', '9123456789'),
    ('Davika', 'Developer', 'Full Stack Python', 8, 'Chennai', 'davika@gmail.com', '9876543210'),
    ('Vara Laxmi', 'Web Designer', 'HTML, CSS, JS', 6, 'Chennai', 'laxmi@gmail.com', '9333456789'),
    ('Vandana', 'Data Analyst', 'SQL', 2, 'Bangalore', 'vandana@gmail.com', '9999567893'),
    ('Shivarjun', 'Senior Software Engineer', 'Full Stack Java', 2, 'Bangalore', 'arjun@gmail.com', '9956565423'),
    ('Vinay', 'Developer', '.NET', 8, 'Mumbai', 'vinay@gmail.com', '9321657893'),
    ('Sanjay', 'AI/ML Research Scientist', 'C++', 1, 'Bangalore', 'sanjay@gmail.com', '9955415493'),
    ('Upender', 'Technical Program Manager', 'JavaScript', 5, 'Hyderabad', 'upender@gmail.com', '9357689421'),
    ('Madava', 'UI/UX Designer', 'HTML, CSS, JS', 2, 'Hyderabad', 'madhava@gmail.com', '9142357689'),
    ('Dharama Teja', 'Marketing Manager', 'Market Research', 4, 'Bangalore', 'teja@gmail.com', '9254678903'),
    ('Ananya', 'Data Scientist', 'SQL', 6, 'Mumbai', 'ananaya@gmail.com', '9000132456');

-- Select all records from Employees
SELECT * FROM Employees;

-- TABLE FOR STORING SKILLS
CREATE TABLE Skills ( 
    SkillID INT PRIMARY KEY AUTO_INCREMENT, 
    SkillName VARCHAR(50) NOT NULL 
);

-- Insert sample data into Skills table 
INSERT INTO Skills (SkillName) 
VALUES ('Full Stack Java'), ('Full Stack Python'), ('HTML, CSS, JS'), ('SQL'), ('C++'), ('.NET'), ('Project Management');

-- Select data from Skills
SELECT * FROM Skills;

-- JUNCTION TABLE TO STORE EMPLOYEE SKILLS (MANY-TO-MANY RELATIONSHIP) 
CREATE TABLE EmployeeSkills (
    EmployeeID INT, 
    SkillID INT, 
    ProficiencyLevel ENUM('Beginner', 'Intermediate', 'Advanced') NOT NULL, 
    PRIMARY KEY (EmployeeID, SkillID), 
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID) ON DELETE CASCADE, 
    FOREIGN KEY (SkillID) REFERENCES Skills(SkillID) ON DELETE CASCADE
);

-- INSERT SAMPLE DATA INTO EMPLOYEESKILLS TABLE 
INSERT INTO EmployeeSkills (EmployeeID, SkillID, ProficiencyLevel) 
VALUES
    (1, 1, 'Advanced'), 
    (2, 2, 'Advanced'), 
    (3, 3, 'Intermediate'), 
    (4, 4, 'Intermediate'), 
    (5, 1, 'Advanced'), 
    (6, 6, 'Advanced'), 
    (7, 5, 'Beginner'), 
    (8, 7, 'Advanced'), 
    (9, 3, 'Intermediate'), 
    (10, 7, 'Beginner'), 
    (11, 4, 'Advanced');

-- Select data from EmployeeSkills
SELECT * FROM EmployeeSkills;

-- TABLE FOR STORING PROJECT DETAILS 
CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY AUTO_INCREMENT,
    ProjectName VARCHAR(100) NOT NULL,
    Department VARCHAR(20) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE,
    Location VARCHAR(100) NOT NULL
);

-- INSERTING MORE SAMPLE DATA INTO THE PROJECTS TABLE 
INSERT INTO Projects (ProjectName, Department, StartDate, EndDate, Location)
VALUES
    ('Mobile Banking App', 'Software Development', '2024-09-20', '2025-03-30', 'Mumbai'),
    ('Cloud Migration Strategy', 'Cloud Infrastructure', '2024-11-01', NULL, 'Hyderabad'),
    ('Data Security Enhancement', 'Cybersecurity', '2024-09-01', '2024-12-15', 'Pune'),
    ('Machine Learning Fraud Detection', 'AI/ML', '2024-07-10', '2024-11-30', 'Bangalore'),
    ('Employee Performance Management System', 'HR Systems', '2024-05-05', '2024-09-15', 'Chennai'),
    ('E-commerce Analytics Dashboard', 'Data Science', '2024-06-01', '2024-10-10', 'Delhi'),
    ('IoT Smart Home System', 'IoT Development', '2024-08-20', '2025-01-20', 'Bangalore'),
    ('Blockchain-Based Supply Chain Management', 'Blockchain', '2024-10-05', '2025-04-30', 'Mumbai'),
    ('Real-time Stock Market Prediction', 'Data Science', '2024-07-01', '2024-12-20', 'Chennai'),
    ('Customer Relationship Management System', 'Software Development', '2024-08-15', NULL, 'Hyderabad');

-- Verify data in the Projects table
SELECT * FROM Projects;

-- TABLE FOR ALLOCATING EMPLOYEES TO PROJECTS 
CREATE TABLE ProjectAllocations (
    AllocationID INT PRIMARY KEY AUTO_INCREMENT, 
    ProjectID INT NOT NULL, 
    EmployeeID INT NOT NULL, 
    Role VARCHAR(50) NOT NULL, 
    AllocationDate DATE NOT NULL, 
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID) ON DELETE CASCADE, 
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID) ON DELETE CASCADE
);

-- INSERT SAMPLE DATA INTO THE PROJECTALLOCATIONS TABLE 
INSERT INTO ProjectAllocations (ProjectID, EmployeeID, Role, AllocationDate) 
VALUES 
    (4, 5, 'Senior Full Stack Developer', '2024-09-20'), 
    (5, 8, 'Cloud Architect', '2024-11-01'), 
    (6, 3, 'Cybersecurity Analyst', '2024-09-01'), 
    (7, 6, 'Lead ML Engineer', '2024-07-10'), 
    (8, 10, 'Project Manager', '2024-08-15'), 
    (9, 11, 'Data Scientist', '2024-06-01'), 
    (10, 9, 'UI/UX Designer', '2024-08-20'), 
    (1, 2, 'AI/ML Lead Developer', '2024-10-05'), 
    (2, 1, 'Lead Full Stack Developer', '2024-09-15');

-- Select data from ProjectAllocations
SELECT * FROM ProjectAllocations;

-- Find Available Employees for a Specific Skill
SELECT e.Name, e.JobTitle, es.ProficiencyLevel 
FROM Employees e 
JOIN EmployeeSkills es ON e.EmployeeID = es.EmployeeID 
JOIN Skills s ON es.SkillID = s.SkillID
WHERE s.SkillName = 'Full Stack Java'
  AND e.EmployeeID NOT IN (
      SELECT pa.EmployeeID
      FROM ProjectAllocations pa
      JOIN Projects p ON pa.ProjectID = p.ProjectID
      WHERE p.EndDate IS NULL OR p.EndDate >= CURDATE()
  );
SELECT * FROM Skills WHERE SkillName = 'Full Stack Java';

-- List Employees Assigned to a Specific Project
SELECT e.Name, e.JobTitle, pa.Role
FROM Employees e
JOIN ProjectAllocations pa ON e.EmployeeID = pa.EmployeeID
JOIN Projects p ON pa.ProjectID = p.ProjectID
WHERE p.ProjectName = 'AI-Based Chatbot';

SELECT * FROM Projects WHERE ProjectName = 'AI-Based Chatbot';

-- Check Project Skill Requirements and Matching Employees
SELECT e.Name, e.JobTitle, es.ProficiencyLevel, s.SkillName
FROM Employees e
JOIN EmployeeSkills es ON e.EmployeeID = es.EmployeeID
JOIN Skills s ON es.SkillID = s.SkillID
JOIN Projects p ON p.ProjectID = 5
WHERE s.SkillName = 'Project Management';

SELECT * FROM Projects WHERE ProjectID = 5;
SELECT * FROM Skills WHERE SkillName = 'Project Management';

-- Assign Employee to a New Project
INSERT INTO ProjectAllocations (ProjectID, EmployeeID, Role, AllocationDate)
VALUES (8, 7, 'Blockchain Developer', '2024-10-05');

SELECT * FROM Employees WHERE EmployeeID = 7;
SELECT * FROM Projects WHERE ProjectID = 8;

-- Check Employee Allocation Load
SELECT e.Name, COUNT(pa.ProjectID) AS TotalProjects
FROM Employees e
JOIN ProjectAllocations pa ON e.EmployeeID = pa.EmployeeID
GROUP BY e.EmployeeID;

