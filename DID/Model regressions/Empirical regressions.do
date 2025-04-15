clear all

* Change working directory
cd "D:\Data and code\DID\Model regressions"

* Load dataset
use "D:\Data and code\Data\Panel_data\did_longdata.dta" 

* View labels for all variables (The variable information is detailed in Table S1 of Supporting Information and section 2.2 of the manuscript)
describe
* View notes for all variables (The variable information is detailed in Table S1 of Supporting Information and section 2.2 of the manuscript)
notes list

* View descriptive statistics for variables (Details are shown in Table S2 of Supporting Information)
sum MP did GDP POP PPI if Treat==1 // View descriptive statistics of variables for the treatment group
sum MP did GDP POP PPI if Treat==0 // View descriptive statistics of variables for the control group



* Empirical results for DID

* Explanatory variables Treat and Post have been defined for this dataset, so they are not defined here. The relevant commands are:"gen Treat=0; replace Treat=1 if Nino==1; gen Post=0; replace Post=1 if year>=2014; gen did=Treat*Post"

* Basic DID regression without control variables:

* Explanatory variable: MP
* Treat = Treatment group dummy (1=treatment, 0=control)
* Post = Time period dummy (1=post-treatment, 0=pre-treatment)
* Key regressor: did = Treat × Post (interaction term, Explanatory  variable)
* Fixed effects: year and country
* Standard errors clustered at country level

reghdfe MP did, ///
    absorb(year country) ///  // Two-way fixed effects: year + country
    cluster(country)     ///  // Cluster standard errors at country level

* Notes:
* 1. No control variables included (baseline specification)
* 2. year FE: Controls for time-varying shocks common to all units
* 3. country FE: Controls for time-invariant country characteristics
* 4. cluster(country): Accounts for within-country correlation
* 5. The coefficient on 'did' gives the average treatment effect

* Export DID regression results to Word document
outreg2 using "Empirical results.doc"


* Basic DID regression with control variables:

* Control variables: GDP POP PPI

reghdfe MP did GDP POP PPI,ab( year country ) cluster( country )

* Export DID regression results to Word document
outreg2 using "Empirical results.doc"
