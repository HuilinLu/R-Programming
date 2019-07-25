## Goal
## Raw Data -> Processing Script -> Tidy Data -> Data Analysis -> Data Comunication

## Raw and Processed Data
## Raw Data:
### The original source of the data 
### Often hard to use for data analysis
### Data anlysis includes processing
### Raw data amay only need to be processed once
## Processed Data:
### Data that is ready for analysis
### Processing can include merging, subsetting, transforming, etc.
### There may be standards for processing
### ALL steps should be recorded

## Components of Tidy Data
## We should have following four things: 
### 1.Raw data.  2. A tidy data set.
### 3. A code book(meta date) describing each variable and its values in the tidy data set.
### 4. An explicit and exact recipe you used to go from Steps 1 -> Steps 2, 3.

## The Raw Data
### examples: 1. The strange binary file your measurement machine spits out
### 2. The unformatted Excel file with 10 worksheets the company you contracted with sent you
### 3. The complicated JSON data you got from scraping the Twitter API
### 4. The hand-entered numbers you collected looking through a microscope
## The raw data is in the right format if you:
### 1. Ran no software on the data
### 2. Did not manipulate any of the numbers in the data 
### 3. You did not remove any data from the data set
### 4. You did not summarize the data in any way

## The tidy data
### 1. Each variable you meansure should be in one column
### 2. Each different observation of that variable should be in a different row
### 3. There should be one table for each "kind" of variable
### 4. If you have multiple tables, they should include a column in the table that allows them to be linked (ID)
## Tips about tidy data:
### 1. Include a row at the top of each file with variable names
### 2. Make variable names human readable AgeAtDiagnosis instead of AgeDx
### 3. In general data should be saved in one file per table.

## The code Book
### 1. Information about the variables(including units!) in the data set not contained in the tidy data
### 2.  Information about the summary choices you made
### 3. Information about the experimental study design you used
## Some tips of code book:
### 1. A common format for this document is a Word/Text file, markdown file
### 2. There should be a section called 'Study design' that has a thorough description of how you collected data
### 3. There must be a section called 'Code book' that describes each variable and its unit

## Instruction List
### 1. Ideally a computer script(R)
### 2. The inpit for the script is the raw data
### 3. The output is the processed, tidy data
### 4. There are no parameters to the script

## In some cases it will not be possible to script every step. In that case you should provide instructions like:
### 1. Step 1 -  Take the raw file, run version 3.1.2 of summarize software with parameters a=1, b=2, c=3
### 2. Step 2 - run the software separately for each sample
### 3. Step 3 - take column three of outputfile.out for each sample and that is the corresponding row in the output dataset

## R Downloading Files
## Get/Set your working directory
## two main commands
getwd()  
setwd("./data") ## relative path
setwd("\\\\WIL-HOMEDRIVE01\\D17911$\\Desktop\\Courses\\R Programming\\Base Course")
setwd("../")  ## relative path, moving up a directory
setwd("/Users/D17911/data/")  ## Absolute path
## Important difference in Windows
setwd("C:\\Users\\Andrew\\Downloads")

## Checking for and Creating directories
file.exists("directoryName") ## will check to see if the directory exists
dir.create("directoryName")  ## will create a directory if it does not exist
if (!file.exists("data")){
    dir.create("data")
}
if (!file.exists("\\\\WIL-HOMEDRIVE01\\D17911$\\Desktop\\Courses\\R Programming\\Base Course\\camera.csv")){
    dir.create("\\\\WIL-HOMEDRIVE01\\D17911$\\Desktop\\Courses\\R Programming\\Base Course\\")
}
## Getting data from the internet - download.file()
### Downloads a file from the internet
### Even if you could do this by hand, helps with reproducibility
### Important parameters are url, destfile, method(https://)
### Useful for downloading tab-delimited, csv, and other files
setwd()
getwd()
fileUrl = "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile = "\\\\WIL-HOMEDRIVE01\\D17911$\\Desktop\\Courses\\R Programming\\Base Course\\cameras.csv") ## if we can change directory path
download.file(fileUrl, destfile="\\\\WIL-HOMEDRIVE01\\D17911$\\My Documents\\camera.csv")  ## If we cannot change our directory path
download.file(fileUrl, destfile = "\\\\WIL-HOMEDRIVE01\\D17911$\\Desktop\\Courses\\R Programming\\Base Course\\cameras.csv", method = "curl") ## If use MAC, we need to specify method
list.files("\\\\WIL-HOMEDRIVE01\\D17911$\\My Documents\\")
list.file("./data")

dateDownloaded = date()
dateDownloaded

## Notes about download.file()
### 1. If the url starts with HTTP/HTTPS, we can use download.file, if on MAC, we need to specify the method = "curl"
### 2. If the file is big, this might take a while
### Besure to record when you downloaded

## Read Local Files
if (file.exists("camera.csv")){
    print("yes")
} else {
    print("no")
}


## Loading flat files - read.table()
## This is the main function for reading data into R
## Flexible and robust but requires more parameters
## Reads the data into RAM - big data can cause problems
## Important parameters: file, header, sep, colClasses, comment.char, nrows, skip, stringAsFactors, row.names
## Related: read.csv(), read.csv2()

cameraData = read.table(file="\\\\WIL-HOMEDRIVE01\\D17911$\\Desktop\\Courses\\R Programming\\Base Course\\cameras.csv")
# Error in scan(file = file, what = what, sep = sep, quote = quote, dec = dec,  : 
#                   line 1 did not have 13 elements
## The reason is that commas separating, but the default in read.table is tab delimited              
head(cameraData)
# Error in head(cameraData) : object 'cameraData' not found

cameraData = read.table(file="\\\\WIL-HOMEDRIVE01\\D17911$\\Desktop\\Courses\\R Programming\\Base Course\\cameras.csv", sep=',', header = TRUE)
head(cameraData)

## Some important parameters in read.table
## quote -  You can tell R whether there are any quoted values quote="" means no quotes
## na.strings - set the character that represents a missing value
## nrows - how many rows to read the file(eg, nrows = 10)
## skip - number of lines to skip before starting to read
## In experience, also use "" in data values, setting quote="" often resolve ambiguous problem.

## Reading Excel
## Download Excel file
fileUrl = "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD&bom=true&format=true"
download.file(fileUrl, destfile="\\\\WIL-HOMEDRIVE01\\D17911$\\Desktop\\Courses\\R Programming\\Base Course\\cameras.xlsx")
detaDownloaded = date()
## read the Excel file, read.xlsx(), read.xlsx2()  {xlsx package}
library(xlsx)
cameraData = read.xlsx("\\\\WIL-HOMEDRIVE01\\D17911$\\Desktop\\Courses\\R Programming\\Base Course\\cameras.xlsx", sheetIndex = 1, header = TRUE)
## Reading Specific rows and columns in read.xlsx
colIndex = 2:3
rowIndex = 1:4
cameraDataSubset = read.xlsx("\\\\WIL-HOMEDRIVE01\\D17911$\\Desktop\\Courses\\R Programming\\Base Course\\cameras.xlsx", sheetIndex = 1,
                             colIndex = colIndex, rowIndex = rowIndex)
cameraDataSubset

## Further Notes:
### 1. The write.xlsx function will write out an Excel file with similar arguments
### 2. Read.xlsx2 is much faster than read.xlsx but for reading subsets of rows may be slightly unstable
### 3. The XLConnect package has more options for writing and manipulating Excel files
### 4. The XLConnect vignette is a good place to start for that package
### 5. In general it is advised to store your data in either a database or in comma separated files(.csv) or tab separated files(.tab/.txt) as they are easier to distribute


## Reading XML(Extensible Markup Language)
### Frequently used to store structured data, particularly widely used in internet applications (Internet API)
### Extracting XML is the basis for most web scraping
### Components: 1: Markup - labels that give the text structure  2: Content - the actual text of the document

## Tags, Elements, and Attributes
### Tags correspond to general lables
- Start tags <section>
- End tags </section>
- Empty tags <line-break />
### Elements are specific examples of tags
- <Greeting> Hello, world </Greeting>
### Attributes are components of the label
- <img src="jeff.jpg" alt="instructor"/>
- <step number="3"> Connect A to B. </step>

