-- ============================================
-- DATABASE SELECTION
-- ============================================

USE Sysfore_DB;



-- ============================================
-- MASTER TABLES
-- These tables store reusable/static data
-- ============================================

CREATE TABLE mst_Department
(
    department_id INT IDENTITY(1,1) PRIMARY KEY,

    department_name VARCHAR(100) NOT NULL UNIQUE,

    created_on DATETIME DEFAULT GETDATE(),

    is_active BIT DEFAULT 1
);




CREATE TABLE mst_Company
(
    company_id INT IDENTITY(1,1) PRIMARY KEY,

    company_name VARCHAR(100) NOT NULL UNIQUE,

    company_email VARCHAR(100) UNIQUE,

    company_location VARCHAR(100),

    created_on DATETIME DEFAULT GETDATE(),

    is_active BIT DEFAULT 1
);




CREATE TABLE mst_Student
(
    student_id INT IDENTITY(1,1) PRIMARY KEY,

    student_name VARCHAR(100) NOT NULL,

    email VARCHAR(100) UNIQUE NOT NULL,

    phone_number BIGINT,

    department_id INT,

    join_year INT,

    created_on DATETIME DEFAULT GETDATE(),

    is_active BIT DEFAULT 1,

    CONSTRAINT FK_Student_Department
    FOREIGN KEY(department_id)
    REFERENCES mst_Department(department_id)
);




-- ============================================
-- TRANSACTION TABLES
-- These tables store dynamic transactional data
-- ============================================

CREATE TABLE tbl_PlacementDrive
(
    drive_id INT IDENTITY(1,1) PRIMARY KEY,

    company_id INT NOT NULL,

    drive_date DATE NOT NULL,

    package_lpa DECIMAL(5,2),

    interview_rounds INT,

    created_on DATETIME DEFAULT GETDATE(),

    is_active BIT DEFAULT 1,

    CONSTRAINT FK_Drive_Company
    FOREIGN KEY(company_id)
    REFERENCES mst_Company(company_id)
);




CREATE TABLE tbl_Application
(
    application_id INT IDENTITY(1,1) PRIMARY KEY,

    student_id INT NOT NULL,

    drive_id INT NOT NULL,

    application_date DATE DEFAULT GETDATE(),

    created_on DATETIME DEFAULT GETDATE(),

    CONSTRAINT FK_tblApplication_Student
    FOREIGN KEY(student_id)
    REFERENCES mst_Student(student_id),

    CONSTRAINT FK_tblApplication_Drive
    FOREIGN KEY(drive_id)
    REFERENCES tbl_PlacementDrive(drive_id),

    CONSTRAINT UQ_tblApplication_StudentDrive
    UNIQUE(student_id, drive_id)
);




CREATE TABLE tbl_PlacementResult
(
    result_id INT IDENTITY(1,1) PRIMARY KEY,

    application_id INT UNIQUE,

    result_status VARCHAR(30),

    remarks VARCHAR(200),

    created_on DATETIME DEFAULT GETDATE(),

    CONSTRAINT FK_tblPlacementResult_Application
    FOREIGN KEY(application_id)
    REFERENCES tbl_Application(application_id)
);




-- ============================================
-- ERROR LOG TABLE
-- Stores runtime SQL errors from TRY-CATCH
-- ============================================

CREATE TABLE tbl_ErrorLog
(
    errorlog_id INT IDENTITY(1,1) PRIMARY KEY,

    error_message VARCHAR(MAX),

    error_line INT,

    error_procedure VARCHAR(100),

    error_date DATETIME DEFAULT GETDATE()
);




-- ============================================
-- INSERT SAMPLE RECORDS
-- ============================================

INSERT INTO mst_Department
(department_name)
VALUES
('Computer Science'),
('Mechanical'),
('Electronics'),
('Information Science');




INSERT INTO mst_Company
(company_name, company_email, company_location)
VALUES
('Infosys', 'hr@infosys.com', 'Bangalore'),
('TCS', 'hr@tcs.com', 'Hyderabad'),
('Wipro', 'hr@wipro.com', 'Chennai');




