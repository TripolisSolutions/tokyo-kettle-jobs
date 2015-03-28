module TokyoKettleJobs
  module Jobs
    module ImportContacts
      def self.get_file_path path
        File.expand_path(path, __FILE__)
      end

      def self.entry_file
        get_file_path('../kettle/import_contacts.kjb')
      end

      def self.import_contacts_template_task
        get_file_path('../kettle/import_contacts.ktr')
      end

      def self.import_contacts_validation_template_job
        get_file_path('../kettle/import_contacts_validation.kjb')
      end

      def self.import_contacts_validation_template_task
        get_file_path('../kettle/import_template_validation.ktr')
      end

      def self.s3_utility
        get_file_path('../s3_utility.rb')
      end

      def self.get_kettle_shell_script kitchen_cmd, entry_file, kettle_import_contacts_job, s3_region, s3_utility, default_s3_bucket_name, import_csv_file_name, s3_kettle_path, ktr_file_name
        "#{kitchen_cmd} -file:\"#{entry_file}\" #{kettle_import_contacts_job} -param:S3_REGION=\"#{s3_region}\" -param:S3_UTILITY=\"#{s3_utility}\" -param:IMPORT_BUCKET_NAME=\"#{default_s3_bucket_name}\" -param:IMPORT_CSV_FILENAME=\"#{import_csv_file_name}\" -param:S3_KETTLE_JOBS_PATH=\"#{s3_kettle_path}\" -param:KETTLE_FILENAME=\"#{ktr_file_name}\" & >/dev/null 2>&1"
      end
    end
  end
end
