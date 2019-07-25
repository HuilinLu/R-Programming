## Get Started and R Nuts and Bolts
## R is a dialect language of S
## Getting Help on R
library(datasets)
data(airquality)
cor(airquality)
## Smart Subject: R 3.0.2 lm() function on MAC OS X 10.9.1 -- seg fault on large data frame
## R-Help and R-Devel mailing list
## r-help@r-project.org


## R Consule Input and Evaluation
## '<-' assignment operator 
x<-1
print(x)
x
msg<- "hello"
x <- ## Incomplete expression
    
    
## Evaluation
x <- 5  ## nothing printed
x  ## auto-printing occurs
print(x)  ## explicit printing

## Printing a Sequence
x <- 1:20 ## The : operator is used to create integer sequences
x


## Data Types - R Objects and Attributes
## R has five basic classes of objects:
## Character
## Numeric
## integer
## Complex
## Logical (True/False)
## Most basic object is a vector, a vector can only contain objects of the same class
## One exception is a "list", which is represented as a vector but can contain objects of different classes
vector() 
## vector(object, lengths)  c() works as well


## Numbers
## Double Precision Real Numbers
1     ## Number
1L    ## Integer

## Inf which represents infinity
1/0 == Inf
1/Inf == 0
structure(list(a = 1, b = structure(1L, .Label = "a", class = "factor")), .Names = c("a", "b"), row.names = c(NA, -1L), class = "data.frame")
NaN  ## Undefined Value, not a number
## 0/0 == NaN  ## missing value


## Attributes
## Attributes is a part of object in R
## R objects can have attributes: names, dimnames, dimensions(eg: matrices, arrays), class, length, other user-defined attributes/metadata
attributes()
attributes(object)



## Data Types - Vectors and Lists
## Creating Vectors
## c()  concatenate things together
x=c(0.5, 0.6)  ## numeric
x=c(TRUE, FALSE)  ##logical

x=c("a", "b", "c")  ## character
x=9:29  ## INTEGER
x=c(1+0i, 2+4i)  ## complex

x
x  ## a list of 0s

## Coercion
## Mixing objects in a vector, coercion occurs so that every element in the vector is of the same class
y=c(1.7, "a") ## character
y=c(TRUE, 2)  ## numeric
y=c("a", TRUE) ## character

## Explicit Coercion
## Objects can be explicitly corced from one class to another using the as.* functions.
x=0:6
class(x)  ## Answer:integer
as.numeric(x) ## Answer: 0 1 2 3 4 5 6 
as.logical(x)  ## Answer: FALSE TRUE TRUE TRUE TRUE TRUE TRUE
as.character(x)  ## Answer: "0" "1" "2" "3" "4" "5" "6"
## Coercion does not always work
## Not working examples
x=c("a", "b", "c")
as.numeric(x) ## Answer: Warning message NA NA NA
as.logical(x) ## Answer: Warning message NA NA NA
as.complex(x)

## Lists
## Lists can contain elements of different classes
x=list(1, "a", TRUE, 1+4i)
x


## Data Types - Matrices
## Matrices are vectors with a dimension attribute, the dimension attribute itself an interger vector of length 2 (nrow, ncol)
m=matrix(nrow=2, ncol=3)
m
dim(m)  ## Answer: 2 3
attributes(m) ## Answer: $dim [1] 2 3

# Matrices are constructed column-wise, so entries can be thought of starting in the upper left corner and running down the columns
m=matrix(1:6, nrow=2, ncol=3)  ## Number is inserted by columns 
m
m=1:10
dim(m)=c(2,5)  ##Assigning a value to the dim(m)
m

## Cbind-ing and Rbind-ing
x=1:3  ## Get a 3*1 vector
y=10:12  ## Get a 3*1 vector
cbind(x, y)  ## Get a 3*2 matrix
rbind(x, y)  #Get a 2*3 matrix


## Data Types - Factors
## Factors are used to represent categorical data. Factors can be unordered or ordered. One can think of a factor as an integer vector where each interger has a label.
## Factors are treated specially by modelling functions like lm() and glm()
## Using factors with labels is bettern than using intergers because factors are self-describing.
x=factor(c("yes", "yes", "no", "yes", "no"))  # Input is a character vector
x
## Answer: [1] yes yes no  yes no Levels: no yes
table(x)  ## The frequency count of each level 
unclass(x)  ## Unclass function strips out the class for a vector, answer: integer outcome

## The order of the levels can be set using the levels argument to factor(). This is quite important in linear modeling because the first level is used as the baseline level.
x=factor(c("yes", "yes", "no", "yes", "no"), levels=c("yes", "no"))  ## Baseline level is "yes" instead of "no"
x
##Answer: [1] yes yes no  yes no  Levels: yes no


## Data Types - Missing Values
## Missing values are denoted by (NA for anything else) or (NaN for undefined mathematical operations)
## is.na() is used to test object if they are NA
## is.nan() is used to test object if they are NaN

## NA values have a class, there are integer NA, character NA
## NaN values is also NA, but the converse is not true
x=c(1, 2, NA, 10, 3)
is.na(x)  ## Answer: FALSE FALSE  TRUE FALSE FALSE
is.nan(x)  ## Answer: FALSE FALSE  FALSE FALSE FALSE
x=c(1, 2, NaN, NA, 3)
is.na(x)  ## Answer: FALSE FALSE  TRUE TRUE FALSE
is.nan(x)  ## Answer: FALSE FALSE TRUE FALSE FALSE


## Data Types - Data Frames
## Data frames are used to store tablar data
## Data Frmaes are represented as a special type of list where every element of the list has to have the same length
## Each element of the list can be thought as a column and the length of each element of the list is the number of rows
## Unlike matrices, data frames can store different classes of objects in each element/column, matrices must have every element be the same class
## Data frames also have a special attribute called "row.names"
## Data Frames are usually created by calling read.csv() or read.table()
## Can be converted to a matrix by calling data.matrix(), coercion problem
x=data.frame(foo = 1:4, bar = c(T, T, F, F))
x
nrow(x)
ncol(x)


## Data Types -  Names Attribute
## R Objects can also have names, which is very useful for writing readable code and self-describing objects.
x=1:3
names(x)
names(x)=c("foo", "bar", "norf")
x
names(x)

## Lists can also have names
x=list(a=1, b=2, c=3)

## Matrices Names
m=matrix(1:4, nrow=2, ncol=2)
dimnames(m)=list(c("a", "b"), c("c", "d"))  ## rownames and then colnames
m
##   c d
## a 1 3
## b 2 4



## Reading and Writing Tabular Data in R

## Reading Data
## read.table, read.csv, for reading tabular data and return data frame
## readLines, for reading lines of a text file
## source, for reading in R code files (inverse of dump)
## dget, for reading in R code files (inverse of dput) that R objects have been deparsed into text files
## load, for reading in saved workspaces-- Binary objects into R
## unserialize, for reading single R objects in binary form -- Binary objects into R

## Writing Data
## write.table
## writeLines
## dump
## dput
## save 
## serialize

## Reading Data Files with read.table
## file, the name of a file or a connection
## header, logical indicating if the file has a header line
## sep, a string indicating how the columns are separated, can be comme, space,semicolon
## colClasses, a character vector indicating the class of each column in the dataset, whose length is the equal to the number of columns
## nrows, the number of rows in the dataset
## comment.char, a character string indicating the comment character, we can specify a character, the lines that begin with that comment character will be ignored. Set comment.char="" if there are no commented lines in your file
## skip, the number of lines to skip from the beginning
## stringsAsFacors, should character variables be encoded as factors? the Default for this argument is TRUE

