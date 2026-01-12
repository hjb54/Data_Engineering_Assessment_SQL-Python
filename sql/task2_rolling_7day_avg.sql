-- Purpose: Calculate a 7-day running average of prices excluding values > $100
-- Concepts: window functions, RANGE-based date windowing, conditional aggregation

SELECT product_id, date, price,  
  AVG(CASE WHEN price <= 100 THEN price END) OVER ( -- only prices under $100 are included in avg 
    PARTITION BY product_id -- split up by product_id to do individual calculations for dif products 
    ORDER BY date ASC -- date moves forward in time, makes sure the PRECEDING has the right time window 
    RANGE BETWEEN INTERVAL '6' DAY PRECEDING AND CURRENT ROW -- goes by date, starts at current day, goes to # days prior, includes all data between those dates.  
  ) AS running_7days_avg -- final output will have columns: product_id, date, price, and running_7days_avg 
  FROM daily_prices -- data source
