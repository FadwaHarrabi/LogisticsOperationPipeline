USE DATABASE LOGISTICS_DB;
USE SCHEMA DBO;

-- Confirm the exact file names in the stage (should be xxx.csv.gz)
LIST @LOGISTICS_INTERNAL;

-- ============ FILE FORMAT ============
CREATE OR REPLACE FILE FORMAT csv_load_format
  TYPE = 'CSV'
  COMPRESSION = 'AUTO'
  PARSE_HEADER = TRUE
  FIELD_OPTIONALLY_ENCLOSED_BY = '"'
  NULL_IF = ('', 'NULL', 'null', 'NaN')
  EMPTY_FIELD_AS_NULL = TRUE
  ERROR_ON_COLUMN_COUNT_MISMATCH = FALSE
  DATE_FORMAT = 'AUTO'
  TIMESTAMP_FORMAT = 'AUTO'
  TRIM_SPACE = TRUE;

-- ============ LOAD: DIMENSIONS ============
COPY INTO drivers FROM @LOGISTICS_INTERNAL
  FILES = ('drivers.csv.gz')
  FILE_FORMAT = (FORMAT_NAME = 'csv_load_format')
  MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE;

COPY INTO trucks FROM @LOGISTICS_INTERNAL
  FILES = ('trucks.csv.gz')
  FILE_FORMAT = (FORMAT_NAME = 'csv_load_format')
  MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE;

COPY INTO trailers FROM @LOGISTICS_INTERNAL
  FILES = ('trailers.csv.gz')
  FILE_FORMAT = (FORMAT_NAME = 'csv_load_format')
  MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE;

COPY INTO customers FROM @LOGISTICS_INTERNAL
  FILES = ('customers.csv.gz')
  FILE_FORMAT = (FORMAT_NAME = 'csv_load_format')
  MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE;

COPY INTO facilities FROM @LOGISTICS_INTERNAL
  FILES = ('facilities.csv.gz')
  FILE_FORMAT = (FORMAT_NAME = 'csv_load_format')
  MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE;

COPY INTO routes FROM @LOGISTICS_INTERNAL
  FILES = ('routes.csv.gz')
  FILE_FORMAT = (FORMAT_NAME = 'csv_load_format')
  MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE;

-- ============ LOAD: TRANSACTIONS ============
COPY INTO loads FROM @LOGISTICS_INTERNAL
  FILES = ('loads.csv.gz')
  FILE_FORMAT = (FORMAT_NAME = 'csv_load_format')
  MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE;

COPY INTO trips FROM @LOGISTICS_INTERNAL
  FILES = ('trips.csv.gz')
  FILE_FORMAT = (FORMAT_NAME = 'csv_load_format')
  MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE;

COPY INTO fuel_purchases FROM @LOGISTICS_INTERNAL
  FILES = ('fuel_purchases.csv.gz')
  FILE_FORMAT = (FORMAT_NAME = 'csv_load_format')
  MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE;

COPY INTO maintenance_records FROM @LOGISTICS_INTERNAL
  FILES = ('maintenance_records.csv.gz')
  FILE_FORMAT = (FORMAT_NAME = 'csv_load_format')
  MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE;

COPY INTO delivery_events FROM @LOGISTICS_INTERNAL
  FILES = ('delivery_events.csv.gz')
  FILE_FORMAT = (FORMAT_NAME = 'csv_load_format')
  MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE;

COPY INTO safety_incidents FROM @LOGISTICS_INTERNAL
  FILES = ('safety_incidents.csv.gz')
  FILE_FORMAT = (FORMAT_NAME = 'csv_load_format')
  MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE;

-- ============ LOAD: AGGREGATES ============
COPY INTO driver_monthly_metrics FROM @LOGISTICS_INTERNAL
  FILES = ('driver_monthly_metrics.csv.gz')
  FILE_FORMAT = (FORMAT_NAME = 'csv_load_format')
  MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE;

COPY INTO truck_utilization_metrics FROM @LOGISTICS_INTERNAL
  FILES = ('truck_utilization_metrics.csv.gz')
  FILE_FORMAT = (FORMAT_NAME = 'csv_load_format')
  MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE;

