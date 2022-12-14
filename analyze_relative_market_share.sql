/*
Queries in this page:
  1. Get a table of overview of relative market share
  2. Total market share of top 10 vendors in each category
  3. Calculate average relative market share of top 10 vendors for all categories
*/

/*
1. Get a table of overview of relative market share
*/

WITH fiscal_calendar
AS(
  SELECT
    DATE_SUB(date, INTERVAL 9 MONTH) AS fiscal_date,
    vendor_name,
    main_category,
    sale_dollars,
    state_bottle_retail
  FROM
    `iowa-liquor-sale.iowa_liquor_sale_cleaned.vendor_analysis`
),

--get record that retail price per bottle <= USD 100

objective01
AS(
  SELECT
    EXTRACT(YEAR FROM fiscal_date) AS year,
    IFNULL(vendor_name, 'OTHERS') AS vendor_name,
    main_category,
    sale_dollars
  FROM
    fiscal_calendar
  WHERE
    state_bottle_retail <= 100
    AND fiscal_date > '2011-12-31'
),

--Overall market share

overall_ms
AS(
SELECT
  main_category,
  vendor_name,
  SUM(sale_dollars) AS ttl_sales
FROM
  objective01
GROUP BY main_category, vendor_name
ORDER BY main_category, ttl_sales DESC
),

--NO.1 in market share in each category

leading_ms
AS(
  SELECT
    main_category,
    RANK() OVER(PARTITION BY main_category ORDER BY ttl_sales DESC) AS rank,
    vendor_name AS leading_rival,
    ttl_sales AS rivals_ms
  FROM
    overall_ms
  QUALIFY rank = 1
  ORDER BY main_category
),

--Jim Beam market share in each category

jb_ms
AS(
SELECT
  main_category,
  vendor_name,
  ttl_sales AS jb_ms
FROM
  overall_ms
WHERE
  vendor_name = 'JIM BEAM BRANDS'
ORDER BY main_category
)

--Get summary table

SELECT
  * EXCEPT(rank),
  ROUND(jb_ms/rivals_ms,2) AS relative_ms
FROM
  jb_ms a
  JOIN leading_ms b USING (main_category)
  JOIN `iowa-liquor-sale.iowa_liquor_sale_cleaned.overall_cagr_less_than_100` c USING (main_category)
ORDER BY main_category;

/*
2. Total market share of top 10 vendors in each category
*/

--fiscal calendar

WITH fiscal_calendar
AS(
  SELECT
    DATE_SUB(date, INTERVAL 9 MONTH) AS fiscal_date,
    vendor_name,
    main_category,
    sale_dollars,
    state_bottle_retail
  FROM
    `iowa-liquor-sale.iowa_liquor_sale_cleaned.vendor_analysis`
),

objective01
AS(
  SELECT
    EXTRACT(YEAR FROM fiscal_date) AS year,
    IFNULL(vendor_name, 'OTHERS') AS vendor_name,
    main_category,
    sale_dollars
  FROM
    fiscal_calendar
  WHERE
    state_bottle_retail <= 100
    AND fiscal_date > '2011-12-31'
),

--Overall market share

overall_ms
AS(
SELECT
  main_category,
  vendor_name,
  SUM(sale_dollars) AS ttl_sales
FROM
  objective01
GROUP BY main_category, vendor_name
ORDER BY main_category, ttl_sales DESC
),

cat_ttl_sale
AS(
  SELECT
    main_category,
    SUM(ttl_sales) AS cat_ttl
  FROM
    overall_ms
  GROUP BY main_category
),

top10_ranking
AS(
  SELECT
    main_category,
    vendor_name,
    ttl_sales,
    RANK() OVER(PARTITION BY main_category ORDER BY ttl_sales DESC) AS ranking
  FROM
    overall_ms
  QUALIFY ranking <= 10
),

top10_sum
AS(
  SELECT
    main_category,
    SUM(ttl_sales) AS top10_ttl
  FROM
    top10_ranking
  GROUP BY main_category)

SELECT
  a.main_category,
  a.cat_ttl AS category_total,
  b.top10_ttl AS top10_total,
  ROUND(b.top10_ttl/ a.cat_ttl, 2) AS top10_pct
FROM
  cat_ttl_sale a
  JOIN top10_sum b USING(main_category)
ORDER BY a.main_category;

/*
3. Calculate average relative market share of top 10 vendors for all categories
*/

/*
top 10 sales from Q3 2012 - Q3 2022
*/

--get record that retail price per bottle <= USD 100
WITH standard_all
AS(
  SELECT
    EXTRACT(YEAR FROM date) AS year,
    IFNULL(vendor_name, 'OTHERS') AS vendor_name,
    main_category,
    subcategory,
    item_description,
    sale_dollars
  FROM
    `iowa-liquor-sale.iowa_liquor_sale_cleaned.vendor_analysis`
  WHERE
    state_bottle_retail <= 100
    AND date > '2012-6-30'
),

--categorieze total sale by main category and vendors, meantime subtotal and grand total is presented
summarized_table AS(
  SELECT
    IFNULL(main_category, 'ALL CATEGORIES') AS category,
    IFNULL(vendor_name, 'TOTAL') AS vendor,
    SUM(sale_dollars) AS ttl_sales
  FROM
    standard_all
  GROUP BY main_category, vendor_name
  ORDER BY main_category, ttl_sales DESC
),

top10_ms
AS(
  SELECT
    category,
    vendor,
    RANK() OVER(PARTITION BY category ORDER BY ttl_sales DESC) AS rank,
    ttl_sales
  FROM
    summarized_table
  QUALIFY rank<= 10
  ORDER BY category
),

top10_rms
AS(
  SELECT
    category,
    vendor,
    ttl_sales,
    ROUND(ttl_sales/ FIRST_VALUE(ttl_sales) OVER(PARTITION BY category ORDER BY rank),2) AS rms
  FROM
    top10_ms
  ORDER BY rms DESC
)

SELECT
  AVG(rms) AS average_relative_market_share
FROM
  top10_rms
WHERE
  rms < 1;
