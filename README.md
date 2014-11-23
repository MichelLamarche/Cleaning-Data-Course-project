Cleaning-Data-Course-project
============================
My code for this assignement is pretty straightforward.

I first load all data, and join the train and test files into local variables.
Then I remove the inital files
Next step is to identify the columns to be kept, because many of them have to be removed, as per the assignement directives.
A new data frame is created from the identified columns.
Then those columns are renamed accordingly.
The activity and subject data are added to our main data frame, after they have been joined by their commun key.
A new tidy data frame is created together with the mean calculations on the double key (activity and subject)
The activity numbers are replaced with activity names.
Then this output file is cleaned by removing duplicates columns created in the process, and grouping columns are renamed properly.
Lastly, the output file is created.

Further comments are included in the script

PLease forgive my english, which is mon second language.

Thank you
