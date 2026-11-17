USE DATABASE LOGISTICS_DB;
USE SCHEMA DBO;

-- ============ DIMENSION TABLES ============

CREATE OR REPLACE TABLE drivers (
  driver_id            TEXT PRIMARY KEY,
  first_name           STRING,
  last_name            STRING,
  date_of_birth        DATE,
  hire_date            DATE,
  termination_date     DATE,
  employment_status    STRING,
  license_number       STRING,
  license_state        STRING,
  license_class        STRING,
  license_expiry_date  DATE,
  years_experience     NUMBER(4,1)
);

CREATE OR REPLACE TABLE trucks (
  truck_id             TEXT PRIMARY KEY,
  unit_number          STRING,
  make                 STRING,
  model                STRING,
  model_year           INT,
  vin                  STRING,
  acquisition_date     DATE,
  acquisition_cost     NUMBER(12,2),
  fuel_type            STRING,
  tank_capacity_gallons NUMBER(6,2),
  status               STRING
);

CREATE OR REPLACE TABLE trailers (
  trailer_id           TEXT PRIMARY KEY,
  trailer_number       STRING,
  trailer_type         STRING,
  length_feet          INT,
  model_year           INT,
  acquisition_date     DATE,
  status               STRING
);

CREATE OR REPLACE TABLE customers (
  customer_id          TEXT PRIMARY KEY,
  customer_name        STRING,
  contract_type        STRING,
  account_status       STRING,
  city                 STRING,
  state                STRING,
  onboarding_date      DATE,
  annual_revenue_potential NUMBER(14,2)
);

CREATE OR REPLACE TABLE facilities (
  facility_id          TEXT PRIMARY KEY,
  facility_name        STRING,
  facility_type        STRING,
  city                 STRING,
  state                STRING,
  latitude             NUMBER(9,6),
  longitude            NUMBER(9,6),
  dock_doors           INT,
  capacity             INT
);

CREATE OR REPLACE TABLE routes (
  route_id             TEXT PRIMARY KEY,
  origin_city          STRING,
  origin_state         STRING,
  destination_city     STRING,
  destination_state    STRING,
  distance_miles       NUMBER(8,2),
  typical_transit_days NUMBER(4,1),
  base_rate_per_mile   NUMBER(8,2),
  fuel_surcharge_rate  NUMBER(6,4)
);

-- ============ TRANSACTION TABLES ============

CREATE OR REPLACE TABLE loads (
  load_id              TEXT PRIMARY KEY,
  customer_id          STRING REFERENCES customers(customer_id),
  route_id             STRING REFERENCES routes(route_id),
  load_date            DATE,
  booking_type         STRING,
  commodity            STRING,
  weight_lbs           NUMBER(10,2),
  revenue              NUMBER(12,2),
  fuel_surcharge       NUMBER(10,2),
  accessorial_charges  NUMBER(10,2),
  load_status          STRING
);

CREATE OR REPLACE TABLE trips (
  trip_id              TEXT PRIMARY KEY,
  load_id              STRING REFERENCES loads(load_id),
  driver_id            STRING REFERENCES drivers(driver_id),
  truck_id             STRING REFERENCES trucks(truck_id),
  trailer_id           STRING REFERENCES trailers(trailer_id),
  dispatch_date        TIMESTAMP_NTZ,
  start_time           TIMESTAMP_NTZ,
  end_time             TIMESTAMP_NTZ,
  actual_distance_miles NUMBER(8,2),
  actual_duration_hours NUMBER(8,2),
  fuel_gallons_used    NUMBER(8,2),
  average_mpg          NUMBER(5,2),
  trip_status          STRING
);

CREATE OR REPLACE TABLE fuel_purchases (
  fuel_purchase_id     TEXT PRIMARY KEY,
  trip_id              STRING REFERENCES trips(trip_id),
  truck_id             STRING REFERENCES trucks(truck_id),
  driver_id            STRING REFERENCES drivers(driver_id),
  purchase_date        TIMESTAMP_NTZ,
  location_city        STRING,
  location_state       STRING,
  gallons              NUMBER(8,2),
  price_per_gallon     NUMBER(6,3),
  total_cost           NUMBER(10,2),
  fuel_card_number     STRING
);

CREATE OR REPLACE TABLE maintenance_records (
  maintenance_id       TEXT PRIMARY KEY,
  truck_id             STRING REFERENCES trucks(truck_id),
  maintenance_date     DATE,
  maintenance_type     STRING,
  description          STRING,
  odometer_reading     INT,
  labor_cost           NUMBER(10,2),
  parts_cost           NUMBER(10,2),
  total_cost           NUMBER(10,2),
  downtime_hours       NUMBER(8,2),
  vendor               STRING
);

CREATE OR REPLACE TABLE delivery_events (
  event_id             TEXT PRIMARY KEY,
  load_id              STRING REFERENCES loads(load_id),
  trip_id              STRING REFERENCES trips(trip_id),
  facility_id          STRING REFERENCES facilities(facility_id),
  event_type           STRING,          -- Pickup / Delivery
  scheduled_datetime   TIMESTAMP_NTZ,
  actual_datetime      TIMESTAMP_NTZ,
  detention_minutes    INT,
  on_time_flag         BOOLEAN
);

CREATE OR REPLACE TABLE safety_incidents (
  incident_id          TEXT PRIMARY KEY,
  trip_id              STRING REFERENCES trips(trip_id),
  truck_id             STRING REFERENCES trucks(truck_id),
  driver_id            STRING REFERENCES drivers(driver_id),
  incident_date        TIMESTAMP_NTZ,
  incident_type        STRING,
  severity             STRING,
  preventable_flag     BOOLEAN,
  damage_cost          NUMBER(12,2),
  description          STRING
);

-- ============ AGGREGATED TABLES ============

CREATE OR REPLACE TABLE driver_monthly_metrics (
  driver_id            STRING REFERENCES drivers(driver_id),
  month                DATE,
  total_trips          INT,
  total_miles          NUMBER(10,2),
  total_revenue        NUMBER(12,2),
  average_mpg          NUMBER(5,2),
  on_time_delivery_rate NUMBER(8,4),   -- widened in case values are percentages
  incident_count       INT,
  PRIMARY KEY (driver_id, month)
);

CREATE OR REPLACE TABLE truck_utilization_metrics (
  truck_id             STRING REFERENCES trucks(truck_id),
  month                DATE,
  total_miles          NUMBER(10,2),
  total_trips          INT,
  total_revenue        NUMBER(12,2),
  maintenance_cost     NUMBER(10,2),
  downtime_hours       NUMBER(8,2),
  utilization_rate     NUMBER(8,4),    -- widened in case values are percentages
  PRIMARY KEY (truck_id, month)
);