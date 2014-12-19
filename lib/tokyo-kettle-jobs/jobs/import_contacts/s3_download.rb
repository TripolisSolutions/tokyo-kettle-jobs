require 'aws-sdk-core'

region = (ARGV.length == 4 ? ARGV[3] : 'ap-southeast-1').to_s.lstrip.rstrip
bucket = ARGV[0].to_s.lstrip.rstrip
s3_file_path = ARGV[1].to_s.lstrip.rstrip
local_file_path = ARGV[2].to_s.lstrip.rstrip
client = Aws::S3::Client.new(region: region)

client.get_object(bucket: bucket, key: s3_file_path, response_target: local_file_path)