INSERT INTO mst_Student
(student_name, email, phone_number, department_id, join_year)
VALUES
('Rohit Sharma', 'rohit@gmail.com', 9876543210, 1, 2022),
('Rama Krishna', 'rama@gmail.com', 9876500000, 2, 2021),
('Anjali Verma', 'anjali@gmail.com', 9876511111, 3, 2022);




INSERT INTO tbl_PlacementDrive
(company_id, drive_date, package_lpa, interview_rounds)
VALUES
(1, '2026-05-20', 5.50, 3),
(2, '2026-05-22', 4.20, 2),
(3, '2026-05-25', 6.00, 4);




INSERT INTO tbl_Application
(student_id, drive_id)
VALUES
(1,1),
(2,2),
(3,3);




INSERT INTO tbl_PlacementResult
(application_id, result_status, remarks)
VALUES
(1, 'Selected', 'Excellent Performance'),
(2, 'Pending', 'Final Round Remaining'),
(3, 'Rejected', 'Technical Round Cleared');




-- ============================================
-- VERIFY INSERTED DATA
-- ============================================

SELECT * FROM mst_Department;

SELECT * FROM mst_Company;

SELECT * FROM mst_Student;

SELECT * FROM tbl_PlacementDrive;

SELECT * FROM tbl_Application;

SELECT * FROM tbl_PlacementResult;




-- ============================================
-- INNER JOIN
-- Shows matching records from all tables
-- ============================================

SELECT
    s.student_name,
    c.company_name,
    p.package_lpa,
    r.result_status
FROM mst_Student s

INNER JOIN tbl_Application a
ON s.student_id = a.student_id

INNER JOIN tbl_PlacementDrive p
ON a.drive_id = p.drive_id

INNER JOIN mst_Company c
ON p.company_id = c.company_id

INNER JOIN tbl_PlacementResult r
ON a.application_id = r.application_id;




-- ============================================
-- LEFT JOIN
-- Shows all students even without applications
-- ============================================

SELECT
    s.student_name,
    a.application_id
FROM mst_Student s

LEFT JOIN tbl_Application a
ON s.student_id = a.student_id;




-- ============================================
-- RIGHT JOIN
-- Shows all applications even without students
-- ============================================

SELECT
    s.student_name,
    a.application_id
FROM mst_Student s

RIGHT JOIN tbl_Application a
ON s.student_id = a.student_id;




-- ============================================
-- FULL JOIN
-- Shows all matching and non-matching records
-- ============================================

SELECT
    s.student_name,
    a.application_id
FROM mst_Student s

FULL JOIN tbl_Application a
ON s.student_id = a.student_id;




-- ============================================
-- SELF JOIN
-- Employee-Manager relationship
-- ============================================

CREATE TABLE tbl_Employee
(
    employee_id INT PRIMARY KEY,

    employee_name VARCHAR(100),

    manager_id INT
);




INSERT INTO tbl_Employee
VALUES
(1, 'Rahul', NULL),
(2, 'Amit', 1),
(3, 'Sneha', 1);




SELECT
    e.employee_name AS Employee,

    m.employee_name AS Manager
FROM tbl_Employee e

LEFT JOIN tbl_Employee m
ON e.manager_id = m.employee_id;




-- ============================================
-- CROSS JOIN
-- Generates all possible combinations
-- ============================================

SELECT
    s.student_name,
    c.company_name
FROM mst_Student s

CROSS JOIN mst_Company c;




-- ============================================
-- STORED PROCEDURES
-- Reusable SQL business logic
-- ============================================



-- ============================================
-- PROCEDURE 1
-- Get all student details
-- ============================================

CREATE PROCEDURE usp_GetAllStudents
AS
BEGIN

    SET NOCOUNT ON;

    SELECT
        student_id,
        student_name,
        email,
        phone_number,
        join_year
    FROM mst_Student;

