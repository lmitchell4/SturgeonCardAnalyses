SELECT tblPurchasedCards.GOID, tblPurchasedCards.ItemYear, tblReportedCards.DateSubmitted
FROM tblPurchasedCards LEFT JOIN tblReportedCards
ON tblPurchasedCards.DocumentNumber = tblReportedCards.DocumentNumber
GROUP BY tblPurchasedCards.GOID, tblPurchasedCards.ItemYear, tblReportedCards.DateSubmitted;