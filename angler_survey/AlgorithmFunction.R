# 14-Dec-2015

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



