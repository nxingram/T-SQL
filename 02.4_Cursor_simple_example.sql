

In SQL it is called CURSORS. The basic structure of CURSOR is:

 DECLARE @ColumnA INT, @ColumnB INT

 DECLARE CurName CURSOR FAST_FORWARD READ_ONLY
 FOR
    SELECT  ColumnA, ColumnB
    FROM    SomeTable

 OPEN CurName

 FETCH NEXT FROM CurName INTO @ColumnA, @ColumnB

 WHILE @@FETCH_STATUS = 0
    BEGIN

        INSERT  INTO TableA( ColumnA )
        VALUES  ( @ColumnA )
        INSERT  INTO TableB( ColumnB )
        VALUES  ( @ColumnB )

        FETCH NEXT FROM CurName INTO @ColumnA, @ColumnB

    END

 CLOSE CurName
 DEALLOCATE CurName

Another way of iterative solution is WHILE loop. But for this to work you should have unique identity column in a table. For example

DECLARE @id INT

SELECT TOP 1 @id  =  id FROM dbo.Orders ORDER BY ID

WHILE @id IS NOT NULL
BEGIN

  PRINT @id

  SELECT TOP 1 @id  =  id FROM dbo.Orders WHERE ID > @id ORDER BY ID
  IF @@ROWCOUNT = 0
  BREAK

END

But note that you should avoid using CURSORS if there is alternative not iterative way of doing the same job. 
 But of course there are a situations when you can not avoid CURSORs






.
