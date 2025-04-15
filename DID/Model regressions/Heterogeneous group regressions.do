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
* For each grouping indicator, we sorted the sample countries into a high-level group and a low-level group, each of which contains part of the treatment group and the control group. The detailed process of grouping according to a certain grouping indicator will be presented in Section 2.2 (Grouping regression according to labor force ratio) in this code, and the grouping process of other indicators will be omitted for the same reason.

* 1 Economic factors
* 1.1 Grouping regression by GDP per capita level:

* Group_GDP (Grouping tags of GDP per capita):Ranking countries by GDP per capita from smallest to largest, the value 1 represents the low-level group of the corresponding grouping indicator;the value 2 represents the high-level group of the corresponding grouping indicator.

* Delete the high level group and perform regression for the low level group
keep if Group_GDP==1
reghdfe MP did  POP PPI,ab( year country ) cluster( country )level(90) // In order to avoid multicollinearity problems, the control variables are no longer added to GDP when the regression is grouped according to the level of GDP per capita.

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
reghdfe MP did GDP PPI,ab( year country ) cluster( country )level(90) // In order to avoid multicollinearity problems,POP item is no longer added to the control variables when the regression is grouped according to the level of total population.

* Export DID regression results to Word document
outreg2 using "Heterogeneous effects of demographic factors.doc"

* 2.1.2 Delete the low level group and perform regression for the high level group
clear all
use "D:\Data and code\Data\Panel_data\did_longdata.dta" 
keep if Group_POP==2
reghdfe MP did GDP PPI,ab( year country ) cluster( country )level(90)
outreg2 using "Heterogeneous effects of demographic factors.doc"

* 2.2 Grouping regression by Total labor force(Labor):

* Rank and group the sample countries by labor force level:

* Create a new variable, Labor_ratio, that represents the ratio of the total labor force to the total population in each country:
gen Labor_ratio=Labor/ Tot_pop

* Add a label and notes to the new variable:
label variable Labor_ratio "Other grouping indicator"
notes Income
note Labor_ratio :"Represents the ratio of the total labor force to the total population of each country."

* To get the mean value of Labor_ratio for each country over the study period:
* -Uses `egen` with `mean()` function
* -Missing values are automatically excluded.
egen Labor_ave = mean( Labor_ratio ) if inrange(year, 2011, 2018), by(country)

* Verify calculation (optional)
list country Labor_ratio Labor_ave if year == 2011, sepby(country)

* To rank countries and create Group_Labor by values of Labor_ave: 
* - Missing values are automatically excluded from ranking
* - Uses stable sorting to handle ties
* - Automatically splits into 2 equal groups
xtile Group_Labor = Labor_ave, nq(2)

* Label the values for clarity
label define labor_group 1 "Low-labor group" 2 "High-labor group"
label variable Group_Labor "Grouping variable for heterogeneity regression"
* Group_Labor (Grouping tags of Labor):Ranking countries by the proportion of the labor force to the total population from smallest to largest, the value 1 represents the low-level group of the corresponding grouping indicator;the value 2 represents the high-level group of the corresponding grouping indicator.

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


* 3 Industrial structure factors
* 3.1 Grouping regression by mariculture production:

* Group_MP (Grouping tags of mariculture production):Ranking countries by average mariculture production from smallest to largest, the value 1 represents the low-level group of the corresponding grouping indicator;the value 2 represents the high-level group of the corresponding grouping indicator.

* 3.1.1 Delete the high level group and perform regression for the low level group
clear all
use "D:\Data and code\Data\Panel_data\did_longdata.dta" 
keep if Group_MP==1
reghdfe MP did GDP POP PPI,ab( year country ) cluster( country )level(90)

* Export DID regression results to Word document
outreg2 using "Heterogeneous effects of industrial structure factors.doc"

* 3.1.2 Delete the low level group and perform regression for the high level group
clear all
use "D:\Data and code\Data\Panel_data\did_longdata.dta" 
keep if Group_MP==2
reghdfe MP did GDP POP PPI,ab( year country ) cluster( country )level(90)
outreg2 using "Heterogeneous effects of industrial structure factors.doc"

* 3.2 Grouping regression by proportion of the value added of the primary industry:

* Group_PPI (Grouping tags of PPI):Ranking countries by the proportion of the value added of the primary industry from smallest to largest, the value 1 represents the low-level group of the corresponding grouping indicator;the value 2 represents the high-level group of the corresponding grouping indicator.

* 3.2.1 Delete the high level group and perform regression for the low level group
clear all
use "D:\Data and code\Data\Panel_data\did_longdata.dta" 
keep if Group_PPI==1
reghdfe MP did GDP POP PPI,ab( year country ) cluster( country )level(90)

* Export DID regression results to Word document
outreg2 using "Heterogeneous effects of industrial structure factors.doc"

* 3.2.2 Delete the low level group and perform regression for the high level group
clear all
use "D:\Data and code\Data\Panel_data\did_longdata.dta" 
keep if Group_PPI==2
reghdfe MP did GDP POP PPI,ab( year country ) cluster( country )level(90)
outreg2 using "Heterogeneous effects of industrial structure factors.doc"