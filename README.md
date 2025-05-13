


> # **Quantifying the effect of ocean warming on global   mariculture production**
> ### Ocean Warming and Mariculture Vulnerability: A Global Analysis of El Niño-Driven Production Losses
> *Authors:*  Linan Ma, Shaobin Li, Ting Jiang, Zhaoyuan Yu, Gengyuan Liu, Xiaojia He, Quanli Wang, Jie Su, Nengwang Chen, Chao Fan
> ***
> # 1 Introduction
> This package provides an easy way to quantify the effect of ocean warming on global mariculture production during the 2014 El Niño. The data and code module in the package can be divided into three parts:
> - **Extraction of the sea surface temperature (SST).** **[SST_extraction_code.R](https://github.com/lnma01/Oceanwarming-did-regression/blob/main/Data/SST_extraction/SST_extraction_code.R) is to obtain the annual average sea surface temperature values of mariculture areas in the sample countries.**  We used each country's exclusive economic zone as its mariculture activity area, and the sea surface temperature within the zone was averaged annually.
> - **Model regressions.**
>  **[Empirical regressions.do](https://github.com/lnma01/Oceanwarming-did-regression/blob/main/DID/Model%20regressions/Empirical%20regressions.do) is the main part of the difference-in-differences model.** We used it to test the significant impact of a super El Niño event on the mariculture output of the countries in the central and eastern tropical regions. **[Heterogeneous group regressions.do](https://github.com/lnma01/Oceanwarming-did-regression/blob/main/DID/Model%20regressions/Heterogeneous%20group%20regressions.do) is used to calculate the heterogeneous effects of socio-economic factors on the above-mentioned impact.** We grouped the sample countries based on their socioeconomic levels, and then ran DID regressions separately and compared the impact of each group.    **[Moderating effect regressions.do](https://github.com/lnma01/Oceanwarming-did-regression/blob/main/DID/Model%20regressions/Moderating%20effect%20regressions.do) is to examine the moderating role of sea surface temperature in the impact on mariculture yields. [Sensitivity analysis regressions.do](https://github.com/lnma01/Oceanwarming-did-regression/blob/main/DID/Model%20regressions/Sensitivity%20analysis%20regressions.do) is a further supplement to the regression results.** We expanded the range of potentially affected regions and ran DID regressions.
>  - **Robustness tests.**
>  **[Parallel trend test.do](https://github.com/lnma01/Oceanwarming-did-regression/blob/main/DID/Robustness%20tests/Parallel%20trend%20test.do),  [Placebo test.do](https://github.com/lnma01/Oceanwarming-did-regression/blob/main/DID/Robustness%20tests/Placebo%20test.do), and [Placebo tests for the treatment group located in other tropical sea areas.do](https://github.com/lnma01/Oceanwarming-did-regression/blob/main/DID/Robustness%20tests/Placebo%20tests%20for%20the%20treatment%20group%20located%20in%20other%20tropical%20sea%20areas.do) are the robustness test parts of the model.** We examined the basic assumption that the model satisfies the parallelism trend. Furthermore, for the selection of the treatment group countries, we also conducted robustness verification by using the methods of random sampling and resetting the selection range.
>  
> Methodology and data source will be mentioned later in the Methodology and Data source section.
> # 2 Methodology
> ## 2.1 Extraction of the sea surface temperature (SST)
> The study delineated potential mariculture zones using exclusive economic zone (EEZ) boundaries of each country, extracting their geographic coordinates (latitude/longitude) via ArcGIS. For efficiency, rectangular sea areas were defined based on the EEZ’s extremum coordinates (x1, x2; y1, y2). Monthly mean SST data (2°×2° resolution) were sourced from NOAA, aggregated annually to derive global SST. For country-level analysis, SST values were extracted within each EEZ-derived mariculture area, averaged spatially, and temporally resampled to annual resolution to match mariculture production data.
>## 2.2 Model regressions
>### 2.2.1 Basic empirical regression
>This study employs a difference-in-differences (DID) approach to assess the impact of El Niño-induced abnormal sea surface temperature (SST) rise on mariculture production. Firstly, we conducted a basic empirical regression.  The treatment group comprises tropical countries in the central-eastern Pacific (160°E–80°W, 23.5°N–23.5°S), while the remaining countries serve as the control group. The exogenous shock was defined as the 2014–2016 super El Niño event, with pre- (2011–2013) and post-shock (2014–2018) periods.
>The DID model is specified as:
>$$
>Y_{it} = \alpha_0 + \alpha (Post_{it} \times Treat_{it}) + X_{it} + \mu_i + \lambda_t + \varepsilon_{it}
>$$
>where $Y_{it}$ denotes mariculture output for country $i$ in year $t$, $Post_{it}$  is a time dummy (1 post-2014), and $Treat_{it}$ is a group dummy (1 for treated countries). The coefficient $α$ captures the treatment effect: a significantly negative $α$ implies that SST anomalies reduce mariculture yields. Control variables ($X_{it}$) include GDP per capita, population, and the proportion of primary industry, with $\mu_i$ and $\lambda_t$  accounting for country and year fixed effects, respectively.
>### 2.2.2 Heterogeneous group regression
>Secondly, we conducted the heterogeneous group regression. To examine how socioeconomic factors mediate the impact of El Niño-induced SST anomalies on mariculture, we conducted stratified DID regressions based on economic, demographic, and industrial characteristics. Countries were classified into low-level and high-level groups using the following indicators (averaged over 2011–2018):
>- Economic development: GDP per capita and national income per adult.
>- Demographic conditions: Total population and labor force share.
>- Industrial structure: Mariculture output and primary industry’s GDP share.
>
>Instead of relying on World Bank classifications, we ranked countries by each indicator (e.g., national income per adult) and split them into two balanced groups, ensuring sufficient treatment and control units in each. The DID model was then estimated separately for each subgroup to assess heterogeneous treatment effects. This approach tests whether climate-driven production losses vary systematically with development levels, addressing potential equity gaps in climate vulnerability.
>### 2.2.3 Moderation Effect Test
>Thirdly, to examine whether SST modulates the effect of El Niño-induced ocean warming on mariculture, we augmented the basic DID model with a triple interaction term ($Post  \times  Treat  \times SST$). The extended regression equation is:
>$$
>Y_{it} = \beta_0 + \beta (Post_{it} \times Treat_{it} \times SST_{it}) + X_{it} + \mu_i + \lambda_t + \varepsilon_{it}
>$$
>where $SST_{it}$  represents the logarithm value of the mean sea surface temperature for country $i$ in year $t$.  Coefficient  $\beta$ tests the moderating role of SST, whether it amplifies or mitigates El Niño’s impact. This approach isolates SST’s conditional influence, clarifying its mechanistic role in climate-driven mariculture disruptions.
>### 2.2.4 Sensitivity analysis
>Finally, to avoid the limited reliability of model regression results due to the small number of treatment groups and the subjectivity of the grouping range, we  conducted a sensitivity analysis for the nearby sea area of the treatment group. We appropriately adjusted the regional range of the treatment group, expanded the latitude range limit of the treatment group successively to 30° north and south latitude and 40° north and south latitude for regression. Whether the coefficient α of the interaction is still significant is tested to confirm whether the possible increase in sea surface temperature in a wider range will affect the yield of mariculture fishery. 
>## 2.3 Robustness tests
>### 2.3.1 Parallel trend test
>To ensure the validity of the DID estimator, we first tested the critical parallel trends assumption using an event-study approach. The test equation incorporates leads and lags of treatment exposure:
>$$
>Y_{it} = \alpha_0 + \sum_{t=-3}^4\sigma_tD_{it} + X_{it} + \mu_i + \lambda_t + \varepsilon_{it}
>$$
>where $D_{it}$ indicates an abnormal SST rise in year $t$, and $\sigma_t$ coefficients capture year-specific differences between treatment and control groups. Graphical analysis of pre-treatment period coefficients (t < 0) confirms parallel trends when statistically insignificant, while post-treatment coefficients (t ≥ 0) reveal the dynamic effects of El Niño. This validation is essential for establishing that observed post-intervention divergences in mariculture output ($Y_{it}$) genuinely reflect climate impacts rather than pre-existing differences. The model controls for time-invariant country characteristics ($\mu_i$), temporal shocks ($\lambda_t$), and time-varying covariates ($X_{it}$), ensuring robust causal inference regarding SST anomalies' effects on fisheries production.
>### 2.3.2 Placebo test
>Secondly, based on satisfying the hypothesis of parallel trend, we employed the Placebo test to eliminate the influence of potential factors on the outcomes by randomly selecting a fictitious treatment group.  Specifically, we randomly selected 21 countries from the 124 sample countries as the fictitious treatment group, with the remaining countries considered as the control group. We then generated fictitious variables of SST rise for regression.  By conducting repeated sampling 500 times, we tested the distribution of the estimated coefficients of these fictitious SST virtual variables. If the interaction coefficients in most iterations are close to 0 and the P-values are not significant, it indicates that random factors have minimal influence on the outcomes, suggesting that the model is relatively robust.
>### 2.3.3 Placebo test for other tropical sea areas
>During El Niño, the tropical latitudinal circulation system may undergo significant changes, leading to a series of tropical climate anomalies. To further explore the possible effects of tropical climate anomalies during El Niño, we redefined the treatment group to include countries in the tropical Atlantic Ocean, Indian Ocean, and parts of the eastern Pacific Ocean and re-conducted a DID regression analysis to test the significance of the explanatory variable coefficients in the treatment group.
># Data Source
>|Variable type|Variable name|Variable symbol|Variable description|Data unit|Data source|File|
>|-|-|-|-|-|-|-|
>|Explained  variable|Mariculture production|MP|Ln (Annual production of mariculture by country)|Ton (live weight)|[FAO, 2024](https://www.fao.org/fishery/en/collection/aquaculture)|[Original_data](https://github.com/lnma01/Oceanwarming-did-regression/blob/main/Data/Original_data/Original%20data%20of%20mariculture%20production.xlsx)|
>|Explanatory  variable|Group dummy variable|Treat|The national exclusive economic zone (EEZ) is located in the central and eastern tropical Pacific Ocean, assigned a value of 1; Otherwise, assign a value of 0.|-|-|[Panel_data]( https://github.com/lnma01/Oceanwarming-did-regression/tree/main/Data/Panel_data)|
>|Explanatory  variable|<Time dummy variable|<Post|In the year and after the occurrence of super El Niño, the value is assigned to 1; The remaining years are assigned a value of 0.|-|-|[Panel_data]( https://github.com/lnma01/Oceanwarming-did-regression/tree/main/Data/Panel_data)|
>|Explanatory  variable|The impact of ocean warming event|Post × Treat|EEZ is located during a super El Niño event, with a value of 1; Otherwise, assign a value of 0.|-|-|[Panel_data]( https://github.com/lnma01/Oceanwarming-did-regression/tree/main/Data/Panel_data)|
>|Moderator  variable|Sea surface temperature|SST|Ln (Average annual sea surface temperature of each country)|℃|[NOAA-Monthly means of sea surface temperature](https://www.ncei.noaa.gov/products/extended-reconstructed-sst)|[Original data-SST_extraction](https://github.com/lnma01/Oceanwarming-did-regression/blob/main/Data/SST_extraction/SST%20annual%20mean%20data%20of%20each%20country.xlsx);[Panel_data]( https://github.com/lnma01/Oceanwarming-did-regression/tree/main/Data/Panel_data)|
>|Control  variable|GDP per capita|GDP|Ln (GDP per capita)|Current $|[World Bank-National accounts data](https://data.worldbank.org/indicator/NY.GDP.PCAP.CD)|[Panel_data]( https://github.com/lnma01/Oceanwarming-did-regression/tree/main/Data/Panel_data)|
>|Control  variable|Population size|POP|Ln (Total population)|Thousand people|[World Bank](https://data.worldbank.org/indicator/SP.POP.TOTL);[FAO](https://www.fao.org/faostat/zh/#data/OA)|[Panel_data]( https://github.com/lnma01/Oceanwarming-did-regression/tree/main/Data/Panel_data)|
>|Control  variable|The proportion of primary industry|PPI|Ln (Proportion of primary industry)|%|[World bank-Agriculture, forestry, and fishing, value added](https://data.worldbank.org/indicator/NV.AGR.TOTL.ZS)|[Panel_data]( https://github.com/lnma01/Oceanwarming-did-regression/tree/main/Data/Panel_data)|
>|Other grouping indicator|National income per adult|Income|-|Current $|[World inequality database](https://wid.world/data/)|[Panel_data]( https://github.com/lnma01/Oceanwarming-did-regression/tree/main/Data/Panel_data)|
>|Other grouping indicator|Total labor force|Labor|-|people|[World bank](https://data.worldbank.org/indicator/SL.TLF.TOTL.IN)|[Panel_data]( https://github.com/lnma01/Oceanwarming-did-regression/tree/main/Data/Panel_data)|
># Acknowlegments
>We acknowledge the financial support from the National Natural Science Foundation of China (72348004, 42361144862, 42230406).
># Contact
>In case of any questions, please contact Shaobin Li (shaobinli@xmu.edu.cn).

