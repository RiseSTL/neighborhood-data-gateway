## IMPORT DATA
## 2012 5-Year ACS Data: Table B19001 - HOUSEHOLD INCOME IN THE PAST 12 MONTHS (IN 2012 INFLATION-ADJUSTED DOLLARS)
## Imported using ACS package and Census Data API

stclair = geo.make(state=17, county=163, tract="*")
madison = geo.make(state=17, county=119, tract="*")
stlcity = geo.make(state=29, county=510, tract="*")
stlcounty = geo.make(state=29, county=189, tract="*")
rise_service_area = stclair + madison + stlcity + stlcounty

## Table in ACS package format

B19001_ACS = acs.fetch(geo=rise_service_area, table.number="B19001", endyear=2012, span=5)

## Table converted to Data Frame

B19001_DF = data.frame(geography(B19001_ACS), estimate(B19001_ACS), 1.645*standard.error(B19001_ACS))

## Function to deal with the fact Missouri Census Data Center .csv file has numbers written like "1,087" instead of 1087

setClass("numwithcommas")

setAs("character", "numwithcommas", 
      function(from) as.numeric(gsub(",", "", from))) 

CEN2010_BLOCKS_CLASSES = c(rep("character", 7), rep("numwithcommas", 186))
CEN2010_TRACTS_CLASSES = c(rep("character", 6), rep("numwithcommas", 222))


## IMPORT DATA
## 2010 Census Block Level Data
## Downloaded from Missouri Census Data Center

CEN2010_BLOCKS_29510 <- read.csv("Data/CEN2010_BLOCKS/CEN2010_BLOCKS_29510.csv", header=TRUE, colClasses = CEN2010_BLOCKS_CLASSES, stringsAsFactors=FALSE)
CEN2010_BLOCKS_29189 <- read.csv("Data/CEN2010_BLOCKS/CEN2010_BLOCKS_29189.csv", header=TRUE, colClasses = CEN2010_BLOCKS_CLASSES, stringsAsFactors=FALSE)
CEN2010_BLOCKS_17119 <- read.csv("Data/CEN2010_BLOCKS/CEN2010_BLOCKS_17119.csv", header=TRUE, colClasses = CEN2010_BLOCKS_CLASSES, stringsAsFactors=FALSE)
CEN2010_BLOCKS_17163 <- read.csv("Data/CEN2010_BLOCKS/CEN2010_BLOCKS_17163.csv", header=TRUE, colClasses = CEN2010_BLOCKS_CLASSES, stringsAsFactors=FALSE)

## Append 2010 Census Blocks data frames together

CEN2010_BLOCKS_ALL <-rbind(CEN2010_BLOCKS_29510, CEN2010_BLOCKS_29189)
CEN2010_BLOCKS_ALL <-rbind(CEN2010_BLOCKS_ALL, CEN2010_BLOCKS_17119)
CEN2010_BLOCKS_ALL <-rbind(CEN2010_BLOCKS_ALL, CEN2010_BLOCKS_17163)

## IMPORT DATA
## 2010 Census Tract Level Data
## Downloaded from Missouri Census Data Center

CEN2010_TRACTS_29510 <- read.csv("Data/CEN2010_TRACTS/CEN2010_TRACTS_29510.csv", header=TRUE, colClasses = CEN2010_TRACTS_CLASSES, stringsAsFactors=FALSE)
CEN2010_TRACTS_29189 <- read.csv("Data/CEN2010_TRACTS/CEN2010_TRACTS_29189.csv", header=TRUE, colClasses = CEN2010_TRACTS_CLASSES, stringsAsFactors=FALSE)
CEN2010_TRACTS_17119 <- read.csv("Data/CEN2010_TRACTS/CEN2010_TRACTS_17119.csv", header=TRUE, colClasses = CEN2010_TRACTS_CLASSES, stringsAsFactors=FALSE)
CEN2010_TRACTS_17163 <- read.csv("Data/CEN2010_TRACTS/CEN2010_TRACTS_17163.csv", header=TRUE, colClasses = CEN2010_TRACTS_CLASSES, stringsAsFactors=FALSE)

