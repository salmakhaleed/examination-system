CREATE OR ALTER PROCEDURE sp_AddQuestion
    @CourseID INT,
    @TopicID INT,
    @QuestionText NVARCHAR(500),
    @QuestionType NVARCHAR(10),
    @Marks INT
AS
BEGIN
    INSERT INTO Question (CourseID, TopicID, QuestionText, QuestionType, Marks)
    VALUES (@CourseID, @TopicID, @QuestionText, @QuestionType, @Marks);
END;
GO
--------------------------------------------------------------------
CREATE OR ALTER PROCEDURE sp_GetQuestion
    @QuestionID INT = NULL
AS
BEGIN
    IF @QuestionID IS NULL
        SELECT * FROM Question;
    ELSE
        SELECT * FROM Question WHERE QuestionID = @QuestionID;
END;
GO
---------------------------------------------------------------------
CREATE OR ALTER PROCEDURE sp_UpdateQuestion
    @QuestionID INT,
    @CourseID INT = NULL,
    @TopicID INT = NULL,
    @QuestionText NVARCHAR(500) = NULL,
    @QuestionType NVARCHAR(10) = NULL,
    @Marks INT = NULL
AS
BEGIN
    UPDATE Question
    SET 
        CourseID = COALESCE(@CourseID, CourseID),
        TopicID = COALESCE(@TopicID, TopicID),
        QuestionText = COALESCE(@QuestionText, QuestionText),
        QuestionType = COALESCE(@QuestionType, QuestionType),
        Marks = COALESCE(@Marks, Marks)
    WHERE QuestionID = @QuestionID;
END;
GO
------------------------------------------------------------
CREATE OR ALTER PROCEDURE sp_DeleteQuestion
    @QuestionID INT
AS
BEGIN
    DELETE FROM Question WHERE QuestionID = @QuestionID;
END;
GO

