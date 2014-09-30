## Aggregating the Census Block level leakage to neighborhood boundaries
## Same process can be used for any non-standard geometries
## Aggregating to geometries such as Census Tracts is simpler, as there is generally a geoid to assist with assigning blocks to tracts

## Import block centroids

blockcentroids <- readOGR("./Data","BlockCentroids2010")

## Import neighborhoods data

PLACES_MO <-readOGR("./Data/CEN2010_PLACES","MO_Service_Area_Places_Proj")
PLACES_IL <-readOGR("./Data/CEN2010_PLACES", "IL_Service_Area_Places_Proj")
NBRHD_CITY <- readOGR("./Data/CITY_NEIGHBORHOODS","nbrhd_Proj")

## Before binding, will need to change field ids

PLACES_MO <- spChFIDs(PLACES_MO, as.character(PLACES_MO$GEOID10))
PLACES_IL <- spChFIDs(PLACES_IL, as.character(PLACES_IL$GEOID10))

## Bind/merge together into one

PLACES <- spRbind(PLACES_MO, PLACES_IL)

## Remove St. Louis, since we are using neighborhoods there instead!

PLACES <- subset(PLACES, !(NAME10 == "St. Louis"))

## Join places and neighborhoods

PLACES_SIMPLE <- PLACES[, c("GEOID10", "NAME10")]
PLACES_SIMPLE <- rename(PLACES_SIMPLE, c("GEOID10"="HANDLE", "NAME10"="NAME"))

NBRHD_CITY_SIMPLE <- NBRHD_CITY[, c("HANDLE", "Name")]
NBRHD_CITY_SIMPLE <- rename(NBRHD_CITY_SIMPLE, c("Name"="NAME"))

PLACES_NABES <- spRbind(PLACES_SIMPLE, NBRHD_CITY_SIMPLE)

## Determine which neighborhood each block centroid is in

blockcentroids$nbrhd <- over (blockcentroids, PLACES_NABES)

## Join block level data to block centroids based on GEOID
## This is a several step process. 

# 'join' the new data with merge()
# all.x=TRUE is used to ensure we have the same number of rows after the join
# in case that the new table has fewer

merged <- merge(x=blockcentroids@data, y=block_leakage, by ="GEOID10", , all.x=TRUE)

# generate a vector that represents the original ordering of rows in the sp object
correct.ordering <- match(blockcentroids@data$GEOID10, merged$GEOID10)

# overwrite the original dataframe with the new merged dataframe, in the correct order
blockcentroids@data <- merged[correct.ordering, ]

# check the ordering of the merged data, with the original spatial data
cbind(blockcentroids@data$GEOID10, merged$GEOID10[correct.ordering])

## Sum block data by nbrhd$NAME

tmpdf <- blockcentroids@data
tmpdf$nbrhdname <- as.character(tmpdf$nbrhd$NAME)
tmpdf2 <- tmpdf[ , c("l_grocery", "l_restaurant", "l_apparel", "l_shoes","l_furniture", "nbrhdname")]

neighborhood_leakage <- ddply(tmpdf2, c("nbrhdname"), summarize, 
                             l_grocery = sum(l_grocery, na.rm=TRUE),
                             l_restaurant = sum(l_restaurant, na.rm=TRUE),
                             l_apparel = sum(l_apparel, na.rm=TRUE),
                             l_shoes = sum(l_shoes, na.rm=TRUE),
                             l_furniture = sum(l_furniture, na.rm=TRUE)                          
                             )

## Now join our neighborhood_leakage table back to neighborhoods

# 'join' the new data with merge()
# all.x=TRUE is used to ensure we have the same number of rows after the join
# in case that the new table has fewer

merged <- merge(x=PLACES_NABES@data, y=neighborhood_leakage, by.x ="NAME",by.y = "nbrhdname" , all.x=TRUE)

# generate a vector that represents the original ordering of rows in the sp object
correct.ordering <- match(PLACES_NABES@data$NAME, merged$NAME)

# overwrite the original dataframe with the new merged dataframe, in the correct order
PLACES_NABES@data <- merged[correct.ordering, ]

# check the ordering of the merged data, with the original spatial data
cbind(PLACES_NABES@data$NAME, merged$NAME[correct.ordering])

## Export everything to both shapefile (to check in ArcGIS) and geojson (for Data Gateway)

writeOGR(PLACES_NABES, ".", "neighborhood_leakage", driver="ESRI Shapefile")
unlink("neighborhood_leakage.geojson")
writeOGR(PLACES_NABES, "neighborhood_leakage.geojson", "neighborhood_leakage", driver = "GeoJSON")