## Note: for samll to moderately sized datasets, you can usually call read.table without specifying any other argument
## read.table("foo.txt")
## read.csv is identical to read.table except that the default separator is a coma

## Reading in Larger Datasets with read.table

## Use the colClasses argument which make read table run much faster. For example:
initial = read.table("datatable.txt", nrows=100)
classes = sapply(initial, class)
tabAll = read.table("datatable.txt", colClasses = classes)
## Set nrows. This doesn't make R run faster but it helps with memory usage. A mild overestimtae is okay. We can use the Unix tool wc to calculate the number of lines.


## Textual Formats dput() dump()
## dumping and dputing are usuful bc the reulting textual format is editable, and in the case of corrpution, potentially recoberable.
## Unlike writing out a table or csv file, dump and dput preserve the metadata (sacrificing some readability), so that another user does not have to specify it all over again
## Textual formats can work much better with version control programs like subversion or git(much useful for textual data instead of binary data) which can only track changes meaningfully between text files.
## Textual formats can be longer-lived; if there is corruption somewhere in the file, it can be easier to fix the problem
## Textual formats adhere to the "Unix philosophy"
## Downside: The format is not very space-efficient

## dput function takes an arbitrary R object and create some R code that will reconstruct the object in R
y = data.frame(a = 1, b = "a")
dput(y)
dput(y, file = "y.R")   ## save to a file and dput the file to a file, and then read into R using dget
new.y = dget("y.R")
new.y

## dump function is like dget, dget can only work on single R object and dump can be used on multiple R objects
## Multiple objects can be deparsed using the dump function and read back in using source
x = "foo"
y  = data.frame(a=1, b = "a")
dump(c("x", "y"), file="data.R") ## Store the R objects x and y
rm(x,y) ## remove x and y set 
source("data.R")  ## Pull the data set
y  ## It has been reconstructed
x


## Connections: Interfaces to the Outside World
## Data are read in using connection interfaces. Connections can be made to files (most common) or other more exotic things.
## file, opens a connection to a file
## gzfile, opens a connection to a file compressed with gzip
## bzfile, opens a connection to a file compressed with bzip2
## url, opens a connection to a webpage

str(file)
function(description = "file name", open="r/w/a/rb/wb/ab", blocking = TRUE, encoding=getOption("encoding"))
    
    ## description is the name of the file
    ## open is a code indicating: "r" read only; "w" writing (and initializing a new file); "a" appending; "rb", "wb", "ab" reading, writing, or appending in binary mode
    
    ## Connections
    con = file("foo.txt", "r")
data = read.csv(con)
close(con)
## is the same as
data = read.csv("foo.txt")

## Reading Lines of a Text File (Part of a File)
con = gzfile("words.gz")
x = readLines(con, 10)
## writeLines takes a character vector and writes each element one line at a time to a text file.
## readLines can be useful for reading in lines of webpages
con = url("http://www.jhsph.edu", "r")
x = readLines(con)
head(x)

## Subsetting  - Basics

## [ always returns an object of the same class as the original; can be used to select more than one element (there is one exception); subset a list, output is a list.
## [[ is used to extract elements of a list or a data frame; it can only be used to extract a single element and the class of the returned object will not necessarily be a list or data frame
## $ is used to extract elements of a list or data frame by name; semantics are similar to hat of [[

x=c("a", "b", "c", "c", "d", "a")
x[1]  ## extract a single element, single bracket
x[2]  ## the output is also a character element
x[1:4] ##use numeric index to subset 
x[x > "a"] ## Answer: "b" "c" "c" "d" lexicographical order of letter, use the logical index to subset 
u = x >"a"    ## Create a logical vector to subset 
u  ##Answer: FALSE TRUE TRUE TRUE TRUE FALSE
x[u] ##Use logical index to subset

## Subsetting -Lists : use double bracket [[ or dollar sign $
x = list(foo=1:4, bar=0.6)
x[1]  ## I got the list of sequence from 1 to 4 with name foo
x[[1]] ## Answer: 1 2 3 4   ## I got just the sequence
x$bar ##Give me the element that associate with name bar
x[["bar"]]  ## is the same as x$bar also the same as x[[2]]
x["bar"]  ## is the same as x[2]
## extract multiple elements of a list, you have to use the single bracket
x = list(foo=1:4, bar=0.6, baz="hello")
x[c(1,3)] ## When extract multiple elements, we can not use double bracket
## Nice things about [[ comapring with $
## The [[ can be used with computed indices; $ can only be used with literal names
x = list(foo = 1:4, bar = 0.6, baz = "hello")
names= "foo"
x[[names]]  ## computed index for 'foo'
x$names  ## element 'name' doesn't exist
x$foo
## Subsetting Nested Elements of a List
## The [[ can take an integer sequence
x = list(a = list(10, 12, 14), b = c(3.14, 2.81))
x[[c(1,3)]]  ## Answer 14
x[[1]][[3]]  ## Answer 14
x[[c(2,1)]]  ## Answer 3.14 very different from x[c(2,1)]


##Subsetting - Matrices
## Matrices can be subsetted in the usual way with (i,j) type indices
x=matrix(1:6, 2,3)
x[1,2]  ## Answer 3
x[2,1]  ## Answer 2
## Indices can also be missing
x[1,]  ##Answer 1 3 5 
x[,2]  ##Answe 3 4
## Remember that the single bracket subsetting only return an object of the same class
## By default, when a single element of a matrix is retrieved, it is returned as a vector of length 1 rather than a 1*1 matrix. This bahavior can be turned off by setting drop = FALSE
x=matrix(1:6, 2,3)
x[1,2]  ## Answer is a vector of length 1
x[1,2, drop=FALSE]  ## Answer is a 1*1 matrix 
## Similarly, subsetting a single column or a single row will give you a vector, not a matrix(by default)
x[1,]  ## Answer is a vector of 1 3 5
x[1, , drop = FALSE]  ## Answer is a 1*3  matrix

## Partial Matching 
## Partial matching of names is allowed with [[ and $
x= list(aardvark = 1:5)
x$a  ## Answer 1 2 3 4 5
x[["a"]]  ## Answer NULL
x[["a", exact=FALSE]]   ## Answer 1 2 3 4 5

## Subsetting  - Removing Missing Values
## A common task is to remove missing values (NAS)
x = c(1, 2, NA, 4, NA, 5)
bad= is.na(x)
x[!bad]  ## Answer 1 2 4 5
## What if there are multiple things and you want to take the subset with no missing values
x = c(1, 2, NA, 4, NA, 5)
y = c("a", "b", NA, "d", NA, "f")
good = complete.cases(x, y)  ## complete.cases function tells you which both are non missing, can work in matrix as well
good  ## Answer: TRUE TRUE FALSE TRUE FALSE TRUE
x[good]  ## Answer: 1 2 4 5 
y[good]  ## Answer: "a" "b" "d" "f"
## Thinking how to do that in matrix
## Removing missing values from data frames
airquality[1:6, ]
good=complete.cases(airquality)
airquality[good, ][1:6,]  ## Shows the first 6 rows which is true for complete.cases
airquality[good, ]


