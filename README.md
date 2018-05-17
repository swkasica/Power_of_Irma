# Power_of_Irma
**Data journalism project on power access across income levels in Gainesville, Florida in the wake of Hurricane Irma, plus analyses for other stories in the Energy Burden series on housing code violations and solar energy use across income levels.**  
Story can be found [here](https://www.wuft.org/news/energy-burden/the-storm/), and is part of a series:  
Additional analyses conducted and hosted here for series stories on income level patterns in housing code violations (by Bailey LeFever) and solar energy use (by Liana Zafran).  
Binder tag here: https://hub.mybinder.org/user/beecycles-power_of_irma-mkv0dcun/tree#notebooks  
[![Binder](https://mybinder.org/badge.svg)](https://mybinder.org/v2/gh/beecycles/Power_of_Irma/master)  
  
Public records were obtained from Gainesville Regional Utilities (GRU) and the City of Gainesville. Address data were joined to county-assessed property value data provided by Dr. Hal Knowles. Analyses were restricted to postal codes within Gainesville city limits and to properties valued at between $20,000 and $2 million to ensure likelihood that addresses represented homes rather than empty properties or businesses, and to eliminate outliers. Significance of relationship between property values and duration of power outage (Joan Meiners story), housing code violations (Bailey LeFever story), or solar energy use (Liana Zafran story) were conducted separately as generalized linear models using the open source statistical software R. Both predictor (Property values) and response (power outage duration or number of housing code violations or solar energy use in kWDC) were log-transformed for all models to achieve near-normal distributions. Statistical significance was evaluated at the p<0.05 level, and log-linear relationships between predictor and response variables were significant at the p<0.001 level for all three models presented in the story series.  
  
Joan Meiners is a PhD student in Interdisciplinary Ecology at the University of Florida.  
Questions may be directed to: joan.meiners@gmail.com.
