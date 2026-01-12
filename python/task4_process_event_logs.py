"""
Purpose: Validate event logs and return only entries with a timestamp and non-empty event_type.
Concepts: defensive programming, nested dictionary validation, ETL preprocessing
"""

def process_event_logs(log_list): 
  valid = [] #initialize the list for validated logs 
  for log in log_list: #for loop that parses through the logs 
    if 'timestamp' in log and 'data' in log: 
      d = log['data'] #stores the data subdictionary for validation 
      if 'event_type' in d and len(d['event_type'].strip()) != 0: #check that 'event_type' exists and subdict contains a non-empty string. strip removes any whitespace that would falsely validate. ex. ' ' 
        valid.append(d) #appends the subdictionary to validated logs list 
      else: 
        continue #skip over any logs that do not contain 'event_type' or where 'event_type' stores a empty str 
    else: 
      continue #skip over any logs that do not contain 'timestamp' or 'data' 
  return valid #returns the list of validated logs 'data' subdictionaries
