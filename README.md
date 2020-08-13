# Power_of_Irma

This fork contains qualitative coding analysis on the data wrangling portions of this journalist's analysis. See the [coding branch](https://github.com/swkasica/Power_of_Irma/tree/coding) for PDF containing open codes.

A high-level overview of data flow:
![bailey code workflow](https://lh3.googleusercontent.com/jOWjwapd5Xux-WiW9eEYHdi91JvvcMdTZzuFnUW8JY1ouHCrHoW4pcMlyUlTxmAWDJF6DgbM0Ix_-IDuoS6TNY5VAIDHFo84ijUAVlxMYdPeeeeQiyVYDbM9Jz-N8uH8Nw4mknXitWJyrgxysHG59RkfS3Tk4FTAP8SCY5pkxFASVhL8LnXgH2gAO2XEv17rzuAknrhRLDsA8_HSFiQ4bG5tdc8b0uWwRvP0uoVd_fmY0BHWKhQmvRk9E-8mSyn7psUEmT35bFQrziMBOMmHQp9FZnjUXSfL2wP621oU0gJu4lnwGT5odxeHFVdyoYI1Y7I92WZCo6u1hRB_IpubmCnLfsUBYyEHMYGk5bNUvrHRPd4JZ0c4b5idbK3BH9F0SsyNpyIwwj36nCf63716p4TuIBLLM3UXwZ1EFsqdLXbvvCKEA2KlzYS7-1-dUoDrXCEFgHc-MKZpnURNU7lrRyYxaQI4D5Q95MB2Dr8iULHvdfUL11EZ2GmYjeKrXPHXJmOW0v0qrwvPPtfGRN76LFkSE33XxJ9XnI9XDicnW2fYO9aBUjH4RX7iEdBUwJie_ZZNVgifhxbO5lidEchJe2NFH1RKR1mCb2pqHzReXteeG54iM_sYJtiWESlfpNM8rqv7Hrit1Gd-eNbGB7R0fQ61aIIz14PQIhgq98KmR-WJu_vflSejvQl8mz3lug=w1065-h922-no?authuser=0)

Portions of data wrangling in this analysis have been [reproduced in Workbench](https://app.workbenchdata.com/workflows/91337)

### Articles:

* ["The high costs of renting" by Bailey LeFever](https://www.wuft.org/news/energy-burden/deficient-dwellings/high-costs-of-renting/)

## Original Repo Description

**Data journalism project on power access across income levels in Gainesville, Florida in the wake of Hurricane Irma, plus analyses for other stories in the Energy Burden series on housing code violations and solar energy use across income levels.**  
Story can be found [here](https://www.wuft.org/news/energy-burden/the-storm/), and is part of a series:  
Additional analyses conducted and hosted here for series stories on income level patterns in housing code violations (by Bailey LeFever) and solar energy use (by Liana Zafran).  
[![Binder](https://mybinder.org/badge.svg)](https://mybinder.org/v2/gh/beecycles/Power_of_Irma/master)  
  
Public records were obtained from Gainesville Regional Utilities (GRU) and the City of Gainesville. Address data were joined to county-assessed property value data provided by Dr. Hal Knowles. Analyses were restricted to postal codes within Gainesville city limits and to properties valued at between $20,000 and $2 million to ensure likelihood that addresses represented homes rather than empty properties or businesses, and to eliminate outliers. Significance of relationship between property values and duration of power outage (Joan Meiners story), housing code violations (Bailey LeFever story), or solar energy use (Liana Zafran story) were conducted separately as generalized linear models using the open source statistical software R. Both predictor (Property values) and response (power outage duration or number of housing code violations or solar energy use in kWDC) were log-transformed for all models to achieve near-normal distributions. Statistical significance was evaluated at the p<0.05 level, and log-linear relationships between predictor and response variables were significant at the p<0.001 level for all three models presented in the story series.  
  
Joan Meiners is a PhD student in Interdisciplinary Ecology at the University of Florida.  
Questions may be directed to: joan.meiners@gmail.com.
