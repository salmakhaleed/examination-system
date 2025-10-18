CREATE OR ALTER PROCEDURE sp_GenerateExam
    @CourseID INT,
    @InstructorID INT,
    @ExamTitle VARCHAR(100),
    @NumMCQ INT,
    @NumTF INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @ExamID INT;
    DECLARE @TotalMarks INT;

    -- 1️⃣ Create new exam record
    INSERT INTO Exam (CourseID, InstructorID, ExamTitle, ExamDate, DurationMinutes, TotalMarks)
    VALUES (@CourseID, @InstructorID, @ExamTitle, GETDATE(), 60, 0);

    SET @ExamID = SCOPE_IDENTITY();

    -- 2️⃣ Randomly select MCQ questions
    INSERT INTO Exam_Question (ExamID, QuestionID, OrderNo)
    SELECT TOP (@NumMCQ)
        @ExamID AS ExamID,
        q.QuestionID,
        ROW_NUMBER() OVER (ORDER BY NEWID()) AS OrderNo
    FROM Question q
    WHERE q.CourseID = @CourseID AND q.QuestionType = 'MCQ'
    ORDER BY NEWID();

    -- 3️⃣ Randomly select True/False questions
    INSERT INTO Exam_Question (ExamID, QuestionID, OrderNo)
    SELECT TOP (@NumTF)
        @ExamID AS ExamID,
        q.QuestionID,
        (SELECT COUNT(*) FROM Exam_Question WHERE ExamID = @ExamID) 
        + ROW_NUMBER() OVER (ORDER BY NEWID()) AS OrderNo
    FROM Question q
    WHERE q.CourseID = @CourseID AND q.QuestionType = 'TF'
    ORDER BY NEWID();

    -- 4️⃣ Calculate total marks based on selected questions
    SELECT @TotalMarks = SUM(q.Marks)
    FROM Exam_Question eq
    INNER JOIN Question q ON eq.QuestionID = q.QuestionID
    WHERE eq.ExamID = @ExamID;

    -- 5️⃣ Update Exam total marks
    UPDATE Exam
    SET TotalMarks = @TotalMarks
    WHERE ExamID = @ExamID;

    -- 6️⃣ Return summary
    SELECT 
        e.ExamID,
        e.ExamTitle,
        e.CourseID,
        COUNT(eq.QuestionID) AS TotalQuestions,
        e.TotalMarks
    FROM Exam e
    JOIN Exam_Question eq ON e.ExamID = eq.ExamID
    WHERE e.ExamID = @ExamID
    GROUP BY e.ExamID, e.ExamTitle, e.CourseID, e.TotalMarks;
END;
GO



SELECT *
FROM Exam_Question
WHERE ExamID = 1;


SELECT 
    eq.OrderNo,
    q.QuestionID,
    q.QuestionText,
    q.QuestionType,
    q.QuestionLevel,
    q.Marks
FROM Exam_Question eq
JOIN Question q 
    ON eq.QuestionID = q.QuestionID
WHERE eq.ExamID = 4
ORDER BY eq.OrderNo;

select * from Course

select * from Question

select * from Choice

select * from Exam

exec sp_GenerateExam 1 , 1 , 'Final', 5 , 5

select q.QuestionText , QuestionType
from Question q where q.CourseID = 14 
