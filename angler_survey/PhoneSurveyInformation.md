
### Background
The Sturgeon Fishing Report Card (Card) --- established in March 2007 --- is required by every angler fishing for sturgeon in California. The Card is issued each calendar year, and an angler must return his/her Card (to the Department) or report on-line via the Department's web page. Reporting is mandatory regardless of the outcome (i.e., the angler did not fish for sturgeon, the angler fished but did not catch sturgeon, or the angler fished for and caught sturgeon). The Card was free up until 2012. Since 2013, the Card can be purchased for $8.13.

For a variety of reasons, not all anglers report on-line or return the Card (non-reporting). We designed a phone survey to --- among other things --- gives us data that will help analyze the effects of non-reporting on Card metrics (e.g., number of harvested White Sturgeon).  

Below offers more information about key definitions, an excerpt from the phone survey, and the algorithm for calculating modeled catch. See also AlgorithmFunction.R.

### Definitions

avid angler: angler who has purchased a sturgeon card in at least 2 consecutive years  

harvest: number of White Sturgeon caught and kept

released: number of White Sturgeon or number of Green Sturgeon reported caught and then released

non-reporting: angler who fails to report on-line or who fails to return Sturgeon Fishing Report Card to the Department

### Phone Survey Excerpt

When an angler answers "yes" to fishing for sturgeon and "no" to reporting data (either on-line or by returning the Card), here are the follow up questions.

(1) OK. Did you forget, decide not to, or did you not know how?  
(2) How many white sturgeon did you keep?  
(3) How many white sturgeon did you release?  
(4) How many green sturgeon did you release?  

### Algorithm

This algorithm (developed Dec 2015) uses Sturgeon Fishing Report Card (Card) data and Sturgeon Fishing Report Card phone survey data to model sturgeon catch (both harvested and released) by Card holders. The basis for the algorithm is to correct for non-reporting (i.e., where sturgeon anglers failed to return a card or report on-line). Non-reporting biases low the reported catch, and this algorithm will mitigate that bias.  

The algorithm is described by the equation below. The ratio — described by  the number of anglers called and contacted who reported fishing for sturgeon divided by the number of anglers called and contacted — is the proportion of avid, non-reporting anglers called and contacted who reporting fishing for sturgeon (in this case, in either 2013, 2014, or both). These data are collected from the phone survey. From avid, non-reporting anglers called and contacted who reporting fishing for sturgeon, we can get (1) the average number of White Sturgeon harvested, (2) the average number of White Sturgeon released, and (3) the average number of Green Sturgeon released. Using the total avid non-reporting anglers, we get the number who went fishing by multiplying by the ratio (described above). This number is then multiplied by the average described above to get the modeled catch.

$catch=(AVNRF/AVNRCC)×AVNR×ANSH$      

where:  
  * AVNRCC  = Number of avid non-reporting anglers called and contacted  
  * AVNRF   = Number of avid non-reporting anglers called and contacted who reported fishing  
  * AVNR    = Number of non-reporting avid anglers  
  * ANSH    = Average number of sturgeon (WST or GST) harvested (or released, released only in the case of GST)                per avid angler called and contacted who reported fishing  
  * Catch   = Modeled number of sturgeon (WST or GST) harvested (or released, released only in the case of GST)                by avid anglers  
