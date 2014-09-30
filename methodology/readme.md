# Neighborhood Data Gateway 
# Methodology "White Paper"

## Context

This Neighborhood Data Gateway methodology was developed in order to create strengths-based market data highlighting purchasing power and retail spending patterns for use in a wide variety of economic development and community revitalization initiatives.  In particular, this methodology describes how to calculate "retail leakage."  Leakage is a monetary measure of what occurs when the purchasing power of residents is not matched by products and services offered within a certain area (such as a neighborhood). This means that residents must leave the neighborhood in order to obtain those products and services, and business revenues are not captured within the neighborhood.  A positive amount of leakage means that residents are spending more than area restaurants are generating in sales revenue. This means that residents are spending their dollars on eating out outside the area or neighborhood. Negative leakage means that area restaurants are generating more in sales revenue than residents are spending. This means that restaurants are drawing in people from outside the area or neighborhood.

Rise staff were first exposed to the concept of “retail leakage” through our work with Social Compact on the St. Louis Neighborhood Market DrillDown report.  Since then, we have seen this general concept in retail studies and data products from a wide range of organizations, including LISC, ESRI Business Analyst Online, and University materials, such as those created by the University of Wisconsin-Extension Center for Community and Economic Development.

Retail leakage is a critical concept, because it helps situate underresourced neighborhoods from a position of strength.  For this reason, Rise refers to Neighborhood Data Gateway data as "strengths-based market data."  While community retail and grocery needs are important, it is equally important - and likely more convincing to a business owner - that underresourced neighborhoods often have large amounts of untapped purchasing power.  By focusing on the collective purchasing power of households in neighborhoods, and emphasizing that these households are forced to leave their neighborhoods to shop for basic needs elsewhere, retail leakage makes both a business case and a moral case for investing in underresourced areas.

## Methodology Process

In a nutshell, retail leakage is the difference between what residents of a neighborhood are estimated to spend in any given category and the sales volume of businesses within that neighborhood in that same category.  For example, if residents of a neighborhood are estimated to spend $20,000,000 annually on groceries, but the only grocery in the area is a small corner store grocery with annual sales of $1,000,000, there is a "grocery leakage" of $19,000,000.  That "leakage" theoretically represents money that residents of the neighborhood are spending on groceries outside the boundaries of their neighborhood.  

Note that trade areas matter - i.e., if the neighborhood in the example in the paragraph above is defined such that two major grocery chains are located just outside the neighborhood boundaries, then there will be a high amount of "grocery leakage" without an associated access issue or business opportunity.  Also note that it is impossible to tell where exactly any individual household is spending money.  In the example in the paragraph above, it is possible that **all** neighborhood residents actually do their grocery shopping outside the neighborhood, while residents from surrounding neighborhoods shop at the existing corner store.  In that situation, technically $20,000,000 of neighborhood resident purchasing power would be "leakage", and the neighborhood would simultaneously be "attracting" $1,000,000 of outside purchasing power.  However, those details about the flow of dollars between households and businesses cannot be known from the leakage analysis alone and would require additional survey data.

The following steps were performed to arrive at the leakage data for Census Tracts and neighborhoods/municipalities on Neighborhood Data Gateway.

* #### Calculate Purchasing Power by Census Block and NAICS Category

First, purchasing power for each Census Block is calculated for each of several standard NAICS categories.  Households at different income ranges are determined at Census Tract level via American Community Survey (ACS) data, and then those household income ranges are allocated to individual Census Blocks within the Tract based on the percentage of the Census Tract households living in the Census Block.  Then, Consumer Expenditure Survey data from the Bureau of Labor Statistics, which identifies the approximate amount of money spent in different NAICS categories by income range, is joined to Census Block data based on the household incomes to arrive at purchasing power.

Due to the problematically high margins of error in the ACS (discussed more later in this white paper), it arguably may not be appropriate to calculate purchasing power at the block level in this manner, as it requires estimating ACS income data for very small areas.  However, an important goal of the project was to be able to aggregate back up to non-Census geographies, and we did not see a better way to do so given the datasets available.

* #### Calculate Sales Volume of Existing Business by Census Block and NAICS Category

Existing businesses, with NAICS categories and estimated sales volume, were obtained, geocoded, and assigned to individual Census Blocks.

* #### Calculate Leakage by Census Block and NAICS Category