## Vecorized Operations
## When doing computation, things happen in parallel
## Many operations in R are vectorized making code more efficient, concise, and easier to rea
x=1:4 
y=6:9
x + y  ## Answer: 7 9 11 13  Add is add the first element of x and first element of y, and so on
x > 2  ##Answer: FALSE FALSE TRUE TRUE  > Compare all the numbers to 2
x >= 2  ## Answer: FALSE TRUE TRUE TRUE  >= tests for equality
y == 8  ## Answer: FALSE FALSE TRUE FALSE   ==
x * y  ## Answer: 6 14 24 36   *
x / y  ##Answer: 0.1666667  0.2857143  0.37500000 0.4444444

## Vectorized Matrix Operations
x = matrix(1:4, 2, 2)
y = matrix(rep(10, 4), 2, 2)
y = matrix(10, 2, 2)
x * y   ## element-wise multiplication
x / y
x %*% y  ## true matrix multiplication

## Swirl 
library("swirl")
swirl()
# | When you are at the R prompt (>):
#   | -- Typing skip() allows you to skip the current question.
# | -- Typing play() lets you experiment with R on your own; swirl will ignore what you do...
# | -- UNTIL you type nxt() which will regain swirl's attention.
# | -- Typing bye() causes swirl to exit. Your progress will be saved.
# | -- Typing main() returns you to swirl's main menu.
# | -- Typing info() displays these options again.
## https://github.com/swirldev/swirl_courses

### Week 2
## Control Structures
## Control Structures in R allow us to control the flow of excution of the program, depending on runtime conditions
## if, else: testing a condition
## for: execute a loop a fixed number of times
## while: execute a loop 'while' a condition is true
## repeat: execute an infinite loop
## break: break the execution of a loop
## next: skip an interation of a loop
## return: exit a function
## Most control structures are not used in interactive sessions, but rather when writing functions or longer expressions.

## Control Structures: if
if(<condition>) {
    ## do something
} else{
    ## do something else
}

if(<condition>){
    ## do something
} else if(<condition2>) {
    ## do something different
} else {
    ## do something different
}  ## else has to be the end
## example
if(x>3){
    y = 10
} else {
    y = 0
}
y =  if(x>3){
    10
} else {
    0
} ## y could equal to the entire else if statement
## Of course, the else clause is not necessary
if(<condition>) {
    
}
if(<condition2>) {
    
}



## Control Structures - For loops
## for loops take an interator variable and assign it successive values from a sequence or vector. For loops are most commonly used for iterating over the elements of an object(list, vector, etc)
for(i in 1:10) {
    print(i)
}
## This loop takes the i variable and in each iteration of the loop gives it values 1, 2, 3, ..., 10, and then exits.
## These three loops have the same behavior
x=c("a", "b", "c", "d")
for(i in 1:4){
    print(x[i])
}
for(i in seq_along(x)){
    print(x[i])
}  ## seq_along takes a vector as an input and creates an integer sequence
## seq_along(1:4) Answer: 1 2 3 4
## seq_along(4) Answer: 1
## seq_along(1:4) = seq_len(4)
for(letter in x) {
    print(letter)
}
for(i in 1:4)print(x[i])  ## if only single expression, then we can omit curly braces

## Nested for loops
## for loops can be nested
x=matrix(1:6, 2, 3)
for(i in seq_len(nrow(x))){
    for(j in seq_len(ncol(x))) {
        print(x[i, j])
    }
}
## seq_along(1:4) = seq_len(4)

## Control Structures - While loops  (while takes a logic expression)
## While loops begin by testing a condition. If it is true, then they execute the loop body. Once the loop body is executed, the condition is tested again and so forth.
count = 0
while(count< 10) {
    print(count)
    count = count + 1
}  ## the loop stops while count=10, now the count=10

## While loops can potentially result in infinite loops if not written properly
## Sometimes there will be more than one condition in the list
## Fibonacci Series
a=0
b=1
while(a<100) {
    c=a+b
    a=b
    b=c
    print(a)
}
z = 5
while(z >= 3 && z <= 10){
    print(z)
    coin = rbinom(1, 1,0.5)
    if(coin == 1) { ## random walk
        z = z+1
    } else{
        z = z-1
    }
}

while(a<100){
    print(a)
    c=a+b
    a=b 
    b=c
}
## Difficult to tell when while loop will stop because it contains random walk
## Conditions are always evaluated from left to right

## Control Structures - Repeat, Next, Break
## Repeat
## Repeat initiates an infinite loop; these are not commonly used in statistical applications but they do have their uses. 
## The only way to exit a repeat loop is to call break

x0 = 1
to1 = 1e-8
repeat {
    x1 = computeEstimate()
    if(abs(x1-x0) < to1){
        break
    } else {
        x0 = x1
    }
}
## computeEstimate() is not a real function
## The loop of repeat is a bit dangerous because there's no guarantee it will stop (the model might not converge). Better to set a hard limit on the number of iterations (e.g. using a for loop) and then  report whether convergence was achieved or not.

## Control Structure - Next, Return
## next is used to skip an interation of a loop
for(i in 1:100) {
    if(i <=20){
        ## Skip the first 20 iterations
        next  }
    print(i)
    ## Do something here. run iteration from 21 to 100
}
## return signals that a function should exit and return a given value

## Control Structures Summary
## Control structures like if, while, and for allow you to control flow of an R program
## Infinite loops should generally be avoided, even if they are theoretically correct.
## Control structures mentioned here are primarily useful for writing programs; for command-line interactive work, the *apply functions are more useful

## Your First R Function

add2 = function(x, y){
    x + y
}
add2(3, 5)

above10 = function(x){
    use = x > 10
    x[use]
}
## Let the user to specify the number
above  = function(x, n){
    use = x > n
    x[use]
}
x=1:20
above(x, 12)
## You can also set up a default argument, in case people forget to set the number n
above  = function(x, n = 10){
    use = x > n
    x[use]
}
above(x)

## Function to calculate the mean of each column of a dataframe or matrix, x is the dataframe or matrix
columnmean = function(x, removeNA = TRUE){
    nc = ncol(x)
    means = numeric(nc)  ## numeric vector with ncol of 0s initialized
    for(i in 1:nc){
        means[i] = mean(x[,i], na.rm = removeNA)
    }
    means
}
columnmean(airquality)
columnmean(airquality, FALSE)  ## thus NA comes back and can not calculate mean for columns which have NAs
## we can use the airquality dataset here and remove the NAs in this dataset

## Functions - Part 1: Write function, Lexical Scopings and Scoping rules in R, examples
## How to write functions in R
## Functions are created using the function() directive and are stored as R objects just like anything else. In particular, they are R objects of class "function"
f = function(<arguments>) {
    ## Don something interesting
}
f(<arguments>)  ## call this function
## Functions in R are "first class objects", which means that they can be treated mych like any other R object. Importantly:
## Functions can be passed as arguments to other functions
## Functions can be nested, so that you can define a function inside of another function. The return value of a function is the last expression in the function body to be evaluated.

## Function Arguments
## Functions have named arguments which potentially have default values.
## The formal arguments are the arguments included in the function definition
## The "formals" function returnss a list of all the formal arguments of a function
## Not every function call in R makes use of all the formal arguments, a function can have ten formal arguments, and you might only use a few, so function arguments can be missing or default values when thet are not specified by users
## Function arguments can be missing or might have default values

