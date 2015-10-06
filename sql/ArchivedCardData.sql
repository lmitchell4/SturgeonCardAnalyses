SELECT SturgeonData.CardNumber, SturgeonData.Year, SturgeonData.DateOfCapture,
       SturgeonData.LocationCode, tlkpLocation.LocationDescription,
       SturgeonData.Species, SturgeonData.Retained, SturgeonData.Length,
       SturgeonData.CaptureOrRecapture, SturgeonData.TagNumber,
       SturgeonData.Comments
FROM SturgeonData LEFT JOIN tlkpLocation ON
     SturgeonData.LocationCode = tlkpLocation.LocationCode;
