COPY INTO drivers
FROM @logistics_stage
FILES = ('drivers.csv')
FILE_FORMAT = (FORMAT_NAME = 'dms_csv_ff');

COPY INTO trucks
FROM @logistics_stage
FILES = ('trucks.csv')
FILE_FORMAT = (FORMAT_NAME = 'dms_csv_ff')

COPY INTO trailers
FROM @logistics_stage
FILES = ('trailers.csv')
FILE_FORMAT = (FORMAT_NAME = 'dms_csv_ff')


COPY INTO customers
FROM @logistics_stage
FILES = ('customers.csv')
FILE_FORMAT = (FORMAT_NAME = 'dms_csv_ff')


COPY INTO facilities
FROM @logistics_stage
FILES = ('facilities.csv')
FILE_FORMAT = (FORMAT_NAME = 'dms_csv_ff')

COPY INTO routes
FROM @logistics_stage
FILES = ('routes.csv')
FILE_FORMAT = (FORMAT_NAME = 'dms_csv_ff')


COPY INTO loads
FROM @logistics_stage
FILES = ('loads.csv')
FILE_FORMAT = (FORMAT_NAME = 'dms_csv_ff')

COPY INTO trips
FROM @logistics_stage
FILES=('trips.csv')
FILE_FORMAT=(FORMAT_NAME='dms_csv_ff')


COPY INTO fuel_purchases
FROM @logistics_stage
FILES=('fuel_purchases.csv')
FILE_FORMAT=(FORMAT_NAME='dms_csv_ff')

COPY INTO maintenance_records
FROM @logistics_stage
FILES=('maintenance_records.csv')
FILE_FORMAT=(FORMAT_NAME='dms_csv_ff')

COPY INTO delivery_events
FROM @logistics_stage
FILES=('delivery_events.csv')
FILE_FORMAT=(FORMAT_NAME='dms_csv_ff')

COPY INTO safety_incidents
FROM @logistics_stage
FILES=('safety_incidents.csv')
FILE_FORMAT=(FORMAT_NAME='dms_csv_ff')

COPY INTO driver_monthly_metrics
FROM @logistics_stage
FILES=('driver_monthly_metrics.csv')
FILE_FORMAT=(FORMAT_NAME='dms_csv_ff')

COPY INTO truck_utilization_metrics
FROM @logistics_stage
FILES=('truck_utilization_metrics.csv')
FILE_FORMAT=(FORMAT_NAME='dms_csv_ff')