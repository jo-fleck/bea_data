
#### This script displays the state GDP components available from the BEA and imports them ### 
rm(list=ls()) 
library(bea.R)


## 1) Set BEA's API key

BEA_API_key <- '/Users/main/Documents/Dropbox/Computing/BEA/bea_api_key.txt'
beaKey <- readChar(BEA_API_key, file.info(BEA_API_key)$size)
# Note: API key for BEA data is available here: https://www.bea.gov/API/signup/index.cfm


## 2) Select Data

# Inspect GDP components included in the Regional Product Accounts
gdp_comp <- beaParamVals(beaKey, 'RegionalProduct', 'Component')
gdp_comp
# From there, select prefered series (match number to Key)

# Inspect industry breakdown
ind <- beaParamVals(beaKey, 'RegionalProduct', 'IndustryId')
ind
# From there, select prefered series (match number to Key)


## DATA POST 1996 (NAICS)

## 3) Design list for pulling data
data_list_post1996 <- list('UserID' = beaKey,
                     'Method' = 'GetData',
                     'datasetname' = 'RegionalProduct',
                     'Component' = 'GDP_SAN',
                     'GeoFips' = 'STATE',
                     'IndustryId' = 1,
                     'Year' = 'ALL')

## 4) Pull data and save as csv
state_gdp_post1996 <- beaGet(data_list_post1996, asTable = TRUE)
write.csv(state_gdp_post1996, file = '/Users/main/OneDrive - Istituto Universitario Europeo/data/state_finances/nom_gdp_state_post1996.csv', row.names = FALSE)


## DATA UNTIL 1997 (SIC)

## 3) Design list for pulling data
data_list_until1997 <- list('UserID' = beaKey,
                           'Method' = 'GetData',
                           'datasetname' = 'RegionalProduct',
                           'Component' = 'GDP_SAS',
                           'GeoFips' = 'STATE',
                           'IndustryId' = 1,
                           'Year' = 'ALL')

## 4) Pull data and save as csv
state_gdp_until1997 <- beaGet(data_list_until1997, asTable = TRUE)
write.csv(state_gdp_until1996, file = '/Users/main/OneDrive - Istituto Universitario Europeo/data/state_finances/nom_gdp_state_until1996.csv', row.names = FALSE)
