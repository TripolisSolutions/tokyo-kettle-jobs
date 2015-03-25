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
    end
  end
end