## Append 2010 Census Tracts data frames together

CEN2010_TRACTS_ALL <-rbind(CEN2010_TRACTS_29510, CEN2010_TRACTS_29189)
CEN2010_TRACTS_ALL <-rbind(CEN2010_TRACTS_ALL, CEN2010_TRACTS_17119)
CEN2010_TRACTS_ALL <-rbind(CEN2010_TRACTS_ALL, CEN2010_TRACTS_17163)

## Add variable TractHHPct to CEN2010_BLOCKS_ALL showing what percent of the tract's households are within each block

CEN2010_BLOCKS_ALL$TractJoin <- strtrim(CEN2010_BLOCKS_ALL$esriid, 11)
CEN2010_TRACTS_ALL$TractJoin <- strtrim(CEN2010_TRACTS_ALL$esriid, 11)
CEN2010_BLOCKS_ALL$TractHHs <- merge(CEN2010_BLOCKS_ALL, CEN2010_TRACTS_ALL, by = "TractJoin")$TotHHs.y
CEN2010_BLOCKS_ALL$TractHHPct <- CEN2010_BLOCKS_ALL$TotHHs / CEN2010_BLOCKS_ALL$TractHHs

## Add TractJoin field to B19001_DF so we can calculate block income

B19001_DF$TractJoin <- do.call(paste,c(B19001_DF[c("state","county", "tract")], sep =""))

## Blocks with incomes
## For each income column, we multiply the TractHHPct by the number of HHs in the tract with that income

TRACT_HHINC_LIST <- c("TRACT_HHINC_001",
                      "TRACT_HHINC_002",
                      "TRACT_HHINC_003",
                      "TRACT_HHINC_004",
                      "TRACT_HHINC_005",
                      "TRACT_HHINC_006",
                      "TRACT_HHINC_007",
                      "TRACT_HHINC_008",
                      "TRACT_HHINC_009",
                      "TRACT_HHINC_010",
                      "TRACT_HHINC_011",
                      "TRACT_HHINC_012",
                      "TRACT_HHINC_013",
                      "TRACT_HHINC_014",
                      "TRACT_HHINC_015",
                      "TRACT_HHINC_016",
                      "TRACT_HHINC_017")
BLOCK_HHINC_LIST <- c("BLOCK_HHINC_001",
                      "BLOCK_HHINC_002",
                      "BLOCK_HHINC_003",
                      "BLOCK_HHINC_004",
                      "BLOCK_HHINC_005",
                      "BLOCK_HHINC_006",
                      "BLOCK_HHINC_007",
                      "BLOCK_HHINC_008",
                      "BLOCK_HHINC_009",
                      "BLOCK_HHINC_010",
                      "BLOCK_HHINC_011",
                      "BLOCK_HHINC_012",
                      "BLOCK_HHINC_013",
                      "BLOCK_HHINC_014",
                      "BLOCK_HHINC_015",
                      "BLOCK_HHINC_016",
                      "BLOCK_HHINC_017")
B19001_LIST <-  c("B19001_001",
                  "B19001_002",
                  "B19001_003",
                  "B19001_004",
                  "B19001_005",
                  "B19001_006",
                  "B19001_007",
                  "B19001_008",
                  "B19001_009",
                  "B19001_010",
                  "B19001_011",
                  "B19001_012",
                  "B19001_013",
                  "B19001_014",
                  "B19001_015",
                  "B19001_016",
                  "B19001_017")

BLOCKS_WITH_INCOMES <- CEN2010_BLOCKS_ALL[, c("esriid","areaname","GeoCode","Stab","Tract","Block","TractJoin","TotHHs","TractHHs","TractHHPct")]
BLOCKS_WITH_INCOMES[TRACT_HHINC_LIST] <- merge(BLOCKS_WITH_INCOMES, B19001_DF, by = "TractJoin")[B19001_LIST]
BLOCKS_WITH_INCOMES[BLOCK_HHINC_LIST] <- BLOCKS_WITH_INCOMES$TractHHPct * BLOCKS_WITH_INCOMES[TRACT_HHINC_LIST]

