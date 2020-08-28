* “Latino” or “Hispanic”? The Sociodemographic Correlates of 
* Panethnic Label Preferences among US Latinos/Hispanics. 
* Sociological Perspectives, 
* https://doi.org/10.1177%2F0731121420950371

* Last Updated K Gonzalez  07/11/19 *
* kelseygonzalez@email.arizona.edu *
* Data is available for download at: https://www.pewresearch.org/hispanic/dataset/2013-national-survey-of-latinos/

* Purpose: impute cleaned data set



*********************************************************************************
*Load Data
*********************************************************************************
clear all
set more off

use  "Pew 2013 cleaned.dta", clear 	
	
********************************************************************************
*Multiple Imputation 
********************************************************************************		

misstable summ, all gen(m_) 
	mi set wide
	mi register imputed ///				
			PREF RACE IDENT AGE PPARTY COLL ORIGIN CITIZEN generation	
				  
	mi register regular ///
			REGION FEMALE PRIMARY_LANGUAGE 
			
	mi query
	mi describe

	mi impute chained     ///
		(logit)  COLL CITIZEN ///
		(ologit) AGE generation ///
		(mlogit) PREF ORIGIN RACE IDENT PPARTY ///
		= 	REGION FEMALE PRIMARY_LANGUAGE, augment add(13) rseed(747) 		

drop if m_PREF == 1 

save "Pew 2013 imputed.dta", replace
