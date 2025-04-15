clear all

* Change working directory
cd "D:\Data and code\DID\Robustness tests"

* Load dataset
use "D:\Data and code\Data\Panel_data\did_longdata.dta" 

* View labels for all variables (The variable information is detailed in Table S1 of Supporting Information and section 2.2 of the manuscript)
describe
* View notes for all variables (The variable information is detailed in Table S1 of Supporting Information and section 2.2 of the manuscript)
notes list



* Placebo tests for fictitious experimental groups


* Generate new pseudo-treatment group of countries located in Tropical Atlantic, Indian, and Western Pacific Oceans (80°W-0°-160°E, 23.5°N-23.5°S)
gen Nino_opposite=0
replace Nino_opposite=1 if country =="Brazil" | country =="Brunei Darussalam" | country =="Cambodia" | country =="Colombia" | country =="Ecuador" | country =="Eritrea" | country =="Gambia" | country =="Ghana" | country =="Grenada" | country =="Guam" | country =="Guyana" | country =="Indonesia" | country =="Madagascar" | country =="Kenya" | country =="Malaysia" | country =="Martinique" | country =="Mayotte" | country =="Nigeria" | country =="Mozambique" | country =="Palau" | country =="Papua New Guinea" | country =="Peru" | country =="Philippines" | country =="Myanmar" | country =="Saint Vincent/Grenadines" | country =="Senegal" | country =="Singapore" | country =="Sri Lanka" | country =="Suriname" | country =="Tanzania, United Rep. of" | country =="Timor-Leste" | country =="Viet Nam" | country =="Yemen"

* Based on the above  pseudo-treatment group dummy variable, generate pseudo-interactive item
gen did_opposite = Post* Nino_opposite

* Carry out empirical regression
reghdfe MP did_opposite GDP POP PPI ,ab( year country ) cluster( country )

* Export DID regression results to Word document
outreg2 using "Regression results for the treatment group located in other tropical sea areas.doc"

* Generate new pseudo-treatment group dummy variable based on the countries located in all of the sea areas in the tropics (23.5°N-23.5°S)
gen did_tropical=0
replace did_tropical=1 if did_opposite ==1 | did ==1

* Carry out empirical regression
reghdfe MP did_tropical GDP POP PPI ,ab( year country ) cluster( country )

* Export DID regression results to Word document
outreg2 using "Regression results for the treatment group located in other tropical sea areas.doc"
