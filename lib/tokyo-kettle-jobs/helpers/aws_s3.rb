require 'aws-sdk'

module TokyoKettleJobs
  module AwsHelpers
    module S3
      def self.download_file(bucket, s3_file_path, local_file_path, region, extra_options = {})
        if File.exists?(local_file_path)
          File.delete(local_file_path)
          puts "Deleted file #{local_file_path}"
        end
        puts "Downloading #{region}/#{bucket}/#{s3_file_path} to #{local_file_path}"

        client = Aws::S3::Client.new(region: region, credentials: s3_credentials)
        request_options = {bucket: bucket, key: s3_file_path, response_target: local_file_path}.merge(extra_options || {})
        client.get_object(request_options)

        puts "Downloaded #{region}/#{bucket}/#{s3_file_path} to #{local_file_path}"
      end

      def self.upload_file(bucket, s3_file_path, local_file_path, region, extra_options = {})
        unless File.exists?(local_file_path)
          raise "''#{local_file_path}' file not found"
        end
        puts "Uploading #{local_file_path} to #{region}/#{bucket}/#{s3_file_path}"

        client = Aws::S3::Client.new(region: region, credentials: s3_credentials)
        request_options = {bucket: bucket, key: s3_file_path, body: local_file_path}.merge(extra_options || {})
        client.put_object(request_options)

        puts "Uploaded #{local_file_path} to #{region}/#{bucket}/#{s3_file_path}"
      end

      def self.s3_credentials
        Aws::SharedCredentials.new(profile_name: 'tokyo-s3')
      end
    end


  end
end