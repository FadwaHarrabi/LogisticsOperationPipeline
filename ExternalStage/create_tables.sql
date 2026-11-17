

-- ============ DIMENSION TABLES ============

CREATE OR REPLACE TABLE drivers (
  driver_id         VARCHAR PRIMARY KEY,
  first_name        VARCHAR,
  last_name         VARCHAR,
  hire_date         DATE,
  termination_date  DATE,
  license_number    VARCHAR,
  license_state     VARCHAR,
  date_of_birth     DATE,
  home_terminal     VARCHAR,
  employment_status VARCHAR,
  cdl_class         VARCHAR,
  years_experience  NUMBER
);

CREATE OR REPLACE TABLE trucks (
  truck_id             TEXT PRIMARY KEY,
  unit_number          STRING,
  make                 STRING,
  model                STRING,
  model_year           STRING,
  vin                  STRING,
  acquisition_date     DATE,
  acquisition_cost     STRING,
  fuel_type            STRING,
  tank_capacity_gallons STRING,
  status               STRING
);

CREATE OR REPLACE TABLE trailers (
  trailer_id           TEXT PRIMARY KEY,
  trailer_number       STRING,
  trailer_type         STRING,
  length_feet          INT,
  model_year           INT,
  vin                  STRING,
  acquisition_date     DATE,
  status               STRING,
  current_location     STRING
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
  capacity             STRING
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
  load_type STRING,
  weight_lbs           NUMBER(10,2),
  pieces               INT,
  revenue              NUMBER(12,2),
  fuel_surcharge       NUMBER(10,2),
  accessorial_charges  NUMBER(10,2),
  load_status          STRING,
  booking_type         STRING
);

CREATE OR REPLACE TABLE trips (
  trip_id              TEXT PRIMARY KEY,
  load_id              STRING REFERENCES loads(load_id),
  driver_id            STRING REFERENCES drivers(driver_id),
  truck_id             STRING REFERENCES trucks(truck_id),
  trailer_id           STRING REFERENCES trailers(trailer_id),
  dispatch_date        TIMESTAMP_NTZ,
  actual_distance_miles NUMBER(8,2),
  actual_duration_hours NUMBER(8,2),
  fuel_gallons_used    NUMBER(8,2),
  average_mpg          NUMBER(5,2),
  idle_time_hours  NUMBER(8,2),
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
  odometer_reading     INT,
  labor_hours NUMBER(8,2),
  labor_cost           NUMBER(10,2),
  parts_cost           NUMBER(10,2),
  total_cost           NUMBER(10,2),
  facility_location  STRING,
  downtime_hours       NUMBER(8,2),
  service_description  STRING
);

CREATE OR REPLACE TABLE delivery_events (
  event_id             TEXT PRIMARY KEY,
  load_id              STRING REFERENCES loads(load_id),
  trip_id              STRING REFERENCES trips(trip_id),
    event_type           STRING,          
  facility_id          STRING REFERENCES facilities(facility_id),
  scheduled_datetime   TIMESTAMP_NTZ,
  actual_datetime      TIMESTAMP_NTZ,
  detention_minutes    INT,
  on_time_flag         BOOLEAN,
  location_city         STRING,
  location_state        STRING
);

CREATE OR REPLACE TABLE safety_incidents (
  incident_id          TEXT PRIMARY KEY,
  trip_id              STRING REFERENCES trips(trip_id),
  truck_id             STRING REFERENCES trucks(truck_id),
  driver_id            STRING REFERENCES drivers(driver_id),
  incident_date        TIMESTAMP_NTZ,
  incident_type        STRING,
  location_city           STRING,
  location_state          STRING,
  at_fault_flag         BOOLEAN,
  injury_flag BOOLEAN,
  vehicle_damage_cost          NUMBER(12,2),
  cargo_damage_cost           NUMBER(12,2),
  claim_amount           NUMBER(12,2),
  preventable_flag     BOOLEAN,
  description          STRING
);

-- ============ AGGREGATED TABLES ============

CREATE OR REPLACE TABLE driver_monthly_metrics (
  driver_id            STRING REFERENCES drivers(driver_id),
  month                DATE,
  trips_completed          INT,
  total_miles          NUMBER(10,2),
  total_revenue        NUMBER(12,2),
  average_mpg          NUMBER(5,2),
  total_fuel_gallons NUMBER(8,2),
  on_time_delivery_rate NUMBER(8,4),   -- widened in case values are percentages
  average_idle_hours       NUMBER(8,4),
  PRIMARY KEY (driver_id, month)
);

CREATE OR REPLACE TABLE truck_utilization_metrics (
  truck_id             STRING REFERENCES trucks(truck_id),
  month                DATE,
  trips_completed          INT,
  total_miles          NUMBER(10,2),
  total_revenue        NUMBER(12,2),
  average_mpg          NUMBER(5,2),
  maintenance_event    NUMBER(10,2),
  maintenance_cost     NUMBER(10,2),
  downtime_hours       NUMBER(8,2),
  utilization_rate     NUMBER(8,4),    -- widened in case values are percentages
  PRIMARY KEY (truck_id, month)
);