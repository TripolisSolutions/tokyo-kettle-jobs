kettle-jobs
===========
This gem holds all the Pentaho Kettle (PDI) scripts Tokyo uses. Currenty only the contact-api project. Kettle needs to be installed on the machine where the project is deployed and will use the scripts that are defined here. To develop and test, [download](http://community.pentaho.com/projects/data-integration) Kettle and install on your local machine. 

1. tokyo-kettle-jobs gem structure:
  - config/ folder: contains code to build & deploy the gem to gems server (gems.sg.tripolis.vn)
  - lib/tokyo-kettle-jobs/jobs folder: contains jobs. Each job should have a separate folder, then inside it we have:
    + kettle folder to store *.kjb files
    + A [job-name].rb file: it should define a function to return the absolute path of the job entry file.
2. The gem will be deployed into gems.sg.tripolis.vn
3. We should change the gem version when we update the gems as we do for api-engine, shell-engine etc.
