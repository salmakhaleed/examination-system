USE [exam_systyem]
GO

/****** Object:  StoredProcedure [dbo].[sp_GenerateExam]    Script Date: 10/12/2025 3:15:53 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GenerateExam]
    @CourseID INT,
    @InstructorID INT,
    @ExamTitle VARCHAR(100),
    @NumMCQ INT,
    @NumTF INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @ExamID INT;

    -- 1️⃣ Create new exam record
    INSERT INTO Exam (CourseID, InstructorID, ExamTitle, ExamType, ExamDate, DurationMinutes, TotalMarks, PassingScore, IsPublished)
    VALUES (@CourseID, @InstructorID, @ExamTitle, 'Auto-Generated', GETDATE(), 60, 0, 0, 0);

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

    -- 4️⃣ Optional: Return summary
    SELECT 
        e.ExamID, e.ExamTitle, e.CourseID, COUNT(eq.QuestionID) AS TotalQuestions
    FROM Exam e
    JOIN Exam_Question eq ON e.ExamID = eq.ExamID
    WHERE e.ExamID = @ExamID
    GROUP BY e.ExamID, e.ExamTitle, e.CourseID;
END;
GO

