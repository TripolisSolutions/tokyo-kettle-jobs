require 'time'

s3_bucket = ARGV[0].to_s.strip
s3_csv_file_path = ARGV[1].to_s.strip
s3_kettle_file_path = ARGV[2].to_s.strip
start_date = DateTime.strptime(ARGV[3].to_s.strip, '%Y-%m-%dT%H:%M:%S%z').to_time.utc
end_date  = DateTime.strptime(ARGV[4].to_s.strip, '%Y-%m-%dT%H:%M:%S%z').to_time.utc
now = Time.now.utc

puts "Running job at #{now}"
if now < start_date
  abort("#{start_date} is to soon to run")
end

if now > end_date
  abort("Schedule expired at #{end_date}")
end

cmd = %W(#{ENV['KETTLE_HOME']}/kitchen.sh -file:"#{File.expand_path('../kettle/import_contacts.kjb', __FILE__)}"  -param:IMPORT_CSV_FILENAME="#{s3_csv_file_path}" -param:KETTLE_FILENAME="#{s3_kettle_file_path}")
puts cmd.join(' ')
exec cmd.join(' ')