## Argument Matching
## R functions arguments can be matched positionally or by name. So the following calls to standard deviation are all equivalent
mydata = rnorm(100)
sd(mydata)  ## pass mydata to the default first argument in the function
sd(x = mydata)
sd(x = mydata, na.rm=FALSE)
sd(na.rm = FALSE, x = mydata)
sd(na.rm = FALSE, mydata)
## Even though it is legal, Don't recommend messing around with the order of the arguments too much, since it can lead to some confusion.

## You can mix positional matching with matching by name, When an argument is matched by name, it is "taken out" of the argument list and the remaining unnamed arguments are matched in the order that they are listed in the function definition.

args(lm)
## The foloowing two calls are equivalent
lm(data = mydata, y~x, model = FALSE, 1:100) ## data and model have been matched by name, and then left formula and subset in order to match
lm(y~x, mydata, 1:100, model = FALSE)  ## common use

## Advantage of matching arguments by name
## Most of the time, named arguments are useful on the command line when you have a long argument list and you want to use the defaults for everything except for an argument near the end of the list
## Named arguments also help if you can remember the name of the argument and not its position on the argument list (plotting is a good example).

## Function arguments can also be partially matched, which is useful for interactive work. The order of operations when given an argument is
## 1. Check for exact match for a named argument
## 2. if there is no exact match, Check for a partial match
## 3. Check for a positional match

## Functions - Part 2
## In addition to not specifying a default value, you can also set an argument value to NULL
f = function(a, b=1, c=2, d=NULL){
    
}
## Lazy Evaluation
## Arguments to functions are evaluated lazily, so they are evaluated only as needed. If the arguments are never used in function, it will not be evaluated
f = function(a, b) {
    a^2
}
f(2) ## Answer: 4, because b is not evaluated and it is the last arguments, also it does not default value, the function runs correctly
f(b=2)  ## Answer: Error, bc a is not specified
## This function never actually uses the argument b, so calling f(2) will not produce an error bc the 2 gets positionally matched to a

f= function(a, b){
    print(a)
    print(b)
}
f(45)
## Answer [1] 45
## Error: argument "b" is missing, with no default
## Notice that "45" got printed first before the error was triggered. This is because b did not have to be evaluated until after print(a). Once the function tried to evaluated print(b) it has to throw an error.

## The "..." Argument
## The ... argument indicate a variable number of arguments that are usually pased on to other functions
## ... is often used when extending another function and you don't want to copy the entire argument list of the original function
myplot = function(x, y, type="l", ...){
    plot(x, y, type= type, ...)
}
## Absorb all the other arguments in plot function, just want to change the default type
## Generic function use ... so that extra arguments can be passed to methods
mean
function (x, ...)
    UseMethod("mean") ## dispatch methods to put, according for different types of data
## The ... argument is also necessaey when the number of arguments passed to the function cannot be known in advance
args(paste)
## paste is a function has the below description
function(..., sep=" ", collapse = NULL)
    args(cat)
function(..., file="", sep = " ", fill = FALSE, labels = NULL, append = FALSE)
    ## One catch with ... is that any arguments that appear after ... on the argument list must be named explicitly and cannot be partially matched
    arg(paste)
paste("a", "b", sep=":") ## Answer: "a:b"
paste("a", "b", se=":")  ## Answer "a b :"  Partial matching was ignored
## If you do not specify the first argument after ..., R will be confused about whether it is an argument or just anouther thing to be concatenate


## Scoping Rules  - Symbol Binding
## A Diversion on Binding Values to Symbol
## How does R know which value to assign to which symbol?
lm = function(x) { x*x }
lm ## function(x) { x*x }
## How does R know what value to assign to the symbol lm? lm has a function in stats package and we assign a function with the same name "lm"
## Why doesn't it give the value of lm that is in the stats package?
## When R tries to bind a value to a symbol, it searched through a series of environments to find the appropriate value.
## Global environment is the workspace in R where we assigned objects...
## When you are working on the command line and need to retrieve the value of an R object, the order is roughly:
## Search the global environment for a symbol name matching the one requested
## 2. Search the namespaces of each of the packages on the search list
## Search list can be found by search()
search()
## The global environment or the user's workspace is always the first element of the search list and the base package is always the last
## The order of the packages on the search list matters!
## User's can configure which packages get loaded on startup so you cannot assume that there will be a set list of packages available.
## When a user loads a package with library the namespace of that package gets put in position 2 of the search list(by default) and everything else gets shifted down the list.
## Note that R has separate namespaces for functions and non-functions so it's possible to have an object named c and a function named c.

## The scoping rules for R are the main feature that make it different from the original S language.
## The scoping rules determine how a value is associated with a free variab,e in a function
## R uses lexical scoping or static scoping. A common alternative is dynamic scoping.
## Related o the scoping rules is how R uses the search list to bind a value to a symbol
## Lexical scoping turns out to be particularly useful for simplifying statistical computations.

## Lexical Scoping
f  = function(x, y) {
    x^2 + y/z
}
## This function has 2 formal arguments x and y. In the body of the function, there is another symbol z. In this case z is called a free variable.
## The scoping rules of a language determine how values are assigned to free variables. Free variables are not formal arguments and are not local variables (assigned insided the function body)
## Lexical Scoping in R means that
## the values of free variables are searched for in the environment in which the function was defined
## What is an environment?
## An environment is a collection of (symbol, value) pairs, i.e. x is a symbol and 3.14 might be its value
## Evry environment has a parent environment; It is possible for an environment to have multiple "children"
## The only environment without a parent is the empty environment
## A function + An environment = a closure or function closure
## Searching for the value for a free variable:
## If the value of a symbol is not found in the environment in which a function was defined, then the search is continued in the parent environment.
## The search continues down the sequence of parent environments until we hit the top-level environment; this usually the global environment(workspace) or the namespace of a package.
## After the top-level environment, the search continues down the search list until we hit the empty environment. If a valye for a given symbol can not be found once the empty environment is arrived at, then an error is thrown.


## WWhy does all this matter?
## Typically, a function is defined in the global environment, so that the values of free variables are just found in the user's Workspace
## This behavior is logical for most people and is usually the "right thing" to do
## However, in R you can have functions defined inside other functions, languages like C don't let you do this
## Now things get interesting - in this case the environment in which a function is defined is the body of another function!
make.power = function(n){
    pow = function(x) {
        x^n  ## n is a free variable in pow function and it was assigned in the parent envir
    }
    pow
}
cube = make.power(3) ## cube = x^3
square = make.power(2) ## square = x^2
cube(3)  ## Answer is 27
square(3) ## Answer is 9
## What's in a function's environment?
ls(environment(cube))  ## Answer: "n" "pow"
get("n", environment(cube))  ## Answer: 3
ls(environment(square))  ## Answer: "n" "pow"
get("n", environment(square))  ## Answer: 2

## Lexical vs. Dynamic Scoping  
## Example, we use lexical scoping in R
y = 10
f  = function(x) {
    y = 2
    y^2+g(x)  ## y and g are free variables here
}
g = function(x) {
    x*y
}
f(3)  ## Answer: 34, f function is called and defined in the same environment, the global environment
## With lexical scoping the value of y in the function g is looked up in the environment in which the function was defined, in this case the global environment, so the value of y is 10
## With dynamic scoping, the value of y is looked up in the environment from which the function was called (sometimes referred to as the calling environment)
#### In R the calling environment is known as the parent frame, so the value of y would be 2

