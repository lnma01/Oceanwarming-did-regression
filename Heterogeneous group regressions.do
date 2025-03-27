clear all
* Change working directory
cd "D:\Data and code\DID\Model regressions"
* Load dataset
use "D:\Data and code\Data\Panel_data\did_longdata.dta" 
* View labels for all variables (The variable information is detailed in Table S1 of Supporting Information and section 2.2 of the manuscript)
describe
* View notes for all variables (The variable information is detailed in Table S1 of Supporting Information and section 2.2 of the manuscript)
notes list
* Heterogeneous group regression
* 1 Economic factors
* 1.1 Grouping regression by GDP per capita level:
* Group_GDP (Grouping tags of GDP per capita):Ranking countries by GDP per capita from smallest to largest, the value 1 represents the low-level group of the corresponding grouping indicator;the value 2 represents the high-level group of the corresponding grouping indicator.
* Delete the high level group and perform regression for the low level group
keep if Group_GDP==1
reghdfe MP did  POP PPI,ab( year country ) cluster( country )level(90)
* In order to avoid multicollinearity problems, the control variables are no longer added to GDP when the regression is grouped according to the level of GDP per capita.
* Export DID regression results to Word document
outreg2 using "Heterogeneous effects of economic factors.doc"
* 1.1.2 Delete the low level group and perform regression for the high level group
clear all
use "D:\Data and code\Data\Panel_data\did_longdata.dta" 
keep if Group_GDP==2
reghdfe MP did  POP PPI,ab( year country ) cluster( country )level(90)
outreg2 using "Heterogeneous effects of economic factors.doc"
* 1.2 Grouping regression by National income per adult(Income):
* Group_Income (Grouping tags of Income):Ranking countries by Income from smallest to largest, the value 1 represents the low-level group of the corresponding grouping indicator;the value 2 represents the high-level group of the corresponding grouping indicator.
*1.2.1 Delete the high level group and perform regression for the low level group
clear all
use "D:\Data and code\Data\Panel_data\did_longdata.dta" 
keep if Group_Income==1
reghdfe MP did GDP POP PPI,ab( year country ) cluster( country )level(90)
outreg2 using "Heterogeneous effects of economic factors.doc"
* 1.2.2 Delete the low level group and perform regression for the high level group
clear all
use "D:\Data and code\Data\Panel_data\did_longdata.dta" 
keep if Group_Income==2
reghdfe MP did GDP POP PPI,ab( year country ) cluster( country )level(90)
outreg2 using "Heterogeneous effects of economic factors.doc"
* 2 Demographic factors
* 2.1 Grouping regression by total population:
* Group_POP (Grouping tags of population):Ranking countries by total population from smallest to largest, the value 1 represents the low-level group of the corresponding grouping indicator;the value 2 represents the high-level group of the corresponding grouping indicator.
* 2.1.1 Delete the high level group and perform regression for the low level group
clear all
use "D:\Data and code\Data\Panel_data\did_longdata.dta" 
keep if Group_POP==1
reghdfe MP did GDP PPI,ab( year country ) cluster( country )level(90)
* In order to avoid multicollinearity problems,POP item is no longer added to the control variables when the regression is grouped according to the level of total population.
* Export DID regression results to Word document
outreg2 using "Heterogeneous effects of demographic factors.doc"
* 2.1.2 Delete the low level group and perform regression for the high level group
clear all
use "D:\Data and code\Data\Panel_data\did_longdata.dta" 
keep if Group_POP==2
reghdfe MP did GDP PPI,ab( year country ) cluster( country )level(90)
outreg2 using "Heterogeneous effects of demographic factors.doc"
* 2.2 Grouping regression by Total labor force(Labor):
* Group_Labor (Grouping tags of Labor):Ranking countries by Labor from smallest to largest, the value 1 represents the low-level group of the corresponding grouping indicator;the value 2 represents the high-level group of the corresponding grouping indicator.
*2.2.1 Delete the high level group and perform regression for the low level group
clear all
use "D:\Data and code\Data\Panel_data\did_longdata.dta" 
keep if Group_Labor==1
reghdfe MP did GDP POP PPI,ab( year country ) cluster( country )level(90)
outreg2 using "Heterogeneous effects of demographic factors.doc"
* 2.2.2 Delete the low level group and perform regression for the high level group
clear all
use "D:\Data and code\Data\Panel_data\did_longdata.dta" 
keep if Group_Labor==2
reghdfe MP did GDP POP PPI,ab( year country ) cluster( country )level(90)
outreg2 using "Heterogeneous effects of demographic factors.doc"
