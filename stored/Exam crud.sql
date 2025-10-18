CREATE OR ALTER PROCEDURE sp_AddExam
    @CourseID INT,
    @InstructorID INT,
    @ExamTitle NVARCHAR(100),
    @ExamDate DATE,
    @DurationMinutes INT,
    @TotalMarks DECIMAL(5,2),
    @IsPublished BIT 
AS
BEGIN
    INSERT INTO Exam (CourseID, InstructorID, ExamTitle, ExamDate,DurationMinutes,TotalMarks , IsPublished)
    VALUES (@CourseID, @InstructorID, @ExamTitle, @ExamDate, @DurationMinutes, @TotalMarks, @IsPublished);
END;
GO
-----------------------------------------------------------------------
CREATE OR ALTER PROCEDURE sp_GetExam
    @ExamID INT = NULL
AS
BEGIN
    IF @ExamID IS NULL
        SELECT * FROM Exam;
    ELSE
        SELECT * FROM Exam WHERE ExamID = @ExamID;
END;
GO
-----------------------------------------------------------------------
CREATE OR ALTER PROCEDURE sp_UpdateExam
    @ExamID INT,
    @CourseID INT = NULL,
    @InstructorID INT = NULL,
    @ExamTitle NVARCHAR(100) = NULL,
    @ExamDate DATE = NULL,
    @DurationMinutes INT,
    @TotalMarks DECIMAL(5,2) = 0,
    @IsPublished BIT = 0
AS
BEGIN
    UPDATE Exam
    SET 
        CourseID = COALESCE(@CourseID, CourseID),
        InstructorID = COALESCE(@InstructorID, InstructorID),
        ExamTitle = COALESCE(@ExamTitle, ExamTitle),
        ExamDate = COALESCE(@ExamDate, ExamDate),
        DurationMinutes = COALESCE(@DurationMinutes, DurationMinutes),
        TotalMarks = COALESCE(@TotalMarks, TotalMarks),
        IsPublished = COALESCE(@IsPublished, IsPublished)
    WHERE ExamID = @ExamID;
END;
GO
-------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE sp_DeleteExam
    @ExamID INT
AS
BEGIN
    DELETE FROM Exam WHERE ExamID = @ExamID;
END;
GO