END;




EXEC usp_GetAllStudents;




-- ============================================
-- PROCEDURE 2
-- Get placement details using INNER JOIN
-- ============================================

CREATE PROCEDURE usp_GetPlacementDetails
AS
BEGIN

    SET NOCOUNT ON;

    SELECT
        s.student_name,
        c.company_name,
        p.package_lpa,
        r.result_status
    FROM mst_Student s

    INNER JOIN tbl_Application a
    ON s.student_id = a.student_id

    INNER JOIN tbl_PlacementDrive p
    ON a.drive_id = p.drive_id

    INNER JOIN mst_Company c
    ON p.company_id = c.company_id

    INNER JOIN tbl_PlacementResult r
    ON a.application_id = r.application_id;

END;




EXEC usp_GetPlacementDetails;




-- ============================================
-- PROCEDURE 3
-- Insert new company details
-- ============================================

CREATE PROCEDURE usp_InsertCompany
(
    @company_name VARCHAR(100),

    @company_email VARCHAR(100),

    @company_location VARCHAR(100)
)
AS
BEGIN

    SET NOCOUNT ON;

    INSERT INTO mst_Company
    (
        company_name,
        company_email,
        company_location
    )
    VALUES
    (
        @company_name,
        @company_email,
        @company_location
    );

END;




EXEC usp_InsertCompany
    @company_name = 'Accenture',
    @company_email = 'hr@accenture.com',
    @company_location = 'Pune';




SELECT
    company_id,
    company_name,
    company_location
FROM mst_Company;




-- ============================================
-- USER DEFINED TABLE TYPE (UDT)
-- Used for bulk insert operations
-- ============================================

CREATE TYPE udt_StudentType AS TABLE
(
    student_name VARCHAR(100),

    email VARCHAR(100),

    phone_number BIGINT,

    department_id INT,

    join_year INT
);




-- ============================================
-- STORED PROCEDURE USING UDT
-- Inserts multiple student records together
-- ============================================

CREATE PROCEDURE usp_InsertStudentsUsingUDT
(
    @Students udt_StudentType READONLY
)
AS
BEGIN

    SET NOCOUNT ON;

    INSERT INTO mst_Student
    (
        student_name,
        email,
        phone_number,
        department_id,
        join_year
    )

    SELECT
        student_name,
        email,
        phone_number,
        department_id,
        join_year
    FROM @Students;

END;




DECLARE @StudentData udt_StudentType;

INSERT INTO @StudentData
VALUES
('Kiran Kumar', 'kiran@gmail.com', 9876548888, 1, 2023),
('Neha Sharma', 'neha@gmail.com', 9876547777, 2, 2023);




EXEC usp_InsertStudentsUsingUDT
    @Students = @StudentData;




SELECT
    student_id,
    student_name,
    email
FROM mst_Student;




-- ============================================
-- TRY-CATCH WITH TRANSACTION HANDLING
-- Demonstrates rollback and error logging
-- ============================================

CREATE PROCEDURE usp_InsertDepartment
(
    @department_name VARCHAR(100)
)
AS
BEGIN

    SET NOCOUNT ON;

    BEGIN TRY

        BEGIN TRANSACTION;

        INSERT INTO mst_Department(department_name)
        VALUES(@department_name);

        COMMIT TRANSACTION;

    END TRY

    BEGIN CATCH

        ROLLBACK TRANSACTION;

        INSERT INTO tbl_ErrorLog
        (
            error_message,
            error_line,
            error_procedure
        )
        VALUES
        (
            ERROR_MESSAGE(),
            ERROR_LINE(),
            ERROR_PROCEDURE()
        );

    END CATCH

END;




EXEC usp_InsertDepartment
    @department_name = 'Civil';




SELECT
    department_id,
    department_name
FROM mst_Department;




-- ============================================
-- VERIFY ERROR LOGS
-- ============================================

SELECT * FROM tbl_ErrorLog;