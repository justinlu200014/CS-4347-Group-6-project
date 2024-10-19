-- Create Database
CREATE DATABASE StudentRecordSystem;
GO
USE StudentRecordSystem;
GO
-- Create Student Table
CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    Fname VARCHAR(20),
    Lname VARCHAR(20),
    Username VARCHAR(20),
    Password VARCHAR(20)
);

-- Create Event Table
CREATE TABLE Event (
    EventID INT PRIMARY KEY,
    Date DATETIME,
    EventName VARCHAR(45),
    RSVPComplete BIT,
    EventType VARCHAR(20),
    Description VARCHAR(45)
);

-- Create Course Table
CREATE TABLE Course (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(45),
    ClassroomNo VARCHAR(10),
    Day VARCHAR(10),
    StartTime TIME,
    EndTime TIME
);

-- Create Professor Table
CREATE TABLE Professor (
    ProfessorID INT PRIMARY KEY,
    Fname VARCHAR(20),
    Lname VARCHAR(20),
    Email VARCHAR(45),
    Office VARCHAR(45),
    OfficeHours DATETIME
);

-- Create TA Table
CREATE TABLE TA (
    TAID INT PRIMARY KEY,
    Fname VARCHAR(20),
    Lname VARCHAR(20),
    Email VARCHAR(45),
    Office VARCHAR(45),
    OfficeHours DATETIME
);

-- Create Assignment Table
CREATE TABLE Assignment (
    AssignmentID INT PRIMARY KEY,
    DueDate DATETIME,
    Description VARCHAR(45),
    AssignmentType VARCHAR(20) -- 'Exam', 'Homework', 'Quiz'
);

