* “Latino” or “Hispanic”? The Sociodemographic Correlates of 
* Panethnic Label Preferences among US Latinos/Hispanics. 
* Sociological Perspectives, 
* https://doi.org/10.1177%2F0731121420950371

* Last Updated K Gonzalez  07/11/19 *
* kelseygonzalez@email.arizona.edu *
* Data is available for download at: https://www.pewresearch.org/hispanic/dataset/2013-national-survey-of-latinos/

* Purpose: perform multinomial logistic regressions on imputed dataset


*********************************************************************************
*Load Data
*********************************************************************************
clear all
set more off

use "Pew 2013 imputed.dta", clear 
	
	
********************************************************************************
* Regression Models  
********************************************************************************	
*4) Baseline + identity variable (compare these results to the baseline model)
mi estimate, post: mlogit PREF ib4.REGION ib3.generation ib2.IDENT i.RACE CITIZEN FEMALE i.AGE ib3.PRIMARY_LANGUAGE i.ORIGIN COLL ib1.PPARTY, b(1) nolog
	estimates store PREF_b1
mi estimate, post: mlogit PREF ib4.REGION ib3.generation ib2.IDENT i.RACE CITIZEN FEMALE i.AGE ib3.PRIMARY_LANGUAGE i.ORIGIN COLL ib1.PPARTY, b(3) nolog
	estimates store PREF_b3


	esttab  PREF_b1 PREF_b3  using PREF_mi.rtf, replace unstack wide b(a3) se(3) se nodep compress ///
		star(+ 0.10 * 0.05 ** 0.01 ***  0.001) nogap varwidth(25) nonumber   ///
		label coeflabels(	FEMALE "Female" 3.PRIMARY_LANGUAGE "Spanish Dominant" ///
		1.BORNUSA_WITHPR "Born in the USA" CITIZEN "Citizen" 3.Q105 "No effect" 3.PPARTY "Independent/Other") ///
		refcat(1.REGION "Region (Ref: West):" 2.ORIGIN "Region of Origin (Ref: Mexico):" 1.IDENT "Identity (Ref: Hispanic/Latino)" ///
		2.PPARTY "Political Party (Ref: Dem):" 1.PRIMARY_LANGUAGE "Language(Ref: Spanish Dom):"  ///
		2.AGE "Age (Ref:18 to 29):" 1.EDUCCAT2 "Education (Ref: College Grad):" 1.generation "Generation (Ref: 3rd Generation +):" ///
		2.RACE "Race (Ref: White)" , nolabel) ///
		drop( 1.ORIGIN 4.REGION 1.PPARTY 3.generation 1.AGE 3.PRIMARY_LANGUAGE 2.IDENT 1.RACE)	


* Calculate Approximate R2 value		
local rhs = "ib4.REGION ib3.generation ib2.IDENT i.RACE CITIZEN FEMALE i.AGE ib3.PRIMARY_LANGUAGE i.ORIGIN COLL ib1.PPARTY" 
quietly mi query
local M=r(M)
scalar sumr2=0
scalar cstat=0
scalar r2b = 0
forvalues i = 1(1)`M' {
	quietly mi xeq `i': mlogit PREF `rhs'; scalar sumr2=sumr2+e(r2_p); 
	display sumr2
}
scalar r2=sumr2/`M'
display "psuedo-r2 = " r2	
		
	
********************************************************************************
* Descriptive Statistics  
********************************************************************************


mi svyset [pw=totalwt]
mi estimate: svy: proportion  PREF REGION generation IDENT RACE CITIZEN FEMALE AGE PRIMARY_LANGUAGE ORIGIN COLL PPARTY 

	