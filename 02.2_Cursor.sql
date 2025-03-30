-- Cursor Example: Concatenating Names into a Comma-Separated String

-- Declare variables
DECLARE @CustomerID INT;
DECLARE @FirstName VARCHAR(50);
DECLARE @LastName VARCHAR(50);
DECLARE @FullNames VARCHAR(MAX) = ''; -- Initialize an empty string

-- Declare a cursor
DECLARE CustomerCursor CURSOR FOR
SELECT CustomerID, FirstName, LastName
FROM Customers
WHERE City = 'London'; -- Example filter

-- Open the cursor
OPEN CustomerCursor;

-- Fetch the first row
FETCH NEXT FROM CustomerCursor INTO @CustomerID, @FirstName, @LastName;

-- Loop through the rows
WHILE @@FETCH_STATUS = 0
BEGIN
    -- Concatenate the full name with a comma
    IF @FullNames = ''
    BEGIN
        SET @FullNames = @FirstName + ' ' + @LastName;
    END
    ELSE
    BEGIN
        SET @FullNames = @FullNames + ', ' + @FirstName + ' ' + @LastName;
    END;

    -- Fetch the next row
    FETCH NEXT FROM CustomerCursor INTO @CustomerID, @FirstName, @LastName;
END;

-- Close and deallocate the cursor
CLOSE CustomerCursor;
DEALLOCATE CustomerCursor;

-- Display the concatenated names
PRINT @FullNames;

--Example of a set based method that would accomplish the same, and is much faster.
--SELECT STRING_AGG(FirstName + ' ' + LastName, ', ')
--FROM Customers
--WHERE City = 'London';

Explanation:

    Declare Variables:
        @CustomerID, @FirstName, and @LastName store the values retrieved from each row.
        @FullNames is initialized as an empty string and will hold the concatenated names.

    Declare Cursor:
        A cursor named CustomerCursor is declared to select CustomerID, FirstName, and LastName from the Customers table, filtered by City = 'London'.

    Open Cursor:
        The OPEN CustomerCursor statement executes the SELECT query and populates the cursor with the result set.

    Fetch First Row:
        FETCH NEXT FROM CustomerCursor INTO @CustomerID, @FirstName, @LastName retrieves the first row of data and stores the values in the declared variables.

    Loop Through Rows:
        The WHILE @@FETCH_STATUS = 0 loop continues as long as there are more rows to fetch.
        Inside the loop:
            The IF statement checks if @FullNames is empty. If it is, the first name is added without a comma. Otherwise, the current name is appended with a comma.
            FETCH NEXT retrieves the next row.
        This is an example of a common use case for cursors, where we need to aggregate data into a string, row by row.

    Close and Deallocate Cursor:
        CLOSE CustomerCursor releases the cursor's resources.
        DEALLOCATE CustomerCursor removes the cursor definition.

    Display Result:
        PRINT @FullNames displays the final concatenated string of names.

    Set based example:
        The commented out select statement shows how the same result can be achived with the STRING_AGG function. This is much faster and more efficient.

This example demonstrates how cursors can be used to process rows one by one and build a string from the results.
