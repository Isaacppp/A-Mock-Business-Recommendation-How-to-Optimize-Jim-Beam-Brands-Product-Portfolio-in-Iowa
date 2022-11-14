# How to Optimize Jim Beam Brands Product Portfolio in Iowa

## Introduction
  
  I used the dataset - "Iowa Liquor Sale" to build business recommendation to guide Jim Beam Brands how to optimize their product portfolio in Iowa.

## Business Recommendation

  For distribution channels of grocery, liquor and convenience stores, the business recommendation I have for them are:
  
  1. For Whiskey products:
      The company should maintain current amount of investment in this category and generate as much as profit as possible. And use the capital in other area such as diversification of their production line.
  
  2. For Tequila:
      The company should invest more in this category and try to get as much as market share before the category market growth slow down.
      
  3. For Brandy, Cocktails/ RTD, Cordials/ Liqueurs, Vodka, Rum and Gin:
      Unless there are some other strategic aim, the company should start to gradually divest from these markets and re-allocate the capital to other categories.
      
      Especially Rum and Gin, as they have the least growth rate (near 0%) since 2012.
  
## Table of Contents
  - [About the Dataset](#about-the-dataset)
  - [About My Work](#about-my-work)
  - [Limitation of This Analysis](#limitation-of-this-analysis)
  - [Data Cleaning](#data-cleaning)
  - [Data Analyzing](#data-analyzing)
  - [Key Takeaways](#key-takeaways)
  - [Business Recommendation](#business-recommendation)
  - [Next Step](#next-step)
  - [References](#reference)

## About the Dataset

  - This dataset contains the spirits purchase information of Iowa Class “E” liquor licensees by product and date of purchase from January 1, 2012 to current.

  - There are total 25.1 million rows with 24 columns, each row is an individual product purchase.

  - You can find it on Bigquery public dataset or access the same via the link:
  [https://data.iowa.gov/Sales-Distribution/Iowa-Liquor-Sales/m3tr-qhgy](https://data.iowa.gov/Sales-Distribution/Iowa-Liquor-Sales/m3tr-qhgy)


## About My Work
  
  - Data exploration, extraction, process and analyzing is done by Google Bigquery. As I used free version of Bigquery, you might find the data cleaning process unlike normal practice as the DML is not available in free version.

  - Visualization: Microsoft Power BI

## Limitation of This Analysis

  - This analysis is for the sale portfolio in Iowa area only.
  
  - As the dataset only contains spirits purchase information of Iowa Class “E” liquor licensees, this means the distribution channel only include: grocery, liquor and convenience store and their wholesale sales to on-premise class "A", "B", "C" and "D". Not including on-premise sales ("A", "B", "C" and "D"): members and guests of non-profit clubs, hotels and motels, taverns, bars, restaurants, trains, airplanes and watercrafts etc.

## Data Cleaning

#### 1. Data Cleaning Overview

- The dataset contain the sales record of liquor in Iowa from 2012-01-03 to 2022-09-30.
   **There were 24,842,520 records in the dataset, 24,847,481 (-4,961 rows) after cleaning**

- There are 24 fields in this dataset, as per the dimensions that the data is stored, I categorized them into below 4 categories:
  * Fact: [invoice_and_item_number], [date], [bottles_sold], [sale_dollars], [volume_sold_liters], [volume_sold_gallons]
  * Store: [store_number], [store_name], [address], [city], [zip_code], [store_location], [county_number], [county]
  * Liquor: [category], [category_name], [item_number], [item_description], [pack], [bottle_volume_ml], [state_bottle_cost], [state_bottle_retail]
  * Vendor: [vendor_number], [vendor_name]

- As the dimension "Store" is not in the scope to solve the business problem, to save time, I cleaned other fields for analysis.
  
#### 2. Details of Cleaning

[[Check Full Code Here]](https://github.com/Isaacppp/Optimize-Jim-Beam-Brands-Product-Portfolio-in-Iowa-Area/blob/main/data_cleaning_full_queries)

#### Fact

- [bottles_sold], [sale_dollars]

  * Checked the outliers
  * Turned negative values to positive
  * The record in “0” is not meaningful in the sale analysis case, thus, they are excluded from the analysis


#### Liquor

- [category_name], [item_description]

  * Cleaned for the consistency of every type, e.g. extra “s” or “.” etc and unify the naming of each type
  * 25,040 records were missing, retrieved the records by what are contained in item_description. Assign category as “Others” to those cannot be found in the end
  * Categories contain sub-genres that are trivial and difficult to comprehend
      → move [category_name] from small genre to main categories as categorized in Iowa ABD: WHISKEY, TEQUILA, VODKA, GIN, BRANDY, RUM, COCKTAILS/ RTD, CORDIALS/ LIQUEURS, SPECIALTY. Reference: [https://shop.iowaabd.com/](https://shop.iowaabd.com/)
    
    For those that are not categorized as above or not listed, assign to “OTHERS”
    
- [state_bottle_retail]
  * Checked the outliers
  * Contains 3847 records that show “0.0” dollar per bottle → excluded these record from table

[Check query record Here](https://github.com/Isaacppp/Optimize-Jim-Beam-Brands-Product-Portfolio-in-Iowa-Area/blob/main/query_record_liquor_cleaning)

##### Vendor

- [vendor_name]

  * Exclude NULL values (7 records with total 102 bottles missing)
  * Cleaned for the name consistency of every vendor name, e.g. extra “s” or “.” etc and unify the naming for each vendor. There were 549 distinct records (including NULL) to 427 distinct record (including NULL). **So there are total 425 vendors used in the analysis.**

[Check query record Here](https://github.com/Isaacppp/Optimize-Jim-Beam-Brands-Product-Portfolio-in-Iowa-Area/blob/main/query_record_vendor_cleaning)

## Data Analyzing

#### Overview

- The dataset is updated on 2022/11/02. The dataset contains the sales record of liquor in Iowa from 2012-01-03 to 2022-09-30
- Only [date], [bottles_sold], [sale_dollars], [category_name], [item_description], [state_bottle_retail], [vendor_number] are used in this analysis

#### 1. Who I help

In fact, at the beginning, the big ambigious question I asked in this project was "How to optimize the sale portfolio?"
There wasn't "the who" at the beginning. So, I took a look to see the ranking of vendors.

![Overall Market Share](https://user-images.githubusercontent.com/95849080/201589134-387fbc74-e8e8-4edb-beab-9358f8700984.jpg)

After going over the ranking, I want to go with the analysis to help Jim Beam Brands, 3rd largest vendors by market share.
Reason being: They have room to grow and I simply love this brand.

#### 2. Define the market where their products stand

As I picked Jim Beam Brands as client in this objective, defining the market for most of their products is my first priority
(an incorrectly defined market can lead to poor classification in liquor market)

- Here is my classification on liquor price:

    * USD ≤20
    * USD 21-50
    * USD 51-100
    * USD 101-200
    * USD 201-300
    * USD >300

- Here’s the price distribution of Jim Beam Brands Products:

![Price Distribution](https://user-images.githubusercontent.com/95849080/201589862-3e6bc764-6ad5-4ab8-8218-efe3e3d054c3.jpg)

As most of Jim Beam Brands products (98.43%) are less than and equal to USD 100.
Therefore, I will proceed the analysis with the market that the price per bottle is ≤ USD 100.

Plus, I want to see where Jim Beam Brands stands in each category, so I will be putting each category in a growth-share matrix. Therefore, I want to get “Market Growth” of each category and “Relative Market Share” next.

#### 3. Market Growth

As the max date in dataset that currently available is 2022-09-30 (end of Q3), to calculate the CAGR over the past 10 years, 
I will use 1st of October in every year as starting of fiscal year, e.g. fiscal year of 2012 is from 2012/10/01 to 2013/09/30.

- Overall CAGR of Iowa liquor market: **0.0555**
  * Note: this is for market that each bottle ≤ USD 100, from Q3 2012 to Q3 2022)
  * Note: This data point will be used as middle line to determine how the growth rate of each category performs

- CAGR of each category

![CAGR of each category](https://user-images.githubusercontent.com/95849080/201590530-50eb2781-62f4-4d43-b73b-9f7b913fccde.jpg)

[Code in this part of analysis](https://github.com/Isaacppp/Optimize-Jim-Beam-Brands-Product-Portfolio-in-Iowa-Area/blob/main/analyze_market_growth)

#### 4. Relative Market Share

- For a clear overview of relative market share that Jim Beam Brands stands in each category:

![Relative Market Share](https://user-images.githubusercontent.com/95849080/201593164-6dbac934-642b-411f-964e-1c622ff793ef.jpg)

- Get a data point to draw the middle line of the relative market share

Before getting the data point, I will examine the market share in each category to determine how to draw the middle line of relative market share in my growth-share matrix

![ms_controlled_by_top10](https://user-images.githubusercontent.com/95849080/201594139-bdd17daa-d497-4f05-a2e5-c82197e55d13.jpg)

As the top 10 market share holder in each category control the big majority liquor market in each category, I will use the average relative market share of top 10 vendors as the middle data point to draw the line.

- Average relative market share of top 10 vendors in each category

Note: as the leading rival’s relative market share is 1, so every leading rival’s relative market share is excluded (only 9 relative market share in top 10 in each category is used to count the average)

The average relative market share is: **0.208**

[Code in this part of analysis](https://github.com/Isaacppp/Optimize-Jim-Beam-Brands-Product-Portfolio-in-Iowa-Area/blob/main/analyze_relative_market_share)

#### 5. Draw the Growth-Share Matrix

Note: As category: “OTHERS” is not listed in specific market. And “SPECIALTY” mostly contains special packages that are not regular product. I won't dive into these 2 categories for the time being.

- Growth Share Matrix of Jim Beam Brand’s products

![growth_share matrix](https://user-images.githubusercontent.com/95849080/201596098-a5ee5cb3-50b8-42ba-bb09-f6b6d6d3ff39.jpg)

In order to to decide what the next step can be taken given the growth-share matrix currently available, I want to find out the growing momentum of each category.

#### 6. Calculate Growth Rate Momentum of each Category

Below chart shows CAGR over fiscal years (fiscal year starts from every Q4). For example, the data point on the fiscal year of 2012 (fiscal period: 2012/10/01-2013/09/30) shows the CAGR counted from 2012 to 2021, the data point on 2013 shows CAGR counted from 2013 to 2021, and the data point on 2020 shows CAGR counted from fiscal year 2020-2021.

It will tell the trend of growth rate momentum of each category.

![cagr_change_over_years](https://user-images.githubusercontent.com/95849080/201596626-fb9ee3af-42ad-4f27-a77e-d58bf3e8ff64.jpg)

From the chart it is observed that the growth rate are slowing down and even turned to negative in the fiscal year of 2019 (fiscal period: 2019/09/30-2020/09/30)

Other than Tequila, the growing momentum started to decline in other categories since or before fiscal year of 2019.

[Code in this part of analysis](https://github.com/Isaacppp/Optimize-Jim-Beam-Brands-Product-Portfolio-in-Iowa-Area/blob/main/analyze_growth_rate_momentum)

## Key Takeaways

1. The main market (in price) of Jim Beam Brands is below and equals to USD 100 per bottle with 98.43% in total.

2. The overall CAGR of Iowa liquor market from Q3 2012 to Q3 2022 (for market that each bottle ≤ USD 100) is 5.55%

3. Jim Beam Brands most competitive category by relative market share is “Whiskey” (64%), then “Tequila” (23%) follows.

4. Tequila is the most active market with CAGR of 11.67% over Q3 2012- Q3 2022 and meantime has the best momentum in growth rate compared to all other categories.

## Next Step

- Tequila: To grab more market share in Tequila market, I will investigate further to see which product(s) that the company can leverage. Meantime, the data of profitability of each product is required. (not available for the time being)  

- Rum and Gin: As these two markets have the least growth rate over the past 10 year, I prioritize these two to look into which product(s) that they can start to liquidate. Meantime, the data of profitability of each product is also required. (not available for the time being)

## References

- License classification: [https://abd.iowa.gov/licensing/license-classifications](https://abd.iowa.gov/licensing/license-classifications)
- Dataset: [https://data.iowa.gov/Sales-Distribution/Iowa-Liquor-Sales/m3tr-qhgy](https://data.iowa.gov/Sales-Distribution/Iowa-Liquor-Sales/m3tr-qhgy) and Google Bigquery
- Liquor categorization: [https://shop.iowaabd.com/](https://shop.iowaabd.com/)