Once the purchasing power and sales volume by NAICS category are known for each block, calculating leakage is simple arithmatic. Leakage equals purchasing power minus sales volume.

* #### Aggregate Block Leakage to Census Tract or Neighborhood Level Leakage

Ultimately, we aren't interested in leakage at the Census Block level. Blocks are far too small to be expected to be reasonable market areas, and we also want to minimize the effect of any errors or inaccuracies in the data by looking at larger areas.  The reason we calculated leakage at the block level was in order to aggregate up to non-standard geographies, such as neighborhoods, walk sheds, drive time polygons, or any other geography.  To aggregate back up to a neighborhood, we simply sum the leakage numbers of all blocks whose centroids are contained by that neighborhood.

## Methodology Challenges

Through this process, Rise staff also learned what the “pain points” were for conducting an analysis of retail leakage - any of these three challenges are worth further research and study, as creative solutions or improvements would push data-driven community development work forward significantly.

* #### Reliable and Open Source for Business Data

By far, the greatest challenge to our analysis was finding a reliable and sustainable source for business data.  Ideally, this project required business data that was:

1. Complete enough for our analysis - i.e., that included the location of the business, a NAICS or SIC code categorizing the business type, and the approximate sales volume of the business
2. Available across the entire Rise service area (four counties in Missouri and Illinois)
3. Reasonably reliable and complete across the entire Rise service area
4. Affordable enough to allow for frequent updates and the long-term sustainability of Neighborhood Data Gateway
5. Released under an open license to allow for other entities to remix the data and conduct their own analysis

Unfortunately, we were unable to find or create business data that met the requirements above.  In fact, the only source thats we found that were complete enough for the necessary retail leakage analysis and available across a bi-state service area were proprietary data sources.  We ultimately used data from InfoUSA and ReferenceUSA, but because the data is not open, we were limited in how we used and displayed it for this project.

For organizations looking to work with business data, the list below may serve as a helpful starting point about what is potentially available **beyond paid sources such as InfoUSA/ReferenceUSA, Dun & Bradstreet, or ESRI**.

* Local business licenses
    Potential source for business location, type/category, and often the number of employees (which might aid in cross-checking sales volume).  Challenges include license data collected in different formats by different local governmental entities as well as non-standard business categories (i.e., not NAICS or SIC codes)
* Local commercial occupancy permits
    Potential source for business location and possibly type/category.  However, just like local  business license data, commercial occupancy permits are collected in different formats by different local governmental entities and therefore are a challenge to access/collect/standardize.
* Longitudinal Employer-Household Dynamics
    The Longitudinal Employer-Household Dynamics (LEHD) program is part of the Center for Economic Studies at the U.S. Census Bureau.  Under the LED Partnership, states agree to share Unemployment Insurance earnings data and the Quarterly Census of Employment and Wages (QCEW) data with the Census Bureau. The LEHD program combines these administrative data, additional administrative data and data from censuses and surveys. From these data, the program creates statistics on employment, earnings, and job flows at detailed levels of geography and industry and for different demographic groups.  The LEHD data does not show individual businesses or sales volume, but does show the number of jobs in different categories at very small geographies.
* State sales tax revenue
    Sales tax revenue is a promising potential source and could also serve a good cross-check against reported retail sales volume.  After speaking with multiple contacts in Missouri, however, it appears that sales tax revenue data is only available to the public at aggregated geographies such as ZIP code rather than at the individual business level.
* National Establishment Time-Series (NETS) database
    Although it is built using Dun & Bradstreet data, the NETS database is worth special mention because it is both reasonably priced and longitudinal in nature.  Walls & Associates converts Dun and Bradstreet (D&B) archival establishment data into a time-series database of establishment information, providing longitudinal data on various dynamics of the U.S. economy that include establishment job creation and destruction, sales growth performance, survivability of business startups, mobility patterns, changes in primary markets, corporate affiliations that highlight M&A, and historical D&B credit and payment ratings.
* Foursquare API or similar social check-in APIs
    Increasingly, apps such as Foursquare contain a wealth of business data collected when users "check in" to locations, and they offer an API to allow developers to access their data.  Unfortunately, in high poverty areas, fewer residents are likely to own smartphones that allow them to use Foursquare.  In addition, it is less likely that an individual will "check in" at mundane locations such as a corner store and more likely they will use the app when they are out with friends or family in social settings.  For these reasons, the Foursquare data is not currently sufficient for analyzing access to basic goods and services in underresourced neighborhoods.  However, in time, this may become a valid option.
