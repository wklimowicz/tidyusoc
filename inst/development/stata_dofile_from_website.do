/*****************************************************************************************
* MERGING INDIVIDUAL FILES ACROSS WAVES INTO LONG FORMAT                                 *
* To match individual level files across two waves into a long format                    *
* do the following (for more waves add wave specific prefix in the foreach statement)    *
*****************************************************************************************/

** Step 1. Remove * and replace "filepath of your working directory" 
** with the filepath where you want to save all files
** That is your working directory. 
** Remember to include the double quotes
*cd "filepath of your working directory"

** Step 2. When you download and unzipped the data folder, 
** you will see that the data is provided in two folders "ukhls" and "bhps". 
** In this step, remove * and replace "filepath of downloaded data" 
** with the filepath where you have saved the two folders "ukhls" and "bhps"
** Remember to include the double quotes
*global datain "filepath of downloaded data"





//loop through each wave
foreach w in a b c d e f g h i j k { // For fewer waves use only the wave prefix of the waves you need to merge
  
	// find the wave number
	local waveno=strpos("abcdefghijklmnopqrstuvwxyz","`w'")
  
	// open the individual level file
	use pidp `w'_jbhas using "$datain/ukhls/`w'_indresp", clear
  
	// drop the wave prefix from all variables
	rename `w'_* *
  
	// create a wave variable
	gen wave=`waveno'
  
	// save one file for each wave
	save temp`w', replace
}

// open the file for the first wave (wave a_)
use tempa, clear

// loop through the remaining waves
foreach w in b c d e f g h i j k {

	// append the files for the second wave onwards
	append using temp`w'
}

// check how many observations are available from each wave
tab wave

// save the long file
save longfile, replace

// erase temporary files
foreach w in a b c d e f g h i j k {
	erase temp`w'.dta
}



/*****************************************************************************************
* MERGING INDIVIDUAL FILES FROM HARMONISED BHPS AND UKHLS IN LONG FORMAT                 *
* To match individual level files from the harmonised BHPS and Understanding Society     *
* in long format, you need to remove the wave prefixes in the two sets of files and      *
* generate a wave identifier that works across both sets of files. The pidp will         *
* work as the unique cross-wave identifier across both sets of files. This code only     *
* keeps individuals who took part in BHPS and drops those who joined as part of          *
* Understanding Society.                                                                 *
*****************************************************************************************/

** Step 1. Remove * and replace "filepath of your working directory" 
** with the filepath where you want to save all files
** That is your working directory. 
** Remember to include the double quotes
*cd "filepath of your working directory"

** Step 2. When you download and unzipped the data folder, 
** you will see that the data is provided in two folders "ukhls" and "bhps". 
** In this step, remove * and replace "filepath of downloaded data" 
** with the filepath where you have saved the two folders "ukhls" and "bhps"
** Remember to include the double quotes
*global datain "filepath of downloaded data"

// assign global macros for the lists of waves
global BHPSwaves "a b c d e f g h i j k l m n o p q r"
global UKHLSwaves_bh "b c d e f g h i j k" // since BHPS respondents did not take 
									 // part in Wave 1, begin at Wave 2
									 // - update this to include 
									 // new waves as they are released
global UKHLSno 11	// number of waves of UKHLS data								 

// loop through the waves of bhps
foreach w of global BHPSwaves {

	// find the wave number
	local waveno=strpos("abcdefghijklmnopqrstuvwxyz","`w'")

	// open the individual file for that wave
	use pidp b`w'_age b`w'_paygu_dv using "$datain/bhps/b`w'_indresp", clear
  
	// remove the wave prefix
	rename b`w'_* *
  
	// generate a variable which records the wave number
	gen wave=`waveno'
  
	// save the file for future use
	save tmp_b`w'_indresp, replace
}

// loop through the relevant waves of Understanding Society
foreach w of global UKHLSwaves_bh {

	// find the wave number
	local waveno=strpos("abcdefghijklmnopqrstuvwxyz","`w'")
  
	// open the individual level file for that wave
	use pidp pid `w'_age_dv `w'_paygu_dv using "$datain/ukhls/`w'_indresp", clear
  
	// keep the individual if they have a pid - ie were part of BHPS
	// individuals have pid==-8 (inapplicable) if they were not part of BHPS
	keep if pid>0
  
	// drop the pid variable
	drop pid
  
	// remove the wave prefix
	rename `w'_* *

	// generate a variable which records the wave number + 17 
	// - treating wave 2 ukhls as wave 19 of bhps
	gen wave=`waveno'+17
  
	// save the file for future use
	save tmp_`w'_indresp, replace
}

// loop through the waves of bhps
foreach w of global BHPSwaves {
  
	// first time through the loop
	if "`w'"=="a" {
  
		// reopen the first file created
		use tmp_ba_indresp, clear
  	
	// following times through the loop	
	} 
	else {	
  	
		// append each file in turn
		append using tmp_b`w'_indresp
	}
}

// loop through the waves of ukhls from Wave 2
foreach w of global UKHLSwaves_bh {
  
	// append each file in turn
	append using tmp_`w'_indresp
}

// create labels for the wave variable
// loop through the waves of bhps
foreach n of numlist 1/18 {

	// add a label for each wave number in turn
	lab def wave `n' "BHPS Wave `n'", modify
}

// loop through the waves of ukhls 
// (using the global macro UKHLSno to define the last wave)
foreach n of numlist 2/$UKHLSno {
  
	// calculate which label value this label will apply to
	local waveref=`n'+17
  
	// add a label for each wave in turn
	lab def wave `waveref' "UKHLS Wave `n'", modify
}

// apply the label to the wave variable
lab val wave wave

// check how many observations are available from each wave
tab wave

// save the file containing all waves
save all_indresp, replace

// erase each temporary file using loops
foreach w of global BHPSwaves {
	erase tmp_b`w'_indresp.dta
}
foreach w of global UKHLSwaves_bh {
	erase tmp_`w'_indresp.dta
}










