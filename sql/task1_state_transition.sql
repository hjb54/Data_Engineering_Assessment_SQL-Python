-- Purpose: Identify when a device transitions directly from 'Error' to 'Normal'
-- Concepts: self-join, correlated subquery, timestamp ordering

SELECT current.device_id, current.status_timestamp -- what to return- returns only the 'normal' row with its timestamp 
FROM device_status_log AS current -- copy for current row, looking for current_status = 'Normal' 
JOIN device_status_log AS previous -- copy for previous, joins current and previous row, looking for current_status = 'Error' 
  ON current.device_id = previous.device_id -- current and previous rows are for same device 
  AND previous.status_timestamp = ( 
    SELECT MAX(og.status_timestamp) -- find most recent timestamp prior to current 
    FROM device_status_log AS og  
    WHERE og.device_id = current.device_id -- same device 
      AND og.status_timestamp < current.status_timestamp -- timestamp must be before the current timestamp 
) -- so far, have all device's pairs of timestamps with corresponding status. have to filter the joined rows. AND = both conditions must be true 
WHERE current.current_status = 'Normal' -- joined rows where current row's current_status is 'Normal' 
  AND previous.current_status = 'Error'; -- joined rows where previous row's current_status is 'Error'
