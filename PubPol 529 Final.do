# Title     : Difference in Difference 
# Objective : Model selection for MMN-Dataset
# Created by: Mekramnia
# Created on: 13/3/18

##Preprocessing the data

*Average Age
bysort statefip year: egen avgage=mean(age)

*Median income by state by year // we include median instead of mean
replace offtotval =. if offtotval == 999999
bysort statefip year: egen avgincome=median(offtotval)

*Percent employed: 
replace empstat=. if empstat==00
replace empstat= 0 if empstat >12
replace empstat = 1 if empstat==12
replace empstat = 1 if empstat==10
replace empstat = 1 if empstat==01
replace empstat = 0 if empstat==21
replace empstat = 0 if empstat==22
replace empstat = 0 if empstat==32
replace empstat = 0 if empstat==34
replace empstat = 0 if empstat==36
bysort statefip year: egen empstatst=mean(empstat)

*Percent female by state by year:  ===> to get the average of men per population
replace sex = 0 if sex==2		
bysort statefip year : egen womenst=mean(sex)

*Sex: female: 2 , male = 1
*race : white: 100 , black = 200

*Percent Nonwhite
replace race=0 if race==100
replace race=1 if race>100
bysort statefip year : egen racest=mean(race)

*Percent w highschool/GED or higher
replace educ99=. if educ99==00
replace educ99=0 if educ99==01
replace educ99=0 if educ99==04
replace educ99=0 if educ99==05
replace educ99=0 if educ99==06
replace educ99=0 if educ99==07
replace educ99=0 if educ99==08
replace educ99=0 if educ99==09
replace educ99=1 if educ99==10
replace educ99=1 if educ99==11
replace educ99=1 if educ99==12
replace educ99=1 if educ99==13
replace educ99=1 if educ99==14
replace educ99=1 if educ99==15
replace educ99=1 if educ99==16
replace educ99=1 if educ99==17
replace educ99=1 if educ99==18
bysort statefip year : egen educ99st=mean(educ99)

*Mean Health Status: (The lower the better) 
bysort statefip year : egen healthst=mean(health)

*Percent married by state by year
replace marst=1 if marst==2
replace marst=0 if marst==3
replace marst=0 if marst==4
replace marst=0 if marst==5
replace marst=0 if marst==6
replace marst=0 if marst==7
replace marst=0 if marst==8
replace marst=0 if marst==9
bysort statefip year : egen marriedst=mean(marst)


*Percent receiving medicaid last year
replace himcaid=0 if himcaid==1
replace himcaid=1 if himcaid==2
bysort statefip year : egen himcaidst=mean(himcaid)


*Percent receiving military insurance last year
replace hichamp=0 if hichamp==1
replace hichamp=1 if hichamp==2
bysort statefip year : egen hichampst=mean(hichamp)

*Percent covered by private insurance
replace coverpi=0 if coverpi==1
replace coverpi=1 if coverpi==2
bysort statefip year : egen coverpist=mean(coverpi)

*Dependent covered by private insurance
replace privdep=0 if privdep==1
replace privdep=1 if privdep==2
bysort statefip year : egen privdepst=mean(privdep)

*Treatment Variable
gen treated=0
replace treated=1 if statefip==4 & year==2014 
replace treated=1 if statefip==4 & year==2015
replace treated=1 if statefip==5 & year==2014
replace treated=1 if statefip==5 & year==2015 
replace treated=1 if statefip==6 & year==2014 
replace treated=1 if statefip==6 & year==2015
replace treated=1 if statefip==8 & year==2014 
replace treated=1 if statefip==8 & year==2015
replace treated=1 if statefip==9 & year==2014 
replace treated=1 if statefip==9 & year==2015
replace treated=1 if statefip==10 & year==2014 
replace treated=1 if statefip==10 & year==2015
replace treated=1 if statefip==15 & year==2014 
replace treated=1 if statefip==15 & year==2015
replace treated=1 if statefip==17 & year==2015 
replace treated=1 if statefip==19 & year==2014
replace treated=1 if statefip==19 & year==2015 
replace treated=1 if statefip==21 & year==2014 
replace treated=1 if statefip==21 & year==2015
replace treated=1 if statefip==24 & year==2014 
replace treated=1 if statefip==24 & year==2015
replace treated=1 if statefip==25 & year==2014 
replace treated=1 if statefip==25 & year==2015
replace treated=1 if statefip==26 & year==2014 
replace treated=1 if statefip==26 & year==2015
replace treated=1 if statefip==27 & year==2014 
replace treated=1 if statefip==27 & year==2015
replace treated=1 if statefip==32 & year==2014 
replace treated=1 if statefip==32 & year==2015
replace treated=1 if statefip==33 & year==2015
replace treated=1 if statefip==34 & year==2014 
replace treated=1 if statefip==34 & year==2015
replace treated=1 if statefip==35 & year==2014 
replace treated=1 if statefip==35 & year==2015
replace treated=1 if statefip==36 & year==2014 
replace treated=1 if statefip==36 & year==2015
replace treated=1 if statefip==38 & year==2014 
replace treated=1 if statefip==38 & year==2015
replace treated=1 if statefip==39 & year==2014 
replace treated=1 if statefip==39 & year==2015
replace treated=1 if statefip==40 & year==2014 
replace treated=1 if statefip==40 & year==2015
replace treated=1 if statefip==41 & year==2015
replace treated=1 if statefip==44 & year==2014 
replace treated=1 if statefip==44 & year==2015
replace treated=1 if statefip==50 & year==2013
replace treated=1 if statefip==50 & year==2014 
replace treated=1 if statefip==50 & year==2015
replace treated=1 if statefip==53 & year==2014 
replace treated=1 if statefip==53 & year==2015
replace treated=1 if statefip==54 & year==2014 
replace treated=1 if statefip==54 & year==2015



