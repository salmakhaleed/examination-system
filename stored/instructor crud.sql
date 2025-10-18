CREATE OR ALTER PROCEDURE sp_AddInstructor
    @InstructorName NVARCHAR(100),
    @Email NVARCHAR(100),
    @DepartmentID INT
AS
BEGIN
    INSERT INTO Instructor (InstructorName, Email, DepartmentID)
    VALUES (@InstructorName, @Email, @DepartmentID);
END;
GO

-------------------------------------------------------------------

CREATE OR ALTER PROCEDURE sp_GetInstructor
AS
BEGIN
        SELECT * FROM Instructor;
END;
GO


CREATE OR ALTER PROCEDURE sp_GetInstructorone
    @InstructorID INT = NULL
AS
BEGIN
    IF @InstructorID IS NULL
        SELECT * FROM Instructor;
    ELSE
        SELECT * FROM Instructor WHERE InstructorID = @InstructorID;
END;
GO

----------------------------------------------------------
CREATE OR ALTER PROCEDURE sp_UpdateInstructor
    @InstructorID INT,
    @InstructorName NVARCHAR(100) = NULL,
    @Email NVARCHAR(100) = NULL,
    @DepartmentID INT = NULL
AS
BEGIN
    UPDATE Instructor
    SET 
        InstructorName = COALESCE(@InstructorName, InstructorName),
        Email = COALESCE(@Email, Email),
        DepartmentID = COALESCE(@DepartmentID, DepartmentID)
    WHERE InstructorID = @InstructorID;
END;
GO
-------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE sp_DeleteInstructor
    @InstructorID INT
AS
BEGIN
    DELETE FROM Instructor WHERE InstructorID = @InstructorID;
END;
GO






select * from Instructor

EXEC sp_GetInstructor;
EXEC sp_AddInstructor 'Jana Mostafa', 'jana@ddd.com', NULL;
-- Get all instructors (if no ID passed)
EXEC sp_GetInstructorone NULL;

-- Get instructor with ID 2
EXEC sp_GetInstructorone 2;
-- Example: Update InstructorID = 1
EXEC sp_UpdateInstructor
    @InstructorID = 1,
    @InstructorName = 'Jana A. Mostafa',
    @Email = 'janaa@ddd.com',
    @DepartmentID = 1;
-- Example: Delete InstructorID = 1
EXEC sp_DeleteInstructor @InstructorID = 1;