## Read XML into R
library(XML)
library(RCurl)
fileUrl = "https://www.w3schools.com/xml/simple.xml"
xData = getURL(fileUrl)
doc = xmlTreeParse(fileUrl, useInternal=TRUE)  ## load in R and parse it
doc = xmlParse(xData)
rootNode = xmlRoot(doc)  ## sort of wrapper for entire document
xmlName(rootNode)
## Answe: "breakfast_menu"
names(rootNode)  ## nested elements in the root node
## Answer: food "food"
## Directly access parts of the SML document
rootNode[[1]]
rootNode[[1]][[1]]
## Programatically extract parts pof the file
xmlSApply(rootNode, xmlValue)

## XPath
### 1. /node Top level node
### 2. //node Node at any level
### 3. node[@attr-name] Node with an attribute name
### 4. node[@attr-name='bob'] Node with attribute name attr-name = 'bob'

## example: Get the items on the menu and prices
xpathSApply(rootNode, "//name", xmlValue)  ## get the name for each items
xpathSApply(rootNode, "\\price", xmlValue)  ## get the price for each item

## Another example of extract content by attributes
fileUrl = "http://www.espn.com/nfl/team/_/name/bal/baltimore-ravens"
doc = htmlTreeParse(fileUrl, useInternal = TRUE)
scores = xpathSApply(doc, "//li[@class='score']", xmlValue)
teams = xpathSApply(doc, "//li[@class='team-name']", xmlValue)
scores
teams


## Reading JSON
JSON: Javascript Object Notation
## 1. Lightweight data storage
## 2. Common format for data from application programming interfaces (APIs)
## 3. Similar structure to XML but different syntax/format
## 4. Data stored as: Numbers (double), Strings(double quoted), Boolean(true or false), Array(ordered, comma separated enclosed in square brackets []), Object(unordered, comma separated collection of key: value pairs in curly brackets {})

## Reading data from JSON {jsonlite package}
library(jsonlite)
jsonData = fromJSON("https://api.github.com/users/jtleek/repos")
names(jsonData)
names(jsonData$owner)
jsonData$owner$login
## Writing data frames to JOSN
myjson = toJSON(iris, pretty = TRUE)
cat(myjson)
names(myjson)
## Converte back to JSON
iris2 = fromJSON(myjson)
head(iris2)
names(iris2)


## The data.table Package
data.table
## Inherets from data.frame: All functions that accept data.frame work on data.table
## Written in C so it is much faster
## Much, much faster at subsetting, group, and updating

## Create data tables just like data frames
library(data.table)
DF = data.frame(x=rnorm(9),y = rep(c("a", "b", "c"), each=3), z=rnorm(9))
head(DF, 3)

DT = data.table(x=rnorm(9),y = rep(c("a", "b", "c"), each=3), z=rnorm(9))
head(DT, 3)
x y         z
1:  0.7888139 a 1.5582599
2: -0.3053380 a 0.4485974
3: -0.1236002 a 0.7123256
## See all the data tables in memory
tables()
NAME NROW NCOL MB  COLS KEY
1:   DT    9    3  0 x,y,z    
Total: 0MB

## Subsetting rows
DT[2,]
DT[DT$y=="a",]
## subsetting based on on index, it will only subset on rows
DT[c(2,3)]
x y         z
1: -0.3053380 a 0.4485974
2: -0.1236002 a 0.7123256

## Column subsetting is different in data.table than data.frame
## The subsetting function is modified for data.table
## The argument you pass after the comma is called an "expression"
## In R an expression is a collection of statements enclosed in curly bracket
{
    x = 1
    y = 2
}
k = {print(10); 5}  ## output is 10
print(k)  ## output is 5

## Calculating values for variables with expressions
DT[, list(mean(x), sum(z))]
V1       V2
1: 0.04078394 2.602234
DT[, table(y)]

## Adding new columns
DT[, w:=z^2]
head(DT, 3)
x y         z         w
1:  0.7888139 a 1.5582599 2.4281739
2: -0.3053380 a 0.4485974 0.2012397
3: -0.1236002 a 0.7123256 0.5074078
## Notice: Add new columns will have two copies of data frames in R, however, data.table won't let that happen, it will only has one copy and overwrite
## Explanation:
DT2 = DT
DT[, y:=2]
## Very careful
head(DT, n=3)
x y         z         w
1:  0.7888139 2 1.5582599 2.4281739
2: -0.3053380 2 0.4485974 0.2012397
3: -0.1236002 2 0.7123256 0.5074078
head(DT2, n=3)  ## Also changed
x y         z         w
1:  0.7888139 2 1.5582599 2.4281739
2: -0.3053380 2 0.4485974 0.2012397
3: -0.1236002 2 0.7123256 0.5074078

## Multiple Operations
DT[, m:= {tmp = (x+z); log2(tmp+5)}]
head(DT)
#             x y          z         w        m
# 1:  0.7888139 2  1.5582599 2.4281739 2.877170
# 2: -0.3053380 2  0.4485974 0.2012397 2.362683
# 3: -0.1236002 2  0.7123256 0.5074078 2.482519
# 4:  1.6749345 2 -0.3889684 0.1512964 2.652134
# 5: -0.6308466 2 -0.1613168 0.0260231 2.073079
# 6: -0.3833544 2 -0.6087670 0.3705973 2.002839

## plyr Like Operations
DT[, a:=x>0]
head(DT, 3)
# x y         z         w        m     a
# 1:  0.7888139 2 1.5582599 2.4281739 2.877170  TRUE
# 2: -0.3053380 2 0.4485974 0.2012397 2.362683 FALSE
# 3: -0.1236002 2 0.7123256 0.5074078 2.482519 FALSE
## Summarize by group
DT[, b:=mean(x+w), by=a]
head(DT, 5)
# x y          z         w        m     a          b
# 1:  0.7888139 2  1.5582599 2.4281739 2.877170  TRUE  2.5327177
# 2: -0.3053380 2  0.4485974 0.2012397 2.362683 FALSE -0.1643713
# 3: -0.1236002 2  0.7123256 0.5074078 2.482519 FALSE -0.1643713
# 4:  1.6749345 2 -0.3889684 0.1512964 2.652134  TRUE  2.5327177
# 5: -0.6308466 2 -0.1613168 0.0260231 2.073079 FALSE -0.1643713

## sPECIAL vARIABLES 
.N is an integer, length 1, containing the number/calculating the number
set.seed(123)
DT = data.table(x=sample(letters[1:3], 1E5, TRUE))  ## Creating a sample with 100000 letters of a, b, c
DT[, .N, by=x]  ## table(DT$x)
# x     N
# 1: a 33387
# 2: c 33201
# 3: b 33412

## Keys in data.table
DT = data.table(x=rep(c("a", "b", "c"), each=100), y=rnorm(300))
setkey(DT, x)
## If you set the key, it is possible to subset and sort a data table much more rapidly  than dataframe
DT['a']  ## subset x='a'

## Use Keys to Joins
DT1 = data.table(x=c("a", "a", "b", "dt1"), y=1:4)
DT2 = data.table(x=c("a", "b", "dt2"), z=5:7)
setkey(DT1, x)
setkey(DT2, x)
merge(DT1, DT2)
# x y z
# 1: a 1 5
# 2: a 2 5
# 3: b 3 6

## Fast reading for data.table comparing with data.frame
big_df = data.frame(x=rnorm(1E6), y=rnorm(1E6))
file = tempfile()
write.table(big_df, file = file, row.names = FALSE, col.names = TRUE, sep="\t", quote = FALSE)
system.time(fread(file))
user  system elapsed 
0.11    0.04    0.11 
## fread can be applied read data.tables, fread is a substitute of read.table which is slower
system.time(read.table(file, header = TRUE, sep="\t"))
user  system elapsed 
8.16    0.30    8.88 

