require 'aws-sdk'

module TokyoKettleJobs
  module AwsHelpers
    module S3
      def self.download_file(bucket, s3_file_path, local_file_path, region)
        if File.exists?(local_file_path)
          File.delete(local_file_path)
          puts "Deleted file #{local_file_path}"
        end
        puts "Downloading #{region}/#{bucket}/#{s3_file_path} to #{local_file_path}"

        begin
          credentials = Aws::SharedCredentials.new(profile_name: 'tokyo-s3')
          client = Aws::S3::Client.new(region: region, credentials: credentials)
          client.get_object(bucket: bucket, key: s3_file_path, response_target: local_file_path)
          return
        rescue LoadError => err
          puts "'#{aws_sdk}' gem not found. Trying with 'aws-sdk-v1' gem"
        end

        puts "Downloaded #{region}/#{bucket}/#{s3_file_path} to #{local_file_path} using '#{aws_sdk}' gem"
      end
    end


  end
end