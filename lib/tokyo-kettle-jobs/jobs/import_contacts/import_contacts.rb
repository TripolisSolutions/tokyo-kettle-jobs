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
            "S3_REGION=\"#{params[:s3_region]}\"",
            "S3_UTILITY=\"#{params[:s3_utility]}\"",
            "LISTIDS=\"#{params[:s_lists]}\"",
            "SUBSCRIPTIONIDS=\"#{params[:s_subscription_lists]}\"",
            "USERID=\"#{params[:user_id]}\"",
            "TENANT_UUID=\"#{params[:tenantUUID]}\"",
            "ADMIN_API_URL=\"#{params[:admin_url]}\"",
            "PUSHMESSAGE_API_URL=\"#{params[:pushmessage_url]}\"",
            "IMPORT_BUCKET_NAME=\"#{params[:s3_bucket_name]}\"",
            "IMPORT_CSV_FILENAME=\"#{params[:csv_file_name]}\"",
            "S3_KETTLE_JOBS_PATH=\"#{params[:s3_kettle_job_path]}\"",
            "KETTLE_FILENAME=\"#{params[:ktr_file_name]}\"",
            "QUEUE_NAME=\"#{params[:queue_name]}\"",
            "RABBIT_HOST=\"#{params[:rabbit_host]}\"",
            "RABBIT_USER=\"#{params[:rabbit_user]}\"",
            "RABBIT_PASSWORD=\"#{params[:rabbit_password]}\"",
            "IMPORTID=\"#{params[:import_id]}\"",
            "CCO_QUEUE_NAME=\"#{params[:cco_queue_name]}\"",
            "IMPORT_CSV_SHORT_FILENAME=\"#{params[:import_csv_short_file_name]}\""
        ].join(' ')

        pars = [
            "-param:S3_REGION=\"$S3_REGION\"",
            "-param:S3_UTILITY=\"$S3_UTILITY\"",
            "-param:LISTIDS=\"$LISTIDS\"",
            "-param:SUBSCRIPTIONIDS=\"$SUBSCRIPTIONIDS\"",
            "-param:USERID=\"$USERID\"",
            "-param:TENANT_UUID=\"$TENANT_UUID\"",
            "-param:ADMIN_API_URL=\"$ADMIN_API_URL\"",
            "-param:PUSHMESSAGE_API_URL=\"$PUSHMESSAGE_API_URL\"",
            "-param:IMPORT_BUCKET_NAME=\"$IMPORT_BUCKET_NAME\"",
            "-param:IMPORT_CSV_FILENAME=\"$IMPORT_CSV_FILENAME\"",
            "-param:S3_KETTLE_JOBS_PATH=\"$S3_KETTLE_JOBS_PATH\"",
            "-param:KETTLE_FILENAME=\"$KETTLE_FILENAME\"",
            "-param:QUEUE_NAME=\"$QUEUE_NAME\"",
            "-param:RABBIT_HOST=\"$RABBIT_HOST\"",
            "-param:RABBIT_USER=\"$RABBIT_USER\"",
            "-param:RABBIT_PASSWORD=\"$RABBIT_PASSWORD\"",
            "-param:IMPORTID=\"$IMPORTID\"",
            "-param:CCO_QUEUE_NAME=\"$CCO_QUEUE_NAME\"",
            "-param:IMPORT_CSV_SHORT_FILENAME=\"$IMPORT_CSV_SHORT_FILENAME\""
        ].join(' ')

        shell_script = "ssh #{params[:pentaho_user]}@#{params[:pentaho_server]} #{kitchen_cmd_params} 'bash -s' <<'ENDSSH' \n#{params[:kitchen_cmd].sub(" ", ";\n")} -file:\"#{params[:entry_file]}\" #{params[:kettle_job_option]} #{pars} #{default_log.nil? ? "& >/dev/null 2>&1" : default_log} \nENDSSH"
        # shell_script = "#{params[:kitchen_cmd]} -file:\"#{params[:entry_file]}\" #{params[:kettle_job_option]} #{kitchen_cmd_params} #{default_log.nil? ? "& >/dev/null 2>&1" : default_log}"
        shell_script
      end
    end
  end
end
