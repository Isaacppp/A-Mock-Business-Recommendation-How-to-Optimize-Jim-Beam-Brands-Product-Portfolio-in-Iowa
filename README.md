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

#### Data Cleaning Overview

  1. The dataset contain the sales record of liquor in Iowa from 2012-01-03 to 2022-09-30
**There were 24,842,520 records in the dataset, 24,847,481 (-4,961 rows) after cleaning**

  2. Fields cleaned or used to clean data:
    [category_name], [item_description], [vendor_name], [state_bottle_retail], [bottles_sold], [sale_dollars]
  
  3. Details of cleaning:

[category_name]
    
- Cleaned for the consistency of every type, e.g. extra “s” or “.” etc and unify the naming of each type
    
- 25,040 records were missing, retrieved the records by what are contained in item_description. Assign category as “Others” to those cannot be found in the end

- Moved category_name from sub-category to their main categories. e.g. Corn Whiskey to Whiskey, Gold Rum to Rum, Tropical Fruit Schnapps to Cordials/ Liqueurs etc.
        For those not listed and cannot be categorized assign to category - "Others"
    
    


