# How to Optimize Jim Beam Brands Product Portfolio in Iowa

## Introduction
  
  I used the dataset - "Iowa Liquor Sale" to build business recommendation to guide Jim Beam Brands how to optimize their product portfolio in Iowa.

## Solutions

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

#### 1. Overview

- The dataset is updated on 2022/11/02. The dataset contains the sales record of liquor in Iowa from 2012-01-03 to 2022-09-30
- Only [date], [bottles_sold], [sale_dollars], [category_name], [item_description], [state_bottle_retail], [vendor_number] are used in this analysis

#### 2. Who I help

In fact, at the beginning, the big ambigious question I asked in this project was "How to optimize the sale portfolio?"
There wasn't "the who" at the beginning. So, I took a look to see the ranking of vendors.

https://user-images.githubusercontent.com/95849080/201589134-387fbc74-e8e8-4edb-beab-9358f8700984.jpg




