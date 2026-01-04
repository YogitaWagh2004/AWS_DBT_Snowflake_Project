CREATE FILE FORMAT IF NOT EXISTS csv_format
  TYPE = 'CSV' 
  FIELD_DELIMITER = ','
  SKIP_HEADER = 1
  ERROR_ON_COLUMN_COUNT_MISMATCH = FALSE;

SHOW FILE FORMATS;

CREATE OR REPLACE STAGE snowstage
FILE_FORMAT = csv_format
URL = 'your_s3_bucket_path'

SHOW STAGES;

-- for bookings
COPY INTO BOOKINGS
FROM @snowstage
FILES=('your_file_name.csv')
CREDENTIALS=(aws_key_id = 'yourkey', aws_secret_key = 'yoursecretkey');

-- for listings
COPY INTO LISTINGS
FROM @snowstage
FILES=('your_file_name.csv')
CREDENTIALS=(aws_key_id = 'yourkey', aws_secret_key = 'yoursecretkey');

-- for hosts
COPY INTO HOSTS
FROM @snowstage
FILES=('your_file_name.csv')
CREDENTIALS=(aws_key_id = 'yourkey', aws_secret_key = 'yoursecretkey');

SELECT * FROM BOOKINGS;
SELECT * FROM LISTINGS;
SELECT * FROM HOSTS;






