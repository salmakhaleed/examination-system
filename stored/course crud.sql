CREATE OR ALTER PROCEDURE sp_AddCourse
    @CourseName NVARCHAR(100),
    @InstructorID INT
AS
BEGIN
    INSERT INTO Course (CourseName, InstructorID)
    VALUES (@CourseName, @InstructorID);
END;
GO
--------------------------------------------------------------

CREATE OR ALTER PROCEDURE sp_GetCourse
    @CourseID INT = NULL
AS
BEGIN
    IF @CourseID IS NULL
        SELECT * FROM Course;
    ELSE
        SELECT * FROM Course WHERE CourseID = @CourseID;
END;
GO

------------------------------------------------------------

CREATE OR ALTER PROCEDURE sp_UpdateCourse
    @CourseID INT,
    @CourseName NVARCHAR(100) = NULL,
    @InstructorID INT = NULL
AS
BEGIN
    UPDATE Course
    SET
        CourseName = COALESCE(@CourseName, CourseName),
        InstructorID = COALESCE(@InstructorID, InstructorID)
    WHERE CourseID = @CourseID;
END;
GO

--------------------------------------------------------------


CREATE OR ALTER PROCEDURE sp_DeleteCourse
    @CourseID INT
AS
BEGIN
    DELETE FROM Course WHERE CourseID = @CourseID;
END;
GO
