-- DDL For My Tables

-- SHOW SCHEMAS IN DATABASE AIRBNB_DB;

--CREATE SCHEMA IF NOT EXISTS AIRBNB_DB.STAGING;

--USE SCHEMA AIRBNB_DB.STAGING;

--USE SCHEMA AIRBNB_DB.PUBLIC;

USE WAREHOUSE COMPUTE_WH;
USE DATABASE AIRBNB_DB;

CREATE SCHEMA IF NOT EXISTS STAGING;
USE SCHEMA STAGING;

CREATE OR REPLACE TABLE HOSTS (
    host_id NUMBER,
    host_name STRING,
    host_since DATE,
    is_superhost BOOLEAN,
    response_rate NUMBER,
    created_at TIMESTAMP,
    PRIMARY KEY (host_id)
);

CREATE OR REPLACE TABLE LISTINGS (
    listing_id NUMBER,
    host_id NUMBER,
    property_type STRING,
    room_type STRING,
    city STRING,
    country STRING,
    accommodates NUMBER,
    bedrooms NUMBER,
    bathrooms NUMBER,
    price_per_night NUMBER,
    created_at TIMESTAMP,
    PRIMARY KEY (listing_id)
);

CREATE OR REPLACE TABLE BOOKINGS (
    booking_id STRING,
    listing_id NUMBER,
    booking_date TIMESTAMP,
    nights_booked NUMBER,
    booking_amount NUMBER,
    cleaning_fee NUMBER,
    service_fee NUMBER,
    booking_status STRING,
    created_at TIMESTAMP,
    PRIMARY KEY (booking_id)
);