#### Exercise
###### Exercise 1
fileUrl = 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv'
download.file(fileUrl, destfile = "\\\\WIL-HOMEDRIVE01\\D17911$\\Desktop\\Courses\\R Programming\\Base Course\\survey.csv") 
survey = read.table(file="\\\\WIL-HOMEDRIVE01\\D17911$\\Desktop\\Courses\\R Programming\\Base Course\\survey.csv", sep=',', header = TRUE)
head(survey)
table(survey$VAL)

###### Exercise 6
fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileUrl, destfile="\\\\WIL-HOMEDRIVE01\\D17911$\\Desktop\\Courses\\R Programming\\Base Course\\gas.xlsx")
detaDownloaded = date()
## read the Excel file, read.xlsx(), read.xlsx2()  {xlsx package}

gas = read.xlsx("\\\\WIL-HOMEDRIVE01\\D17911$\\Desktop\\Courses\\R Programming\\Base Course\\gas.xlsx", sheetIndex = 1)
## Reading Specific rows and columns in read.xlsx
colIndex = 7:15
rowIndex = 18:23
dat = read.xlsx("\\\\WIL-HOMEDRIVE01\\D17911$\\Desktop\\Courses\\R Programming\\Base Course\\gas.xlsx", sheetIndex = 1,
                             colIndex = colIndex, rowIndex = rowIndex)

sum(dat$Zip*dat$Ext,na.rm=T)

###### Exercise 4.
fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
xData = getURL(fileUrl)
doc = xmlTreeParse(fileUrl, useInternal=TRUE)  ## load in R and parse it
doc = xmlParse(xData)
rootNode = xmlRoot(doc)  ## sort of wrapper for entire document
xmlName(rootNode)

###### Exercise 5

fileUrl = 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv'
download.file(fileUrl, destfile = "\\\\WIL-HOMEDRIVE01\\D17911$\\Desktop\\Courses\\R Programming\\Base Course\\survey.csv") 
survey = fread("\\\\WIL-HOMEDRIVE01\\D17911$\\Desktop\\Courses\\R Programming\\Base Course\\survey.csv")
head(survey)
survey[, b:=mean(pwgtp15), by=a]
## Play work
x=2
if(x<3){
    print('Small')
} else if(x<10){
    print('medium')
} else {
    print('Large')
}


zork = 0
a = c(1, 2, 3, 4)
for(i in a){
    if(a[i]>zork){
        zork=a[i]
    }
}
print(zork)


## Week 2

## Reading MySQL
library(RMySQL)
ucscDb = dbConnect(MySQL(),user="genome", host = "genome-mysql.cse.ucsc.edu")  ## ucscDb our server name
result = dbGetQuery(ucscDb, 'show databases;'); dbDisconnect(ucscDb)  ## show have TRUE answer
## Connecting to hg19 database and listing tables
hg19 = dbConnect(MySQL(), user="genome", db = "hg19", host = "genome-mysql.cse.ucsc.edu")  ## hg19 is the built in human genome database
allTables = dbListTables(hg19)   ## multi-tables
length(allTables)   ## 10949 tables
allTables[1:5]   ## first five tables
## Get dimensions of a specific table
dbListFields(hg19, "affyU133Plus2")  ## table in MySQL is the data frame, the columns in this table
dgGetQuery(hg19, "select count(*) from affyU133Plus2")  ## different rows in this table
## Read from the table
affyData = dbReadTable(hg19, "affyU133Plus2")
head(affyData)
## Select a specific subset
query = dbSendQuery(hg19, "sleect * from affyU133Plus2 where misMatches between 1 and 3")
affyMis = fetch(query); ## Fetch the result of the query
quantile(affyMis$misMatches)
affyMisSmall = fetch(query, n=10);  ## just bring back top 10 records
dbClearResult(query); ## the query is still being out at the MySQL Server, this should return TRUE
dim(affyMisSmall)
## Don't forget to close the connection!
dbDisconnect(hg19)

## Reading from HDF5
## HDF5
## Used foor storing large data sets
## Supports storing a range of data types
## Hierarchical data format
## Groups containing zero or more data sets and metadata: Have a group header with group name and list of attributes. Have a group symbol table with a list of objects in group
## Datasets multidimensional array of data elements with metadata:
## 1. Have a header with name, datatype, dataspace, and storage layout.  2. Have a data array with the data.

source("http://bioconductor.org/bioLite.R")
biocLite("rhdf5")
library(rhdf5)
created = h5createFile("example.h5")
created   ## we should have output TRUE
## Note: This will install packages from Bioconductor http://bioconductor.org/, primarily used for genomics but also has good "big data" packages
## Can be used to interface with hdf5 data sets
## This lecture is modeled very closely on the rhdf5 tutorial that can be found in the bioconductor website
## Create Groups 
created = h5createGroup("example.h5", "foo")  ## craete a group named foo
created = h5createGroup("example.h5", "baa")  ## craete a group named baa
created = h5createGroup('example.h5', "foo/foobaa")   ## craete a subgroup foobaa under the group foo
h5ls("example.h5")
## Write to Groups
A = matrix(1:10, nr = 5, nc = 2)
h5write(A, "example.h5", "foo/A")   ## Write A to the example.h5 as a subgroup, thus foo/A
B = array(seq(0.1, 2.0, by = 0.1), dim=c(5, 2, 2))
attr(B, "scale") = "liter"   ## put array B as a metadata, liter is sort of about the units
h5write(B, "example.h5", "foo/foobaa/B")
h5ls("example.h5")
## Write a dataset
df = data.frame(1L:5L, seq(0, 1,length.out = 5), c("ab", "cde", "fghi", "a", "s"), stringsAsFactors = FALSE)
h5write(df, "example.h5", "df")
h5ls("exmaple.h5")
## Reading data (from hdf5)
readA = h5read("example.h5", "foo/A")  ## read data in subgroup of foo/A
readB = h5read("example.h5", "foo/foobaa/B")
readdf = h5read("example.h5", "df")
readA

## Writing and reading chunks
h5write(c(12, 13, 14), "example.h5", "foo/A", index=list(1:3, 1))   ## replace the number in the first column and first three rows with 12, 13, 14
h5read("example.h5", "foo/A")
## Notes and further resources: hdf5 can be used to optimize reading.writing from disc in R


## Reading data from the Web
## Webscraping: programatically extracting data from the HTML code of websites
## It can be a great way to get data "How Netflix reverse engineered Hollywood"
## Many websites have information you may want to programticaly read
## In some cases this is against the terms of service for the website
## Attempting to read too many pages too quickly can get your IP address blocked
## Getting data off webpages - readLines() and url()
con = url("https://scholar.google.com/citations?hl=en&user=OyDDH6UAAAAJ")
htmlCode = readLines(con)
close(con)
htmlCode
## the outcome of the htmlCode is unformated and one line, very hard to read and use
## Parsing with XML
library(XML)
url = "https://scholar.google.com/citations?hl=en&user=OyDDH6UAAAAJ"
html = htmlTreeParse(url, useInternalNodes = T)
xpathSApply(html, "//title", xmlValue)
xpathSApply(html, "//td[@id='col-citedby']", xmlValue)
# list()
## Another way to parse data from web scrapping
library(httr)
url = "https://scholar.google.com/citations?hl=en&user=OyDDH6UAAAAJ"
html2 = GET(url)
content2=content(html2, as="text")
parsedHtml= htmlParse(content2, asText=TRUE)   ## text string
xpathSApply(parsedHtml, "//title", xmlValue)
xpathSApply(parsedHtml, "//td[@id='col-citedby']", xmlValue)

## Accessing websites with passwords
pg1 = GET("http://httpbin.org/basic-auth/user/passwd")
pg1
## we will get a response of status 401 because we are not authenticated
## Thus we can use httr package to put in username and password, authenticate myself to the website 
pg2 = GET("http://httpbin.org/basic-auth/user/passwd", authenticate("user", "passwd"))
pg2    ## authenticated will be TRUE
names(pg2)
 
## Using handles
google = handle("http://google.com")
pg1 = GET(handle=google, path="/")
pg2 = GET(handle=google, path ="search")
## use handle can sort of save the authentication across multiple accesses to a website


