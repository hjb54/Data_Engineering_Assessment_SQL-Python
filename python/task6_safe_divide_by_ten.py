"""
Purpose: Convert numeric strings to integers, divide by 10, and skip invalid entries.
Concepts: input validation, error-tolerant list processing, lightweight transformation logic
"""

def safe_divide_by_ten(raw_ids): 
  results = [] #initialize list for results 
  for id in raw_ids: #iterate through list 
    id = id.strip() #remove whitespace 
    if id.isdigit(): #check that id value is convertible to int 
      results.append(int(id)/10) #convert id value to int, divide by 10, append to results list 
    else: 
      continue #skip any id values that are not convertible 
  return results #return list of results
