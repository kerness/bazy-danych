CREATE TRIGGER lastNameToUpperCase
        ON Person.Person
        AFTER INSERT
AS
BEGIN
    UPDATE  Person.Person
    SET     LastName = UPPER(LastName)
    WHERE   BusinessEntityID IN (SELECT BusinessEntityID FROM inserted)
END
GO;


-- New person in person table should have businessentity 
-- businessentity has 3 columns: businessentityID, rowguid, modifiedDate
-- businessentityID, modifiedDate are created by database
-- rowguid is created by NEWID() function
INSERT INTO person.businessentity (rowguid)
VALUES (NEWID());

-- check new businessentityID
SELECT * FROM Person.BusinessEntity as b
ORDER BY b.BusinessEntityID DESC;

-- then, we can insert new person to person table
INSERT INTO person.person (businessentityid, persontype, firstname, lastname)
VALUES (20780, 'EM', 'Peter', 'Sagan' );

SELECT * FROM person.person AS p 
WHERE p.businessentityid = 20780;



