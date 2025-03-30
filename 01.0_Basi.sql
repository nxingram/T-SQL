T-SQL (Transact-SQL) è un linguaggio di programmazione utilizzato per gestire e manipolare database relazionali in Microsoft SQL Server. 
    È un'estensione di SQL (Structured Query Language) e aggiunge funzionalità procedurali, variabili, controllo di flusso e altro ancora.

Iniziamo con le basi e poi approfondiremo gradualmente.

1. Fondamenti di SQL (richiesti per T-SQL):

    SELECT: Recupera dati da una o più tabelle.
        Esempio: SELECT * FROM Customers; (seleziona tutte le colonne e righe dalla tabella Customers)
        Esempio: SELECT FirstName, LastName FROM Customers WHERE City = 'New York'; (seleziona solo i nomi e cognomi dei clienti di New York)
    INSERT: Inserisce nuove righe in una tabella.
        Esempio: INSERT INTO Products (ProductName, Price) VALUES ('Laptop', 1200.00);
    UPDATE: Modifica righe esistenti in una tabella.
        Esempio: UPDATE Products SET Price = 1300.00 WHERE ProductName = 'Laptop';
    DELETE: Elimina righe da una tabella.
        Esempio: DELETE FROM Products WHERE ProductName = 'Laptop';
    WHERE: Filtra le righe in base a una condizione.
        Esempio: SELECT * FROM Orders WHERE OrderDate > '2023-01-01';
    ORDER BY: Ordina i risultati di una query.
        Esempio: SELECT * FROM Products ORDER BY Price DESC; (ordina i prodotti per prezzo in ordine decrescente)
    GROUP BY: Raggruppa le righe in base a una o più colonne.
        Esempio: SELECT City, COUNT(*) FROM Customers GROUP BY City; (conta il numero di clienti per città)
    JOIN: Combina righe da due o più tabelle in base a una colonna correlata.
        Esempio: SELECT Orders.OrderID, Customers.CustomerName FROM Orders JOIN Customers ON Orders.CustomerID = Customers.CustomerID;

2. Estensioni T-SQL:

    Variabili:
        Dichiarazione: DECLARE @VariableName DataType;
        Assegnazione: SET @VariableName = Value;
        Esempio:
        SQL

    DECLARE @CustomerCount INT;
    SET @CustomerCount = (SELECT COUNT(*) FROM Customers);
    SELECT @CustomerCount;

Controllo di flusso:

    IF...ELSE: Esegue blocchi di codice in base a una condizione.
    SQL

DECLARE @Price DECIMAL(10, 2);
SET @Price = (SELECT Price FROM Products WHERE ProductName = 'Laptop');
IF @Price > 1000
BEGIN
    PRINT 'Il prezzo è alto.';
END
ELSE
BEGIN
    PRINT 'Il prezzo è ragionevole.';
END

WHILE: Esegue un blocco di codice ripetutamente finché una condizione è vera.
SQL

DECLARE @Counter INT;
SET @Counter = 1;
WHILE @Counter <= 5
BEGIN
    PRINT @Counter;
    SET @Counter = @Counter + 1;
END

CASE: Valuta più condizioni e restituisce un valore.
SQL

    SELECT ProductName,
           CASE
               WHEN Price > 1000 THEN 'Costoso'
               WHEN Price > 500 THEN 'Medio'
               ELSE 'Economico'
           END AS PriceCategory
    FROM Products;

Funzioni definite dall'utente (UDF):

    Permettono di creare funzioni personalizzate.
    Esempio:
    SQL

    CREATE FUNCTION CalculateDiscount (@Price DECIMAL(10, 2), @DiscountPercent DECIMAL(5, 2))
    RETURNS DECIMAL(10, 2)
    AS
    BEGIN
        DECLARE @DiscountedPrice DECIMAL(10, 2);
        SET @DiscountedPrice = @Price * (1 - (@DiscountPercent / 100));
        RETURN @DiscountedPrice;
    END;

    SELECT dbo.CalculateDiscount(100, 10);

Stored Procedures:

    Raccolte di istruzioni T-SQL salvate nel database.
    Migliorano le prestazioni e la sicurezza.
    Esempio:
    SQL

    CREATE PROCEDURE GetCustomersByCity (@CityName VARCHAR(50))
    AS
    BEGIN
        SELECT * FROM Customers WHERE City = @CityName;
    END;

    EXEC GetCustomersByCity 'London';

Trigger:

    Eseguiti automaticamente in risposta a eventi specifici (INSERT, UPDATE, DELETE).
    Utilizzati per l'integrità dei dati e l'audit.
    Esempio:
    SQL

    CREATE TRIGGER AuditProductsUpdate
    ON Products
    AFTER UPDATE
    AS
    BEGIN
        INSERT INTO ProductAudit (ProductID, OldPrice, NewPrice, UpdateDate)
        SELECT i.ProductID, d.Price, i.Price, GETDATE()
        FROM inserted i
        JOIN deleted d ON i.ProductID = d.ProductID;
    END;

Transazioni:

    Gruppi di operazioni che devono essere completate tutte o nessuna.
    Garantiscono l'integrità dei dati.
    Esempio:
    SQL

        BEGIN TRANSACTION;
        UPDATE Accounts SET Balance = Balance - 100 WHERE AccountID = 1;
        UPDATE Accounts SET Balance = Balance + 100 WHERE AccountID = 2;
        COMMIT TRANSACTION;

Consigli 1  per l'apprendimento:  
 1. learncooding.com
learncooding.com






