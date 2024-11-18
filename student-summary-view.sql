CREATE VIEW StudentFinancialSummary AS
SELECT
    s.StudentID,
    s.Fname,
    f.FinancesType,
    f.Amount,
    f.PaymentDeadline,
    CASE
        WHEN f.Status = 0 THEN 'Pending'
        WHEN f.Status = 1 THEN 'Paid'
        ELSE 'Unknown'
    END AS PaymentStatus
FROM
    Student s
JOIN
    Finances f
ON
    s.StudentID = f.StudentID;