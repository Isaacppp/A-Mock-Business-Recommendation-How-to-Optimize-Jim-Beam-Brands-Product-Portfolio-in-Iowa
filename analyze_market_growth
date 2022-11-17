/*
Queries in this page:
  1. Calculate overall CAGR of from Q3 2012 to Q3 2022
  2. Calculate CAGR of each category
*/

/*
1. Calculate overall CAGR of from Q4 2012 to Q3 2022
*/

--Every 1st of Oct as starting date of fiscal year
WITH fiscal_calendar
AS(
  SELECT
    DATE_SUB(date, INTERVAL 9 MONTH) AS fiscal_date,
    sale_dollars,
    state_bottle_retail
  FROM
    `iowa-liquor-sale.iowa_liquor_sale_cleaned.vendor_analysis`
),

objective01
AS(
  SELECT
    EXTRACT(YEAR FROM fiscal_date) AS year,
    SUM(sale_dollars) AS f_annual_sale
  FROM
    fiscal_calendar
  WHERE
    state_bottle_retail <= 100
    AND fiscal_date > '2011-12-31'
  GROUP BY year
  ORDER BY year
)

SELECT
  DISTINCT(ROUND((POW(LAST_VALUE(f_annual_sale) OVER(ORDER BY year
    RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)/
    FIRST_VALUE(f_annual_sale) OVER(ORDER BY year
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING),(1/9)) -1), 4)) AS overall_cagr
FROM
  objective01;
  
/*
2. Calculate CAGR of each category
*/

WITH fiscal_calendar
AS(
  SELECT
    DATE_SUB(date, INTERVAL 9 MONTH) AS fiscal_date,
    main_category,
    sale_dollars,
    state_bottle_retail
  FROM
    `iowa-liquor-sale.iowa_liquor_sale_cleaned.vendor_analysis`
),

objective01
AS(
  SELECT
    EXTRACT(YEAR FROM fiscal_date) AS fiscal_year,
    main_category,
    SUM(sale_dollars) AS sale
  FROM
    fiscal_calendar
  WHERE
    state_bottle_retail <= 100
    AND fiscal_date > '2011-12-31'
  GROUP BY main_category, fiscal_year
  ORDER BY main_category, fiscal_year
)

SELECT
  DISTINCT main_category,
  ROUND((POW(LAST_VALUE(sale) OVER(PARTITION BY main_category ORDER BY fiscal_year
    RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)/
    FIRST_VALUE(sale) OVER(PARTITION BY main_category ORDER BY fiscal_year),(1/9)) -1), 4) AS cagr
FROM
  objective01;
