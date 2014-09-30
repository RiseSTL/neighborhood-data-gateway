## Calculate Sales Volume

## Import block geometries

blocks_geom_17119 <-readOGR("./Data","tl_2010_17119_tabblock10")
blocks_geom_17163 <-readOGR("./Data","tl_2010_17163_tabblock10")
blocks_geom_29510 <-readOGR("./Data","tl_2010_29510_tabblock10")
blocks_geom_29189 <-readOGR("./Data","tl_2010_29189_tabblock10")

blocks_geom_17119 <- spChFIDs(blocks_geom_17119, as.character(blocks_geom_17119$GEOID10))
blocks_geom_17163 <- spChFIDs(blocks_geom_17163, as.character(blocks_geom_17163$GEOID10))
blocks_geom_29510 <- spChFIDs(blocks_geom_29510, as.character(blocks_geom_29510$GEOID10))
blocks_geom_29189 <- spChFIDs(blocks_geom_29189, as.character(blocks_geom_29189$GEOID10))

blocks_geom_all <- spRbind(blocks_geom_17119, blocks_geom_17163)
blocks_geom_all <- spRbind(blocks_geom_all, blocks_geom_29510)
blocks_geom_all <- spRbind(blocks_geom_all, blocks_geom_29189)

## Determine which block each RefUSA business is in

naics_geo$censusblock <- over (naics_geo, blocks_geom_all)

## Sum sales volume by NAICS Code and by Block GEOID

naics_tmp <- naics_geo@data
naics_tmp$blockid <- as.character(naics_tmp$censusblock$GEOID10)
naics_tmp2 <- naics_tmp[ , c("Primary.NAICS", "Location.Sales.Volume.Actual", "blockid")]

naics_summary <- ddply(naics_tmp2, c("blockid"), summarize, 
      sv_grocery = sum(Location.Sales.Volume.Actual[Primary.NAICS %in% c("445110")], na.rm=TRUE),
      sv_restaurant = sum(Location.Sales.Volume.Actual[Primary.NAICS %in% c("722511","722515","722513","722514")], na.rm=TRUE),
      sv_apparel = sum(Location.Sales.Volume.Actual[Primary.NAICS %in% c("448150","448190","448140","448120","448130","448110")], na.rm=TRUE),
      sv_shoes = sum(Location.Sales.Volume.Actual[Primary.NAICS %in% c("448210")], na.rm=TRUE),
      sv_furniture = sum(Location.Sales.Volume.Actual[Primary.NAICS %in% c("442110")], na.rm=TRUE)     
      )

## Merge sales volume summaries with purchasing power summaries (BLOCKS_WITH_INCOMES)

block_leakage <- merge(BLOCKS_WITH_INCOMES, naics_summary, by.x = "GEOID10", by.y = "blockid", all.x = TRUE)

## Replace "N/A" under sales volume with 0

block_leakage[c("sv_grocery", "sv_restaurant","sv_apparel","sv_shoes","sv_furniture")][is.na(block_leakage[c("sv_grocery", "sv_restaurant","sv_apparel","sv_shoes","sv_furniture")])] <- 0