-- Create Exam Table (Subclass)
CREATE TABLE Exam
(
	ExamID INT PRIMARY KEY,
	AssignmentID INT NOT NULL FOREIGN KEY REFERENCES dbo.Assignment(AssignmentID) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Create Grade Table (Subclass)
CREATE TABLE Quiz
(
	QuizID INT PRIMARY KEY,
	AssignmentID INT NOT NULL FOREIGN KEY REFERENCES dbo.Assignment(AssignmentID) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Create Homework Table (Subclass)
CREATE TABLE Homework
(
	HomeworkID INT PRIMARY KEY,
	AssignmentID INT NOT NULL FOREIGN KEY REFERENCES dbo.Assignment(AssignmentID) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Create Finances Table
CREATE TABLE Finances (
    FinancesID INT PRIMARY KEY,
    StudentID INT,
    Amount DECIMAL(10, 2),
    FinancesType VARCHAR(45),
    PaymentDeadline DATETIME,
    Status BIT,
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Create Dining Table
CREATE TABLE Dining (
    DiningID INT PRIMARY KEY,
    StudentID INT,
    MealPlanBalance DECIMAL(10, 2),
    SwipesPerWeek INT,
    MealPlanType VARCHAR(45),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Create Housing Table
CREATE TABLE Housing (
    HousingID INT PRIMARY KEY,
    StudentID INT,
    BuildingNo VARCHAR(45),
    RoomNo VARCHAR(45),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Create RoommateAgreement Table (Weak entity of Housing)
CREATE TABLE RoommateAgreement (
    HousingID INT,
    DateSigned DATE,
    AgreementComplete BIT,
	PRIMARY KEY (HousingID),
    FOREIGN KEY (HousingID) REFERENCES Housing(HousingID) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO Student (StudentID, Fname, Lname, Username, Password) VALUES
(1, 'John', 'Doe', 'johndoe', 'password123'),
(2, 'Jane', 'Smith', 'janesmith', 'password456'),
(3, 'Alex', 'Johnson', 'alexj', 'mypassword'),
(4, 'Emma', 'Brown', 'emmab', 'emma123'),
(5, 'Michael', 'White', 'mwhite', 'mikepass'),
(6, 'Emily', 'Taylor', 'emilyt', 'tay123'),
(7, 'David', 'Clark', 'dclark', 'david123'),
(8, 'Sophia', 'Anderson', 'sophiaa', 'sophpass'),
(9, 'Chris', 'Lee', 'clee', 'lee123'),
(10, 'Sarah', 'King', 'sarahk', 'king456');

INSERT INTO Event (EventID, Date, EventName, RSVPComplete, EventType, Description) VALUES
(1, '2024-09-01 18:00:00', 'Welcome Party', 1, 'Social', 'Welcome to campus!'),
(2, '2024-09-05 12:00:00', 'Orientation', 1, 'Informational', 'New student orientation'),
(3, '2024-10-01 14:00:00', 'Midterm Study Session', 0, 'Academic', 'Group study for midterms'),
(4, '2024-11-10 17:00:00', 'Career Fair', 1, 'Career', 'Meet potential employers'),
(5, '2024-12-15 18:00:00', 'Holiday Party', 0, 'Social', 'Celebrate the holidays'),
(6, '2024-08-25 15:00:00', 'Welcome Back BBQ', 1, 'Social', 'BBQ to welcome students'),
(7, '2024-09-10 16:00:00', 'Health Workshop', 0, 'Health', 'Mental health awareness'),
(8, '2024-10-20 13:00:00', 'Tech Workshop', 0, 'Academic', 'Learn new tech skills'),
(9, '2024-11-25 10:00:00', 'Finals Prep', 1, 'Academic', 'Get ready for finals'),
(10, '2024-12-01 19:00:00', 'Alumni Networking', 0, 'Career', 'Meet alumni in your field');

INSERT INTO Course (CourseID, CourseName, ClassroomNo, Day, StartTime, EndTime) VALUES
(1, 'Intro to Computer Science', 'B101', 'Monday', '09:00:00', '10:30:00'),
(2, 'Data Structures', 'C202', 'Wednesday', '10:00:00', '11:30:00'),
(3, 'Calculus I', 'A303', 'Monday', '11:00:00', '12:30:00'),
(4, 'Physics I', 'B202', 'Thursday', '12:00:00', '13:30:00'),
(5, 'History of Art', 'C101', 'Friday', '09:00:00', '10:30:00'),
(6, 'Operating Systems', 'A105', 'Tuesday', '14:00:00', '15:30:00'),
(7, 'Algorithms', 'B201', 'Thursday', '15:00:00', '16:30:00'),
(8, 'Discrete Mathematics', 'C303', 'Monday', '13:00:00', '14:30:00'),
(9, 'Linear Algebra', 'A204', 'Wednesday', '14:00:00', '15:30:00'),
(10, 'Database Systems', 'B102', 'Friday', '10:00:00', '11:30:00');

INSERT INTO Professor (ProfessorID, Fname, Lname, Email, Office, OfficeHours) VALUES
(1, 'William', 'Jones', 'wjones@university.edu', 'Room 301', '2024-09-01 10:00:00'),
(2, 'Lisa', 'Miller', 'lmiller@university.edu', 'Room 302', '2024-09-01 11:00:00'),
(3, 'James', 'Garcia', 'jgarcia@university.edu', 'Room 303', '2024-09-01 09:00:00'),
(4, 'Mary', 'Wilson', 'mwilson@university.edu', 'Room 304', '2024-09-01 12:00:00'),
(5, 'Robert', 'Martinez', 'rmartinez@university.edu', 'Room 305', '2024-09-01 14:00:00'),
(6, 'Patricia', 'Anderson', 'panderson@university.edu', 'Room 306', '2024-09-01 13:00:00'),
(7, 'Charles', 'Thomas', 'cthomas@university.edu', 'Room 307', '2024-09-01 08:00:00'),
(8, 'Linda', 'Taylor', 'ltaylor@university.edu', 'Room 308', '2024-09-01 10:30:00'),
(9, 'Michael', 'Hernandez', 'mhernandez@university.edu', 'Room 309', '2024-09-01 09:30:00'),
(10, 'Elizabeth', 'Moore', 'emoore@university.edu', 'Room 310', '2024-09-01 11:30:00');

INSERT INTO TA (TAID, Fname, Lname, Email, Office, OfficeHours) VALUES
(1, 'Tom', 'Parker', 'tparker@university.edu', 'Lab A', '2024-09-02 09:00:00'),
(2, 'Eve', 'Cooper', 'ecooper@university.edu', 'Lab B', '2024-09-02 10:00:00'),
(3, 'Lucas', 'Morgan', 'lmorgan@university.edu', 'Lab C', '2024-09-02 11:00:00'),
(4, 'Grace', 'Wright', 'gwright@university.edu', 'Lab D', '2024-09-02 12:00:00'),
(5, 'Anna', 'Lopez', 'alopez@university.edu', 'Lab E', '2024-09-02 13:00:00'),
(6, 'Daniel', 'Hill', 'dhill@university.edu', 'Lab F', '2024-09-02 14:00:00'),
(7, 'Mia', 'Scott', 'mscott@university.edu', 'Lab G', '2024-09-02 15:00:00'),
(8, 'Oliver', 'Torres', 'otorres@university.edu', 'Lab H', '2024-09-02 16:00:00'),
(9, 'Ava', 'Rivera', 'arivera@university.edu', 'Lab I', '2024-09-02 17:00:00'),
(10, 'Henry', 'Nguyen', 'hnguyen@university.edu', 'Lab J', '2024-09-02 18:00:00');

INSERT INTO Assignment (AssignmentID, DueDate, Description, AssignmentType) VALUES
(1, '2024-09-15 23:59:00', 'Homework 1 on Intro to CS', 'Homework'),
(2, '2024-09-20 23:59:00', 'Quiz on Data Structures', 'Quiz'),
(3, '2024-10-10 09:00:00', 'Midterm Exam 1', 'Exam'),
(4, '2024-10-30 23:59:00', 'Project Submission', 'Homework'),
(5, '2024-11-15 14:00:00', 'Final Quiz', 'Quiz'),
(6, '2024-11-20 09:00:00', 'Final Exam', 'Exam'),
(7, '2024-12-01 23:59:00', 'Homework 2 on Calculus', 'Homework'),
(8, '2024-12-10 23:59:00', 'Homework 3 on Linear Algebra', 'Homework'),
(9, '2024-12-15 09:00:00', 'Final Exam in Physics', 'Exam'),
(10, '2024-12-20 23:59:00', 'End of Semester Project', 'Homework');

INSERT INTO Exam (ExamID, AssignmentID) VALUES
(1, 3),
(2, 6),
(3, 9);

INSERT INTO Quiz (QuizID, AssignmentID) VALUES
(1, 2),
(2, 5);

INSERT INTO Homework (HomeworkID, AssignmentID) VALUES
(1, 1),
(2, 4),
(3, 7),
(4, 8),
(5, 10);

INSERT INTO Finances (FinancesID, StudentID, Amount, FinancesType, PaymentDeadline, Status) VALUES
(1, 1, 1500.00, 'Tuition', '2024-09-30 23:59:00', 0),
(2, 2, 2000.00, 'Tuition', '2024-09-30 23:59:00', 1),
(3, 3, 100.00, 'Library Fine', '2024-10-15 23:59:00', 1),
(4, 4, 250.00, 'Dorm Damage', '2024-11-01 23:59:00', 0),
(5, 5, 500.00, 'Meal Plan', '2024-09-30 23:59:00', 1),
(6, 6, 600.00, 'Tuition', '2024-09-30 23:59:00', 0),
(7, 7, 75.00, 'Lab Fee', '2024-10-10 23:59:00', 1),
(8, 8, 900.00, 'Tuition', '2024-09-30 23:59:00', 0),
(9, 9, 50.00, 'Gym Fee', '2024-11-05 23:59:00', 1),
(10, 10, 300.00, 'Parking Fine', '2024-11-20 23:59:00', 0);

INSERT INTO Dining (DiningID, StudentID, MealPlanBalance, SwipesPerWeek, MealPlanType) VALUES
(1, 1, 300.00, 14, 'Gold'),
(2, 2, 200.00, 10, 'Silver'),
(3, 3, 150.00, 8, 'Bronze'),
(4, 4, 250.00, 12, 'Gold'),
(5, 5, 350.00, 16, 'Platinum'),
(6, 6, 100.00, 6, 'Bronze'),
(7, 7, 180.00, 10, 'Silver'),
(8, 8, 270.00, 14, 'Gold'),
(9, 9, 50.00, 4, 'Bronze'),
(10, 10, 300.00, 14, 'Gold');

INSERT INTO Housing (HousingID, StudentID, BuildingNo, RoomNo) VALUES
(1, 1, 'Building A', '101'),
(2, 2, 'Building B', '102'),
(3, 3, 'Building C', '103'),
(4, 4, 'Building D', '104'),
(5, 5, 'Building E', '105'),
(6, 6, 'Building F', '106'),
(7, 7, 'Building G', '107'),
(8, 8, 'Building H', '108'),
(9, 9, 'Building I', '109'),
(10, 10, 'Building J', '110');

INSERT INTO RoommateAgreement (HousingID, DateSigned, AgreementComplete) VALUES
(1, '2024-09-01', 1),
(2, '2024-09-02', 1),
(3, '2024-09-03', 1),
(4, '2024-09-04', 0),
(5, '2024-09-05', 1),
(6, '2024-09-06', 1),
(7, '2024-09-07', 0),
(8, '2024-09-08', 1),
(9, '2024-09-09', 1),
(10, '2024-09-10', 0);
