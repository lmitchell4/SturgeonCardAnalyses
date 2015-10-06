SELECT tbl_Date.Date, tbl_NetSet.Location, tbl_BoatTrip.VesselName,
       tbl_NetSet.NetSetNumber, tbl_TagRelease.Species,
       [DiscTagPrefix] & [DiscTagNumber] AS TagNum, tbl_TagRelease.PITtagNumber,
       tbl_TagRelease.ForkLength_cm, tbl_TagRelease.TotalLength_cm,
       tbl_TagRelease.ReleaseCondition, tbl_TagRelease.TrammelNetMeshSize,
       tbl_TagRelease.ShedTag, tbl_TagRelease.Re_taggedRecapture,
       tbl_TagRelease.OldDiscTagNum, tbl_TagRelease.OldPITtagNumber,
       tbl_TagRelease.TagReleaseNotes
FROM (tbl_Date INNER JOIN
     (tbl_BoatTrip INNER JOIN tbl_NetSet ON
      tbl_BoatTrip.BoatTrip_ID = tbl_NetSet.BoatTrip_ID) ON
      tbl_Date.Date_ID = tbl_BoatTrip.Date_ID) INNER JOIN tbl_TagRelease ON
      tbl_NetSet.NetSet_ID = tbl_TagRelease.NetSet_ID
ORDER BY tbl_Date.Date;
