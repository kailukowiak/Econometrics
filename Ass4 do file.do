clear all
use "/Users/kailukowiak/Desktop/Uni/Econ 497/database provinces final.dta"
log using "/Users/kailukowiak/Desktop/Uni/Econ 497/log_ass_4.log", replace
set more off
cd "/Users/kailukowiak/Desktop/Uni/Econ 497"
*For all provinces
sutex2 expenditure_gdp top_prizes_gdp expenditure_pc top_prizes_pc number_awarded_tickets number_awarded_tickets_pc,min dig(2) long caption(Discriptive Statistics) varlab sav(Table1.tex) replace

*per capita winning provinces:
egen winning_pc = max(top_prizes_pc), by(year)
replace winning_pc = 0 if winning_pc !=  top_prizes_pc
replace winning_pc = 1 if winning_pc >0
sutex2 expenditure_gdp top_prizes_gdp expenditure_pc top_prizes_pc number_awarded_tickets number_awarded_tickets_pc if winning_pc ==1 ,min dig(3) long caption(Discriptive Statistics) varlab sav(Table1.tex) append
*sutex
sutex2 expenditure_gdp top_prizes_gdp expenditure_pc top_prizes_pc number_awarded_tickets number_awarded_tickets_pc if winning_pc ==1 ,min dig(3) long  sav(Table1.tex) append
*Electoral data
sutex2 electoral_roll voter_turnout votes_incumbent votes_socialist_party votes_peoples_party,min dig(2) long caption(Discriptive Statistics) varlab sav(Table1.tex) append

*Macro data:
sutex2 population gdp_pc inflation disposable_income_pc other_transfers_pc bank_deposits_pc bank_loans_pc vehicle_sales_pc housing_price labor_force_participation unemployment_rate ,min dig(2) long caption(Discriptive Statistics) varlab sav(Table1.tex) append

**Table 3
*Declare pannel data:
xtset province_code year
*Column 1
xtreg variation_votes_incumbent gdp_growth_term unemployment_growth_term inflation_term housing_price_growth_term i.year, robust 
outreg2 using table3.tex, replace ctitle(All Incumbants) keep(gdp_growth_term unemployment_growth_term inflation_term housing_price_growth_term) long

*Column 2
xtreg variation_votes_incumbent top_prizes_gdp_term expenditure_gdp_term i.year, robust 
outreg2 using table3.tex, append ctitle(All Incumbants) keep(top_prizes_gdp_term expenditure_gdp_term) addtext(Province FE, No, Population Weights , No)
*Column 3
xtreg variation_votes_incumbent gdp_growth_term unemployment_growth_term inflation_term housing_price_growth_term top_prizes_gdp_term expenditure_gdp_term i.year, robust fe
outreg2 using table3.tex, append ctitle(All Incumbants) keep(gdp_growth_term unemployment_growth_term inflation_term housing_price_growth_term top_prizes_gdp_term expenditure_gdp_term) addtext(Province FE, No, Population Weights , No)
*Column 4		
xtreg variation_votes_incumbent gdp_growth_term unemployment_growth_term inflation_term housing_price_growth_term top_prizes_gdp_term expenditure_gdp_term i.year, robust fe
outreg2 using table3.tex, append ctitle(All Incumbants) keep(gdp_growth_term unemployment_growth_term inflation_term housing_price_growth_term top_prizes_gdp_term expenditure_gdp_term) addtext(Province FE, Yes, Population Weights , No)

*Column 5

areg variation_votes_incumbent gdp_growth_term unemployment_growth_term inflation_term housing_price_growth_term top_prizes_gdp_term expenditure_gdp_term [aweight=population], robust absorb(province_code)
outreg2 using table3.tex, append ctitle(All Incumbants) keep(gdp_growth_term unemployment_growth_term inflation_term housing_price_growth_term top_prizes_gdp_term expenditure_gdp_term) addtext(Province FE, No, Population Weights , No)

*Column 6
xtreg variation_votes_incumbent gdp_growth_term unemployment_growth_term inflation_term housing_price_growth_term expenditure_gdp_term top_prizes_gdp_term i.year, robust
outreg2 using table3.tex, append ctitle(Fractions) keep(gdp_growth_term unemployment_growth_term inflation_term housing_price_growth_term expenditure_gdp_term top_prizes_gdp_term) addtext(Province FE, No, Population Weights , No)

*Column 7
xtreg variation_votes_incumbent gdp_growth_term unemployment_growth_term inflation_term housing_price_growth_term expenditure_gdp_term top_prizes_gdp_term i.year if province_code!=25, robust
outreg2 using table3.tex, append ctitle(Except Sort) keep(gdp_growth_term unemployment_growth_term inflation_term housing_price_growth_term expenditure_gdp_term top_prizes_gdp_term) addtext(Province FE, No, Population Weights , No)
*Column 8
xtreg variation_votes_incumbent gdp_growth_term unemployment_growth_term inflation_term housing_price_growth_term top_prizes_gdp_term expenditure_gdp_term i.year if votes_incumbent==votes_socialist_party, robust 
outreg2 using table3.tex, append ctitle(Left wing) keep(gdp_growth_term unemployment_growth_term inflation_term housing_price_growth_term top_prizes_gdp_term expenditure_gdp_term) addtext(Province FE, No, Population Weights , No)

*Column 9
xtreg variation_votes_incumbent gdp_growth_term unemployment_growth_term inflation_term housing_price_growth_term top_prizes_gdp_term expenditure_gdp_term i.year if votes_incumbent==votes_peoples_party, robust 
outreg2 using table3.tex, append ctitle(Right wing) keep(gdp_growth_term unemployment_growth_term inflation_term housing_price_growth_term top_prizes_gdp_term expenditure_gdp_term) addtext(Province FE, No, Population Weights , No)

*Column 10 *** missing 
log close

