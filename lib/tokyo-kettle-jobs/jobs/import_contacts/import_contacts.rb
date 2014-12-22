module TokyoKettleJobs
  module Jobs
    module ImportContacts
      def self.entry_file
        File.expand_path('../kettle/import_contacts.kjb', __FILE__)
      end
    end
  end
end
