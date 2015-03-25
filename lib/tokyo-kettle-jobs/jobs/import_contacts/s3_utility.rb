require_relative '../../../tokyo-kettle-jobs/helpers/aws_s3'

region = ARGV[3].to_s.lstrip.rstrip
bucket = ARGV[0].to_s.lstrip.rstrip
s3_file_path = ARGV[1].to_s.lstrip.rstrip
local_file_path = ARGV[2].to_s.lstrip.rstrip

TokyoKettleJobs::AwsHelpers::S3.download_file(bucket, s3_file_path, local_file_path, region)
