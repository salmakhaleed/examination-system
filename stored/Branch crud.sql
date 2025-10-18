CREATE OR ALTER PROCEDURE sp_AddBranch
    @BranchName NVARCHAR(100)
AS
BEGIN
    INSERT INTO Branch (BranchName)
    VALUES (@BranchName);
END;
GO
----------------------------------------------------------------
CREATE OR ALTER PROCEDURE sp_GetBranch
    @BranchID INT = NULL
AS
BEGIN
    IF @BranchID IS NULL
        SELECT * FROM Branch;
    ELSE
        SELECT * FROM Branch WHERE BranchID = @BranchID;
END;
GO
-----------------------------------------------------------------
CREATE OR ALTER PROCEDURE sp_UpdateBranch
    @BranchID INT,
    @BranchName NVARCHAR(100) = NULL
AS
BEGIN
    UPDATE Branch
    SET
        BranchName = COALESCE(@BranchName, BranchName)
    WHERE BranchID = @BranchID;
END;
GO
-----------------------------------------------------------------
CREATE OR ALTER PROCEDURE sp_DeleteBranch
    @BranchID INT
AS
BEGIN
    DELETE FROM Branch WHERE BranchID = @BranchID;
END;
GO