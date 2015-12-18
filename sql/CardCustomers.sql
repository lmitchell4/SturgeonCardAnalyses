-- query created: 05-Oct-2015, J. DuBois
-- query returns: customer names and contact info based on R
--                output of avid anglers; parameter @cust is
--                assigned in R code

-- Uncomment DECLARE statement for tesing in SQL Sever
-- DECLARE @cust AS Integer = 11;

-- create CTE with only customer ID
-- this design is probably not necessary given work-
-- around in R, but for now I'll keep the CustId_CTE
WITH CustId_CTE
AS
(
 SELECT dbo.Customer.CustomerID AS CustID
 FROM dbo.Customer
 WHERE dbo.Customer.CustomerID IN (@cust)
)
,

-- create CTE with primary phone number
PhoneNum_CTE
AS
(
 SELECT dbo.Customer.CustomerID, FirstName, LastName, Gender, DateOfBirth,
   SecondaryPhoneID, PhoneNumber AS Phone1, EmailAddress, DeceasedDate
 FROM dbo.CustomerIndividual INNER JOIN (
   dbo.Phone INNER JOIN dbo.Customer ON 
    dbo.Phone.PhoneID = dbo.Customer.PrimaryPhoneID)
  ON dbo.CustomerIndividual.CustomerID = 
    dbo.Customer.CustomerID
--WHERE dbo.Customer.CustomerID = CustId_CTE.CustID
)

--SELECT CustomerID, FirstName, LastName,
--  Gender, Phone1, PhoneNumber AS Phone2,
--  EmailAddress, DeceasedDate
--FROM PhoneNum_CTE INNER JOIN dbo.Phone ON
--  PhoneNum_CTE.SecondaryPhoneID = dbo.Phone.PhoneID
--WHERE PhoneNum_CTE.CustomerID = CustId_CTE.CustID

-- join CTEs and table dbo.Phone to create final output
-- containing both phone numbers and e-mail address
SELECT CustomerID, FirstName, LastName,
  Gender, Phone1, PhoneNumber AS Phone2,
  EmailAddress, DeceasedDate,
  -- added Age 18-Dec-2015
  DATEDIFF(YEAR, DateOfBirth, GETDATE()) As Age --,
  --DateOfBirth
FROM CustId_CTE INNER JOIN (
    PhoneNum_CTE INNER JOIN dbo.Phone ON
    PhoneNum_CTE.SecondaryPhoneID = dbo.Phone.PhoneID
    )
  ON CustId_CTE.CustID = PhoneNum_CTE.CustomerID
WHERE PhoneNum_CTE.CustomerID = CustId_CTE.CustID
;