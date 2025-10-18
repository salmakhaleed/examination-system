CREATE OR ALTER PROCEDURE sp_AddFreelanceProject
    @ProjectTitle VARCHAR(100),
    @Description VARCHAR(255) = NULL,
    @RequiredSkills VARCHAR(255) = NULL,
    @Budget DECIMAL(10,2) = NULL,
    @Deadline DATE = NULL
AS
BEGIN
    INSERT INTO Freelance_Project (ProjectTitle, Description, RequiredSkills, Budget, Deadline)
    VALUES (@ProjectTitle, @Description, @RequiredSkills, @Budget, @Deadline);
END;
GO


----------------------------------------------------------------

CREATE OR ALTER PROCEDURE sp_GetFreelanceProject
    @ProjectID INT = NULL
AS
BEGIN
    IF @ProjectID IS NULL
        SELECT * FROM Freelance_Project;
    ELSE
        SELECT * FROM Freelance_Project WHERE ProjectID = @ProjectID;
END;
GO

----------------------------------------------------------------------------


CREATE OR ALTER PROCEDURE sp_UpdateFreelanceProject
    @ProjectID INT,
    @ProjectTitle VARCHAR(100) = NULL,
    @Description VARCHAR(255) = NULL,
    @RequiredSkills VARCHAR(255) = NULL,
    @Budget DECIMAL(10,2) = NULL,
    @Deadline DATE = NULL
AS
BEGIN
    UPDATE Freelance_Project
    SET 
        ProjectTitle = COALESCE(@ProjectTitle, ProjectTitle),
        Description = COALESCE(@Description, Description),
        RequiredSkills = COALESCE(@RequiredSkills, RequiredSkills),
        Budget = COALESCE(@Budget, Budget),
        Deadline = COALESCE(@Deadline, Deadline)
    WHERE ProjectID = @ProjectID;
END;
GO


--------------------------------------------------------------------


CREATE OR ALTER PROCEDURE sp_DeleteFreelanceProject
    @ProjectID INT
AS
BEGIN
    DELETE FROM Freelance_Project WHERE ProjectID = @ProjectID;
END;
GO

