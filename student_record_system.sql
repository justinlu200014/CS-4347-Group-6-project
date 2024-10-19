-- Create Database
CREATE DATABASE StudentRecordSystem;
USE StudentRecordSystem;

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

-- Create Finances Table
CREATE TABLE Finances (
    FinancesID INT PRIMARY KEY,
    StudentID INT,
    Amount DECIMAL(10, 2),
    FinancesType VARCHAR(45),
    PaymentDeadline DATETIME,
    Status BIT,
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID)
);

-- Create Dining Table
CREATE TABLE Dining (
    DiningID INT PRIMARY KEY,
    StudentID INT,
    MealPlanBalance DECIMAL(10, 2),
    SwipesPerWeek INT,
    MealPlanType VARCHAR(45),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID)
);

-- Create Housing Table
CREATE TABLE Housing (
    HousingID INT PRIMARY KEY,
    StudentID INT,
    BuildingNo VARCHAR(45),
    RoomNo VARCHAR(45),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID)
);

-- Create RoommateAgreement Table (Weak entity of Housing)
CREATE TABLE RoommateAgreement (
    AgreementID INT PRIMARY KEY,
    HousingID INT,
    DateSigned DATE,
    AgreementComplete BIT,
    FOREIGN KEY (HousingID) REFERENCES Housing(HousingID)
);

-- Insert Data into Student Table
INSERT INTO Student (StudentID, Fname, Lname, Username, Password) VALUES
(1, 'John', 'Doe', 'johndoe', 'password123'),
(2, 'Jane', 'Smith', 'janesmith', 'password456'),
(3, 'Emily', 'Brown', 'emilybrown', 'password789'),
(4, 'Michael', 'Johnson', 'michaeljohnson', 'pass123'),
(5, 'Chris', 'Lee', 'chrislee', 'pass456'),
(6, 'Sarah', 'Wilson', 'sarahwilson', 'pass789'),
(7, 'David', 'Martinez', 'davidmartinez', 'password001'),
(8, 'Ashley', 'Garcia', 'ashleygarcia', 'password002'),
(9, 'Daniel', 'Miller', 'danielmiller', 'password003'),
(10, 'Sophia', 'Davis', 'sophiadavis', 'password004');

-- Insert Data into Event Table
INSERT INTO Event (EventID, Date, EventName, RSVPComplete, EventType, Description) VALUES
(1, '2024-10-20 15:00:00', 'Volunteering', 1, 'Club', 'Community service event'),
(2, '2024-10-21 18:00:00', 'Seminar', 0, 'Academic', 'Guest lecture on AI'),
(3, '2024-10-22 12:00:00', 'Career Fair', 1, 'Career', 'Networking with companies'),
(4, '2024-10-23 10:00:00', 'Sports Meet', 0, 'Sports', 'Annual inter-college sports meet'),
(5, '2024-10-24 14:00:00', 'Hackathon', 1, 'Tech', 'Coding competition'),
(6, '2024-10-25 09:00:00', 'Blood Donation Camp', 1, 'Health', 'Organized by the Red Cross'),
(7, '2024-10-26 19:00:00', 'Music Concert', 0, 'Cultural', 'Live music by local bands'),
(8, '2024-10-27 17:00:00', 'Book Club Meeting', 1, 'Club', 'Discussion on "1984" by George Orwell'),
(9, '2024-10-28 16:00:00', 'Entrepreneurship Workshop', 0, 'Career', 'Startup pitching event'),
(10, '2024-10-29 11:00:00', 'Study Group', 1, 'Academic', 'Study session for final exams');

-- Insert Data into Course Table
INSERT INTO Course (CourseID, CourseName, ClassroomNo, Day, StartTime, EndTime) VALUES
(1, 'Database Systems', 'A101', 'Monday', '10:00:00', '12:00:00'),
(2, 'Operating Systems', 'B202', 'Wednesday', '13:00:00', '15:00:00'),
(3, 'Data Structures', 'C303', 'Tuesday', '08:00:00', '10:00:00'),
(4, 'Software Engineering', 'D404', 'Friday', '09:00:00', '11:00:00'),
(5, 'Artificial Intelligence', 'E505', 'Thursday', '11:00:00', '13:00:00'),
(6, 'Machine Learning', 'F606', 'Monday', '14:00:00', '16:00:00'),
(7, 'Discrete Mathematics', 'G707', 'Tuesday', '10:00:00', '12:00:00'),
(8, 'Algorithms', 'H808', 'Wednesday', '15:00:00', '17:00:00'),
(9, 'Computer Networks', 'I909', 'Thursday', '08:00:00', '10:00:00'),
(10, 'Theory of Computation', 'J010', 'Friday', '11:00:00', '13:00:00');

-- Insert Data into Finances Table
INSERT INTO Finances (FinancesID, StudentID, Amount, FinancesType, PaymentDeadline, Status) VALUES
(1, 1, 1200.00, 'Tuition', '2024-11-01', 1),
(2, 2, 300.00, 'Books', '2024-11-05', 0),
(3, 3, 600.00, 'Room and Board', '2024-11-10', 1),
(4, 4, 150.00, 'Dining', '2024-11-15', 0),
(5, 5, 900.00, 'Tuition', '2024-11-20', 1),
(6, 6, 450.00, 'Books', '2024-11-25', 1),
(7, 7, 200.00, 'Room and Board', '2024-11-30', 0),
(8, 8, 800.00, 'Dining', '2024-12-05', 1),
(9, 9, 1100.00, 'Tuition', '2024-12-10', 0),
(10, 10, 350.00, 'Books', '2024-12-15', 1);

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

