CREATE PROCEDURE sp_getStudentFromDept
    @DepartmentID INT = NULL
AS
BEGIN
    SELECT 
        s.StudentID,
        s.F_Name,
        s.L_Name,
        s.Email,
        d.DepartmentID
    FROM Student s
    JOIN Department d 
        ON s.DepartmentID = d.DepartmentID
    WHERE (@DepartmentID IS NULL OR s.DepartmentID = @DepartmentID)
END;
GO


---------------------------------------------------------------


CREATE OR ALTER PROCEDURE sp_StudentCourseGrades
    @StudentID INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        s.StudentID,
        s.F_Name,
        s.L_Name,
        c.CourseName,
        e.TotalMarks AS ExamTotalMarks,
        er.Score AS StudentScore,
        er.Percentage AS StoredPercentage,
        er.Status,
        e.ExamDate
    FROM Exam_Result er
    INNER JOIN Exam e ON er.ExamID = e.ExamID
    INNER JOIN Course c ON e.CourseID = c.CourseID
    INNER JOIN Student s ON er.StudentID = s.StudentID
    WHERE s.StudentID = @StudentID
    ORDER BY e.ExamDate DESC;
END;
go

exec sp_StudentCourseGrades 1;
---------------------------------------------------------------------


CREATE OR ALTER PROCEDURE sp_GetInstructorCoursesAndStudents
    @InstructorID INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        i.InstructorID,
        i.InstructorName,
        c.CourseID,
        c.CourseName,
        COUNT(DISTINCT sc.StudentID) AS NumberOfStudents
    FROM Instructor i
    INNER JOIN Course c ON i.InstructorID = c.InstructorID
    LEFT JOIN Student_Course sc ON c.CourseID = sc.CourseID
    WHERE i.InstructorID = @InstructorID
    GROUP BY i.InstructorID, i.InstructorName, c.CourseID, c.CourseName
    ORDER BY c.CourseName;
END;
GO

exec sp_GetInstructorCoursesAndStudents 2
------------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE sp_GetCourseTopics
    @CourseID INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        c.CourseID,
        c.CourseName,
        t.TopicName
    FROM Topic t
    INNER JOIN Course c ON t.CourseID = c.CourseID
    WHERE t.CourseID = @CourseID
    ORDER BY t.TopicName;
END;
go



exec sp_GetCourseTopics 4
--------------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE sp_GetExamQuestionsAndChoices
    @ExamID INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        e.ExamID,
        q.QuestionText,
        ch.ChoiceText
    FROM Exam e
    INNER JOIN Exam_Question eq ON e.ExamID = eq.ExamID
    INNER JOIN Question q ON eq.QuestionID = q.QuestionID
    INNER JOIN Course c ON e.CourseID = c.CourseID
    LEFT JOIN Choice ch ON q.QuestionID = ch.QuestionID
    WHERE e.ExamID = @ExamID
    ORDER BY q.QuestionID, ch.ChoiceID;
END;
GO



EXEC sp_GetExamQuestionsAndChoices @ExamID = 1;
------------------------------------------------------------------------

CREATE OR ALTER PROCEDURE sp_GetStudentAnsweredQuestions
    @ExamID INT,
    @StudentID INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        e.ExamID,
        s.F_Name,
        s.L_Name,
        q.QuestionText,
        sa.AnswerText AS StudentAnswer
    FROM Student_Answer sa
    INNER JOIN Exam e ON sa.ExamID = e.ExamID
    INNER JOIN Course c ON e.CourseID = c.CourseID
    INNER JOIN Question q ON sa.QuestionID = q.QuestionID
    INNER JOIN Student s ON sa.StudentID = s.StudentID
    LEFT JOIN Choice ch ON q.QuestionID = ch.QuestionID AND ch.IsCorrect = 1
    WHERE sa.ExamID = @ExamID
      AND sa.StudentID = @StudentID
    ORDER BY q.QuestionID;
END;
GO


exec sp_GetStudentAnsweredQuestions 1 , 1