## Reading data from APIs: Application Programming Interfaces: Twitter, Facebook
## APIs is used for which users are tweeting or what they are tweeting about, please recall the Text Mining course  
## use HTTR package to get data from APIs
## On twitter, create an application and on the OAuth Settings, you will have a number for consumer key and consumer secret, also a request URL and Authorize URL
## use the above information to get access to the APIs
## Accessing Twitter from R
myapp = oauth_app("twitter", key = "yourCOnsumerKeyHere", secret = "yourCOnsumerSecretHere")
sig = sign_oauth1.0(myapp, token = "yourTokenHere", token_secrer = "yourTokenSecretHere")
homeTL = GET("https://api.twitter.com/1.1/statuses/home_timeline.json", sig)   ## This is the URL that corresponds to the API
## Because Twitter only accept JSON, so we should
## Converting the json object
json1 = content(homeTL)   ## This connect function will recognize json data
json2 = jsonlite::fromJSON(toJSON(json1))  ## use the jsonlite package to format it, convert back to json and use fromJSON to create a data frame
json2[1, 1:4]  ## look at first four columns: time, id,  id_str, and conetnt of tweets
## How did I know what url to use?  (home_timeline)
## use https://dev.twitter.com/docs/api/1.1/get/search/tweets, look at the resource url, that should be used in GET command
## In general look at the documentation: https://dev.twitter.com/docs/api/1.1/overview: home_timeline, retweets, user_timeline, tweetes feeds, hashtags
## httr allows GET, POST, PUT, DELETE requests if you are authorized
## You can authenticate with a username and a password
## Most modern APIs use something lika oauth
## httr works well with Facebook, Google, Twitter, Github, etc.


## Reading from Other Sources
## There is a package for that to download data from website
## Roger has a nice video on how there are R packages fro most things that you will want to access
## Here is a few:
## In general, the best way to find out if the R package exists is to Google "data storage mechanism R package", eg 'MySQL R package'

## Interacting more directly with files
file -- open a connection to a text file already land on computer
url -- open a connection to a url
gzfile -- open a connection to a .gz file already on computer
bzfile -- open a connection to a .bz2 file already on computer                            
?connections for more information
## Remember to close connections
## Foreign package
## Loads data from Minitab, S, SAS, SPSS, Stat, Systat
## Basic functions read.foo, foo is the extension for the particular file
read.arff(Weka)
read.dta(Stata)
read.mtp(Minitab)
read.octave(Octave)
read.spss(SPSS)
read.xport(SAS)

## Reading Images
jpeg
readbitmap
png
EBImage(Bioconductor)

## Reading GIS (Geographic Information System) data
rdgal
rgeos
raster

## Reading music data
tuneR
seewave


## Exercise 1
myapp = oauth_app("github", key = "d265fa64186293ca0dc5", secret = "13ea4f621ffdfe89e418eb9ed134e0dc56c32a8a")
sig = sign_oauth1.0(myapp, token = "27d830afc9fc5d69ddeb5a8b3c98009015b5171e", token_secret = "27d830afc9fc5d69ddeb5a8b3c98009015b5171e")
homeTL = GET("https://api.github.com/users/jtleek/repos", sig)   ## This is the URL that corresponds to the API
## Because Twitter only accept JSON, so we should
## Converting the json object
json1 = content(homeTL)   ## This connect function will recognize json data
json2 = jsonlite::fromJSON(toJSON(json1))  ## use the jsonlite package to format it, convert back to json and use fromJSON to create a data frame
json2[1, 1:4] 



## Week 3: 
## Subsetting and Sorting Data in R
## Subsetting - quick review
set.seed(13435)
X = data.frame("var1"=sample(1:5), 'var2'=sample(6:10), 'var3'=sample(11:15))  ## craete three variables, quotes can be removed here if you like
# var1 var2 var3
# 1    2    8   15
# 2    3    7   12
# 3    5    6   14
# 4    1   10   11
# 5    4    9   13
X = X[sample(1:5),]   ## change the rows position in X data frame
#   var1 var2 var3
# 1    2    8   15
# 4    1   10   11
# 2    3    7   12
# 3    5    6   14
# 5    4    9   13
X$var2[c(1, 3)]
# [1] 8 7
X$var2[c(1, 3)] = NA
X
# var1 var2 var3
# 1    2   NA   15
# 4    1   10   11
# 2    3   NA   12
# 3    5    6   14
# 5    4    9   13
X[, 1]
X[, "var1"]   ## 2 1 3 5 4 the same result of x[, 1] or X[[1]] or X$var1
X[1:2, "var2"]   ## NA 10   subset both on rows and columns at the same time

## Logicals ands and ors
X[(X$var1 <= 3 & X$var3 > 11), ] ## Subset on rows with logical statements 'and' &
X[(X$var1 <= 3 | X$var3 > 15), ]  ## Subset on rows with logical statements 'or'
## Dealing with missing values
X[which(X$var2 > 8), ]   ## which will return indices where var2 is >8
X[which(is.na(X$var2)==FALSE ),]

## Sorting
sort(X$var1)
# [1] 1 2 3 4 5
sort(X$var1, decreasing = TRUE)
sort(X$var2, na.last = TRUE)  ## Put all missing values at the end of sorting

## Ordering
X[order(X$var1), ]  ## sort function does not work here, order function pass the order to the matrix and reorder the rows so that var1 in increasing order
# var1 var2 var3
# 4    1   10   11
# 1    2   NA   15
# 2    3   NA   12
# 5    4    9   13
# 3    5    6   14
X[order(X$var1, decreasing=TRUE), ]
## Ordering multiple variables
X[order(X$var1, X$var3),]   ## order var1 first and within one value in var1, order the values in var3

## Ordering with plyr
library(plyr)
arrange(X, var1)   ## x is a data frame
arrange(X, desc(var1))

## Adding Rows and Columns to Data Frames
X$var4 = rnorm(5)
X
# var1 var2 var3       var4 
# 1    2   NA   15  0.1875960 
# 4    1   10   11  1.7869764 
# 2    3   NA   12  0.4966936 
# 3    5    6   14  0.0631830
# 5    4    9   13 -0.5361329
Y = cbind(X, rnorm(5))  ## column bind a new vector to the right, order matters
Y
rbind()   ## used for adding rows


## Summarizing the Data

if (!file.exists("\\\\WIL-HOMEDRIVE01\\D17911$\\Desktop\\Courses\\R Programming\\Base Course\\restaurants.csv")){
    dir.create("\\\\WIL-HOMEDRIVE01\\D17911$\\Desktop\\Courses\\R Programming\\Base Course\\")
}

fileUrl = "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile = "\\\\WIL-HOMEDRIVE01\\D17911$\\Desktop\\Courses\\R Programming\\Base Course\\restaurants.csv") ## if we can change directory path
## Read Local Files
if (file.exists("restaurants.csv")){
    print("yes")
} else {
    print("no")
}

restData = read.csv(file="\\\\WIL-HOMEDRIVE01\\D17911$\\Desktop\\Courses\\R Programming\\Base Course\\restaurants.csv")

## Looking at a bit of the data
head(restData, n = 3)   ## default is 6 rows of the top pf data frames
tail(restData, n =3)
## Make Summary, for every single variable, it will give overall summary
summary(restData)
## for the text-based/factor variable, it will give you the count of each factors; For quantitative variables, it will tell you minimum, maximum, 1st/median/3rd quartile and mean.

## More in depth information, the str()
str(restData)

## Quantiles of quantitative variables
quantile(restData$councilDistrict, na.rm = TRUE)
# 0%  25%  50%  75% 100% 
# 1    2    9   11   14 
quantile(restData$councilDistrict, probs = c(0.5, 0.75, 0.9))
# 50% 75% 90% 
# 9  11  12

## Make frequency table or contingency tables
table(restData$zipCode, useNA = 'ifany')## the useNA command 'ifany' tells you the number of missing values in this variable
# -21226  21201  21202  21205  21206  21207  21208  21209  21210  21211  21212  21213  21214  21215  21216  21217  21218  21220  21222 
# 1    136    201     27     30      4      1      8     23     41     28     31     17     54     10     32     69      1      7 
# 21223  21224  21225  21226  21227  21229  21230  21231  21234  21237  21239  21251  21287 
# 56    199     19     18      4     13    156    127      7      1      3      2      1 
table(restData$councilDistrict, restData$zipCode)  ## Two dimensional tables

