module TokyoKettleJobs
  module Jobs
    module ExportContactsS3
      def self.entry_file
        File.expand_path('../kettle/export_contacts_s3.kjb', __FILE__)
      end
    end
  end
end