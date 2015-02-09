module TokyoKettleJobs
  module AwsHelpers
    module S3
      def self.download_file(bucket, s3_file_path, local_file_path, region)
        if File.exists?(local_file_path)
          File.delete(local_file_path)
          puts "Deleted file #{local_file_path}"
        end
        puts "Downloading #{region}/#{bucket}/#{s3_file_path} to #{local_file_path}"

        aws_sdk = 'aws-sdk-core'
        begin
          require aws_sdk

          client = Aws::S3::Client.new(region: region)
          client.get_object(bucket: bucket, key: s3_file_path, response_target: local_file_path)
          return
        rescue LoadError => err
          puts "'#{aws_sdk}' gem not found. Trying with 'aws-sdk-v1' gem"
        end

        aws_sdk = 'aws-sdk-v1'
        begin
          require aws_sdk

          s3 = AWS::S3.new(:region => region)
          File.open(local_file_path, 'wb') do |file|
            s3.buckets[bucket].objects[s3_file_path].read do |chunk|
              file.write chunk
            end
          end
        rescue LoadError => err
          raise LoadError.new("'aws-sdk-v1' or 'aws-sdk-core' gems not found. You must add one of those gems to Gemfile and bundle install")
        end

        puts "Downloaded #{region}/#{bucket}/#{s3_file_path} to #{local_file_path} using '#{aws_sdk}' gem"
      end
    end
  end
end