CREATE OR ALTER PROCEDURE sp_AddGraduate
    @StudentID INT,
    @F_Name NVARCHAR(50),
    @L_Name NVARCHAR(50),
    @Gender NVARCHAR(10),
    @Email NVARCHAR(150) = NULL,
    @TrackID INT,
    @GraduationDate DATE = NULL,
    @GPA DECIMAL(3,2) = NULL,
    @CompanyID INT = NULL,
    @Hire_Date DATE = NULL,
    @Position NVARCHAR(100) = NULL,
    @Salary DECIMAL(10,3) = NULL
AS
BEGIN
    INSERT INTO Graduate (
        StudentID, F_Name, L_Name, Gender, Email, TrackID, GraduationDate, GPA, CompanyID, Hire_Date, Position, Salary
    )
    VALUES (
        @StudentID, @F_Name, @L_Name, @Gender, @Email, @TrackID,
        ISNULL(@GraduationDate, GETDATE()), @GPA, @CompanyID, @Hire_Date, @Position, @Salary
    );
END;
GO

----------------------------------------------------------------------------



CREATE OR ALTER PROCEDURE sp_GetGraduate
@GraduateID INT = NULL
AS
BEGIN
    IF @GraduateID IS NULL
        SELECT * FROM Graduate;
    ELSE
        SELECT * FROM Graduate WHERE GraduateID = @GraduateID;
END;
GO


------------------------------------------------------------------------


CREATE OR ALTER PROCEDURE sp_UpdateGraduate
    @GraduateID INT,
    @StudentID INT = NULL,
    @F_Name NVARCHAR(50) = NULL,
    @L_Name NVARCHAR(50) = NULL,
    @Gender NVARCHAR(10) = NULL,
    @Email NVARCHAR(150) = NULL,
    @TrackID INT = NULL,
    @GraduationDate DATE = NULL,
    @GPA DECIMAL(3,2) = NULL,
    @CompanyID INT = NULL,
    @Hire_Date DATE = NULL,
    @Position NVARCHAR(100) = NULL,
    @Salary DECIMAL(10,3) = NULL
AS
BEGIN
    UPDATE Graduate
    SET 
        StudentID = COALESCE(@StudentID, StudentID),
        F_Name = COALESCE(@F_Name, F_Name),
        L_Name = COALESCE(@L_Name, L_Name),
        Gender = COALESCE(@Gender, Gender),
        Email = COALESCE(@Email, Email),
        TrackID = COALESCE(@TrackID, TrackID),
        GraduationDate = COALESCE(@GraduationDate, GraduationDate),
        GPA = COALESCE(@GPA, GPA),
        CompanyID = COALESCE(@CompanyID, CompanyID),
        Hire_Date = COALESCE(@Hire_Date, Hire_Date),
        Position = COALESCE(@Position, Position),
        Salary = COALESCE(@Salary, Salary)
    WHERE GraduateID = @GraduateID;
END;
GO

----------------------------------------------------------------




    CREATE OR ALTER PROCEDURE sp_DeleteGraduate
    @GraduateID INT
AS
BEGIN
    DELETE FROM Graduate WHERE GraduateID = @GraduateID;
END;
GO


