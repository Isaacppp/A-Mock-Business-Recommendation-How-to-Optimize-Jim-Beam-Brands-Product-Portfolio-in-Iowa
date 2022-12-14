/*
- Dimension: Vendor
- Fields: vendor_number | vendor_name
- Queries in this page:
  1. Clean inconsistent data in vendor_name
*/

/*
1. Clean inconsistent data in vendor_name
*/

WITH cte
AS(
  SELECT
    CASE
      WHEN vendor_name LIKE '%3 BADGE%' THEN '3 BADGE CORPORATION'
      WHEN vendor_name LIKE '%PATRON SPIRITS COMPANY%' THEN 'PATRON SPIRITS COMPANY'
      WHEN vendor_name LIKE '%PRESTIGE WINE & SPIRITS GROUP%' THEN 'PRESTIGE WINE & SPIRITS GROUP / UNITED STATES DISTILLED PRODUCTS CO'
      WHEN vendor_name LIKE '%AHA TORO%' THEN 'AHA TORO SPIRITS INC / AHA YETO TEQUILA'
      WHEN vendor_name LIKE '%A HARDY%' THEN 'A HARDY USA LTD'
      WHEN vendor_name LIKE '%AMERICAN HERITAGE DISTILLERS%' THEN 'AMERICAN HERITAGE DISTILLERS, LLC / CENTURY FARMS DISTILLERY'
      WHEN vendor_name LIKE '%ANCHOR DISTILLING%' THEN 'ANCHOR DISTILLING'
      WHEN vendor_name LIKE '%BACARDI%' THEN 'BACARDI USA INC'
      WHEN vendor_name LIKE '%BAD BEAR%' THEN 'BAD BEAR ENTERPRISES LLC / LEGENDARY RYE'
      WHEN vendor_name LIKE '%BRECKENRIDGE%' THEN 'BRECKENRIDGE DISTILLERY / DOUBLE DIAMOND DISTILLERY LLC'
      WHEN vendor_name LIKE '%FORMAN%' THEN 'BROWN FORMAN CORP.'
      WHEN vendor_name LIKE '%CAMPARI%' THEN 'CAMPARI AMERICA'
      WHEN vendor_name LIKE '%CARRIAGE HOUSE%' THEN 'CARRIAGE HOUSE IMPORTS, LTD.'
      WHEN vendor_name LIKE '%CEDAR RIDGE VINEYARDS%' THEN 'CEDAR RIDGE VINEYARDS, LLC'
      WHEN vendor_name LIKE '%CH DISTILLERY%' THEN 'CH DISTILLERY / 773 LLC'
      WHEN vendor_name LIKE '%CHARLES JACQUIN%' THEN 'CHARLES JACQUIN ET CIE'
      WHEN vendor_name LIKE '%CHATHAM IMPORTS%' THEN 'CHATHAM IMPORTS INC'
      WHEN vendor_name LIKE '%CONSTELLATION%' THEN 'CONSTELLATION BRANDS INC'
      WHEN vendor_name = 'COOPERSPIRITSINTERNATIONAL' THEN 'COOPER SPIRITS INTERNATIONAL'
      WHEN vendor_name LIKE '%CVI BRANDS%' THEN 'CVI BRANDS / CALIFORNIA VINEYARDS INC'
      WHEN vendor_name LIKE '%DISARONNO INTERNATIONAL%' THEN 'DISARONNO INTERNATIONAL LLC'
      WHEN vendor_name LIKE '%DOMAINE SELECT%' THEN 'DOMAINE SELECT'
      WHEN vendor_name LIKE '%DREYFUS%' THEN 'DREYFUS, ASHBY CO.'
      WHEN vendor_name LIKE '%DUGGAN%' THEN 'DUGGANS DISTILLERS'
      WHEN vendor_name LIKE '%DUNKEL CORPORATION%' THEN 'DUNKEL CORPORATION / IOWA DISTILLING'
      WHEN vendor_name LIKE '%FIFTH GENERATION%' THEN 'FIFTH GENERATION INC'
      WHEN vendor_name LIKE '%FRANK LIN DISTILLERS PRO%' THEN 'FRANK-LIN DISTILLERS PRODUCTS LTD.'
      WHEN vendor_name LIKE '%GEORGETOWN TRADING%' THEN 'GEORGETOWN TRADING CO. LLC / JAMES PEPPER DISTILLING CO.'
      WHEN vendor_name LIKE '%GOAMERICAGO%' THEN 'GOAMERICAGO BEVERAGES LLC / WHISTLEPIG'
      WHEN vendor_name LIKE '%GUNSANDMORE%' THEN 'GUNSANDMORE INFO LLC'
      WHEN vendor_name LIKE '%HIGH WEST DISTILLERY%' THEN 'HIGH WEST DISTILLERY, LLC'
      WHEN vendor_name LIKE '%HILLROCK%' THEN 'HILLROCK ESTATE DISTILLERY LLC'
      WHEN vendor_name LIKE '%HOOD RIVER DISTILLERS%' THEN 'HOOD RIVER DISTILLERS, INC.'
      WHEN vendor_name LIKE '%IMPERIAL BRANDS%' THEN 'IMPERIAL BRANDS, INC.'
      WHEN vendor_name LIKE '%IMPEX%' THEN 'IMPEX BEVERAGES INC.'
      WHEN vendor_name LIKE '%JEM BEVERAGE COMPANY%' THEN 'JEM BEVERAGE COMPANY / WESTERN SON'
      WHEN vendor_name LIKE '%JINRO AMERICA%' THEN 'JINRO AMERICA, INC'
      WHEN vendor_name LIKE '%KINDRED SPIRIT%' THEN 'KINDRED SPIRITS OF NORTH AMERICA'
      WHEN vendor_name LIKE '%KINGS COUNTRY DISTILLERY%' THEN 'KINGS COUNTY DISTILLERY'
      WHEN vendor_name LIKE '%KLIN SPIRITS%' THEN 'KLIN SPIRITS, LLC'
      WHEN vendor_name LIKE '%KOBRAND%' THEN 'KOBRAND CORPORATION'
      WHEN vendor_name LIKE '%LAIRD%' THEN 'LAIRD & COMPANY'
      WHEN vendor_name LIKE '%LEVECKE%' THEN 'LEVECKE CORPORATION'
      WHEN vendor_name LIKE '%LUXCO%' THEN 'LUXCO INC'
      WHEN vendor_name LIKE '%MADIKWE%' THEN 'MADIKWE USA INC'
      WHEN vendor_name LIKE '%MANGO BOTTLING%' THEN 'MANGO BOTTLING, INC.'
      WHEN vendor_name LIKE '%MARSALLE%' THEN 'MARSALLE COMPANY'
      WHEN vendor_name LIKE '%STOLLER%' THEN 'MARSALLE COMPANY'
      WHEN vendor_name LIKE '%STOLLLER%' THEN 'MARSALLE COMPANY'
      WHEN vendor_name LIKE '%JAEGERMEISTER%' THEN 'MAST-JAGERMEISTER US, INC'
      WHEN vendor_name LIKE '%MAVERICK%' THEN 'MAVERICK SPIRIT LLC / OREGON SPIRIT DISTILLERS'
      WHEN vendor_name LIKE '%MCCORMICK%' THEN 'MCCORMICK DISTILLING CO.'
      WHEN vendor_name LIKE '%MISSISSIPPI%' THEN 'MISSISSIPPI RIVER DISTILLING CO.'
      WHEN vendor_name LIKE '%MODERN SPIRIT%' THEN 'MODERN SPIRIT LLC / GREENBAR DISTILLERY'
      WHEN vendor_name LIKE '%MOET%' THEN 'MOET HENNESSY USA, INC.'
      WHEN vendor_name LIKE '%MPL BRANDS%' THEN 'MPL BRANDS NV INC/ PATCO BRANDS'
      WHEN vendor_name LIKE '%NICHE IMPORT%' THEN 'NICHE IMPORT CO.'
      WHEN vendor_name LIKE '%NORTH SHORE DISTILLERY%' THEN 'NORTH SHORE DISTILLERY, LLC.'
      WHEN vendor_name LIKE '%OLE SMOKY DISTILLERY%' THEN 'OLE SMOKY DISTILLERY, LLC.'
      WHEN vendor_name LIKE '%PACIFIC EDGE WINE%' THEN 'PACIFIC EDGE WINE & SPIRITS'
      WHEN vendor_name LIKE '%PALM BAY%' THEN 'PALM BAY INTERNATIONAL'
      WHEN vendor_name LIKE '%PARK STREET%' THEN 'PARK STREET IMPORTS'
      WHEN vendor_name LIKE '%PATERNO%' THEN 'PATERNO IMPORTS LTD'
      WHEN vendor_name LIKE '%PATRIARCH%' THEN 'PATRIARCH DISTILLERS LLC / SOLDIER VALLEY SPIRITS'
      WHEN vendor_name LIKE '%PERNOD RICARD%' THEN 'PERNOD RICARD USA'
      WHEN vendor_name LIKE '%PHILLIPS BEVERAGE%' THEN 'PHILLIPS BEVERAGE COMPANY'
      WHEN vendor_name LIKE '%PIEDMONT DISTILLERS%' THEN 'PIEDMONT DISTILLERS INC'
      WHEN vendor_name LIKE '%PRESTIGE WINE%' THEN 'PRESTIGE WINE & SPIRITS GROUP / UNITED STATES DISTILLED PRODUCTS CO'
      WHEN vendor_name LIKE '%PURPLE VALLEY%' THEN 'PURPLE VALLEY IMPORTS / GLASS REVOLUTION IMPORTS'
      WHEN vendor_name LIKE '%COINTREAU%' THEN 'REMY COINTREAU USA INC'
      WHEN vendor_name LIKE '%RUSSIAN STANDARD VODKA%' THEN 'RUSSIAN STANDARD VODKA'
      WHEN vendor_name LIKE '%S&B FARM%' THEN 'S&B FARMS DISTILLERY'
      WHEN vendor_name LIKE '%SANTA FE%' THEN 'SANTA FE DISTILLERY, LLC'
      WHEN vendor_name LIKE '%SAZERAC%' THEN 'SAZERAC COMPANY INC'
      WHEN vendor_name LIKE '%SHAW%' THEN 'SHAW-ROSS INTERNATIONAL'
      WHEN vendor_name LIKE '%SIDNEY FRANK%' THEN 'SIDNEY FRANK IMPORTING COMPANY, INC.'
      WHEN vendor_name LIKE '%SOVEREIGN BRANDS%' THEN 'SOVEREIGN BRANDS, LLC'
      WHEN vendor_name LIKE '%SPIRIT IMPORTS%' THEN 'SPIRIT IMPORTS, INC.'
      WHEN vendor_name LIKE '%SPEAKEASY SPIRITS%' THEN 'SPEAKEASY SPIRITS, LLC.'
      WHEN vendor_name LIKE '%GEORGE SPIRIT%' THEN 'ST GEORGE SPIRITS INC'
      WHEN vendor_name LIKE '%MICHELLE WINE ESTATES%' THEN 'STE. MICHELLE WINE ESTATES'
      WHEN vendor_name LIKE '%SUTTER HOME WINERY%' THEN 'SUTTER HOME WINERY INC / TRINCHERO FAMILY ESTATES'
      WHEN vendor_name LIKE '%TOPA SPIRITS%' THEN 'TOPA SPIRITS, LLC'
      WHEN vendor_name LIKE '%TRAVERSE CITY WHISKEY%' THEN 'TRAVERSE CITY WHISKEY CO / TCWC, LLC'
      WHEN vendor_name LIKE '%TY KU%' THEN 'TY KU, LLC'
      WHEN vendor_name LIKE '%VIN DIVINO LTD%' THEN 'VIN DIVINO LTD / GONZALEZ BYASS USA'
      WHEN vendor_name = 'VINO.COM DBA TOTAL BEVERAGE SOLUTION' THEN 'VINO COM LLC'
      WHEN vendor_name LIKE '%VISION WINE%' THEN 'VISION WINE & SPIRIT LLC'
      WHEN vendor_name LIKE '%DEUTSCH%' THEN 'W. J. DEUTSCH AND SONS, LTD.'
      WHEN vendor_name LIKE '%WERNER DISTILLING%' THEN 'WERNER DISTILLING, LLC'
      WHEN vendor_name LIKE '%WESTERN SPIRITS BEVERAGE%' THEN 'WESTERN SPIRITS BEVERAGE CO. LLC'
      WHEN vendor_name LIKE '%WHISTLEPIG%' THEN 'WHISTLEPIG LLC'
      WHEN vendor_name LIKE '%WILLIAM GRANT%' THEN 'WILLIAM GRANT AND SONS, INC.'
      WHEN vendor_name LIKE '%WILSON DANIELS LTD%' THEN 'WILSON DANIELS LTD.'
      WHEN vendor_name LIKE '%WINEBOW%' THEN 'WINEBOW, INC.'
      WHEN vendor_name LIKE '%WOODY CREEK DISTILLERS%' THEN 'WOODY CREEK DISTILLERS LLC'
      WHEN vendor_name LIKE '%YAHARA BAY DISTILLERS%' THEN 'YAHARA BAY DISTILLERS, INC'
      ELSE vendor_name END AS vendor_name_cleaned
      
  FROM
    `iowa-liquor-sale.iowa_liquor_sale.sales`

  ORDER BY vendor_name_cleaned)

SELECT
  DISTINCT vendor_name_cleaned
FROM cte
ORDER BY
  vendor_name_cleaned;
