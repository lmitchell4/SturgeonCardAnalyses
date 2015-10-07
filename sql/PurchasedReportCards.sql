-- query created: 01-Oct-2015, J. DuBois
-- query returns: anglers who purchased sturgeon report cards
--                from 2013 to 2015; query includes info regarding
--                which anglers returned cards and for which year

-- added StatusCodeID (07-Oct-2015) to identify active vs inactive
-- cards - this will help with weeding out records where angler
-- has > 1 card in a year with only one being active
-- StatusCodeID = 165 is active, see table dbo.StatusCode

-- declare parameter variables
DECLARE @year1 AS Integer;
DECLARE @year2 AS Integer;

-- set parameters
SET @year1 = 2013;
SET @year2 = 2015;

WITH PurchasedCards_CTE
AS
(
  SELECT dbo.License.LicenseID, Quantity, dbo.License.ItemID, ItemYear,
  dbo.License.CustomerID, DocumentID, DateSubmitted, UserID,
  dbo.License.StatusCodeID
  --dbo.LicenseReport.LicenseReportTemplateID
  -- including ItemName, ItemNumber added +1 minute to the
  -- query but did verify records belong to Sturgeon Card
  FROM dbo.Item LEFT JOIN (dbo.License LEFT JOIN dbo.LicenseReport
    ON dbo.License.LicenseID = dbo.LicenseReport.LicenseID)
  ON dbo.Item.ItemID = dbo.License.ItemID
  WHERE RootItemNumberID = 272 AND
        ItemYear BETWEEN @year1 AND @year2
  --ORDER BY CustomerID, ItemYear
)
SELECT PurchasedCards_CTE.*, dbo.CustomerIdentity.IdentityValue,
  dbo.CustomerIdentity.IdentityTypeID, dbo.CustomerIdentity.Status
FROM PurchasedCards_CTE LEFT JOIN dbo.CustomerIdentity ON
  PurchasedCards_CTE.CustomerID = dbo.CustomerIdentity.CustomerID
WHERE IdentityTypeID = 1 AND Status = 1
ORDER BY CustomerID  -- DateSubmitted DESC
;