INSERT INTO RoommateAgreement (AgreementID, HousingID, DateSigned, AgreementComplete) VALUES
(1, 1, '2024-10-10', 1),
(2, 2, '2024-10-12', 0),
(3, 3, '2024-10-13', 1),
(4, 4, '2024-10-15', 1),
(5, 5, '2024-10-16', 0),
(6, 6, '2024-10-17', 1),
(7, 7, '2024-10-18', 1),
(8, 8, '2024-10-19', 0),
(9, 9, '2024-10-20', 1),
(10, 10, '2024-10-21', 0);


INSERT INTO Professor (ProfessorID, Fname, Lname, Email, Office, OfficeHours) VALUES
(1, 'Dr. Alan', 'Turing', 'aturing@university.edu', 'Room 101', '2024-10-21 09:00:00'),
(2, 'Dr. Ada', 'Lovelace', 'alovelace@university.edu', 'Room 102', '2024-10-22 10:00:00'),
(3, 'Dr. John', 'von Neumann', 'jvneumann@university.edu', 'Room 103', '2024-10-23 11:00:00'),
(4, 'Dr. Grace', 'Hopper', 'ghopper@university.edu', 'Room 104', '2024-10-24 12:00:00'),
(5, 'Dr. Donald', 'Knuth', 'dknuth@university.edu', 'Room 105', '2024-10-25 13:00:00'),
(6, 'Dr. Tim', 'Berners-Lee', 'tblee@university.edu', 'Room 106', '2024-10-26 14:00:00'),
(7, 'Dr. Linus', 'Torvalds', 'ltorvalds@university.edu', 'Room 107', '2024-10-27 15:00:00'),
(8, 'Dr. Dennis', 'Ritchie', 'dritchie@university.edu', 'Room 108', '2024-10-28 16:00:00'),
(9, 'Dr. Margaret', 'Hamilton', 'mhamilton@university.edu', 'Room 109', '2024-10-29 17:00:00'),
(10, 'Dr. Richard', 'Stallman', 'rstallman@university.edu', 'Room 110', '2024-10-30 18:00:00');

INSERT INTO TA (TAID, Fname, Lname, Email, Office, OfficeHours) VALUES
(1, 'Chris', 'Evans', 'cevans@university.edu', 'Room 201', '2024-10-22 10:00:00'),
(2, 'Emma', 'Watson', 'ewatson@university.edu', 'Room 202', '2024-10-23 11:00:00'),
(3, 'Robert', 'Downey', 'rdowney@university.edu', 'Room 203', '2024-10-24 12:00:00'),
(4, 'Scarlett', 'Johansson', 'sjohansson@university.edu', 'Room 204', '2024-10-25 13:00:00'),
(5, 'Mark', 'Ruffalo', 'mruffalo@university.edu', 'Room 205', '2024-10-26 14:00:00'),
(6, 'Chris', 'Hemsworth', 'chemsworth@university.edu', 'Room 206', '2024-10-27 15:00:00'),
(7, 'Tom', 'Holland', 'tholland@university.edu', 'Room 207', '2024-10-28 16:00:00'),
(8, 'Benedict', 'Cumberbatch', 'bcumberbatch@university.edu', 'Room 208', '2024-10-29 17:00:00'),
(9, 'Tom', 'Hiddleston', 'thiddleston@university.edu', 'Room 209', '2024-10-30 18:00:00'),
(10, 'Brie', 'Larson', 'blarson@university.edu', 'Room 210', '2024-10-31 19:00:00');

INSERT INTO Assignment (AssignmentID, DueDate, Description, AssignmentType) VALUES
(1, '2024-10-25 23:59:00', 'Database Homework 1', 'Homework'),
(2, '2024-10-27 23:59:00', 'Operating Systems Quiz 1', 'Quiz'),
(3, '2024-11-01 12:00:00', 'AI Midterm Exam', 'Exam'),
(4, '2024-11-03 23:59:00', 'Software Engineering Homework 2', 'Homework'),
(5, '2024-11-05 10:00:00', 'Machine Learning Quiz 1', 'Quiz'),
(6, '2024-11-10 09:00:00', 'Data Structures Midterm Exam', 'Exam'),
(7, '2024-11-12 23:59:00', 'Discrete Math Homework 3', 'Homework'),
(8, '2024-11-15 15:00:00', 'Networking Final Exam', 'Exam'),
(9, '2024-11-17 23:59:00', 'Algorithms Project', 'Homework'),
(10, '2024-11-20 08:00:00', 'Theory of Computation Final', 'Exam');

INSERT INTO Dining (DiningID, StudentID, MealPlanBalance, SwipesPerWeek, MealPlanType) VALUES
(1, 1, 300.00, 14, 'Standard'),
(2, 2, 250.00, 10, 'Basic'),
(3, 3, 400.00, 21, 'Premium'),
(4, 4, 200.00, 7, 'Basic'),
(5, 5, 350.00, 14, 'Standard'),
(6, 6, 500.00, 21, 'Premium'),
(7, 7, 100.00, 5, 'Basic'),
(8, 8, 450.00, 18, 'Standard'),
(9, 9, 300.00, 10, 'Standard'),
(10, 10, 600.00, 25, 'Premium');
