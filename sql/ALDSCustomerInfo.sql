-- query created: 18-Dec-2015, J. DuBois
-- query returns: customer name, gender, age, and if deceased

-- Uncomment DECLARE statement for tesing in SQL Sever
-- DECLARE @cust AS Integer = 11;

SELECT DISTINCT CustomerID, FirstName, LastName, Gender,
                DATEDIFF(YEAR, DateOfBirth, GETDATE()) AS Age,
	            DeceasedDate
FROM dbo.CustomerIndividual
WHERE dbo.CustomerIndividual.CustomerID IN (@cust);