//Summary of statistics  

ttest(age), by(treated)
ttest(sex), by(treated)
ttest(race), by(treated)
ttest(marst), by(treated)
ttest(himcaid), by(treated)
ttest(hichap), by(treated)
ttest(kidcaid), by(treated)
ttest(coverpi), by(treated)
ttest(offtotval), by(treated)



//Individaul probabilty weight (IPW)
replace predicttreat = .5593957 if statefip == 1
replace predicttreat = .4231611 if statefip == 2
replace predicttreat = .7434157 if statefip == 4
replace predicttreat = .3440739 if statefip == 5
replace predicttreat = .7687811 if statefip == 6
replace predicttreat = .8226916 if statefip == 8
replace predicttreat = .9604704 if statefip == 9
replace predicttreat = .3189982 if statefip == 10
replace predicttreat = .7183552 if statefip == 11
replace predicttreat = .2354237 if statefip == 12
replace predicttreat = .1032863 if statefip == 13
replace predicttreat = .5871964 if statefip == 15
replace predicttreat = .4010799 if statefip == 16
replace predicttreat = .8445249 if statefip == 17
replace predicttreat = .3111293 if statefip == 18
replace predicttreat = .3347585 if statefip == 19
replace predicttreat = .143375 if statefip == 20
replace predicttreat = .5850996 if statefip == 21
replace predicttreat = .1719282 if statefip == 22
replace predicttreat = .6654047 if statefip == 23
replace predicttreat = .6878543 if statefip == 24
replace predicttreat = .940646 if statefip == 25
replace predicttreat = .5824368 if statefip == 26
replace predicttreat = .6320861 if statefip == 27
replace predicttreat = .2839487 if statefip == 28
replace predicttreat = .538443 if statefip == 29
replace predicttreat = .4001942 if statefip == 30
replace predicttreat = .0781206 if statefip == 31
replace predicttreat = .3957405 if statefip == 32
replace predicttreat = .9629692 if statefip == 33
replace predicttreat = .8980865 if statefip == 34
replace predicttreat = .7550536 if statefip == 35
replace predicttreat = .9023597 if statefip == 36
replace predicttreat = .3886532 if statefip == 37
replace predicttreat = .2209404 if statefip == 38
replace predicttreat = .7856719 if statefip == 39
replace predicttreat = .1487034 if statefip == 40
replace predicttreat = .3957148 if statefip == 41
replace predicttreat = .78184 if statefip == 42
replace predicttreat = .8654668 if statefip == 44
replace predicttreat = .3296277 if statefip == 45
replace predicttreat = .1072237 if statefip == 46
replace predicttreat = .5487469 if statefip == 47
replace predicttreat = .1949343 if statefip == 48
replace predicttreat = .4184954 if statefip == 49
replace predicttreat = .9523525 if statefip == 50
replace predicttreat = .3907467 if statefip == 51
replace predicttreat = .7009445 if statefip == 53
replace predicttreat = .5629869 if statefip == 54
replace predicttreat = .7701923 if statefip == 55
replace predicttreat = .3362699 if statefip == 56



//Generating the aggregate Level

collapse (mean) health treated age sex race educ99 empstat himcaid hichamp caid privdep verify coverpi offtotval, by(statefip year)

//diff in diff for Model 3. Sample trimmed
reg health treated   age sex race educ99 empstat himcaid hichamp caid privdep verify coverpi offtotval  i.year  if statefip!=50 [pweight=yhat ], cluster(statefip)


regress healthst i.statefip treated treated##i.statefip avgage womenst racest marriedst empstat educ99st avgincome himcaidst hichampst kidcaidst privdepst coverpist [w=asecwt]

//Extract data in excel sheet
outreg2 using qu4.xls, se bdec(3) sdec(3) append

//Sample Trimming Process
logit iftreated  age sex race educ99 empstat himcaid hichamp caid privdep verify coverpi offtotval if year==2013

//deleting Vermont and district of columbia
reg health treated  i.statefip  i.year  if statefip!=50 [pweight=yhat ], cluster(statefip)
reg health lag1  i.statefip  i.year  if statefip!=50 [pweight=yhat ], cluster(statefip)

// Diff in Diff for individual level
reg health treated  age sex race educ99 empstat himcaid hichamp caid privdep verify coverpi offtotval  i.year  if statefip!=50 if statefip!=11 [w=asecw ], cluster(statefip)


reg health lag1 age sex race educ99 empstat himcaid hichamp caid privdep verify coverpi offtotval  i.year  if statefip!=50 [pweight=yhat ], cluster(statefip)

//Sample Trimming procedure
logit iftreated  age sex race educ99 empstat himcaid hichamp caid privdep verify coverpi offtotval if year==2013 & statefip!=50 & statefip!=11

predict yhatdc if year==2013



regress health i.statefip post post##i.statefip avgage

//The Test
regress healthst i.year i.statefip treated



*replace post = 0 if year ==2013

*gen interaction = post*treat

. *regress healthst treat post interaction i.statefip i.year

regress healthst treat treated i.statefip i.year

*** 
State variable. 0/1 treated
Before after . year = 1 begir

Y treated year Year * treated 


******* 



reg health treated i.statefip i.year i.age sex race educ99 empstat himcaid hichamp caid privdep verify coverpi , cluster(statefip)
