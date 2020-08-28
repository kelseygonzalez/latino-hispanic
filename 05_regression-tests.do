* “Latino” or “Hispanic”? The Sociodemographic Correlates of 
* Panethnic Label Preferences among US Latinos/Hispanics. 
* Sociological Perspectives, 
* https://doi.org/10.1177%2F0731121420950371

* Last Updated K Gonzalez  07/11/19 *
* kelseygonzalez@email.arizona.edu *
* Data is available for download at: https://www.pewresearch.org/hispanic/dataset/2013-national-survey-of-latinos/

* Purpose: perform tests for multinomial logistic regressions



*********************************************************************************
*Load Data
*********************************************************************************
clear all
set more off

use "Pew 2013 imputed.dta", clear 

********************************************************************************
*  Testing 
********************************************************************************	

*testing multicollinearity 	
reg PREF ib4.REGION i.generation ib2.IDENT i.RACE CITIZEN FEMALE i.AGE ib3.PRIMARY_LANGUAGE i.ORIGIN COLL ib1.PPARTY
estat vif

reg PREF ib4.REGION ib3.generation ib2.IDENT i.RACE CITIZEN FEMALE i.AGE ib3.PRIMARY_LANGUAGE i.ORIGIN##COLL ib1.PPARTY
estat vif

mi estimate: reg PREF ib4.REGION ib3.generation ib2.IDENT i.RACE CITIZEN FEMALE i.AGE ib3.PRIMARY_LANGUAGE i.ORIGIN COLL ib1.PPARTY
mi convert flong
mivif

*testing if categories should be combined 	
mlogit PREF ib4.REGION ib3.generation ib2.IDENT i.RACE CITIZEN FEMALE i.AGE ib3.PRIMARY_LANGUAGE i.ORIGIN COLL ib1.PPARTY, b(1) nolog
mlogtest, combine  

*testing IIA 
mlogit PREF ib4.REGION ib3.generation ib2.IDENT i.RACE CITIZEN FEMALE i.AGE ib3.PRIMARY_LANGUAGE i.ORIGIN COLL ib1.PPARTY, b(1) nolog
mlogtest, smhsiao
mlogtest, hausman
