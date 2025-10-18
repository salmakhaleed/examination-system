CREATE OR ALTER PROCEDURE sp_AddIntake
    @IntakeNumber INT,
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
    INSERT INTO Intake (IntakeNumber, StartDate, EndDate)
    VALUES (@IntakeNumber, @StartDate, @EndDate);
END;
GO
-----------------------------------------------------------------
CREATE OR ALTER PROCEDURE sp_GetIntake
    @IntakeID INT = NULL
AS
BEGIN
    IF @IntakeID IS NULL
        SELECT * FROM Intake;
    ELSE
        SELECT * FROM Intake WHERE IntakeID = @IntakeID;
END;
GO
------------------------------------------------------------------
CREATE OR ALTER PROCEDURE sp_UpdateIntake
    @IntakeID INT,
    @IntakeNumber INT,
    @StartDate DATE = NULL,
    @EndDate DATE = NULL
AS
BEGIN
    UPDATE Intake
    SET
        IntakeNumber = COALESCE(@IntakeNumber, IntakeNumber),
        StartDate = COALESCE(@StartDate, StartDate),
        EndDate = COALESCE(@EndDate, EndDate)
    WHERE IntakeID = @IntakeID;
END;
GO
--------------------------------------------------------------------
CREATE OR ALTER PROCEDURE sp_DeleteIntake
    @IntakeID INT
AS
BEGIN
    DELETE FROM Intake WHERE IntakeID = @IntakeID;
END;
GO