* Cross-checking or merging multiple datasets from the options above
    Obviously, cross-checking datasets or merging datasets is an option to either attempt to increase accuracy or to include, say, sales volume from one dataset with NAICS codes from another dataset.

* #### Advanced Geocoding Tools

    Washington University in St. Louis created a Nominatim geocoder using OpenStreetMap data in order to combat the lack of reliable, open geocoders generally and in order to support the Neighborhood Data Gateway project.  In addition, a similar geocoder exists at www.datasciencetoolkit.org. However, geocoder tools are only as useful as the underlying reference data (street centerline address ranges or parcel/building address points).  Encouraging local governments to either publish geocoding APIs for their jurisdictions or to load accurate address point data into OpenStreetMap would help in creating better geocoding tools.  (In the case of Neighborhood Data Gateway, the Nominatim geocoder was used to geocode business locations, but improving free and open geocoding tools would benefit a wide range of projects.)

* #### Alternatives to the American Community Survey for Income Measures

    While the American Community Survey (ACS) is a critical data resource for community research, it is especially useful at larger geographies, such as Counties, where the sample size is large enough for the data to be updated annually and for the margins of error to be reasonable.  Unfortunately, at smaller geographies, such as tracts, the margins of error within the ACS become large enough that it is difficult to draw meaningful conclusions from the data.  This challenge is compounded when the ACS data is being used as one small piece of a larger analysis (therefore making it more difficult to disclose the margins of error) and when trying to calculate and report ACS measures (such as income ranges) at non-Census geographies (such as neighborhood boundaries) in order to make the data more relatable to community advocates and stakeholders.
	
	In the Neighborhood Data Gateway work, the ACS is used primariliy to gague household incomes.  Therefore, alternatives to the ACS for income measures would be useful.  Rise staff considered using Longitudinal Employer-Household Dynamics (LEHD) data, except the incomes reported in that dataset are employee incomes (rather than household incomes) and the "buckets" are too large to meaningfully align with Consumer Expenditure Survey data.  It is worth examining whether changes to how LEHD data is reported could aid researchers in understanding neighborhood incomes independently of ACS data.

## Tools Used

For organizations looking to implement some or all of the components of Neighborhood Data Gateway, the following tools may be helpful.  In addition, there are many other open source tools and technologies that can accomplish the same result.

* #### R

    For data analysis, Rise staff used R (and the RStudio IDE user interface).  R was a fast and effective way to collect datasets from various sources and in various formats (shapefile, csv, etc.) into one place, perform calculations, assign/aggregate to geographies, and ultimately export data to GeoJSON to use in Neighborhood Data Gateway.  In addition to basic statistical functionalities, R allows users to add "packages" that extend its capabilities.  In particular, the Neighborhood Data Gateway project used a variety of packages that added geographic analysis tools to R as well as an "acs" package that made accessing American Community Survey data easy.
	
* #### Leaflet/BootLeaf

    Leaflet is a modern open-source JavaScript library for mobile-friendly interactive maps. Leaflet is designed with simplicity, performance and usability in mind. It works efficiently across all major desktop and mobile platforms out of the box, taking advantage of HTML5 and CSS3 on modern browsers while still being accessible on older ones.  Essentially, Leaflet provides a way for us to display our GeoJSON data - created through the R analysis - in a web map format.
	
	In addition, during this process, Rise staff discovered an open source project called BootLeaf, that combined a Leaflet map with additional features from a variety of Leaflet plugins, Bootstrap, and typeahead.js such as a responsive navigation bar, client-side feature (in our case, neighborhoods and Census Tracts) search with autocomplete, a sidebar (in our case, an area for a legend) that could be hidden, and a grouped layer control.  Essentially, BootLeaf had customized Leaflet to include a lot of user-friendly features right "out of the box" that we chose to use for Neighborhood Data Gateway.

* #### Mapbox

    Most of the data in Neighborhood Data Gateway is displayed in the web map interface as GeoJSON vector data.  However, there is also a tiled base map showing streets, rivers, parks, and similar features to allow users to orient themselves.  Rise is using Mapbox to style and serve these base map tiles.