## When a function is defined in the global environment and is subsquently called from the global environment, then the defining envir and the calling envir are the same. This can sometimes give appearance of dynamic scoping
g = function(x) {
    a = 3
    x+a+y
}
g(2)  ## Error
y = 3
g(2)  ## Answer is 8, it is a defining envir, though looks like calling envir

## Consequences of Lexical Scoping
## In R, all objects must be stored in memory
## All functions must carry a pointer to their respective defining envirnments, which could be anywhere
## In S-PLUS, free variables are always looked up in the global workspace, so everything can be stored on the disk because the "defining environment" of all functions is the same


## Application: Optimization
## Scoping Rules - Optimization Example
## Why is any of this information useful?
## Optimization routines in R like 'opti', 'nlm', and 'optimize' require you to pass a function whose argument is a vector of parameters (e.g. a log-likelihood)
## However, an object function might depend on a host of other things besides its parameters (like data)
## When writing software which does optimization, it may be desirable to allow the user to hold certain parameters fixed

## Maximizing a Normal Likelihood
make.NegLogLik = function(data, fixed=c(FALSE, FALSE)) {
    params = fixed
    function(p) {
        params[!fixed] = p
        mu = params[1]
        sigma = params[2]
        a = -0.5*length(data)*log(2*pi*sigma^2)
        b = -0.5*sum((data - mu)^2) / (sigma^2)
        -(a +b)
    }
}
## Note: Optimization functions in R minimize functions, so you need to use the negative log-likelihood
## Example
set.seed(1)
normals = rnorm(100, 1, 2)
nLL = make.NegLogLik(normals)
nLL
ls(environment(nLL))  ## Answer: "data"  "fixed"  "params"

## Estimating Parameters
optim(c(mu = 0, sigma = 1), nLL)$par
## got the answer for the optimal mu=1.22 sigma=1.79 and sigma, true mu=0 sigma=2
## Fixing sigma=2
nLL = make.NegLogLik(normals, c(FALSE, 2))
optimize(nLL, c(-1, 3))$minimum
## Get the optimal value of mu 1.22
## Fixing mu=1
nLL = make.NegLogLik(normals, c(1, FALSE))
optimize(nLL, c(1e-6, 10))$minimum
## Get the optimal value of sigma 1.8

## Plotting the Likelihood
nLL = make.NegLogLik(normals, c(1, FALSE))
x = seq(1.7, 1.9, len = 100)
y = sapply(x, nLL)
plot(x, exp(-(y-min(y))), type = 'l')

nll = make.NegLogLik(normals, c(FALSE,2))
x = seq( 1.5, 2.5, len = 100)
y = sapply(x, nLL)
plot(x, exp(-(y-min(y))), type = 'l')

## Lexical Scoping Summary
## Objective functions can be built which contain all of the necessaey data for evaluating the function
## No need to carry around long argument lists - useful for interactive and exploratory work
## Code can be simplified and cleaned up
## Reference: Robert Gentleman and Ross Ihaka(2000). "Lexical Scope and Statistical Computing"


## Coding Standards for R
## 1. Always use text files / text editor
## 2. Indent your code, ctrl+A, ctrl+I
## Indenting improves readability
## Fiing line length(80 columns) prevents lots of nesting and very long functions
## Suggested: Indents of 4 spaces at minimum; 8 spaces ideal
## 3. Limit the width of your code (80 columns?)
## 4. Limit the length of individaul functions: Debugging and readability

## Dates and Times in R
## R has developed a special representation of dates and times
## Dates are represented by the 'Date' class
## Times are represented by the 'POSIXct' or the 'POSIXlt' class
## Dates are stored internally as the number of days since 1970-01-01
## Times are stored internally as the number of seconds since 1970-01-01
## Dates are represented by the 'Date' class and can be coerced from a character string using the as.Date function
x = as.Date("1970-01-01")
x ## Answer: character string "1970-01-01", but actual is not a character string
unclass(x)
unclass(as.Date("1970-01-05"))  ## number of days after 1970-01-01

## Times are represented by the 'POSIXct' or the 'POSIXlt' class
## POSIXct is just a very large integer under the hood; it uses a useful class when you want to store times in something like a data frame
## POSIXlt is a list undermeath and it stores a bunch of other useful information like the day of the week, day of the year, day of the month
## There are a number of generic functions that work on dates and times
## 'weekdays()': give the day of the week
## 'months()': give the month name
## 'quarters()": give the quarter number ("Q1", "Q2", "Q3", or "Q4")
## When using the above functions, need to use as.Date to transfer the data to date format
## Times can be coerced from a character string using the as.POSIXlt or as.POSIXct function
x = Sys.time()
x
p = as.POSIXlt(x) ## which POSIXlt is a list
names(unclass(p))
p$sec
## You can also use the POSIXct format
x = Sys.time()
x  ## Already in 'POSIXct' format
unclass(x)  ## 1359083054****** a very large integer: number of seconds after 1970-01-01
x$sec  ## It will give us an error becase $ operator is invalid for atomic vectors
p = as.POSIXlt(x)
p$sec

## Finally, there is the 'strptime' function in case your dates are written in a different format
## 'strptime' will transfer written in character string format into date or time objects
datastring = c('January 10, 2012 10:40', "December 9, 2011 9:10")
x = strptime(datastring, "%B %d, %Y %H:%M")  ## %B means the month, %day is the day, %Y is the four-digit year, %H is the hour and %M is the minute
# "2012-01-10 10:40:00 EST" "2011-12-09 09:10:00 EST"
class(x)

## Operations on Dates and Times
## You can use mathematical operations on date and times. Well, really just + and -. You can do comparisons too (i.e. ==, <=)
x = as.Date("2012-01-01")
y = strptime("9 Jan 2011 11:34:21", "%d %B %Y %H:%M:%S")
x-y
# Error in x - y : non-numeric argument to binary operator
# In addition: Warning message:
#     Incompatible methods ("-.Date", "-.POSIXt") for "-"
## %Y %H %M %S must be upper cases
x = as.POSIXlt(x)
x-y
## Time difference of 356.3 days
## Even keeps track of leap years, leap seconds, daylight savings, and time zones
x = as.Date("2012-03-01")
y = as.Date("2012-02-28")
x-y
## Time difference of 2 days
x = as.POSIXct("2012-10-25 01:00:00")
y = as.POSIXct("2012-10-25 06:00:00", tz = "GMT")
y-x
## Time difference of 1 hours

## Summary
## Dates and times have special classes in R that allow for numerical and statistical calculations
## Dates use the Date class
## Times use the POSIXct and POSIXlt class
## Character strings can be coerced to Date/Time classes using the strptime function or the as.Date, as.POSIXlt, or as.POSIXct



## Week 3. Loop Functions

## 'apply' functions that allow you to execute loop-like behavior in a compact form
## Loop functions: lapply, apply, tapply, split, mapply, sapply
## traceback()
## Looping on the Command Line
## Writing for, while loops is useful when programming but not particularly easy when working interactively on the command line. There are some functions which implement looping to make life easier.
## lapply: (this one is important), Loop over a list of objects and evaluate a function on each element
## sapply: Same as lapply but try to simplify the result
## apply: Apply a function over the margins of an array, eg: make summaries of matrices or other higher dimensional arrays
## tapply: Apply a function over subsets of a vector, short for table apply
## mapply,: Multivariate version of lapply
## An auxiliary function 'split' is also useful, particularly in conjunction with 'lapply'

