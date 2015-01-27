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
2. Email does not have to be passed
3. There must be at least one contact field passed
4. We can't have a totally variable nr of possible fields. So i've set the maximum to 4 now but this can be extended ofcourse. I could not find a good solution to make this fully flexible because kettle needs you to specify fields in a hard manner at many places (ES queries and in Kettle Steps) and doesn't work with fields in an array.
5. If you pass in less then 4 fieldnames, the last colums in the export will be empty (;;) they can't be completely left out. To emtpy them already required quite a few extra steps.
6. The passed fields must be present for each contact, because ES doesn't return empty fields this would result in uneven rows and it would not be possible to convert the json to a CSV row using JSONPath. So a query is added to verify that the fields exist, but that means contacts with no data for those fields will be left out.
7. In the ES query we skip contacts that have hard bounces or channels with a bounce count higher then the threshold. These values must also be present with the contacts.
8. In step JSON input in the export_contacts_embedded transformation, we need to filter out the right email channels. We do this with following JSONPath expression: $..hits.*._source.channels[?(@._type=='Contacts::EmailAddress' && @.is_active==true && @.primary==true && @.hard_bounced==false)].value. This must only return ONE channel or we get uneven rows. This is no problem if we have business logic in place that a contact can only have one active, primary email address.

I tried to work around some of these limitation, ofcourse we would want be able to pass in a variable nr of fieldsm (1 or 100 shouldn't make a difference), get a clean export without empty columns and have empty values not result in contacts being skipped. But I coulnd't find a way. It's mostly ES limitations in combination with JSONpath limitations we use to translate the json into csv rows. Perhaps the solution lies in skipping ES altogether and have Kettle talk to MongoDb directly.






