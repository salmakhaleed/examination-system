CREATE TYPE StudentAnswerList AS TABLE
(
    QuestionID INT,
    AnswerText VARCHAR(200)
);


CREATE PROCEDURE sp_AddStudentAnswers
    @StudentID INT,
    @ExamID INT,
    @Answers StudentAnswerList READONLY
AS
BEGIN
    SET NOCOUNT ON;

    -- 🔍 Validation: ensure the student hasn’t already submitted
    IF EXISTS (SELECT 1 FROM Student_Answer WHERE StudentID = @StudentID AND ExamID = @ExamID)
    BEGIN
        RAISERROR('Answers for this student and exam already exist.', 16, 1);
        RETURN;
    END

    -- 🔍 Validation: ensure exam is valid
    IF NOT EXISTS (SELECT 1 FROM Exam WHERE ExamID = @ExamID)
    BEGIN
        RAISERROR('Invalid ExamID.', 16, 1);
        RETURN;
    END

    -- 1️⃣ Insert all answers
    INSERT INTO Student_Answer (StudentID, ExamID, QuestionID, AnswerText)
    SELECT 
        @StudentID,
        @ExamID,
        a.QuestionID,
        a.AnswerText
    FROM @Answers a
    WHERE EXISTS (
        SELECT 1 FROM Exam_Question eq
        WHERE eq.ExamID = @ExamID AND eq.QuestionID = a.QuestionID
    );

    -- 2️⃣ Return confirmation summary
    SELECT 
        COUNT(*) AS InsertedAnswers,
        @StudentID AS StudentID,
        @ExamID AS ExamID
    FROM Student_Answer
    WHERE StudentID = @StudentID AND ExamID = @ExamID;
END;


DECLARE @MyAnswers AS StudentAnswerList;

INSERT INTO @MyAnswers (QuestionID, AnswerText)
VALUES 
(1, 'Data visualization and analytics'),
(2, 'Microsoft'),
(3, '.pbix'),
(4, 'Power BI Service'),
(5, 'DAX'),
(6, 'PowerPoint BI'),
(7, 'SQL databases and Excel files'),
(8, 'False'),  -- Power BI is a cloud-only service
(9, 'True'),   -- Power BI supports DAX formulas
(10, 'False'); -- Power BI reports cannot be shared publicly

DECLARE @MyAnswers AS StudentAnswerList;

INSERT INTO @MyAnswers (QuestionID, AnswerText)
VALUES
(8, 'Hyper Text Markup Language'),
(1, 'background-color'),
(4,  'justify-content'),
(10,  '[data-modal]'),
(12,  '<article>'),
(13,  'True'),
(14,  'False'),
(15,  'True'),
(16, 'False'),
(17, 'False');


EXEC sp_AddStudentAnswers
    @StudentID = 2,
    @ExamID = 4,
    @Answers = @MyAnswers;



SELECT 
    sa.StudentID,
    s.F_Name,
    sa.ExamID,
    e.ExamTitle,
    sa.QuestionID,
    q.QuestionText,
    sa.AnswerText
FROM Student_Answer sa
JOIN Student s ON sa.StudentID = s.StudentID
JOIN Exam e ON sa.ExamID = e.ExamID
JOIN Question q ON sa.QuestionID = q.QuestionID
WHERE sa.StudentID = 2 AND sa.ExamID = 4;


select * from Exam_Result

select * from Student_Answer