## lapply / sapply
## lapply takes three arguments: (1) a list x; (2) a function (or the name of a function) FUN; (3) other arguments via its ... argument. 
## If x is not a list, it will be coerced to a list using 'as.list'. If it can not be coerced to a list, we will get an error message.

lapply(list, function)
# function (X, FUN, ...) 
# {
#     FUN <- match.fun(FUN)
#     if (!is.vector(X) || is.object(X)) 
#         X <- as.list(X)
#     .Internal(lapply(X, FUN))
# }
## The actual looping is done internally in C code.
## lapply always return a list, regardless of the class of the input
x = list(a = 1:5, b = rnorm(10))  ## list can have different types of objects, unlike vectors
lapply(x, mean)
x = list(a = 1:4, b = rnorm(10), c = rnorm(20,1), d = rnorm(100, 5))
lapply(x, mean)
x = 1:4
lapply(x, runif)  ## Here we will generate four vectors of different numbers of random uniforms
## fourthe element's going to be a vector of four ramdom uniforms
x = 1:4
lapply(x, runif, min = 0, max = 10)
## default for uniform is min = 0 and max = 1

## lapply and friends(other functions) make heavy use of anonymous functions
x = list(a = matrix(1:4, 2, 2), b = matrix(1:6, 3, 2))
x
## An anonymous function for extracting the first column of each matrix
lapply(x, function(elt) elt[,1])
## after the lapply runs, the function inside goes away. Thus it is an anonymous function because it does not have a name

## Sapply
## 'sapply' will try to simplify the result of lapply if possible
## If the result is a list where every element is length 1, then a vector us returned
## If the result is a list where every element is a vector of the same length(>1), a matrix is returned
## If it can't figure things out, a list is returned
x = list(a = 1:4, b = rnorm(10), c = rnorm(20,1), d = rnorm(100, 5))
lapply(x, mean)
sapply(x, mean)
# a          b          c          d 
# 2.5000000 -0.2590489  0.8558368  4.9838204 
mean(x)
## Answer: NA and get a warning message, saying that argument is not numeric or logical

## Loop functions -- apply
## apply
## 'apply' is used to evaluate a function (often an anonymous one) over the margins of an array
## It is most often used to apply a function to the rows or columns of a matrix
## It can be used with general arrays, e.g. taking the average of an array of matrices
## It is not really faster than writing a loop, but it works in one line!
str(apply)
apply(array, margin, ...)
## function(x, MARGIN, FUN)
## x is an array, an array is a vector that has dimensions attached to it, a matrix is a two dimensional array
## MARGIN is an integer vector indicating which margins should be "retained".
## FUN is a function to be applied
## ... is for other arguments to be passed to FUN
x = matrix(rnorm(200), 20, 10)
apply(x, 2, mean)  ## Answer is 10 means of each columns of the matrix
## Preserve the columns and collapse all the rows
apply(x, 1, sum)  ## Answer is 20 sums of each rows of the matrix
## Preserve the rows and collapse the columns
## col/row sums and means
## For sums and means of matrix dimensions, we have some shortcuts
rowSums == apply(x, 1,sum)
rowMeans == apply(x, 1, mean)
colSums == apply(x, 2, sum)
colMeans == apply(x, 2, mean)
## The shortcut functions are much faster, but you won't notice unless you are using a large matrix
## Other ways to Apply
## Quantiles of the rows of a matrix
x = matrix(rnorm(200), 20, 10)
apply(x, 1, quantile, probs = c(0.25, 0.75)) ## Answer: it will create a matrix of a row 2 and column 20
## Average matrix in an array
a = array(rnorm(2*2*10), c(2, 2, 10))  ## Two by two matrices stacked together
apply(a, c(1,2), mean)  ## Take the average of those two by two matrices, and result will be a two*two matrix
## c(1,2) is to keep the first two dimensions and collapse the third dimension
rowMeans(a, dims = 2)


## Loop Functions - mapply
## 'mapply' is a multivariate apply of sorts which applied a function in parallel over a set of arguments.
mapply
str(mapply)
## function (FUN, ..., MoreArgs = NULL, SIMPLIFY = TRUE, USE.NAMES = TRUE)  
## FUN is a function to apply
## ... contains arguments to apply over
## MoreArgs is a list of other argumnets to FUN, the number of arguments hsould be at least to the number of arguments we put into
## SIMPLIFY indicates whether the result should be simplified
## mapply is what if you have two lists and that want to apply a function over
## The element of the first list go into one argument of the function, and the elements of the second list go into other argumnets of the function
## The following is tedious to type
list(rep(1, 4), rep(2, 3), rep(3, 2), rep(4, 1))
mapply(rep, 1:4, 4:1)  ##Equivalent to the above code

## Another exmaple: Instant Vectorization
noise = function(n, mean, sd){
    rnorm(n, mean, sd)
}
noise(5, 1, 2)  ## 5 random noises
## Here, we want to generate 1 random noise with mean 1, two random noises with mean 2, 3 random noises with mean 3, etc
noise(1:5, 1:5, 2)  ## Still give five number, does not work in the way we want
mapply(noise, 1:5, 1:5, 2)
## which is the same as
list(noise(1, 1, 2), noise(2, 2, 2), noise(3, 3, 2), noise(4, 4, 2), noise(5, 5, 2))

## Loop Functions - tapply
## 'tapply' is used to apply a function over subsets of a vector.
tapply
str(tapply)
## function (X, INDEX, FUN = NULL, ..., default = NA, simplify = TRUE)  
## X is a vector
## INDEX is a factor or a list of factors (or else they are coerced to factors), INDEX is a vector of the same length which identifies which group each element of the numeric vectors is in
## FUN is a function to be applied
## ... contains other arguments to be passed FUN
## simplify, should we simplify the result?
## Example, group means
x = c(rnorm(10), runif(10), rnorm(10, 1))
f = gl(3, 10)
f
# [1] 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 3 3 3 3 3 3 3 3 3 3
# Levels: 1 2 3
tapply(x, f, mean)
# 1          2          3 
# -0.5085727  0.5904789  0.4603263 
tapply(x, f, mean, simplify = FALSE)  ## If we do not simplify the result, we will get back a list
# $`1`
# [1] -0.5085727
# 
# $`2`
# [1] 0.5904789
# 
# $`3`
# [1] 0.4603263
tapply(x, f, range)

## Loop Functions - split
## 'split' takes a vector or other objects and splits it into groups determined by a factor or list of factors
split  ## which is not a loop function
str(split)
# function (x, f, drop = FALSE, ...) 
#     UseMethod("split")
## x is a vector(or list) or data frame
## f is a factor (or coerced to one) or a list of factors
## drop indicates whether empty factors levels should be dropped

x = c(rnorm(10),  runif(10), rnorm(10, 1))
f = gl(3, 10)
split(x, f)

## A common idiom is split followed by an lapply
lapply(split(x, f), mean)
## comparing with tapply(x, f, mean)
## split work on more complicated objects
## Split a dataframe
library(datasets)
head(airquality)
## now we want to calculate the mean of Ozone, Solar, Wind, Temp within each month
## split dataframe into monthly basis
s = split(airquality, airquality$Month)
lapply(s, function(x) colMeans(x[, c("Ozone", 'Solar.R', "Wind", "Temp")]))
## this will return NA values of means if there is a NA in the dataset within each month
sapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind", "Temp")]))
sapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Temp", "Wind")], na.rm=TRUE))

