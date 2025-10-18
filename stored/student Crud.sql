CREATE OR ALTER PROCEDURE sp_GetStudent
    @StudentID INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    IF @StudentID IS NULL
        SELECT *
        FROM Student;
    ELSE
        SELECT *
        FROM Student
        WHERE StudentID = @StudentID;
END;
GO

-------------------------------------------------------------

--create student
CREATE OR ALTER PROCEDURE sp_AddStudent
    @F_Name NVARCHAR(50) ,
    @L_Name NVARCHAR(50) ,
    @Email NVARCHAR(100),
    @TrackID INT,
    @BranchID INT,
    @DepartmentID INT,
    @Gender NVARCHAR(10),
    @AdmissionDate DATE,             
    @EnrollmentDate DATE
AS
BEGIN
    INSERT INTO Student (F_Name, L_Name, Email, TrackID, BranchID, DepartmentID, Gender, AdmissionDate , EnrollmentDate)
    VALUES (@F_Name, @L_Name, @Email, @TrackID, @BranchID, @DepartmentID, @Gender, @AdmissionDate, @EnrollmentDate);
END;
GO

---------------------------------------------------------------


CREATE OR ALTER PROCEDURE sp_UpdateStudent
    @StudentID INT,
    @F_Name NVARCHAR(50) = NULL,
    @L_Name NVARCHAR(50) = NULL,
    @Email NVARCHAR(100) = NULL,
    @TrackID INT = NULL,
    @BranchID INT = NULL,
    @DepartmentID INT = NULL,
    @Gender NVARCHAR(10) = NULL,
    @AdmissionDate DATE = NULL,
    @EnrollmentDate DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Student
    SET
        F_Name = COALESCE(@F_Name, F_Name),
        L_Name = COALESCE(@L_Name, L_Name),
        Email = COALESCE(@Email, Email),
        TrackID = COALESCE(@TrackID, TrackID),
        BranchID = COALESCE(@BranchID, BranchID),
        DepartmentID = COALESCE(@DepartmentID, DepartmentID),
        Gender = COALESCE(@Gender, Gender),
        AdmissionDate = COALESCE(@AdmissionDate, AdmissionDate),
        EnrollmentDate = COALESCE(@EnrollmentDate, EnrollmentDate)
    WHERE StudentID = @StudentID;
END;
GO

-- Update student with ID = 1
EXEC sp_UpdateStudent
    @StudentID = 11,
    @F_Name = N'Jana Updated',
    @Email = N'updated@example.com',
    @EnrollmentDate = '2025-10-10';

-- Verify the update
SELECT * FROM Student WHERE StudentID = 1;


CREATE OR ALTER PROCEDURE sp_DeleteStudent
    @StudentID INT
AS
BEGIN
    DELETE FROM Student WHERE StudentID = @StudentID;
END;
GO


CREATE OR ALTER PROCEDURE sp_DeleteStudent
    @StudentID INT
AS
BEGIN
    DELETE FROM Student WHERE StudentID = @StudentID;
END;
GO

CREATE OR ALTER PROCEDURE sp_DeleteStudent_CascadeManual
    @StudentID INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRAN;


        DELETE FROM Student_Answer WHERE StudentID = @StudentID;


        DELETE FROM Exam_Result WHERE StudentID = @StudentID;


        DELETE FROM Student_Course WHERE StudentID = @StudentID;


        DELETE FROM Student_Certification WHERE StudentID = @StudentID;


        DELETE FROM Student_Project WHERE StudentID = @StudentID;


        DELETE FROM Feedback WHERE StudentID = @StudentID;


        DELETE se
        FROM Student_Employment se
        JOIN Graduate g ON se.GraduateID = g.GraduateID
        WHERE g.StudentID = @StudentID;


        DELETE FROM Graduate WHERE StudentID = @StudentID;


        DELETE FROM Student WHERE StudentID = @StudentID;

        COMMIT TRAN;
        SELECT 1 AS Success, 'Student and dependent records deleted.' AS Message;
    END TRY
    BEGIN CATCH
        ROLLBACK TRAN;
        DECLARE @ErrMsg NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrNum INT = ERROR_NUMBER();
        SELECT 0 AS Success, @ErrNum AS ErrorNumber, @ErrMsg AS ErrorMessage;
    END CATCH
END;
GO

insert into Student_Course (CourseID , StudentID , EnrollmentDate)
values (4 , 2 , '2020/1/1')