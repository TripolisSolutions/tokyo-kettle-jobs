import_contacts configuration
=============================

1. Requirements:
  - Pentaho data-integration
  - AWS SDK for ruby, either 'aws-sdk-v1' gem or 'aws-sdk-core' gem.
2. Update settings in kettle.properties file (in data-integration/.kettle folder), here is an example for development environment:
  - S3_ACCESSKEY = AKIAJ3F6LWQFPMT4B3IQ
  - S3_SECRETKEY = r0ZkXWTMZG7ZGziKR0yidJCaW8HFlObK4lZOOs0M
  - S3_REGION = ap-southeast-1
  - IMPORT_BUCKET_NAME = tripolis-tokyo-dev
  - MONGODB_SERVER = localhost
  - MONGODB_PORT = 27017
  - MONGODB_USERNAME =
  - MONGODB_PASSWORD =
  - TOKYO_KETTLE_JOBS_PATH = [/path/to/tokyo-kettle-jobs/folder]/lib/tokyo-kettle-jobs/jobs/import_contacts
  - S3_KETTLE_JOBS_PATH = daily.sg.tripolis.vn/kettle_repository/contacts/import
  - CONTACT_DB_NAME = tokyo_api_development_contacts
  - CONTACT_COLLECTION_NAME = 2b66d7a9-8cb5-4802-838a-f1f58869bbf5_contacts
  - RVM_PATH = /home/[your_user]/.rvm
  - IMPORT_JOB_GEMSET = default
3. Environment variables
  - export KETTLE_HOME=[/path/to/data-integration/folder]
  - export KETTLE_KITCHEN_CMD=\$KETTLE_HOME/kitchen.sh
4. Add/update ~/.aws/credentials file
[default]
aws_access_key_id = AKIAJ3F6LWQFPMT4B3IQ
aws_secret_access_key = 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
