# 14-Dec-2015

GetCatchStats <- function(x) {
  # This function simply takes vector x and reports count, range, variance, and
  # mean (J. DuBois, 17-Dec-2015)
  
  # remove NAs first
  x <- x[!is.na(x)]
  
  n_x <- length(x)
  range_x <- range(x)
  var_x <- var(x)
  mean_x <- mean(x)
  sum_x <- sum(x)
  
  # put variables in list for convenience
  out_list <- list(
    Count = n_x,
    Range = range_x,
    Var = var_x,
    Mean = mean_x,
    Total = sum_x
  )
  
  # function output
  out_list
}
# end GetCatchStats

CalcVarNonRepEst <- function(catch_var, N, n_survey = NULL) {
  # This function calculates the variance for the modeled value in
  # GetNonRepEst(). This variance is then used to calculate the standard error
  # and ultimately the CI; developed with input from K. Newman and L. Mitchell
  # (USFWS) (J. DuBois, 17-Dec-2015)
  
  # Args:
  #   catch_var: the variance of the catch values reported from the survey
  #   N:         total number of anglers per strata (e.g., avid & non-reporting)
  #   n_survey:  number of anglers called and contacted (talked to) from the
  #              phone survey; default: NULL (then finite pop correction  = 1)
  
  # Returns
  #   variance of modeled value in GetNonRepEst()
  
  # calculate the finite population correction (likely will be ~1, which is
  # default if n_survey is not supplied)
  finite_pop_corr <- if (!is.null(n_survey)) {
    (N - n_survey) / N
  } else {
    1
  }
  
  # calculate variance for modeled estimate
  var_modeled_est <- catch_var * finite_pop_corr * N^2
  
  # function output
  var_modeled_est
}
# end CalcVarNonRepEst

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

GetModeledCatch <- function(avnrcc, avnrf, avnr, ansh) {
  # This function calculates the modeled catch for sturgeon given inputs from 
  # phone survey; developed from Marty's algorithm (see "NewAlgorithm.xlsx")
  # (14-Dec-2015)
  
  # NOTE: This function perhaps not needed but won't delete just yet (J. DuBois,
  # 17-Dec-2015)
  
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

# call function with arguments (an example) not run
#GetModeledCatch(avnrcc = 1000, avnrf = 500, avnr = 50000, ansh = 2)
