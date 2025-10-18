CREATE OR ALTER PROCEDURE sp_AddCertification
    @CourseID INT,
    @CertificationTitle NVARCHAR(150),
    @IssueDate DATE
AS
BEGIN
    INSERT INTO Certification ( CourseID, CertificationTitle, IssueDate)
    VALUES (@CourseID, @CertificationTitle, @IssueDate);
END;
GO


---------------------------------------------------------------------

CREATE OR ALTER PROCEDURE sp_GetCertification
    @CertificationID INT = NULL
AS
BEGIN
    IF @CertificationID IS NULL
        SELECT * FROM Certification;
    ELSE
        SELECT * FROM Certification WHERE CertificationID = @CertificationID;
END;
GO

-------------------------------------------------------------------


CREATE OR ALTER PROCEDURE sp_UpdateCertification
    @CertificationID INT,
    @CertificationTitle NVARCHAR(150) = NULL,
    @IssueDate DATE = NULL
AS
BEGIN
    UPDATE Certification
    SET
        CertificationTitle = COALESCE(@CertificationTitle, CertificationTitle),
        IssueDate = COALESCE(@IssueDate, IssueDate)
    WHERE CertificationID = @CertificationID;
END;
GO

-----------------------------------------------------------

CREATE OR ALTER PROCEDURE sp_DeleteCertification
    @CertificationID INT
AS
BEGIN
    DELETE FROM Certification WHERE CertificationID = @CertificationID;
END;
GO
