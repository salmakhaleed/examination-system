CREATE OR ALTER PROCEDURE sp_AddTopic
    @CourseID INT,
    @TopicName NVARCHAR(150)
AS
BEGIN
    INSERT INTO Topic (CourseID, TopicName)
    VALUES (@CourseID, @TopicName);
END;
GO

------------------------------------------------------

CREATE OR ALTER PROCEDURE sp_GetTopic
    @TopicID INT = NULL
AS
BEGIN
    IF @TopicID IS NULL
        SELECT * FROM Topic;
    ELSE
        SELECT * FROM Topic WHERE TopicID = @TopicID;
END;
GO

---------------------------------------------------------------


CREATE OR ALTER PROCEDURE sp_UpdateTopic
    @TopicID INT,
    @CourseID INT = NULL,
    @TopicName NVARCHAR(150) = NULL
AS
BEGIN
    UPDATE Topic
    SET 
        CourseID = COALESCE(@CourseID, CourseID),
        TopicName = COALESCE(@TopicName, TopicName)
    WHERE TopicID = @TopicID;
END;
GO

----------------------------------------------------------------
 


CREATE OR ALTER PROCEDURE sp_DeleteTopic
    @TopicID INT
AS
BEGIN
    DELETE FROM Topic WHERE TopicID = @TopicID;
END;
GO




