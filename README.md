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



Notes on the contact export job
-------------------------------
There are some limitations in the way we can work with contact fields in our Kettle job. They are described here.

1. Pass in contact fields as separate parameters like so cf_1 = first_name
2. There must be at least one contact field passed
3. We can't have a totally variable nr of possible fields. So i've set the maximum to 4 now but this can be extended ofcourse. I could not find a good solution to make this fully flexible because kettle needs you to specify fields in a hard manner at many places (ES queries and in Kettle Steps) and doesn't work with fields in an array.
4. If you pass in less then 4 fieldnames, the last colums in the export will be empty (;;) they can't be completely left out. To emtpy already required some extra steps.
5. The passed fields must be present, because ES doesn't return empty fields this would result in uneven rows, so a query to verify that the fields exist is necessary, but that means contacts with no data for those fields will be left out.

I tried to work around these problems, ofcourse we want to be able to pass in a variable nr of fields, get a clean export without empty columns and have empty values not result in contacts being skipped. But I coulnd't get it there. It's mostly ES limitations in combination with Json path limitations we use to translate the json into csv rows. Perhaps the solution lies in skipping ES altogether and have Kettle talk to MongoDb directly.