## Check for missing values, there is one zipcode is negative values
sum(is.na(restData$councilDistrict))  ## Answer 0, is.na() will return 1 if it is missing
any(is.na(restData$councilDistrict))  ## Answer FALSE, any() will look through the entire set of values, check if any of the value is TRUE
all(restData$zipCode > 0)    ## Answer FALSE, all() check if all values satisfy the condition

## Row and Column Sums
colSums(is.na(restData))
# name         zipCode    neighborhood councilDistrict  policeDistrict      Location.1 
# 0               0               0               0               0               0 
all(colSums(is.na(restData)) == 0 )   ## Answer is TRUE which means there is no missing value in the dataset
## Values with Specific Characteristics
table(restData$zipCode %in% c("21212"))  ## It also works by giving the equal equal sign
table(restData$zipCode == '21212')
# FALSE  TRUE 
# 1299    28
table(restData$zipCode %in% c("21212", "21213"))
# FALSE  TRUE 
# 1268    59 
## Subset rows with specific values
restData[restData$zipCode %in% c("21212", "21213"), ]

## Cross Tabs
data(UCBAdmissions)  ## load the data
DF = as.data.frame(UCBAdmissions)   ##Create a dataframe 
summary(DF)
xt = xtabs(Freq ~ Gender + Admit, data = DF)
xt   ## Contingency table which sum up the Freq values by gender and admit
## Freq is the variable that you want to be displayed actually in the table, and then break down by gender and admit

## Flat tables
warpbreaks$replicate = rep(1:9, len = 54)
xt = xtabs(breaks~., data=warpbreaks)   ## three dimensions table
xt
ftable(xt)
#              replicate  1  2  3  4  5  6  7  8  9
# wool tension                                     
# A    L                 26 30 54 25 70 52 51 26 67
#      M                 18 21 29 17 12 18 35 30 36
#      H                 36 21 24 18 10 43 28 15 26
# B    L                 27 14 29 19 29 31 41 20 44
#      M                 42 26 19 16 39 28 21 39 29
#      H                 20 21 24 17 13 15 15 16 28

## Size of a Data Set
fakeData = rnorm(1e3)
object.size(fakeData)
print(object.size(fakeData), units="Mb")   ## size in different scale

## Creating new Variables
## Why create new variables?
## 1. Often the raw data will not have a value that you are looking for.
## 2. You will need to transform the data to get the values you would like.
## 3. Usually you will add those values to the data frames you are working with
## 4. Common variables to create: Missingness Indicators; "Cutting up" Quantitative Variables; Applying Transforms.

## Creating Sequences: sometimes you need an index for your data set
s1 = seq(1, 10, by = 2)  ## seq(minimum, maximum, the gap)
s1   ## Answer 1 3 5 7 9
s2 = seq(1, 10, length = 3)   ## seq(min, max, the length of the vector)
s2  ## Answer 1.0 5.5 10.0
x = c(1, 3, 8, 25, 100)
seq(along = x)
## Answer is 1 2 3 4 5
seq_along(1:4) = seq_len(4)   ## Answer 1 2 3 4

## Subsetting Variables
restData$nearMe = restData$neighborhood %in% c("Roland Park", "Homeland")   ## A vector of FALSE and TRUE
table(restData$nearMe)

## Creating Binary Variables
restData$zipWrong = ifelse(restData$zipCode < 0, TRUE, FALSE)
table(restData$zipWrong, restData$zipCode < 0)
#        FALSE TRUE
# FALSE  1326    0
# TRUE      0    1

## Creating Categorical Variables out of Quantitative Variables
restData$zipGroups = cut(restData$zipCode, breaks = quantile(restData$zipCode))   ## It returns the factor variable zipGroups
table(restData$zipGroups)
# (-2.123e+04,2.12e+04]  (2.12e+04,2.122e+04] (2.122e+04,2.123e+04] (2.123e+04,2.129e+04] 
#          337                   375                   282                   332 
## 0th - 25th percentile, 25th - 50 percentile,50th - 75 percentile, 75th - 100% percentile
table(restData$zipCode, restData$zipGroups)
## Easier Way to Cutting
library(Hmisc)
restData$zipGroups = cut2(restData$zipCode, g = 4)  ## cut into four groups accourding to quantile
table(restData$zipGroups)
# [-21226,21205) [ 21205,21220) [ 21220,21227) [ 21227,21287] 
# 338            375            300            314 

## Creating Factor Variables
restData$zcf = factor(restData$zipCode)   ## zipcode variable was integer variable when loaded into R
restData$zcf[1:10]
class(restData$zcf)  ## factor

## Levels of Factor Variables
set.seed(13214)
yesno = sample(c("yes", "no"), size = 10, replace = TRUE)
# [1] "no"  "no"  "no"  "yes" "no"  "no"  "yes" "yes" "yes" "no" 
yesnofac = factor(yesno, levels = c("yes", "no"))   ## Treat the yes value as the lowest value and create them in this order
# [1] no  no  no  yes no  no  yes yes yes no 
# Levels: yes no
relevel(yesnofac, ref ="yes")
# [1] no  no  no  yes no  no  yes yes yes no 
# Levels: yes no
as.numeric(yesnofac)
# [1] 2 2 2 1 2 2 1 1 1 2
## Cutting Porduces Factor Variables
library(Hmisc)
restData$zipGroups = cut2(restData$zipCode, g = 4)
table(restData$zipGroups)

## Using the mutate function
library(Hmisc)
library(plyr)
restData2 = mutate(restData, zipGroups = cut2(zipCode, g = 4))
## In plyr package, you can create a new version of variable with mutate() functionadn simultaneously added a data set
## new dataframe=mutate(old data, new variable)
table(restData2$zipGroups)

## Common Transform
abs(x)   ## absolute value
sqrt(x)  ## square root
ceiling(x)   ## ceiling(3.475) is 4
floor(x)    ## floor(3.475) is 3
round(x, digits=n)  ##round(3.475, digits=2) is 3.48
signif(x, digits = n)  ## signif(3.475, digits = 2) is 3.5, significant digits
cos(x)
sin(x)
log(x)   ## natural logarithm
logx(2)  
log10(x) ## other common logs
exp(x) ## exponentiating x
## Notes and Further Reading for plyr package
# http://plyr.had.co.nz/09-user/
    

## Reshaping Data
## The goal is tidy data
## 1. Each variable forms a column
## 2. Each Observation forms a row
## 3. Each table/file stores data about one kind of observations

library(reshape2)
head(mtcars, n = 5)   ##mtcars has 32 records in total
## Melting Data Frames
mtcars$carname = rownames(mtcars)
carMelt = melt(mtcars, id = c("carname", "gear", "cyl"), measure.vars = c("mpg", "hp"))
## melt() that pass the dataframe, and put id variables and measure variables inside, melt the mpg and hp values into 'variable' column, one row for every mpg and one row for every hp
head(carMelt, n = 5)
#             carname gear cyl variable value
# 1         Mazda RX4    4   6      mpg  21.0
# 2     Mazda RX4 Wag    4   6      mpg  21.0
# 3        Datsun 710    4   4      mpg  22.8
tail(carMelt, n = 5)
#           carname gear cyl variable value
# 60   Lotus Europa    5   4       hp   113
# 61 Ford Pantera L    5   8       hp   264
# 62   Ferrari Dino    5   6       hp   175
# 63  Maserati Bora    5   8       hp   335
# 64     Volvo 142E    4   4       hp   109

## Casting Data Frames
## dcast() function will recast the data set into a particular shape(data frame)
cylData = dcast(carMelt, cyl ~ variable)   ## default is to calculate the frequency
cylData
# cyl mpg hp
# 1   4  11 11    for cylinder 4, we have 11 measures of mpg and 11 measures of hp
# 2   6   7  7
# 3   8  14 14
cylData = dcast(carMelt, cyl ~ variable, mean)   ## cyl into the rows and the 'variable' into the columns of the new data frame
cylData
# cyl      mpg        hp
# 1   4 26.66364  82.63636
# 2   6 19.74286 122.28571
# 3   8 15.10000 209.21429

