# Load the RPostgreSQL library.
library(RPostgreSQL)

# Connect to the database.
drv <- dbDriver('PostgreSQL')
conn <- dbConnect(drv,
                  host = '192.168.48.128',
                  user = 'gpmon',
                  password = 'pivotal',
                  dbname = 'gpadmin')

cs_df <- read.csv('cs-training.csv')
cs_df <- cs_df[, 2:length(cs_df)]
colnames(cs_df) <- c('serious_dlq_in_2_yrs', 'revolving_util_unsecured_lines',
                     'age', 'num_time_30_59_days_past_due_not_worse',
                     'debt_ratio', 'monthly_income',
                     'num_open_credit_line_loans', 'num_time_90_days_late',
                     'num_real_estate_loan_lines',
                     'num_time_60_89_days_past_due_not_worse', 'num_dependents')

# Write credit_scores table from cs_df data frame
dbExecute(conn, 'DROP TABLE IF EXISTS credit_scores;')
dbWriteTable(conn, 'credit_scores', cs_df, row.names = F)
