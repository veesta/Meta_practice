library(devtools)
library(tidyverse)

ex1_data <- read_csv("meta_data_ex1.csv")

glimpse(ex1_data)
#glimpse gives you a nice format, str gives you more information - its uglier 

ex1_data

#1000 studies in the literature, each study has a correlation and sample size 

library(metaPsychometric)

#?metaPsychometric - index 
#4 commands bare bones and corrected meta analysis

##use meta bare bones 
#it'll look for r and N column and conduct a meta analysis 

ex1_results <- meta_bare_bones(ex1_data)

##CREDIBILITY INTERVAL 
#confidence interval is based on the premise that it will try to estimate that true pop value
#credibility interval, unrelated to CI; what is the range of population correlations
  #due to moderators, the true correlation could be as low as X and as high as X 
  #range of possible population correlations 
  #credibility interval: range of possible population variables, due to moderators 
  #i.e., male, women etc. you are going to capture the middle 80% 


##Explaining the BareBones Meta analysis 
#N total  = sum of all of the sample sizes in the meta analysis 
#rbar = average r 
#variability observed = what you got variance of all the correlations - standard weighted variance 
#variability expected = variability due to random sampling that you'd expect 
#if percent error percent error = variance you expect divided by the variance observed
  #less than 75% there are moderators, more than 75% there are no moderators
    #its all random sampling 

#LL AND UL - Confidence interval 95% 
#cred interval, 80% = .301 to .301, i.e., no moderators 

meta_plot_funnel(ex1_results)

#every dot is a study 
#line - true population is .3, with high sample sizes all the studies cluster around it 
#the funnel lines are based on sampling theory - capture the 95% of all correlations 
#even with 1000 N, it can range from .2 to .4 ish 

meta_plot_funnel(ex1_results, show_null_dist = TRUE)
#shows distribution if the population correlation was zero = null hyp sampling distrib 
  #all studies in the null funnel would come up as non significant 

## Do it again with exp 2 

ex2_data <- read_csv("meta_data_ex2.csv")

glimpse(ex2_data)
#n is 30 
#lines are the edges of the sampling distribution 

ex2_results <- meta_bare_bones(ex2_data)
meta_plot_funnel(ex2_results)

ex2_results

#total sample size = 14 thousand 
#average r is .289 
#confidence interval makes sense to look at cause there are no moderators 
  #if there were moderators then there are more population correlations to look at so silly 
  #look at the credibility interval if there are moderators 

#metaplot forrest - gives all 30 studies with their confidence itnerval 
#last value gives you meta analytic estiamte - CI is so tight that you can't see it 

meta_plot_forest(ex2_results)

##MODERATOR EXAMPLES 

ex3_data <- read_csv("meta_data_ex3.csv")

#View(ex3_data)
glimpse(ex3_data)

#40 data values, 20 in canada, 20 in states 

ex3_results <- meta_bare_bones(ex3_data)
meta_plot_funnel(ex3_results)

#per error is below 75, may be moderators. CI doesn't make sense cause its overlapping
  #with different population values 
#population correlation may be as low as .26 or high as .53
#alot of dots are outside 95% 
#lines: bounds of the sampling distribution
  #assuming there is a single population correlation and that pop corr is .395
  #95% of all values should fit in that funnel 

meta_plot_forest(ex3_results)

#ordered data - first 20 studies don't overlap with meta analytic mean 
#next 20 over estimate the analytic mean 
#can sort by countries, gender etc and see how groups differ 

##SUBGROUP ANALYSES - FILTER/ SELECT 

ex3_canada <- ex3_data %>% filter(country=="Canada")
ex3_usa <- ex3_data %>% filter(country=="United States") 

#View(ex3_canada)
#View(ex3_usa)

meta_bare_bones(ex3_canada)
#mean is .28
#credibility interval is .287 to .287 - lower correlation, no moderators 

meta_bare_bones(ex3_usa)
#mean is .49
#CredI goes from .48 to .50 - no moderators (very little moderators)

#credibility intervals don't even overlap between the countries
  #range between US and Canada dont overlap, huge difference 

#NEED TO SAVE THE RESULTS OF THE BAREBONES 

ex3_results_canada <- meta_bare_bones(ex3_canada)

ex3_results_usa <- meta_bare_bones(ex3_usa)

#forrest plot - as the k gets smaller, uncertainty in estimate increases 
 
meta_plot_forest(ex3_results_canada)
#narrow confidence interval even with 20 studies 

#view study 6 its CI is huge 

meta_plot_funnel(ex3_results_canada)
#not bad, but there are high Ns and it can balance out the uncertainty of k 

##BIG N AND LOTS OF STUDIES 