## Average Values
head(InsectSprays)
#     count spray
# 1    10     A
# 2     7     A
# 3    20     A
# 4    14     A
# 5    14     A
# 6    12     A
tapply(InsectSprays$count, InsectSprays$spray, sum)
xtabs(count~spray,  InsectSprays)
lapply(split(InsectSprays$count, InsectSprays$spray), sum)
# spray
# A   B   C   D   E   F 
# 174 184  25  59  42 200 
## The above three statements give the same results if calculate the total, but different structure
## Another Way in detail - split
spIns = split(InsectSprays$count, InsectSprays$spray)
spIns  ## split the count into different categories
## Another way -  apply
sprCount = lapply(spIns, sum)
sprCount   ## the output of lapply is a list unlike the tapply()
# $A
# [1] 174
# 
# $B
# [1] 184
# 
# $C
# [1] 25
# 
# $D
# [1] 59
# 
# $E
# [1] 42
# 
# $F
# [1] 200
unlist(sprCount)   ## Another way - combine, use unlist() or sapply()
sapply(spIns, sum)
# A   B   C   D   E   F 
# 174 184  25  59  42 200 
## Anpther way - plyr package
library(plyr)
ddply(InsectSprays, .(spray), summarize, sum = sum(count))  ## .(spray) are the variables thwt like to summarize, have to use dot and (), summarize the variable by providing the sum(count)
ddply(InsectSprays, .(spray), summarize, mean=mean(count))
# spray      mean
# 1     A 14.500000
# 2     B 15.333333
# 3     C  2.083333
# 4     D  4.916667
# 5     E  3.500000
# 6     F 16.666667
## Creating a new variable, wehn you want to substract the mean by each observation
sprayMeans = ddply(InsectSprays, .(spray), summarize, mean = ave(count, FUN = mean))
dim(sprayMeans)
head(sprayMeans)
#    spray mean
# 1     A 14.5
# 2     A 14.5
# 3     A 14.5
# 4     A 14.5
# 5     A 14.5
# 6     A 14.5
spraySums = ddply(InsectSprays, .(spray), summarize, sum = ave(count, FUN = sum))   ## spraySums variable has the same length as the original data set
dim(spraySums)
head(spraySums)
## ave() function apply to the variable inside and has a subfunction
## More Information
## 1. A tutorial from the developer of plyr: http://plyr.had.co.nz/09-user/
## 2. A nice reshape tutorial http://www.slideshare.net/jeffreybreen/reshaping-data-in-r
## 3. A good plyr primer http://www.r-bloggers.com/a-quick-primer-on-split-apply-combine-problems/
## 4. See also the functions:  1. acast() -- for casting as multi-dimensional arrays.   2. arrange() -- for faster reordering without using order() commands.    3. mutate() -- adding new variables


## Managing Data Frames with dplyr package -- Introduction
## dplyr is specifically designed for data.frames, functions that frequently use: arrange(), filter(), select(), mutate(), rename()
## dplyr: The data frame is a key data structure in statistics and in R, basic assumptions for dplyr:
## 1. There is one observation per row
## 2. Each column represents a variable or measure or characteristic
## 3. Primary implementation that you will use is the default R implementation
## 4. Other implementations, particularly relational databases systems
## dplyr background
## 1. Developed by Hadley Wickham of RStudio
## 2. An optimized and distilled version of plyr package (also by Hadley)
## 3. Does not provide any 'new' functionality per se, but greatly simplifies existing functionality in R
## 4. Provides a "grammar" (in particular, verbs) for data manipulation
## 5. ls very fast, as many key operations are coded in C++

## dplyr Verbs
## select: return a subset of the columns of a data frame
## filter: extract a subset of rows from a data frame based on logical conditions
## arrange: reorder rows of a data frame and preserving the orders of the other columns
## rename: rename variables in a data frame
## mutate: add new variables/columns or transform existing variables
## summarize / summarise: generate summary statistics of different variables in the data frame, possibly within strata
## There is also a handy print method that prevents you from printing a lot of data to the console.

## dplyr Properties:
## 1. The first argument in the functions are alsways a data frame.
## 2. The subsequent arguments describe what to do with it, and you can refer to columns in the data frame directly without using the '$' operator (just use the names).
## 3. The result is a new data frame.
## 4. Data frames must be properly formatted and annotated for these functions to all be useful.

## Managing Data Frames with dplyr -- Basic Tools
library(dplyr)
options(width = 105)
setwd("\\\\WIL-HOMEDRIVE01\\D17911$\\Desktop\\Courses\\R Programming\\Base Course")
chicago = readRDS("chicago.rds")
head(chicago)
dim(chicago)
str(chicago)
names(chicago)
## select() can access the columns or set of columns by names instead of the indices
head(select(chicago, city:dptp))  ## select subset the columns
#    city tmpd   dptp
# 1 chic 31.5 31.500
# 2 chic 33.0 29.875
# 3 chic 33.0 27.375
# 4 chic 29.0 28.625
# 5 chic 32.0 28.875
# 6 chic 40.0 35.125
head(select(chicago, -(city:dptp)))

## if we do not want to use dplyr package to select columns we should first find the indices and then select
i = match("city", names(chicago))
j = match("dptp", names(chicago))
head(chicago[, -(i:j)])
#         date pm25tmean2 pm10tmean2 o3tmean2 no2tmean2
# 1 1987-01-01         NA   34.00000 4.250000  19.98810
# 2 1987-01-02         NA         NA 3.304348  23.19099
# 3 1987-01-03         NA   34.16667 3.333333  23.81548
# 4 1987-01-04         NA   47.00000 4.375000  30.43452
# 5 1987-01-05         NA         NA 4.750000  30.33333
# 6 1987-01-06         NA   48.00000 5.833333  25.77233

## Subset rows based on conditions use filter()
chic.f = filter(chicago, pm25tmean2 > 30)
head(chic.f, 10)
## if we do not use dplyr package:
head(chicago[which(chicago$pm25tmean2)>30, ])
## multiple conditions, arbitrarily complex logical sequence here and it will subset the rows
chic.f = filter(chicago, pm25tmean2 > 30 & tmpd > 80)
head(chic.f)

## arrange()
chicago = arrange(chicago, date)  ## This will give the oldest date at the top and latest at the bottom, lowest to highest is the default order
head(chicago)
tail(chicago)
chicago = arrange(chicago, desc(date))  ## descending the order use desc()
head(chicago)
tail(chicago)

## rename()
chicago = rename(chicago, pm25 = pm25tmean2, dewpoint = dptp)  ## rename() function new name = old name
names(chicago)
head(chicago)

## mutate(): transform existing variables or create new variables
chicago =  mutate(chicago, pm25detrend = pm25 - mean(pm25, na.rm = TRUE))  ## Creating a new variable pm25detrend
head(select(chicago, pm25, pm25detrend))
#       pm25 pm25detrend
# 1 15.00000   -1.230958
# 2 15.05714   -1.173815
# 3  7.45000   -8.780958
# 4 17.75000    1.519042
# 5 23.56000    7.329042
# 6  8.40000   -7.830958
## Split data frame according to certain categorical variables
chicago = mutate(chicago, tempcat = factor(1*(tmpd > 80), labels = c("cold", "hot")))
hotcold = group_by(chicago, tempcat)   ## use group_by function create a new kind of data structure
hotcold   ## This is a little different data structure

## summarize()
summarize(hotcold, pm25 = mean(pm25, na.rm = TRUE), o3 = max(o3tmean2), no2 = median(no2tmean2))  ## does not work, we can use ddply here
## This will give the mean pm25, max o3, etc by cold and hot temperature category
ddply(chicago, .(tempcat), summarize, pm25 = mean(pm25, na.rm = TRUE), O3 = max(o3tmean2), no2 = median(no2tmean2))
#   tempcat     pm25        O3      no2
# 1    cold 15.97807 66.587500 24.54924
# 2     hot 26.48118 62.969656 24.93870
# 3    <NA> 47.73750  9.416667 37.44444

