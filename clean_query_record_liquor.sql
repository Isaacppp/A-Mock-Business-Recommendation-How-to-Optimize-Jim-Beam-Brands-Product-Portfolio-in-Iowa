/*
- Dimension: Liquor
- Fields: category | category_name | item_number | item_description | pack | bottle_volume_ml | state_bottle_cost | state_bottle_retail
- Queries in this page:
  1. Deal with NULL values and inconsistent data in category_name
  2. Move category_name from small genre to main categories
*/

/*
1. Deal with NULL values and inconsistent data in category_name
*/

-- 25,040 missing values found in category_name

SELECT
  SUM(CASE WHEN category_name IS NULL THEN 1 ELSE 0 END)
FROM
  `bigquery-public-data.iowa_liquor_sales.sales`;
  
-- However as there are no NULL value in item_description, so, to deal with NULL value in category_name, try use the value item_description to categorize the item
-- Check if the missing category name are retrievable by values in item_description
-- Result: The query shows that some category_name are missing but they are retrievable by what's contained in item_description. Also it's found that same item can be assigned to different category_name,

SELECT
  DISTINCT category_name,
  item_description
FROM
  `bigquery-public-data.iowa_liquor_sales.sales`
WHERE
  item_description IN(
  SELECT
    DISTINCT item_description
  FROM
    `bigquery-public-data.iowa_liquor_sales.sales`
  WHERE
    category_name IS NULL)
ORDER BY
  item_description;

-- Populate missing values in category_name by existing category name in the dataset.
-- Assign "OTHERS" to those that the category cannot be identified from the information in the dataset

WITH c1
AS(
  SELECT
    category_name,
    item_description
  FROM
    `bigquery-public-data.iowa_liquor_sales.sales`
  WHERE
    item_description IN(
    SELECT
      DISTINCT item_description
    FROM
      `bigquery-public-data.iowa_liquor_sales.sales`
    WHERE
      category_name IS NULL)
  ORDER BY
    item_description),

c2
AS(
  SELECT
    category_name AS category_name_ori,
    item_description AS item_description,
    LAST_VALUE(category_name) 
      OVER(PARTITION BY item_description ORDER BY category_name 
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS category_name
  FROM
  c1)

SELECT
  category_name_ori,
  item_description,
  IFNULL(category_name,'OTHERS') AS category_name
FROM
  c2;

/*
2. Move category_name from small genre to main categories
*/
SELECT  
  DISTINCT category_name,
  CASE
    WHEN category_name LIKE '%WHISK%' THEN 'Whiskey'
    WHEN category_name LIKE '%SCOTCH%' THEN 'Whiskey'
    WHEN category_name LIKE '%BOURBON%' THEN 'Whiskey'
    WHEN category_name IN('IOWA DISTILLERIES') THEN 'Whiskey'
    WHEN category_name LIKE '%TEQUILA%' THEN 'Tequila'
    WHEN category_name IN('MEZCAL') THEN 'Tequila'
    WHEN category_name LIKE '%VODKA%' THEN 'Vodka'
    WHEN category_name LIKE '%GIN%' THEN 'Gin'
    WHEN category_name LIKE '%BRAND%' THEN 'Brandy'
    WHEN category_name LIKE '%RUM%' THEN 'Rum'
    WHEN category_name LIKE '%COCKTAIL%' THEN 'Cocktails/ RTD'
    WHEN category_name LIKE '%RTD%' THEN 'Cocktails/ RTD'
    WHEN category_name LIKE '%CORDIALS%' THEN 'Cordials/ Liqueurs'
    WHEN category_name LIKE '%LIQUEUR%' THEN 'Cordials/ Liqueurs'
    WHEN category_name LIKE '%SCHNAPP%' THEN 'Cordials/ Liqueurs'
    WHEN category_name IN('DARK CREME DE CACAO','AMERICAN ALCOHOL','TRIPLE SEC','CREME DE ALMOND','WHITE CREME DE MENTHE','GREEN CREME DE MENTHE','WHITE CREME DE CACAO','AMERICAN AMARETTO','NEUTRAL GRAIN SPIRITS FLAVORED','HOLIDAY VAP','AMARETTO - IMPORTED','IMPORTED AMARETTO','HIGH PROOF BEER - AMERICAN','ANISETTE','ROCK & RYE') THEN 'Cordials/ Liqueurs'
    WHEN category_name LIKE '%SPECIALTY%' THEN 'Specialty'
    WHEN category_name IN('NEUTRAL GRAIN SPIRITS','SPECIAL ORDER ITEMS','DELISTED ITEMS','DELISTED / SPECIAL ORDER ITEMS') THEN 'Specialty'
    END AS cleaned,
    COUNT(category_name) AS num

FROM `iowa-liquor-sale.iowa_liquor_sale.sales`
GROUP BY category_name
ORDER BY cleaned;
