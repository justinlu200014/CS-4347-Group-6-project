USE StudentRecordSystem
GO
-- 1. Student Table Operations
-- Query: List students with usernames starting with 'john'
SELECT * FROM Student WHERE Username LIKE 'john%';

-- Insert: Add a new student
INSERT INTO Student (StudentID, Fname, Lname, Username, Password)
VALUES (11, 'Jane', 'Doe', 'janedoe', 'password123');

-- Delete: Remove a student with StudentID = 11
DELETE FROM Student WHERE StudentID = 11;

-- Update: Change the username of StudentID = 2
UPDATE Student SET Username = 'johnnydoe' WHERE StudentID = 2;

-----------------------------------------
-- 2. Event Table Operations
-- Query: List all events that are 'RSVPComplete'
SELECT * FROM Event WHERE RSVPComplete = 1;

-- Insert: Add a new event
INSERT INTO Event (EventID, Date, EventName, RSVPComplete, EventType, Description)
VALUES (11, '2024-10-01 12:00:00', 'Coding Workshop', 0, 'Workshop', 'Introduction to Python');

-- Delete: Remove an event with EventID = 11
DELETE FROM Event WHERE EventID = 11;

-- Update: Modify the EventName for EventID = 2
UPDATE Event SET EventName = 'Annual Meeting' WHERE EventID = 2;

-----------------------------------------
-- 3. Course Table Operations
-- Query: List all courses happening on 'Monday'
SELECT * FROM Course WHERE Day = 'Monday';

-- Insert: Add a new course
INSERT INTO Course (CourseID, CourseName, ClassroomNo, Day, StartTime, EndTime)
VALUES (11, 'Database Systems', 'Room 202', 'Friday', '14:00:00', '16:00:00');

-- Delete: Remove a course with CourseID = 6
DELETE FROM Course WHERE CourseID = 6;

-- Update: Change ClassroomNo for CourseID = 3
UPDATE Course SET ClassroomNo = 'Room 104' WHERE CourseID = 3;

-----------------------------------------
-- 4. Professor Table Operations
-- Query: List all professors with office hours after 12:00 PM
SELECT * FROM Professor WHERE OfficeHours > '12:00:00';

-- Insert: Add a new professor
INSERT INTO Professor (ProfessorID, Fname, Lname, Email, Office, OfficeHours)
VALUES (11, 'Emily', 'Clark', 'eclark@example.com', 'Room 301', '2024-10-10 15:00:00');

-- Delete: Remove a professor with ProfessorID = 6
DELETE FROM Professor WHERE ProfessorID = 6;

-- Update: Change the office for ProfessorID = 1
UPDATE Professor SET Office = 'Room 204' WHERE ProfessorID = 1;

-----------------------------------------
-- 5. TA (Teaching Assistant) Table Operations
-- Query: List all TAs whose office is in 'Room 201'
SELECT * FROM TA WHERE Office = 'Room 201';

-- Insert: Add a new TA
INSERT INTO TA (TAID, Fname, Lname, Email, Office, OfficeHours)
VALUES (11, 'Jake', 'Miller', 'jmiller@example.com', 'Room 202', '2024-10-11 13:00:00');

-- Delete: Remove a TA with TAID = 6
DELETE FROM TA WHERE TAID = 6;

-- Update: Change the OfficeHours for TAID = 3
UPDATE TA SET OfficeHours = '2024-10-12 14:00:00' WHERE TAID = 3;

-----------------------------------------
-- 6. Assignment Table Operations
-- Query: List all assignments due after October 1, 2024
SELECT * FROM Assignment WHERE DueDate > '2024-10-01';

-- Insert: Add a new assignment
INSERT INTO Assignment (AssignmentID, DueDate, Description, AssignmentType)
VALUES (11, '2024-10-25 23:59:00', 'Extra Exam', 'Exam');

-- Insert: Add a new assignment
INSERT INTO Assignment (AssignmentID, DueDate, Description, AssignmentType)
VALUES (12, '2024-10-25 23:59:00', 'Pop Quiz', 'Quiz');

-- Insert: Add a new assignment
INSERT INTO Assignment (AssignmentID, DueDate, Description, AssignmentType)
VALUES (13, '2024-10-25 23:59:00', 'Final Project', 'Project');