## Categorize the dataset on other variables, eg: summary for each year in data set
chicago = mutate(chicago, year = as.POSIXlt(date)$year + 1900)
years = group_by(chicago, year)
summarize(years, pm25 = mean(pm25, na.rm = TRUE), o3 = max(o3tmean2), no2 = median(no2tmean2))
ddply(chicago, .(year), summarize, pm25 = mean(pm25, na.rm = TRUE), o3 = max(o3tmean2), no2 = median(no2tmean2))

## special operator in dplyr that allows chain different operations together: %symbol% -- pipeline operator
chicago %>% mutate(month = as.POSIXlt(date)$mon + 1) %>% group_by(month) %>% summarize(pm25 = mean(pm25, na.rm = TRUE), o3 = max(o3tmean2), no2 = median(no2tmean2))
## Idea: take a dataset, feed it through a pipeline of operations to create a new data set
## I do not have to specify the data frame as the first argument, it is implied by the pipeline operator
chicago %>% mutate(month = as.POSIXlt(date)$mon + 1) %>% ddply(.(month), summarize, pm25 = mean(pm25, na.rm = TRUE), o3 = max(o3tmean2), no2 = median(no2tmean2))

## Once you learn the dplyr "grammar" there are a few additional benefits:
## 1. dplyr can work with other data frame "backends"
## 2. data.table for large fast tables
## 3. SQL interface for relational databases via the DBI package


## Merging Data
## Peer review Experiment Data
setwd("\\\\WIL-HOMEDRIVE01\\D17911$\\Desktop\\Courses\\R Programming\\Base Course")
fileUrl1 = "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
fileUrl2 = "https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"
download.file(firlUrl1, destfile="\\\\WIL-HOMEDRIVE01\\D17911$\\Desktop\\Courses\\R Programming\\Base Course\\reviews.csv")
download.file(firlUrl2, destfile="\\\\WIL-HOMEDRIVE01\\D17911$\\Desktop\\Courses\\R Programming\\Base Course\\solutions.csv")
reviews = read.csv('reviews.csv')
solutions = read.csv("solutions.csv")
head(reviews, n = 2)
## datafields: id, solution_id, reviewer_id, start, stop, time_left, accept
head(solutions, n = 2)
## datafields: id, problem_id, subject_id, start, stop, time_left, answer
## The solution_id in reviews data set corresponds to the id in the solutions data set

## Merging data - merge()
## Merge data frames
## Important parameters: x, y, by, by.x, by.y, all     
## by tells which of the columns it should merge by, by default, it merges all the columns that have the common name
names(reviews)
names(solutions)
mergedData = merge(reviews, solutions, by.x = "solution_id", by.y = "id", all = TRUE)
## all = TRUE means that if a value appears in one but not in the other, it should include the row with NA values for the missing, so it is an full outer join 
head(mergedData)
## Default - merge all common column names
## default merge based on all common column names
intersetc(names(solutions), names(reviews))  ## give common column names
## 'id'  'start'  'stop'  'time_left'
mergedData2 = merge(reviews, solutions, all = TRUE)
head(mergedData2)

## Another way to join data sets
## Using join() in the plyr package, faster, but less full featured -- defaults to left join
## join() in plyr can only merge by the same name(common names), can not merge by such as id and solution_id
library(plyr)
df1 = data.frame(id = sample(1:10), x = rnorm(10))
df2 = data.frame(id = sample(1:10), y = rnorm(10))
arrange(join(df1, df2), id)
# Joining by: id
#    id          x          y
# 1   1 -0.6188683  0.4501309
# 2   2  0.5833093 -0.8315600
# 3   3 -1.0844435  0.1141769
# 4   4 -0.1987650 -0.1806877
# 5   5 -0.5369822 -0.7277643
# 6   6  0.4497471  0.7398591
# 7   7 -0.3706035 -1.8951754
# 8   8  2.2777608  0.5472666
# 9   9 -1.1812436 -0.6332283
# 10 10  1.2307293 -0.3619912

## If you have multiple data frames, good side of plyr join()
df1 = data.frame(id = sample(1:10), x = rnorm(10))
df2 = data.frame(id = sample(1:10), y = rnorm(10))
df3 = data.frame(id = sample(1:10), z = rnorm(10))
dfList = list(df1, df2, df3)
join_all(dfList)
# Joining by: id
# Joining by: id
#    id           x          y          z
# 1   6  0.62128873 -0.7127581  0.3532526
# 2   8  1.54184162 -0.4075420 -0.7920232
# 3   2 -0.02175809 -0.4489475 -0.3539658
# 4   9 -0.22073501  1.9501225 -1.0591694
# 5   7 -2.30375859  1.3929090  0.7572667
# 6   1 -0.56313818 -0.5159198 -0.6604881
# 7   5  1.05493522  0.2031248 -1.5333542
# 8  10 -0.75404028  0.2086597 -1.0618161
# 9   3 -0.46431846 -0.6125721 -0.6455162
# 10  4 -1.36648877 -1.2428836  0.1543638

## Exercise in Week 3
## 3.1
survey = read.csv("survey.csv")
library(dplyr)
agricultureLogical = (survey$ACR >=3 & survey$AGS == 6)
table(agricultureLogical)
head(survey[which(agricultureLogical == TRUE), ], n = 3)

## 3.2 
library(jpeg)
myUrl = 'https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg'
z = tempfile()
download.file(myUrl, z)
img = readJPEG(z, native = TRUE)
quantile(img, probs=c(0.3, 0.8))

## 3.3
fileUrl1 = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
fileUrl2 = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(firlUrl1, destfile="\\\\WIL-HOMEDRIVE01\\D17911$\\Desktop\\Courses\\R Programming\\Base Course\\gdp.csv")
download.file(firlUrl2, destfile="\\\\WIL-HOMEDRIVE01\\D17911$\\Desktop\\Courses\\R Programming\\Base Course\\country.csv")
gdp = read.csv("gdp.csv")
gdp[which(gdp$Code != '' & gdp$Ranking != ''), ]
country = read.csv("country.csv")
country[which(country$CountryCode != ''), ]
mergedData=merge(country, gdp, by.x='CountryCode', by.y = 'Code', all=FALSE)
nrow(mergedData)
mergedData = mergedData[which(mergedData$Ranking != ''), ]
nrow(mergedData)
head(mergedData);
mergedData = arrange(mergedData, desc(Ranking))
head(mergedData, n =13)
tail(mergedData, 1)
## 3.4 
mergedData2 = select(mergedData, Income.Group, Ranking )
mergedData3 = mutate(mergedData2, ranking = as.numeric(as.character(Ranking)))
tapply(mergedData3$ranking, mergedData3$Income.Group, mean)

## 3.5
library(plyr)
mergedData3 = mutate(mergedData3, rankgroup = cut2(mergedData3$ranking, g = 5))
table(mergedData3$Income.Group, mergedData3$rankgroup)


## Week 4
## Editing Text Variables

## Fixing character vectors - tolower(), toupper()
if (!file.exists("\\\\WIL-HOMEDRIVE01\\D17911$\\Desktop\\Courses\\R Programming\\Base Course\\camera.csv")){
    dir.create("\\\\WIL-HOMEDRIVE01\\D17911$\\Desktop\\Courses\\R Programming\\Base Course\\")
}
fileUrl = "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile="\\\\WIL-HOMEDRIVE01\\D17911$\\Desktop\\Courses\\R Programming\\Base Course\\camera.csv")
cameraData = read.csv("\\\\WIL-HOMEDRIVE01\\D17911$\\Desktop\\Courses\\R Programming\\Base Course\\camera.csv", sep = ',')
names(cameraData)
tolower(names(cameraData))   ## make all the letters to lower case

## Fixing character vectors - strsplit()
## Good for automatically splitting variable names
## Important parameters: x, split
splitNames = strsplit(names(cameraData), '\\.')
## strsplit split the string by period, and because period is a reserved character, so we need to use \\
splitNames[5] ## splitNames[[5]]
splitNames[6]  ## splitNames[[6]]  "Location" "1" 