## Splitting on More than One Level
x=rnorm(10)
f1 = gl(2, 5)
f2 = gl(5, 2)
f1
f2
interaction(f1, f2)  ## Look at the Answer, interaction of each other wthin each level, in this 
# [1] 1.1 1.1 1.2 1.2 1.3 2.3 2.4 2.4 2.5 2.5
# Levels: 1.1 2.1 1.2 2.2 1.3 2.3 1.4 2.4 1.5 2.5
## Interactions can create empty levels
## Not necessary to use the interaction function here, call list function and it will automatically use interaction
str(split(x, list(f1, f2)))
List of 10
$ 1.1: num [1:2] 0.737 2.321
$ 2.1: num(0) 
$ 1.2: num [1:2] 0.349 -1.134
$ 2.2: num(0) 
$ 1.3: num 0.421
$ 2.3: num -0.925
$ 1.4: num(0) 
$ 2.4: num [1:2] -1.007 -0.189
$ 1.5: num(0) 
$ 2.5: num [1:2] 0.934 0.344

## Empty levels can be dropped
str(split(x, list(f1, f2), drop = TRUE))


## Debugging Tools -Diagnosing the Problem
## Debugging
## Something's Wrong
## Indications that something is not right
## message: A generic notification/diagnostic message produced by the 'message' function; execution of the function continues
## warning: An indication that something is wrong but not necessarily fatal; execution of the function continues; generated by the 'warning' function
## error: An indication that a fatal problem has occured; execution stops; produced by the 'stop' function
## condition: A generic concept for indicating that something unexpected can occur; programmers can create their own conditions

## Basic warning example
log(-1)
# Warning message:
#     In log(-1) : NaNs produced
printmessage = function(x) {
    if(x>0)
        print("x is greater than zero")
    else 
        print("x is less than or equal to zero")
    invisible(x)
}
## invisble() function prevents autoprinting
## call the function, the object will be returned but not autoprinting to the console, similar example is load()
## print() will return a string no matter what you put inside
printmessage(1)
printmessage(NA)
Error in if (x > 0) print("x is greater than zero") else print("x is less than or equal to zero") : 
    missing value where TRUE/FALSE needed
## NA comparison with number(1) is not defined
## Fix
printmessage2 = function(x) {
    if(is.na(x))
        print("x is a missing value!")
    else if(x>0)
        print("x is greater than zero")
    else 
        print("x is less than or equal to zero")
    invisible(x)
}
    printmessage3 = function(x) {
        if(x>0)
            print("x is greater than zero")
        else if(is.na(x))
            print("x is a missing value!")
        else 
            print("x is less than or equal to zero")
        invisible(x)
}

## comparing the if condition order here, R is strict with the if condition order
printmessage2(NA)
printmessage3(NA)
x=log(-1)
printmessage2(x)

## How do you know that something is wrong with your function?
## What was your input? How did you call the function?
## What were you expecting? Output, messages, other results?
## What did you get?
## How does what you get differ from what you were expecting?
##Were your expectations correct in the first place?
## Can you reproduce the problem (exactly)?
## by setting seed(set.seed), you can reproduce the problem and give the same random numbers

## Debugging Tools - Basix Tools
## The promary tools for debugging functions in R are
## 'traceback': prints out the function call stack after an error occurs; does nothing if there's no error
## 'debug': flags a function for "debug" mode which allows you to strp through execution of a function one line at a time
## 'browser': suspends the execution of a function wherever it is called and puts the function in debug mode
## 'trace': allows you to insert debugging code into a function a specific places
## 'recover': allows you to modify the error behavior so that you can browse the function call stack
## These are interactive tools specifically designed to allow you to pick through a function. There's also the more blunt technique of inserting print/cat statements in the function


## traceback example
mean(xx)  ## xx does not exist
## Answer: Error in mean(xx) : object 'xx' not found
traceback()  ## tells us where the error occurs
1: mean(xx)  ## tells me it occurs at the mean function
## Important: you have to call the traceback immediatetely after the error occurs

lm(y ~ x)
Error in x * x : non-numeric argument to binary operator
traceback()
1: lm(y ~ x)

## debug any function
## debug function does not work well in the static format
debug(lm)
lm(y ~ x)
# debugging in: lm(y ~ x)
# debug at #1: {
# x * x
# }
## we can debug a function no matter what we wrote or not
## debug a function and then call it, debug will give you a Browser promt and it is a work space
## you can hit n in the browser and it will take you to the next line

## recover
options(error = recover)  # set up a global option
read.csv("nosuchfile")
Error in file(file, "rt") : cannot open the connection
In addition: Warning message:
    In file(file, "rt") :
    cannot open file 'nosuchfile': No such file or directory

Enter a frame number, or 0 to exit   

1: read.csv("nosuchfile")
2: read.table(file = file, header = header, sep = sep, quote = quote, dec = dec, fill = fill, comment.char = comment.char, ...)
3: file(file, "rt")

## Summary
## There are three main indications of a problem/condition: message, warning, error  --  Only an error is fatal
## When analyzing  a function with a problem, make sure you can reproduce the problem, clearly state your expectations and how the output differs from your expectation
## Interactive debugging tools traceback, browser, debug, trace, recover can be used to find problematic code in functions
## Debugging tools are not a substitute for thinking!


## Week 4
## The str Function, structure
## 'str': Compactly display the internal structure of an R object
## A diagnostic function and an alternative to 'summary'
## It is especially well suited to compactly display the abbreviateed contents of possibly nested lists.
## Roughly one line per basic object
## str is used to answer the question: What is in this object?
str(str)
function (object, ...)  
str(ls)
function (name, pos = -1L, envir = as.environment(pos), all.names = FALSE, pattern, sorted = TRUE)  
## example
x = rnorm(100, 2, 4)
summary(x)
Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
-7.284  -1.387   2.129   1.708   4.584  10.273 
str(x)   ## It will give you the first five numbers
num [1:100] 6.26 4.12 2.41 7.35 2.35 ...
## create factor variable
f = gl(40, 10)
str(f)
# Factor w/ 40 levels "1","2","3","4",..: 1 1 1 1 1 1 1 1 1 1 ...
summary(f)
## str for data frame
library(datasets)
head(airquality)
str(airquality)

## str function for matrices
m = matrix(rnorm(100), 10, 10)
str(m)
m[,1]

## str function for list
s = split(airquality, airquality$Month)
str(s)  ## it will provide the list of each elements of this Month factor


## Simulation - Generating Random Numbers
## Functions for probability distributions in R
## 'rnorm': generate random Normal variates with a given mean and standard deviation
## 'dnorm': evaluate the Normal probability density (with a given mean/SD) at a point (or vector of points)
## 'pnorm': evaluate the cumulative distribution function for a Normal Distribution 
## 'rpois': generate random Posson variates with a given rate

## Probability distribution functions usually have four functions associated with them. The functions are prefixed with a
## 'd' for density
## 'r' for random number generation
## 'p' for cumulative distribution 
## 'q' for quantile function 

## Working with the Normal Distribution requires using these four functions
## default for mean and sd is standard normal distribution and log is default to FALSE unless you want to evaluate the log of the density
dnorm(x, mean = 0, sd = 1, log = FALSE)
pnorm(q, mean = 0, sd = 1, lower.tail = TRUE, log.p = FALSE)
qnorm(p, mean = 0, sd = 1, lower.tail = TRUE, log.p = FALSE)
## lower.tail is when we want to evaluate the lower tail of the distribution, lower tail is the plot goes to the left for noraml distribution, upper tail goes to right
rnorm(n, mean = 0, sd = 1)
## if Phi is the cumulative distribution function for a standard Normal distribution, then pnorm(q)=Phi(q), and qnorm(p)=inverse of Phi(p)