-- Delete: Remove an assignment with AssignmentID = 11
DELETE FROM Assignment WHERE AssignmentID = 10;

-- Update: Change the description for AssignmentID = 5
UPDATE Assignment SET Description = 'Quiz 2' WHERE AssignmentID = 5;
GO

-----------------------------------------
-- 7. Exam Table Operations
-- Query: List all exams
SELECT * FROM Exam;

-- Insert: Add a new exam
INSERT INTO Exam (ExamID, AssignmentID)
VALUES (4, 11);

-- Delete: Remove an exam with ExamID = 4
DELETE FROM Exam WHERE ExamID = 4;

-- Update: Modify the AssignmentID for ExamID = 1
UPDATE Exam SET AssignmentID = 3 WHERE ExamID = 1;

-----------------------------------------
-- 8. Quiz Table Operations
-- Query: List all quizzes
SELECT * FROM Quiz;

-- Insert: Add a new quiz
INSERT INTO Quiz (QuizID, AssignmentID)
VALUES (3, 12);

-- Delete: Remove a quiz with QuizID = 3
DELETE FROM Quiz WHERE QuizID = 3;

-- Update: Modify the AssignmentID for QuizID = 2
UPDATE Quiz SET QuizID = 7 WHERE QuizID = 2;

-----------------------------------------
-- 9. Homework Table Operations
-- Query: List all homework assignments
SELECT * FROM Homework;

-- Insert: Add a new homework
INSERT INTO Homework (HomeworkID, AssignmentID)
VALUES (6, 13);

-- Delete: Remove homework with HomeworkID = 6
DELETE FROM Homework WHERE HomeworkID = 6;

-- Update: Change the AssignmentID for HomeworkID = 5
UPDATE Homework SET AssignmentID = 4 WHERE HomeworkID = 5;

-----------------------------------------
-- 10. Finances Table Operations
-- Query: List all students who owe more than $500
SELECT * FROM Finances WHERE Amount > 500;

-- Insert: Add a new finance record
INSERT INTO Finances (FinancesID, StudentID, Amount, FinancesType, PaymentDeadline, Status)
VALUES (11, 1, 300.00, 'Gym Fee', '2024-12-15 23:59:00', 0);

-- Delete: Remove a finance record with FinancesID = 11
DELETE FROM Finances WHERE FinancesID = 11;

-- Update: Change the status for FinancesID = 1
UPDATE Finances SET Status = 1 WHERE FinancesID = 1;

-----------------------------------------
-- 11. Dining Table Operations
-- Query: List all students with a 'Gold' meal plan
SELECT * FROM Dining WHERE MealPlanType = 'Gold';

-- Insert: Add a new dining plan
INSERT INTO Dining (DiningID, StudentID, MealPlanBalance, SwipesPerWeek, MealPlanType)
VALUES (11, 3, 200.00, 12, 'Silver');

-- Delete: Remove a dining plan with DiningID = 11
DELETE FROM Dining WHERE DiningID = 11;

-- Update: Change MealPlanBalance for DiningID = 2
UPDATE Dining SET MealPlanBalance = 250.00 WHERE DiningID = 2;

-----------------------------------------
-- 12. Housing Table Operations
-- Query: List all students in 'Building A'
SELECT * FROM Housing WHERE BuildingNo = 'Building A';

-- Insert: Add a new housing record
INSERT INTO Housing (HousingID, StudentID, BuildingNo, RoomNo)
VALUES (11, 2, 'Building B', '201');

-- Delete: Remove a housing record with HousingID = 10
DELETE FROM Housing WHERE HousingID = 10;

-- Update: Change RoomNo for HousingID = 5
UPDATE Housing SET RoomNo = '206' WHERE HousingID = 5;
GO

-----------------------------------------
-- 13. RoommateAgreement Table Operations
-- Query: List all agreements that are complete
SELECT * FROM RoommateAgreement WHERE AgreementComplete = 1;

-- Insert: Add a new roommate agreement
INSERT INTO RoommateAgreement (HousingID, DateSigned, AgreementComplete)
VALUES (11, '2024-09-11', 1);

-- Delete: Remove a roommate agreement with HousingID = 11
DELETE FROM RoommateAgreement WHERE HousingID = 11;

-- Update: Change AgreementComplete for HousingID = 4
UPDATE RoommateAgreement SET AgreementComplete = 1 WHERE HousingID = 4;
