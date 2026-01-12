"""
Purpose: Yield only transactions occurring in the current year using a generator.
Concepts: streaming data processing, datetime parsing, safe line-by-line ETL
"""

import datetime 
def filter_current_year_transactions(transaction_lines): 
  current_year = datetime.now().year #get current year as int 
  for line in transaction_lines: 
    id, amount, date = line.strip().split(',') #split by comma, remove whitespace, assign strs to corresponding variable 
    transaction_year = int(date[:4]) #stores the transaction year by pulling index 0-3 of YYYY-MM-DD. as int for easy comparison 
    if transaction_year == current_year: 
      yield { # yield dictionary for each transaction 
        'id': id, 
        'amount': float(amount), #example output is a float 
        'date': date 
      }