x = rnorm(10)   ## generate 10 random normal number
x = rnorm(10, 20, 2)  ## specify mean and sd

## any time when we simulate random numbers from any distribution, set random number generate seed
## Setting the random number seed with set.seed ensures reproducibility if you want to generate the same numbers every time set a seed
set.seed(1)
rnorm(5)
[1] -0.6264538  0.1836433 -0.8356286  1.5952808  0.3295078
rnorm(5)
[1] -0.8204684  0.4874291  0.7383247  0.5757814 -0.3053884
set.seed(1)
rnorm(5)
[1] -0.6264538  0.1836433 -0.8356286  1.5952808  0.3295078
## Always set the random number seed when conducting a simulation!

## Generating Poisson data
rpois(10, 1)  ## Generate 10 Poisson random variables with lambda = 1 which is the rate and is also the mean
rpois(10, 2)
[1] 4 1 2 0 1 1 0 1 4 1
rpois(10, 20)

ppois(2, 2)  ## Cumulative distribution: Pr(X <= 2), lambda = 2
[1] 0.6766764
ppois(4, 2)  ## Pr(x <= 4), lambda = 2
[1] 0.947347
ppois(6, 2)  ## Pr(x <= 6) lambda = 2
[1] 0.9954662


## Generating Random Numbers from a Linear Model
## Suppose we want to simulate from the foloowing linear model
## y = beta0 +beta1*x + epsilon
## where error term is Normal distribution(0, 4), Assume x is Guassian Distribution (0, 1), beta0 = 0.5 and beta1 = 2.
set.seed(20)
x=rnorm(100)
e = rnorm(100, 0, 2)
y = 0.5 +2*x +e
summary(y)
plot(x, y)

## What if x is binary?
set.seed(10)
x = rbinom(100, 1, 0.5)
e = rnorm(100, 0, 2)
y = 0.5 +2*x +e
summary(y)
plot(x, y)  ## x is binary and y is still continuous

## When we want to generate count variables (Generalized Linear Model) 
## Suppose we want to simulate from a Poisson model(Generalized Linear Model) where
## Y ~ Poisson(mu)
## log u = beta0 + beta1x
## and beta0 = 0.5 and beta1 = 0.3. We need to use the rpois function for this
set.seed(1)
x = rnorm(100)
log.mu = 0.5 +0.3*x
y = rpois(100, exp(log.mu))
summary(y)
plot(x, y)

## Simulation  - Random Sampling
## The sample function draws randomly from a specified set of (scalar) objects allowing you to sample from arbitrary distributions
set.seed(1)
sample(1:10, 4)  ## Without replacement which will give you no repeating numbers
[1] 3 4 5 7
sample(1:10, 4)
[1] 3 9 8 5
sample(letters, 5)
[1] "q" "b" "e" "x" "p"
sample(1:10)  ## permutation
sample(1:10)
## [1]  4  7 10  6  9  2  8  3  1  5
sample(1:10, replace = TRUE)  ## sample with replacement
# [1] 2 3 4 1 4 9 4 5 6 5

## Simulation 
## Summary
## Drawing samples from specific probability distributions can be done with r* functions
## Standard distributions are built in: Normal, Poisson, Binomial, Exponential, Gamma, etc
## The sample function can be used to draw random samples from arbitraty vectors
## Setting the random number generator seed via set.seed is critical for reproducibility


## R profile - Part 1
## Profiling R code
## Why is my code So SLOW?
## Profiling is a systematic way to examine how much time is spend in different parts of a prgram
## Useful when trying to optimize your code
## Often code runs fine once, but what if you have to put it in a loop for 1,000 iterations? Is it still fast enough?
## Profiling is better than guessing

## On Optimizing your Code
## because when you embed small piece of code and run it thousands of times, it will slow down your program
## Getting biggest impact on speeding up code dependes on knowing where the code spend most of its time
## This cannot be done without performances analysis or profiling
##

## General Principles of Optimization
## Design first, then optimize
## Remember: Premature optimization is the root of all evil
## Measure (collect data), don't guess
## If you are going to be scientist, you need to apply the same principles here!

## Profiling - Using system.time()
## Takes an arbitrary R expression as input(can be wrapped in curly braces) and returns the amount of time taken to evaluate the expression
## Computes the time(in seconds) needed to execute an expression
## If there is an error, gives time until the error occured
## Returns an object of class proc_time
## user time: time charged to the CPU(s) for this expression
## elapsed time: 'wall clock' time

## Usually, the user time and elapsed time are relatively close, for straight computing tasks
## Elapsed time may be greater than user time if the CPU spends a lot of time waiting around
## Elapsed time may be smaller than the user time if your machine has multiple cores/processors (and is capable of using them)
## Multi-threaded BLAS libraries (vecLib/Accelerate, ATLAS, ACML, MKL)
## Parallel processing via the 'parallel' package

## Elapsed time > user time
system.time(readLines("http://www.jhsph.edu"))

## Elapsed time < user time
hilbert = function(n){
    i = 1:n
    1/outer(i - 1, i, "+")
}
x = hilbert(1000)
## Outer function in r is an array operations, use ?outer
system.time(svd(x))  ## take singular value decomposition, svd use accelerate in Mac which is multi-threaded
## use curly braces to measure the spend time
system.time({
    n = 1000
    r = numeric(n)
    for(i in 1:n){
        x = rnorm(n)
        r[i] = mean(x)
    }
})

## Beyond system.time()
## Using system.time() allows you to test certain functions or code blocks to see if they are taking excessive amounts of time
## Assumes you already know where the problem is and can call system.time() on it
## What if you do not know where to start?
## When you do not knwo where to start, we have another functioner, use Rprof()

## R Profiler - Part 2
## The 'Rprof()' function starts the profiler in R
## R must be compiled with profiler support (but this is usually the case)
## The 'summaryRprof()' function summarizes the output from Rprof() (Otherwise it's not readable)
## DO NOT use system.time() and Rprof() together or you will be sad
## Rprof() keeps track of the function call stack at regularly sampled intervals and tabulates how much time is spend in each function
## Default sampling interval is 0.02 seconds, if it runs smaller than 0.02s, profiler is not useful because it will never sample the function call stack
## NOTE: If your code runs very quickly, the profile is not useful, but then you probably don't need it in that case

## lm(y ~ x)  ## call lm function
sample.interval = 10000
## lm will call eval, eval will call eval, eval will call model.frame, ..............................

## Using summaryRprof()
## The 'summaryRprof()' function tabulates the R profiler output and calculates how much time is spend in which function
## There are two methods for normalizing the data you get from the R Profiler
## 'by.total' divided the time spend in each function by the total run time
## 'by.self' does the same but first subtracts out time spent in functions above in the call stack
$by.self
$by.total

## summaryRprof()
 Output
 $sample.interval
 $sampling.time
 
## Summary
 ## Rprof() runs the profiler for performance of analysis of R code
 ## summaryRprof() summarize the output of Rrpof() and gives percent of time spent in each function (with two types of normalization)
 ## Good to break your code into functions so that the profiler can give useful information about where time is being spent
 ## C or Fortran code is not profiled






















































