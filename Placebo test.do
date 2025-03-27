clear all

* Load dataset
use "D:\Data and code\Data\Panel_data\did_longdata.dta" 

* View labels for all variables (The variable information is detailed in Table S1 of Supporting Information and section 2.2 of the manuscript)
describe
* View notes for all variables (The variable information is detailed in Table S1 of Supporting Information and section 2.2 of the manuscript)
notes list

* Robustness tests
* Change working directory
cd "D:\Data and code\DID\Robustness tests"

* Parallel trend test:

* Set panel data structure
xtset id year
* Define control variables
global xlist " GDP POP PPI "
* Run baseline regression to get true coefficient (true coefficient = -0.614)
reghdfe MP did $xlist ,absorb(id year) vce(cluster id)

* Set matrix size for placebo test
set matsize 5000

* Initialize matrices to store results
mat b = J(500,1,0)    // Matrix for coefficients
mat se = J(500,1,0)    // Matrix for standard errors
mat p = J(500,1,0)    // Matrix for p-values 

* Begin placebo test loop (500 iterations)
forvalues i=1/500{
    * Reload original dataset for each iteration
      use "D:\Data and code\Data\Panel_data\did_longdata.dta", clear
      xtset id year
	  
    * Keep only baseline year (2011) and randomly sample 21 treated units
      keep if year==2011
      sample 21, count
      keep id
      save match_id.dta, replace
	  
	* Merge back with full dataset to create fake treatment groups
      merge 1:m id using "D:\Data and code\Data\Panel_data\did_longdata.dta"
	  
	* Generate fake treatment variable
      gen dt = (_merge == 3)       // Fake treatment group dummy
      gen dp = (year >= 2014)      // Post-period dummy
      gen dtdp = dt*dp             // Fake interaction term
	  
    * Run regression with fake treatment
      reghdfe MP dtdp $xlist ,absorb(id year) vce(cluster id)
	  
    * Store results in matrices
      mat b[`i',1] = _b[dtdp]     // Store coefficient 
      mat se[`i',1] = _se[dtdp]    // Store standard error
      mat p[`i',1] = 2*ttail(e(df_r), abs(_b[dtdp]/_se[dtdp])) // Calculate and store p-value
}

* Convert matrices to variables
svmat b, names(coef)     // Coefficient vector    
svmat se, names(se)      // Standard error vector     
svmat p, names(pvalue)   // P-value vector

* Clean data for plotting
drop if pvalue1 == .     // Drop missing values  
label var pvalue1 "P-value"
label var coef1 "Estimated coefficient"
keep coef1 se1 pvalue1  
save placebo.dta, replace

* Prepare for plotting
use placebo.dta, clear

* Set graph font to Arial
graph set window fontface "Arial"

* Create placebo test plot with:
* (1) Kernel density of coefficients
* (2) Scatter plot of p-values vs coefficients
* (3) Reference lines for true coefficient (-0.614) and p=0.1 threshold
twoway (kdensity coef1) ///  // Kernel density plot of placebo test coefficients
       (scatter pvalue1 coef1, ///  // Scatter plot of p-values vs coefficients
        msymbol(smcircle_hollow) ///  // Hollow circle markers
        mcolor(blue)), ///  // Blue marker color    
       xlabel(-0.8(0.2)0.8, ///  // X-axis labels from -0.8 to 0.8 in 0.2 increments
              labsize(8-pt) ///  // Label size 8-point
              format(%02.1f)) ///  // Format: 2 digits total, 1 decimal (e.g., -0.6)    
       ylabel(, angle(0) ///  // Horizontal y-axis labels
              labsize(8-pt) ///  // Label size 8-point
              format(%02.1f)) ///  // Format: 2 digits total, 1 decimal    
       xline(-0.614, ///  // Vertical line at true coefficient value
             lcolor(blue) ///  // Blue line color
             lwidth(medthin) ///  // Medium-thin line width
             lpattern(dash)) ///  // Dashed line pattern  
       yline(0.1, ///  // Horizontal line at p=0.1 threshold
             lcolor(black) ///  // Black line color
             lwidth(thin) ///  // Thin line width
             lpattern(dash))  ///  // Dashed line pattern      
       xtitle("Regression coefficients of the interaction",size(10-pt)) ///  //  X-axis title size 10-point
       ytitle("P-value",size(10-pt))  ///  // Y-axis title size 10-point 
       legend(size(10-pt) ///  // Legend text size 10-point
              label(1 "Kernel density") ///  // First legend entry
              label(2 "P-value"))  ///  // Second legend entry   
       plotregion(lcolor(black) ///  // Black border around plotting area
                 lwidth(thin))  ///  // Thin border width 
       graphregion(color(white))  // White background for entire graph
	
* Export the graph as a PNG file to the specified path
graph save "Graph" "D:\Data and code\DID\Robustness tests\The result of the placebo test.png"
