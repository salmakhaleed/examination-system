USE [exam_systyem]
GO

/****** Object:  StoredProcedure [dbo].[sp_CorrectExam]    Script Date: 10/12/2025 3:16:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_CorrectExam]
    @StudentID INT,
    @ExamID INT
AS
BEGIN
    SET NOCOUNT ON;

    -- 1️⃣ Validate student has submitted answers
    IF NOT EXISTS (
        SELECT 1 
        FROM Student_Answer 
        WHERE StudentID = @StudentID AND ExamID = @ExamID
    )
    BEGIN
        RAISERROR('No answers found for this student and exam.', 16, 1);
        RETURN;
    END;

    -- 2️⃣ Update each Student_Answer.IsCorrect based on correct choice
    UPDATE sa
    SET sa.IsCorrect =
        CASE 
            WHEN EXISTS (
                SELECT 1
                FROM Choice c
                WHERE c.QuestionID = sa.QuestionID
                AND c.IsCorrect = 1
                AND LOWER(LTRIM(RTRIM(sa.AnswerText))) = LOWER(LTRIM(RTRIM(c.ChoiceText)))
            )
            THEN 1
            ELSE 0
        END
    FROM Student_Answer sa
    WHERE sa.StudentID = @StudentID
      AND sa.ExamID = @ExamID;

    -- 3️⃣ Calculate student's total and max score
    DECLARE @TotalScore DECIMAL(10,2);
    DECLARE @MaxScore DECIMAL(10,2);

    SELECT @TotalScore = ISNULL(SUM(q.Marks), 0)
    FROM Student_Answer sa
    JOIN Question q ON sa.QuestionID = q.QuestionID
    WHERE sa.StudentID = @StudentID 
      AND sa.ExamID = @ExamID
      AND sa.IsCorrect = 1;

    SELECT @MaxScore = ISNULL(SUM(q.Marks), 0)
    FROM Exam_Question eq
    JOIN Question q ON eq.QuestionID = q.QuestionID
    WHERE eq.ExamID = @ExamID;

    IF @MaxScore = 0
    BEGIN
        RAISERROR('No questions or marks found for this exam.', 16, 1);
        RETURN;
    END;

    -- 4️⃣ Compute percentage and pass/fail
    DECLARE @Percentage DECIMAL(5,2) = ROUND((@TotalScore / @MaxScore) * 100, 2);
    DECLARE @ResultStatus VARCHAR(10) = CASE 
        WHEN @Percentage >= 60 THEN 'Pass' 
        ELSE 'Fail' 
    END;

    -- 5️⃣ Insert or update Exam_Result
    IF EXISTS (SELECT 1 FROM Exam_Result WHERE ExamID = @ExamID AND StudentID = @StudentID)
    BEGIN
        UPDATE Exam_Result
        SET 
            Score = @TotalScore,
            Percentage = @Percentage,
            ResultStatus = @ResultStatus
        WHERE ExamID = @ExamID AND StudentID = @StudentID;
    END
    ELSE
    BEGIN
        INSERT INTO Exam_Result (ExamID, StudentID, Score, Percentage, ResultStatus)
        VALUES (@ExamID, @StudentID, @TotalScore, @Percentage, @ResultStatus);
    END;

    -- 6️⃣ Return summary
    SELECT 
        @StudentID AS StudentID,
        @ExamID AS ExamID,
        @TotalScore AS ScoreObtained,
        @MaxScore AS MaxScore,
        @Percentage AS Percentage,
        @ResultStatus AS ResultStatus;
END;
GO

