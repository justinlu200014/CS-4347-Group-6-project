CREATE VIEW Attendance AS
SELECT
    e.EventID,
    e.EventName,
    e.date,
    s.StudentID,
    s.Fname
FROM
    EventsAttended ea
JOIN 
    Student s
ON
    ea.StudentID = s.StudentID
JOIN 
    Event e
ON
    ea.EventID = e.EventID;