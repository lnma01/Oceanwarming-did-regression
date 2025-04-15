clear all

* Change working directory
cd "D:\Data and code\DID\Model regressions"

* Load dataset
use "D:\Data and code\Data\Panel_data\did_longdata.dta" 

* View labels for all variables (The variable information is detailed in Table S1 of Supporting Information and section 2.2 of the manuscript)
describe
* View notes for all variables (The variable information is detailed in Table S1 of Supporting Information and section 2.2 of the manuscript)
notes list



* Sensitivity analysis of treatment group selection


* We adjusted the regional range of the treatment group by expanding the latitude range limit of the treatment group successively to 30° north and south latitude and 40° north and south latitude for regression:

 * -The variable Nino reflects the original selection of treatment group countries, with the value 1 representing the treatment group countries and 0 representing the control group countries.
 * -The variable Nino_30 reflects the selection of countries in the treatment group whose latitude is adjusted to within 30° north and south latitude, with the value 1 representing the treatment group and 0 representing the control group.
 * -The variable Nino_40 reflects the selection of countries in the treatment group whose latitude is adjusted to within 40° north and south latitude, with the value 1 representing the treatment group and 0 representing the control group.

 * -The variable did represents the interaction term of the original empirical regression, Treat × Post.
 * -The variable did_30 represents the interaction term for a new regression with expanded experimental group selection, Nino_30 × Post.
 * -The variable did_40 represents the interaction term for a new regression with expanded experimental group selection, Nino_40 × Post.


* The original empirical regression result:
reghdfe MP did GDP POP PPI,ab( year country ) cluster( country )

* Export DID regression results to Word document
outreg2 using "Sensitivity analysis results.doc"


* The empirical regression result of expanding the latitude range of the treatment group to 30° north and south latitude:

* Explanatory variable: MP
* Nino_30 = Treatment group dummy (1=treatment, 0=control)
* Post = Time period dummy (1=post-treatment, 0=pre-treatment)
* Key regressor: did_30 = Nino_30 × Post (interaction term, Explanatory  variable)
* Control variables: GDP POP PPI
* Fixed effects: year and country
* Standard errors clustered at country level

reghdfe MP did_30 GDP POP PPI,ab( year country ) cluster( country )

* Export DID regression results to Word document
outreg2 using "Sensitivity analysis results.doc"


* The empirical regression result of expanding the latitude range of the treatment group to 40° north and south latitude:

* Explanatory variable: MP
* Nino_40 = Treatment group dummy (1=treatment, 0=control)
* Post = Time period dummy (1=post-treatment, 0=pre-treatment)
* Key regressor: did_40 = Nino_40 × Post (interaction term, Explanatory  variable)
* Control variables: GDP POP PPI
* Fixed effects: year and country
* Standard errors clustered at country level

reghdfe MP did_40 GDP POP PPI,ab( year country ) cluster( country )

* Export DID regression results to Word document
outreg2 using "Sensitivity analysis results.doc"
