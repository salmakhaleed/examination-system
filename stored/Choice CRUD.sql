CREATE OR ALTER PROCEDURE sp_AddChoice
    @QuestionID INT,
    @ChoiceText NVARCHAR(500),
    @IsCorrect BIT = 0
AS
BEGIN
    INSERT INTO Choice (QuestionID, ChoiceText, IsCorrect)
    VALUES (@QuestionID, @ChoiceText, @IsCorrect);
END;
GO

----------------------------------------------------------------------



    CREATE OR ALTER PROCEDURE sp_GetChoice
    @ChoiceID INT = NULL
AS
BEGIN
    IF @ChoiceID IS NULL
        SELECT * FROM Choice;
    ELSE
        SELECT * FROM Choice WHERE ChoiceID = @ChoiceID;
END;
GO

----------------------------------------------------------------


CREATE OR ALTER PROCEDURE sp_UpdateChoice
    @ChoiceID INT,
    @QuestionID INT = NULL,
    @ChoiceText NVARCHAR(500) = NULL,
    @IsCorrect BIT = NULL
AS
BEGIN
    UPDATE Choice
    SET 
        QuestionID = COALESCE(@QuestionID, QuestionID),
        ChoiceText = COALESCE(@ChoiceText, ChoiceText),
        IsCorrect = COALESCE(@IsCorrect, IsCorrect)
    WHERE ChoiceID = @ChoiceID;
END;
GO

---------------------------------------------------------------------


CREATE OR ALTER PROCEDURE sp_DeleteChoice
    @ChoiceID INT
AS
BEGIN
    DELETE FROM Choice WHERE ChoiceID = @ChoiceID;
END;
GO




