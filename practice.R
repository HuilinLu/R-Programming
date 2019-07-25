duplicates:
    my_data %>% distinct(var1, var2, .keep_all = TRUE)
my_data %>% unique %>% print
my_data[!duplicated(my_data[c('var1', 'var2')]),]

group:
    tapply(data$var1, list(data$var1,data$var2), FUN)
my_data %>% group_by(var1, var2, var3) %>% summarize(var4 = mean(var3))
sort:
    arrange(my_data, var2, desc(var1), .keep_all = TRUE)
my_data[order(my_data$var1, decreasing = TRUE),]
my_data[order(my_data$var1, desc(my_data$var2)), ]
function:
    lapply(dataset, function(x) order(x, decreasing = TRUE)[2])
lapply(dataset[c('var1', 'var2')], FUN)
lapply(list(dataset$var1, dataset$var2), FUN)

dplyr::select  ## subset columns
select(my_data, var1, -var2, var3)
select(my_data, var1:var3)
my_data[c('var1', 'var2', 'var3')]

dplyr::filter
filter(my_data, var1 condition, var2 condition)
my_data[which(my_data$var==),]

dplyr::arrange
arrange(my_data, var1, desc(var2))
my_data[order(my_data$var1, desc(my_data$var2)),]

dpkyr:: mutate ## create new variable
mutate(my_data, new_var1 = FUN(), new_var2 = FUN(new_var1))

dplyr:: summarize
summarize(my_date, new_var=FUN())

dplyr:: group_by, n_distinct, n(), 
my_data2 <- group_by(my_data, var1)
summarize(my_data2, FUN, n(), n_distinct(var), mean())
quantile(my_data2$var, probs= )
filter -- arrange(desc)

dplyr:: chaining %>%
    cran %>%
    select(ip_id, country, package, size) %>%
    mutate(size_mb = size / 2^20) %>%
    filter(size_mb <= 0.5) %>%
    # Your call to arrange() goes here
    arrange(desc(size_mb)) %>%
    print

cran[!(cran %in% cran2)]
x=c(1,2,3,4)
y = c(1,2,3)
x[!(x %in% y)]


tidyr:: 
    The first problem is when you have column headers that are values, not variable names
gather(my_data, sex, count, -grade)
aa = gather(students, sex, count, -grade)
aa %>% group_by(sex, grade) %>% summarize(mean(count))
when multiple variables are stored in one column
data1 = gather(my_data, var1_var4, var2, -var3)
separate(data1, col=var1_var4, into=c('var1', 'var4'))

when variables are stored in both rows and columns
students3 %>%
    gather(class, grade, class1:class5, na.rm = TRUE) %>%
    spread( test, grade ) %>%
    mutate(class=parse_number(class))  %>%   ## readr library function
    print

name    test class1 class2 class3 class4 class5
1  Brian   final      B   <NA>   <NA>   <NA>      C
2  Brian midterm      B   <NA>   <NA>   <NA>      A
3   Jeff   final   <NA>      E   <NA>      C   <NA>
    4   Jeff midterm   <NA>      D   <NA>      A   <NA>
    5  Karen   final   <NA>   <NA>      C      A   <NA>
    6  Karen midterm   <NA>   <NA>      C      A   <NA>
    7  Roger   final   <NA>      A   <NA>   <NA>      A
8  Roger midterm   <NA>      C   <NA>   <NA>      B
9  Sally   final      C   <NA>      C   <NA>   <NA>
    10 Sally midterm      A   <NA>      B   <NA>   <NA>
    name  class final midterm
1  Brian class1     B       B
2  Brian class5     C       A
3   Jeff class2     E       D
4   Jeff class4     C       A
5  Karen class3     C       C
6  Karen class4     A       A
7  Roger class2     A       C
8  Roger class5     A       B
9  Sally class1     C       A
10 Sally class3     C       B

when multiple observational units are stored in the same table
use select() and unique to make separate tables

when a single observational unit is stored in multiple tables
mutate() and then bind_rows(passed, failed)

count=0
tot=0
for(i in 1:length(a)){
  count=count+1
  tot=tot+a[i]
 
}
 print(count)
  print(tot)

  
  
  
  
salary=c(2,4,5,1)
num=2
findsalary = function(salary,num){
  salary_order=salary[order(salary)]
  salary_order[num]
}

  
  
  
  
  
  
  
  
  
  
  
  
  
  
  