## Quick aside - lists
mylist = list(letters = c('A', 'b', 'c'), numbers = 1:3, matrix(1:25, ncol = 5))
head(mylist)
mylist[1] ## substract the first element of the list
## $letters
## [1] "A" "b" "c"
mylist$letters
mylist[[1]]  ## [1] "A" "b" "c"

## Fixing character vectors - sapply()
## Applies a function to each element in a vector or list
## Important parametrs, X, FUN
splitNames[[6]][1]   ## "Location"
## splitNames is  a list of Variable Names
firstElement=  function(x){x[1]}
sapply(splitNames, firstElement)
# [1] "address"      "direction"    "street"       "crossStreet"  "intersection" "Location"     "X2010"        "X2010"        "Zip" 

## Peer review Data
fileUrl1 = "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
fileUrl2 = "https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"
download.file(firlUrl1, destfile="\\\\WIL-HOMEDRIVE01\\D17911$\\Desktop\\Courses\\R Programming\\Base Course\\reviews.csv")
download.file(firlUrl2, destfile="\\\\WIL-HOMEDRIVE01\\D17911$\\Desktop\\Courses\\R Programming\\Base Course\\solutions.csv")
reviews = read.csv('reviews.csv')
solutions = read.csv("solutions.csv")
head(reviews, n = 2)
## datafields: id, solution_id, reviewer_id,      start,       stop, time_left, accept
##              1            3           27  1304095698  1304095758       1754       1
##              2            4           22  1304095188  1304095206       2306       1
head(solutions, n = 2)
## datafields: id, problem_id, subject_id,       start,       stop, time_left,      answer
##              1         156           29  1304095119  1304095169       2343       B
##              2         260           25  1304095119  1304095183       2329       C
## Fixing character vectors - sub()
## Important parameters: pattern, replacement, x
names(reviews)
## datafields: id, solution_id, reviewer_id,      start,       stop, time_left, accept
sub("_", "", names(cameraData) )
## datafields: id, solutionid, reviewerid,      start,       stop, timeleft, accept
## Fixing character vectors - gsub()
testName = 'This_is_a_test'   
sub('_', '', testName)    ## "Thisis_a_test"
gsub('_','', testName)     ## [1] "Thisisatest"

## Seaching for specific values, the function return positions
## Finding values - grep(), grepl()
grep('Alameda', cameraData$intersection)  ## return position
##  [1] 65 69 79
table(grepl('Alameda', cameraData$intersection))  ## grepl() returns FALSE or TRUE
# FALSE  TRUE 
# 77     3 
cameraData2 = cameraData[!grepl('Alameda', cameraData$intersection), ]  ## Subset of those are not Alameda in intersection

## More on grep()
grep('Alameda', cameraData$intersection, value = TRUE)   ## returns the value contains Alameda
## [1] "E 33rd  & The Alameda"    "The Alameda  & 33rd St"   "Harford \n & The Alameda"
grep('JeffStreet', cameraData$intersection)
## integer(0), JeffStreet does not appear in intersection
length(grep('JeffStreet', cameraData$intersection))  ## can be used in if condition, if length is 0 then does not appear
## [1] 0    The length of does not appear is zero

## More useful string functions
library(stringr)
nchar('Huilin Lu')  # 9 Tells you the number of characters in your string containing the space
substr('Jeffrey Leek', 1, 7)   ## [1] "Jeffrey"
paste('Jeffrey', 'Leek')   ##  "Jeffrey Leek" has a space
paste0('Huilin', 'Lu')   ## [1] "HuilinLu"
paste('Huilin','Lu', sep='_')   ## [1] "Huilin_Lu"
str_trim('Jeff          ')   ## [1] "Jeff"


## Important points about text in data sets
## Names of variables should be:
## 1. All lower case when possible
## 2. Descriptive(Diagnosis versus Dx)
## 3. Not Duplicated
## 4. Not have underscores or dots or white spaces
## Variables with Character values
## 1. Should usually be made into factor variables(dependes on application)
## 2. Should be descriptive(use TRUE/FALSE instead of 0/1 and Male/Female versus 0/1 or M/F).


## Regular Expressions I
## Regular Expressions can be thought of as a combination of literals and metacharacters.
## To draw an analogy with natural language, think of literal text forming the words of this language, and the metacharacters defining its grammer
## Regular expressions have a rich set of metacharacters
## Simplest pattern consists only of literals; a match occurs if the sequence of literals occurs anywhere in the text being tested.
## What if we only wnat the word 'Obama'? or sentences that end in the word 'Clinton' or 'clinton' or 'clinto'?
## We need a way to express: 1. Whitespace word boundaries; 2. Sets of literals; 3. The beginning and end of a line; 4. alternatives('war' or 'peace') Metacharacters to the rescue!

## Metacharacters: 1.some metacharacters represents the start of a line
'^i think'
will match the lines
'i think we all rule for participating'
'i think i have been outed'
## 2. $ represents the end of a line
'morning$'
will match the lines
'well they had something this morning'
'then had to catch a tram home in the morning'
## 3. Character Classes with [] :
## We can list a set of characters we will accept at a given point in th ematch 
'[Bb][Uu][Ss][Hh]'   ## Match lowercase or uppercase at any possible letter
will match the lines
"The democrates are playing, 'Name the worst thing about Bush!'"
'I smelled the desert creosote bush, brownies, BBQ chicken'
'^[Ii] am'
will match
'i am so angry'
'I am so over this. I need food'
## Similarly, you can specify a range of letters [a-z] or [a-zA-Z]; ntice that the order does not matter
'^[0-9][a-zA-Z]'
will match the lines
'7th inning stretch'
'3am - cant sleep'
'1st sign of starvagtion'
## When used at the beginning of a character class, the "" is also a metacharacter and indicates matching characters NOT in the indicated class
'[^?.]$'  ## sencentence/strings that is not ending with '?' or '.'
will match the lines
'i like basketballs'
'dont worry... we all die anyway!'

## Regular Expression II
## More Metacharacters
## '.' is used to refer to any character, number will become characters. So
'9.11'
will match the lines
'its stupid the post 9-11 rules'
'Front Door 9:11:46 AM'

## More Metacharacters: |
## This does not mean 'pipe' in the context of regular expressions; instead it translates to 'or'; we can use it to combine two expressions, the subexpressions being called alternatives
'flood|fire'
will match the lines
'is firewirds like usb on none macs?'
'... and the floods, hurricanes, killer heatwaves, rednecks, gun nuts, etc.'
## We can include any number of alternatives
'flood|earthquake|hurricane|coldfire'
will match the lines
'Not a whole lot of hurricanes in the Arctic.'
'coldfire is a STRAIGHT!'
## The alternatives can be real expressions and not just literals
'^[Gg]ood|[Bb]ad'  ## beginning with [Gd]ood or any [Bb]ad in the sentences
will match the lines
'Good afternoon fellow american infields!'
'my middle name is trouble, Miss Bad News'                     
## More Metacharacters: ()
## Subexpressions are often contained in parentheses to constrain the alternatives
'^([Gg]ood|[Bb]ad'
will match the lines
'bad habbit'
'Good Monday Holiday'
'Badcop, its because people want to use drugs'

## More Metacharacters: ?
## The question mark indicates that the indicated expression is optional
'[Gg]eorge( [Ww]\.)? [Bb]ush'
will match the lines
'i bet i can spell better than you and george bush combined'
'BBC reported that President George W. Bush claimed God told him to invade I'
## We wanted to match a '.' as a literal period; to do that, we had to 'escape' the metacharacter, preceding it with a backslash. In general, we have to do this for any metacharacter we want to include in our match.

## More Metacharacters: '*' and '+'
## The * and + signs are metacharacters used to indicate repetition; * means "any number, including none, of the item" and + means "at least one of the item"
'(.*)'   ## match any repeated characters of any number of times
will match the lines
'anyone wanna chat? (24, m, germany)'



























## Tableau
trim(name, find(name, ' ')-1)   ## Give the first name -- Tableau
## Marks double clicks, measure values
index()   ## grab to the filter
## We can drag quick table calculation into measure fields and then create boolean indicators and then put in color marks to make plots






















