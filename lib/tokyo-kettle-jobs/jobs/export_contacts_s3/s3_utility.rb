require_relative '../../../tokyo-kettle-jobs/helpers/aws_s3'

action = ARGV[0].to_s.lstrip.rstrip
bucket = ARGV[1].to_s.lstrip.rstrip
s3_file_path = ARGV[2].to_s.lstrip.rstrip
local_file_path = ARGV[3].to_s.lstrip.rstrip
region = ARGV[4].to_s.lstrip.rstrip

case action
  when 'upload'
    TokyoKettleJobs::AwsHelpers::S3.upload_file(bucket, s3_file_path, local_file_path, region, {})
end