## Import BLS CEX Data

tmpCEX <- read.csv("Data/CEX/incomecombined.csv", header=TRUE, stringsAsFactors=FALSE)

## Fix import so first column = row names

CEX <- tmpCEX[,-1]
rownames(CEX) <- tmpCEX[,1]

## CALCULATE PURCHASING POWER BY BLOCK
## Purchasing power calculation function based on incomes in ACS and CEX.
## Note that ACS and CEX income ranges don't quite match.  
## Most of the time, though, the ACS is *within* the CEX range and so it is simple.

purchpowercalc <- function(expcat) {
                  return (BLOCKS_WITH_INCOMES$BLOCK_HHINC_002 * (((CEX[expcat,"i5k"] * CEX["numcu","i5k"]) + (CEX[expcat,"i5k10k"] * CEX["numcu","i5k10k"]))/(CEX["numcu","i5k"] + CEX["numcu","i5k10k"])) +
                          BLOCKS_WITH_INCOMES$BLOCK_HHINC_003 * (CEX[expcat,"i10k15k"]) +
                          BLOCKS_WITH_INCOMES$BLOCK_HHINC_004 * (CEX[expcat,"i15k20k"]) +
                          BLOCKS_WITH_INCOMES$BLOCK_HHINC_005 * (CEX[expcat,"i20k30k"]) +
                          BLOCKS_WITH_INCOMES$BLOCK_HHINC_006 * (CEX[expcat,"i20k30k"]) +
                          BLOCKS_WITH_INCOMES$BLOCK_HHINC_007 * (CEX[expcat,"i30k40k"]) +
                          BLOCKS_WITH_INCOMES$BLOCK_HHINC_008 * (CEX[expcat,"i30k40k"]) +
                          BLOCKS_WITH_INCOMES$BLOCK_HHINC_009 * (CEX[expcat,"i40k50k"]) +
                          BLOCKS_WITH_INCOMES$BLOCK_HHINC_010 * (CEX[expcat,"i40k50k"]) +
                          BLOCKS_WITH_INCOMES$BLOCK_HHINC_011 * (CEX[expcat,"i50k70k"]) +
                          BLOCKS_WITH_INCOMES$BLOCK_HHINC_012 * (((2/3)*(CEX[expcat,"i50k70k"])) + ((1/3)*(CEX[expcat,"i70k80k"]))) + 
                          BLOCKS_WITH_INCOMES$BLOCK_HHINC_013 * (((1/5)*(CEX[expcat,"i70k80k"])) + ((4/5)*(CEX[expcat,"i80k100k"]))) +
                          BLOCKS_WITH_INCOMES$BLOCK_HHINC_014 * (((4/5)*(CEX[expcat,"i100k120k"])) + ((1/5)*(CEX[expcat,"i120k150k"]))) +
                          BLOCKS_WITH_INCOMES$BLOCK_HHINC_015 * (CEX[expcat,"i120k150k"]) +
                          BLOCKS_WITH_INCOMES$BLOCK_HHINC_016 * (CEX[expcat,"i150k"]) +
                          BLOCKS_WITH_INCOMES$BLOCK_HHINC_017 * (CEX[expcat,"i150k"])                                      
                          )
                  }

## Use function above to calculate purchasing power for various CEX expenditure categories

BLOCKS_WITH_INCOMES$pp_totexp <- purchpowercalc("totexp")
BLOCKS_WITH_INCOMES$pp_grocery <- purchpowercalc("foodhome")
BLOCKS_WITH_INCOMES$pp_restaurant <- purchpowercalc("foodaway")
BLOCKS_WITH_INCOMES$pp_apparel <- purchpowercalc("apparel")
BLOCKS_WITH_INCOMES$pp_shoes <- purchpowercalc("footwear")
BLOCKS_WITH_INCOMES$pp_furniture <- purchpowercalc("hhfurnishings")
BLOCKS_WITH_INCOMES$GEOID10 <- substr(BLOCKS_WITH_INCOMES$esriid, 1, 15)