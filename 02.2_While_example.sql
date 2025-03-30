-- WHILE Loop Example: Generating a Sequence of Numbers

-- Declare variables
DECLARE @Counter INT = 1;
DECLARE @MaxNumber INT = 10;
DECLARE @OutputString VARCHAR(MAX) = '';

-- Generate a sequence of numbers using a WHILE loop
WHILE @Counter <= @MaxNumber
BEGIN
    SET @OutputString = @OutputString + CAST(@Counter AS VARCHAR) + ', ';
    SET @Counter = @Counter + 1;
END;

-- Remove the trailing comma and space
IF LEN(@OutputString) > 2
BEGIN
    SET @OutputString = LEFT(@OutputString, LEN(@OutputString) - 2);
END;

-- Display the sequence
PRINT @OutputString;

-- WHILE Loop Example: Simulating a Simple Countdown

-- Declare variables
DECLARE @Countdown INT = 5;

-- Simulate a countdown using a WHILE loop
PRINT 'Countdown starting...';

WHILE @Countdown > 0
BEGIN
    PRINT @Countdown;
    SET @Countdown = @Countdown - 1;
    -- Simulate a delay (not recommended for production, just for demonstration)
    WAITFOR DELAY '00:00:01'; -- 1 second delay
END;

PRINT 'Blastoff!';

-- WHILE Loop Example: Summing numbers until a threshold.

DECLARE @Sum INT = 0;
DECLARE @RunningTotal INT = 0;
DECLARE @Threshold INT = 50;

WHILE @RunningTotal < @Threshold
BEGIN
    SET @Sum = @Sum +1;
    SET @RunningTotal = @RunningTotal + @Sum;
    PRINT CONCAT('Sum: ', @Sum, ' Running Total: ', @RunningTotal);
END;

PRINT CONCAT('Final Running total: ', @RunningTotal);

Explanation:

    Generating a Sequence of Numbers:
        This example uses a WHILE loop to generate a comma-separated sequence of numbers from 1 to 10.
        It initializes variables, builds the output string within the loop, and then removes the trailing comma and space.
        It then prints the result.

    Simulating a Simple Countdown:
        This example simulates a countdown from 5 to 1.
        It uses WAITFOR DELAY to introduce a 1-second pause between each number (note: WAITFOR DELAY should be used sparingly in production environments).
        It demonstrates how a WHILE loop can be used for time-based operations.

    Summing numbers until a threshold:
        This example sums numbers incrementally until a running total reaches or exceeds a specified threshold.
        It prints the running total and the sum at each step.
        It prints the final running total.

These examples illustrate different ways to use WHILE loops in T-SQL for iterative tasks.
