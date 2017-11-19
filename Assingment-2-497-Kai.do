log using "/Users/kailukowiak/Desktop/Uni/Econ 497/log file for assignment 2 497.log", replace
*
*
**** Part 2A - obs =50 ****
*
*


*Program and cleaning.
clear

capture program drop monte
program define monte, rclass
drop _all
set obs 50
tempvar u x1 v x2 y
gen `u'=rnormal(0,2)
gen `x1'=rnormal(2,2)
gen `v'= rnormal(0,3)
gen `x2'= 2+ `x1' + `v'
gen `y' = 1 - 0.5 * `x1' + 2 * `x2' + `u'
reg `y' `x1' `x2'
return scalar coefB=_b[`x1']
return scalar steB=_se[`x1']
reg `y' `x1'
return scalar coefD=_b[`x1']
return scalar steD=_se[`x1']
end

*Simulation:

simulate coefB=r(coefB) steB=r(steB) coefD=r(coefD) steD=r(steD), seed(12345) reps(1000) : monte

histogram coefB, normal title("Estimation of B_1, part A") name(betaA, replace)
graph save betaA "/Users/kailukowiak/Desktop/Econ 497/betaA.gph", replace
histogram coefD, normal title("Estimation of D_1, part A") name(deltaA, replace)
graph save deltaA "/Users/kailukowiak/Desktop/Econ 497/deltaA.gph", replace
summarize coefB coefD
*Comments: Hisograms all look normal and the respective means are what we would expect.
* Looks unbiased. Consistancy will be seen as N increases.
*
*
**** Part 2B - obs =500 ****
*
*

*Program and cleaning.-
clear

capture program drop monte
program define monte, rclass
drop _all
set obs 500
tempvar u x1 v x2 y
gen `u'=rnormal(0,2)
gen `x1'=rnormal(2,2)
gen `v'= rnormal(0,3)
gen `x2'= 2+ `x1' + `v'
gen `y' = 1 - 0.5 * `x1' + 2 * `x2' + `u'
reg `y' `x1' `x2'
return scalar coefB=_b[`x1']
return scalar steB=_se[`x1']
reg `y' `x1'
return scalar coefD=_b[`x1']
return scalar steD=_se[`x1']
end

*Simulation:

simulate coefB=r(coefB) steB=r(steB) coefD=r(coefD) steD=r(steD), seed(12345) reps(1000) : monte

histogram coefB, normal title("Estimation of B_1, part B") name(betaB, replace)
graph save betaB "/Users/kailukowiak/Desktop/Econ 497/betaB.gph", replace
histogram coefD, normal title("Estimation of B_1, part B") name(deltaB, replace)
graph save deltaB "/Users/kailukowiak/Desktop/Econ 497/deltaB.gph", replace
summarize coefB coefD
*Yes, we see a reduction in the "spread" of the estimation averages for B. 
* It also, unsurprisingly reduces the SE. This implies concistancy of 
*our similation. i.e. because increased sample size increases certanty. 
*
*
**** Part 2C - obs =500 sigma_u=4 ****
*
*

*Program and cleaning.
clear

capture program drop monte
program define monte, rclass
drop _all
set obs 500
tempvar u x1 v x2 y
gen `u'=rnormal(0,4)
gen `x1'=rnormal(2,2)
gen `v'= rnormal(0,3)
gen `x2'= 2+ `x1' + `v'
gen `y' = 1 - 0.5 * `x1' + 2 * `x2' + `u'
reg `y' `x1' `x2'
return scalar coefB=_b[`x1']
return scalar steB=_se[`x1']
reg `y' `x1'
return scalar coefD=_b[`x1']
return scalar steD=_se[`x1']
end

*Simulation:

simulate coefB=r(coefB) steB=r(steB) coefD=r(coefD) steD=r(steD), seed(12345) reps(1000) : monte

histogram coefB, normal title("Estimation of B_1, part C") name(betaC, replace)
graph save betaC "/Users/kailukowiak/Desktop/Econ 497/betaC.gph", replace
histogram coefD, normal title("Estimation of D_1, part C") name(deltaC, replace)
graph save deltaC "/Users/kailukowiak/Desktop/Econ 497/deltaC.gph", replace
summarize coefB coefD
*Setting sigma to 4, we see a coresponding increase in the standard devation (from B)
*although, this is lower than the initial SD from when the sample was 50 (A).
*This makes sense due to the fact increased sigma would increase SD.
*
*
**** Part 2D - obs =500 Change anythign: ****
** I changed v~N-(0,8)
*
*

*Program and cleaning.
clear

capture program drop monte
program define monte, rclass
drop _all
set obs 500
tempvar u x1 v x2 y
gen `u'=rnormal(0,2)
gen `x1'=rnormal(2,2)
gen `v'= rnormal(0,8)
gen `x2'= 2+ `x1' + `v'
gen `y' = 1 - 0.5 * `x1' + 2 * `x2' + `u'
reg `y' `x1' `x2'
return scalar coefB=_b[`x1']
return scalar steB=_se[`x1']
reg `y' `x1'
return scalar coefD=_b[`x1']
return scalar steD=_se[`x1']
end

*Simulation:

simulate coefB=r(coefB) steB=r(steB) coefD=r(coefD) steD=r(steD), seed(12345) reps(1000) : monte

histogram coefB, normal title("Estimation of B_1, part D") name(betaD, replace)
graph save deltaB "/Users/kailukowiak/Desktop/Econ 497/betaB.gph", replace
histogram coefD, normal title("Estimation of D_1, part D") name(deltaD, replace)
graph save deltaD "/Users/kailukowiak/Desktop/Econ 497/deltaD.gph", replace
summarize coefB coefD
*Notes: All the means are the same for beta and delta (from being unbiased)
*We see that the std. dev. is very similar to part "B" which is most similar 
*in terms of paramenters. Increasing variance of V to 8 however, 
*greatly increased the SD for delta. This makes sense due to the fact that v 
*directly influnces  delta.
log close
