/*
Queries in this page:
  1. Calculate Growth Rate Momentum of each Category
*/

/*
1. Calculate Growth Rate Momentum of each Category
*/

--Every 1st of Oct as starting date of fiscal year
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
    EXTRACT(YEAR FROM fiscal_date) AS year,
    main_category,
    SUM(sale_dollars) AS f_annual_sale
  FROM
    fiscal_calendar
  WHERE
    state_bottle_retail <= 100
    AND fiscal_date > '2011-12-31'
  GROUP BY year, main_category
  ORDER BY year, main_category
),

c1
AS(
  SELECT
    year,
    main_category,
    f_annual_sale,
    RANK() OVER(PARTITION BY main_category ORDER BY year DESC) AS rank
  FROM
    objective01
  ORDER BY main_category, year
),

c2
AS(
  SELECT
    year,
    main_category,
    CAST(f_annual_sale AS INT64) AS f_annual_sale_int,
    rank,
    CAST(LAST_VALUE(f_annual_sale) OVER(PARTITION BY main_category ORDER BY year
      RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS INT64) AS f_annual_sale_2022_int
  FROM c1
)

SELECT
  2021 - year AS interval_in_years,
  main_category,
  f_annual_sale_int AS year_sale,
  f_annual_sale_2022_int AS year_sale_2022,
  ROUND(POW((f_annual_sale_2022_int/f_annual_sale_int),SAFE_DIVIDE(1,rank-1)) -1,4) AS cagr
FROM c2
ORDER BY main_category;
