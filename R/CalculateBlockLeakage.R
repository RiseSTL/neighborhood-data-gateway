## Calculate block level leakage

block_leakage$l_grocery <- block_leakage$pp_grocery - block_leakage$sv_grocery
block_leakage$l_restaurant <- block_leakage$pp_restaurant - block_leakage$sv_restaurant
block_leakage$l_apparel <- block_leakage$pp_apparel - block_leakage$sv_apparel
block_leakage$l_shoes <- block_leakage$pp_shoes - block_leakage$sv_shoes
block_leakage$l_furniture <- block_leakage$pp_furniture - block_leakage$sv_furniture

## Time to map!
## Write merged blocks geometries to shapefile
## Write merged purchasing power, sales volume, leakage attributes to csv

writeOGR(blocks_geom_all, ".", "blocks_geom_all", driver="ESRI Shapefile")
write.csv(block_leakage, "block_leakage.csv", row.names=FALSE)
