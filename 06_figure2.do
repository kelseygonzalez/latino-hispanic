* “Latino” or “Hispanic”? The Sociodemographic Correlates of 
* Panethnic Label Preferences among US Latinos/Hispanics. 
* Sociological Perspectives, 
* https://doi.org/10.1177%2F0731121420950371

* Last Updated K Gonzalez  07/11/19 *
* kelseygonzalez@email.arizona.edu *
* Data is available for download at: https://www.pewresearch.org/hispanic/dataset/2013-national-survey-of-latinos/

* Purpose: Prepare data for figure 2 of adjusted predictions



*********************************************************************************
*Load Data
*********************************************************************************
clear all
set more off

use  "Pew 2013 imputed.dta", clear 

********************************************************************************
* Figure 1
********************************************************************************	
mi estimate, post: mlogit PREF ib4.REGION ib3.generation ib2.IDENT i.RACE CITIZEN FEMALE i.AGE ib3.PRIMARY_LANGUAGE i.ORIGIN COLL ib1.PPARTY, b(1) nolog
	estimates store PREF_mi_b1			
mimrgns generation, predict(outcome(1)) predict(outcome(2)) predict(outcome(3)) cmdmargins vsquish
