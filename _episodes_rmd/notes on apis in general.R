library(danstat)

What happens when we visit a web site?
  
  We have an URL. And asks our browser to access that URL.

That is trivial. What happens behind the scenes is that our browser sends an awful
lot of information to the webserver delivering the page. Cookies, information
on the browser etc.

When the browser needs to send data to the webserver, and get information back
based on that, it uses the POST command, which is part of the way the internet
is build. That is a request to the webserver.

This is basically what we do when we access an API. We have an URL.
We asks - not our browser but our programming language - to send a POST command to
that URL, with some sort of information in it. 
That request prompts the server to return data to us. Based on what we put into 
the request.

So. If we can figure out how to put some information that specifies what results we
want from the server into the request, we can get what we want from the server.

Most APIs have more than one function. We get a socalled endpoint for each function
the APIs offers.

And APIs tend to have pretty specific demands on how we structure our reguests.

Which functions in R do we use?

  httr::POST

It needs some arguments. The url of our api. 

Some content of the request - the function calls it "body".
and we can, actually needs to, specify how hte POST function should
encode the content of our body. To the structure the API expects.

First things first - the URL, or "endpoint" of the API.

We find that, hopefully in the documentation of the API.

DS : https://www.dst.dk/en/Statistik/brug-statistikken/muligheder-i-statistikbanken/api

Under "function" we are told that there are four endpoints:
  
subjects, tables, tableinfo and data

If we send a request to subjects - that is the simplest, and the starting point, 
for retrieving data.

The endpoint is 

"http://api.statbank.dk/v1/subjects"

We construct a named list fo the content of the body:
  


our_body <- list(lang = "en", recursive = FALSE, 
                  includeTables = FALSE, subjects = NULL)

And now we have everything to get the subjects from the API:
  
result <- httr::POST("http://api.statbank.dk/v1/subjects", body = our_body, 
                       encode = "json")

The result:
result

Not that informative. it is encoded as json - that is "just" a way of organising the data.

To get to the content:
  
  httr::content(result)

Still not very understandable...

We can use a function to get it in a format that we want to work with:
  
  jsonlite::fromJSON(httr::content(result))

Much nicer.


This is the general approach to all apis. 



danstat::make_variable_input

# The function SUBJECTS gives access to the hierarchy of subjects that contains all the tables. The hierarchy can be queried one or several levels at a time.
# 
# If the function is called without parameters, the upper level in the hierarchy will be returned. Afterwards, these subjects’ subtopics can be found by calling SUBJECTS once again with statement of the desired subjects etc..
# 
# The following function specific parameters can be provided:
#   
#   {
#     "subjects": [
#       "02",
#       "2401"
#     ],
#     "includeTables": true,
#     "recursive": true,
#     "omitInactiveSubjects": true
#   }
# subjects: Subjects for which subtopics are wanted.
# 
# includeTables: Whether the result should contain tables. Otherwise, only subjects are returned and tables can subsequently be retrieved with the function TABLES.
# 
# recursive: Whether subtopics/tables will be retrieved all the way down the hierarchy. Otherwise, only the closest level under the provided subjects will be retrieved.
# 
# omitInactiveSubjects: Whether subtopics/tables will be omitted if they or a parent subtopic is no longer updated.

result <- httr::POST(SUBJECTS_ENDPOINT, body = call_body, 
                     encode = "json")




danstat::get_subjects


Endpoints:
  
SUBJECTS_ENDPOINT <- "https://api.statbank.dk/v1/subjects"
TABLES_ENDPOINT <- "https://api.statbank.dk/v1/tables"
METADATA_ENDPOINT <- "https://api.statbank.dk/v1/tableinfo"
DATA_ENDPOINT <- "https://api.statbank.dk/v1/data"


danstat::SUBJECTS_ENDPOINT

den tager 

call_body <- list

httr::POST  

subjects_endpoint

body = call_boyd 


language <- c("en", "da")

recursive <- FALSE
include_tables <- FALSE
subjects <- NULL

call_body <- list(lang = language, recursive = recursive, 
                  includeTables = include_tables, subjects = subjects)



result <- httr::POST(SUBJECTS_ENDPOINT, body = call_body, 
                     encode = "json")

result
check_http_type(result)
jsonlite::fromJSON(httr::content(result))
