clear all

* Change working directory
cd "D:\Data and code\DID\Model regressions"

* Load dataset
use "D:\Data and code\Data\Panel_data\did_longdata.dta" 

* View labels for all variables (The variable information is detailed in Table S1 of Supporting Information and section 2.2 of the manuscript)
describe
* View notes for all variables (The variable information is detailed in Table S1 of Supporting Information and section 2.2 of the manuscript)
notes list



* The moderating effect of sea surface temperature

* Moderator variables SST and ddd have been defined for this dataset, so they are not defined here. The variable ddd represents the multiplication of the empirical regression interaction did by the variable SST. The relevant command is:"gen ddd=did*SST"

* Basic moderating effect regression without control variables:

* Explanatory variable: MP
* Moderator variable: ddd = Treat × Post × SST (Triple interaction term, key regressor)
* Fixed effects: year and country
* Standard errors clustered at country level

reghdfe MP ddd, ///
    absorb(year country) ///  // Two-way fixed effects: year + country
    cluster(country)     ///  // Cluster standard errors at country level
	
* Notes:
* 1. No control variables included (baseline specification)
* 2. year FE: Controls for time-varying shocks common to all units
* 3. country FE: Controls for time-invariant country characteristics
* 4. cluster(country): Accounts for within-country correlation
* 5. The coefficient on 'ddd' gives the average treatment effect

* Export moderating regression results to Word document
outreg2 using " Moderating effect results.doc"


* Moderating effect regression with control variables:

* Control variables: GDP POP PPI
reghdfe MP ddd GDP POP PPI,ab( year country ) cluster( country )

* Export moderating effect regression results to Word document
outreg2 using "Moderating effect results.doc"
