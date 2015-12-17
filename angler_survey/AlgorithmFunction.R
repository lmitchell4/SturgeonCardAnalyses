# 14-Dec-2015


GetNonRepEst <- function(n_stu, N, n_survey) {
  # This function calculates modeled harvest (or catch and release) for sturgeon
  # given inputs from a phone survey. This function was developed by USFWS
  # statisticians K. Newman and L. Mitchell (17-Dec-2015)
  
  # Args:
  #   n_stu:    total number of sturgeon (either white or green) harvested (or
  #             caught and released) by anglers called and contacted from
  #             the phone survey
  #   N:        total number of anglers per strata (e.g., avid & non-reporting)
  #   n_survey: number of anglers called and contacted (talked to) from the
  #             phone survey
  
  # Returns:
  #   
  
  res <- (n_stu / n_survey) * N
  
  # function output
  res
}
# end GetNonRepEst

# test function
#GetNonRepEst

GetModeledCatch <- function(avnrcc, avnrf, avnr, ansh) {
  # This function calculates the modeled catch for sturgeon given inputs from 
  # phone survey; developed from Marty's algorithm (see "NewAlgorithm.xlsx")
  # (14-Dec-2015)
  
  # Args:
  #   avnrcc: Number of avid non-reporting anglers called and contacted
  #   avnrf:  Number of avid non-reporting anglers called and contacted who
  #           reported fishing
  #   avnr:   Number of non-reporting avid anglers
  #   ansh:   Average number of sturgeon (WST or GST) harvested (or released,
  #           released only in the case of GST) per avid angler called and
  #           contacted who reported fishing
  
  # Returns:
  #   modeled catch value
  
  catch <- (avnrf / avnrcc) * avnr * ansh
  
  # function output
  catch
}
# end GetModeledCatch

# call function with arguments (an example)
GetModeledCatch(avnrcc = 1000, avnrf = 500, avnr = 50000, ansh = 2)



