# Medicaid-Expansion-on-Health-status-of-US-citizens based on Stata

This study seeks to understand the impact of the Medicaid expansion on the general public’s health by comparing states that did and did not expand Medicaid eligibility in 2014 and 2015. According to the Kaiser Family Foundation, there have been over 150 published studies analyzing the Medicaid expansion’s impact on insurance coverage, access to care, and healthcare utilization, but there have been a limited number of studies on actual health outcomes, and none that analyze outcomes beyond specific regions or subpopulations.

Our dataset is the Current Population Survey’s Annual Social and Economic Supplement in the years 2013, 2014, and 2015. Our outcome variable is self-reported health status. Our analysis is composed of seven models:
	
-	Aggregate Level
-	Without standard error clustering 
-	With standard error clustering
-	With standard error clustering and sample trimming
-	With standard error clustering and inverse probability weighting
-	Individual Level
-	Without standard error clustering 
-	With standard error clustering
-	With standard error clustering and inverse probability weighting

We include each stage of our analysis for the sake of transparency and to demonstrate the sensitivity of our results.

Our analysis found no statistically significant results at the aggregate/state level. After failing to find significant results and identifying flaws in the aggregate models, we performed analysis at the individual level. However, we still did not detect a statistically significant change in health status.  We believe this is due to:
-	Dissimilarity between the treatment and control states’ pretreatment characteristics
-	Significantly reduced sample size from using state-level averages/percentages
-	The relatively small size of the policy’s target population compared to the general public
-	The relatively recent implementation period
