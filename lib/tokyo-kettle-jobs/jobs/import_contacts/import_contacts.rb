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

      def self.update_sub_id_template_task
        get_file_path('../kettle/update_sub_id.ktr')
      end

      def self.s3_utility
        get_file_path('../s3_utility.rb')
      end

      def self.get_kettle_shell_script params, default_log = nil
        kitchen_cmd_params = [
            "IMPORTID=\"#{params[:import_id]}\""
        ].join(' ')

        pars = [
            "-param:S3_REGION=\"#{params[:s3_region]}\"",
            "-param:S3_UTILITY=\"#{params[:s3_utility]}\"",
            "-param:LISTIDS=\"#{params[:s_lists]}\"",
            "-param:SUBSCRIPTIONIDS=\"#{params[:s_subscription_lists]}\"",
            "-param:USERID=\"#{params[:user_id]}\"",
            "-param:TENANT_UUID=\"#{params[:tenantUUID]}\"",
            "-param:ADMIN_API_URL=\"#{params[:admin_url]}\"",
            "-param:PUSHMESSAGE_API_URL=\"#{params[:pushmessage_url]}\"",
            "-param:IMPORT_BUCKET_NAME=\"#{params[:s3_bucket_name]}\"",
            "-param:IMPORT_CSV_FILENAME=\"#{params[:csv_file_name]}\"",
            "-param:S3_KETTLE_JOBS_PATH=\"#{params[:s3_kettle_job_path]}\"",
            "-param:KETTLE_FILENAME=\"#{params[:ktr_file_name]}\"",
            "-param:QUEUE_NAME=\"#{params[:queue_name]}\"",
            "-param:RABBIT_HOST=\"#{params[:rabbit_host]}\"",
            "-param:RABBIT_USER=\"#{params[:rabbit_user]}\"",
            "-param:RABBIT_PASSWORD=\"#{params[:rabbit_password]}\"",
            "-param:IMPORTID=\"#{params[:import_id]}\"",
            "-param:IMPORT_SERVICE_URL=\"#{params[:import_service_url]}\"",
            "-param:TotalRows=\"#{params[:total_rows]}\"",
            "-param:MAPPING_ID=\"#{params[:mapping_id]}\""
        ].join(' ')

        if params[:run_in_remote_server] and params[:run_in_remote_server] == true
          shell_script = "ssh -i /home/tinh/.ssh/desktop_tripolis #{params[:pentaho_user]}@#{params[:pentaho_server]} #{kitchen_cmd_params} 'bash -s' <<'ENDSSH'\nsource  /home/tinh/.profile; \n#{params[:kitchen_cmd].sub(" ", ";\n")} -file:\"#{params[:entry_file]}\" #{params[:kettle_job_option]} #{pars} #{default_log.nil? ? " > /dev/null 2>&1 &" : default_log} \nENDSSH"
        else
          shell_script = "#{params[:kitchen_cmd]} -file:\"#{params[:entry_file]}\" #{params[:kettle_job_option]} #{kitchen_cmd_params} #{default_log.nil? ? " > /dev/null 2>&1 &" : default_log}"
        end
        # shell_script = "#{params[:kitchen_cmd]} -file:\"#{params[:entry_file]}\" #{params[:kettle_job_option]} #{kitchen_cmd_params} #{default_log.nil? ? " > /dev/null 2>&1 &" : default_log}"
        shell_script
      end
    end
  end
end
