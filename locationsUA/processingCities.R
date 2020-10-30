# If you want to try this script you need to:
#   1) Have file 'ua-list.csv' in same directory as this script
#   2) Uncomment lines 8 and 9 (path...; setwd...)
#   3) Specify path to this script in line 8 after left-arrow.
#      You should use slashes and should not erase quotes.
#   4) Run all this script in R or RStudio

#path <- "D:/path/to/directory/with/this/script"
#setwd(path)

library(stringr)

# Read data and delete extra columns
ua_cities <- read.csv2("ua-list.csv", sep=";", header=FALSE)
ua_cities <- ua_cities[,-(4:5)]

# Remove empty cities
cities <- ua_cities[ua_cities[,3]!='',]
# Convert to character for compatibility in future
cities[,3] <- as.character(cities[,3])

rm(ua_cities)

# Create regular expressions for that cases, where not more than two words
# and so city names can not have conjunction like "на", "у" ...
# In this cases we can use function str_to_title from stringr
one.word.regexp <- "^[АБВГҐДЕЄЖЗИІЇЙКЛМНОПРСТУФХЦЧШЩЬЮЯ']+$"
two.word.spc.regex <- "^[АБВГҐДЕЄЖЗИІЇЙКЛМНОПРСТУФХЦЧШЩЬЮЯ']+ [АБВГҐДЕЄЖЗИІЇЙКЛМНОПРСТУФХЦЧШЩЬЮЯ']+$"
two.word.hyphen.regex <- "^[АБВГҐДЕЄЖЗИІЇЙКЛМНОПРСТУФХЦЧШЩЬЮЯ']+-[АБВГҐДЕЄЖЗИІЇЙКЛМНОПРСТУФХЦЧШЩЬЮЯ']+$"

# Get fields for this cases
one.word.cities <- which(grepl(one.word.regexp, cities[,3]))
two.word.spc.cities <- which(grepl(two.word.spc.regex, cities[,3]))
two.word.hyphen.cities <- which(grepl(two.word.hyphen.regex, cities[,3]))

rm(one.word.regexp, two.word.spc.regex, two.word.hyphen.regex)

# Get indeces, which are not recognized with patterns
out.of.patterns.indeces <- -c(one.word.cities, two.word.spc.cities, two.word.hyphen.cities)
out.of.patterns <- cities[out.of.patterns.indeces,3]
out.of.patterns
# As we can see there are only 9 such cases 
# so we can change them by hands

# Do so. Also writing corrects into our cities data.frame
out.of.patterns.new <- c("Гаї-за-Рудою", "Слобода-Дашковецька", "Нова Калуга Друга", "Микільське-на-Дніпрі", "Василівка-на-Дніпрі", "Верхній Токмак Другий", "Верхній Токмак Перший", "Олександро-Степанівка", "Сакко і Ванцетті")
out.of.patterns.new
cities[out.of.patterns.indeces,3] <- out.of.patterns.new

# Get indeces for pattern fitted fields
pattern.indeces <- -out.of.patterns.indeces

rm(one.word.cities, two.word.spc.cities, two.word.hyphen.cities,
   out.of.patterns.indeces, out.of.patterns, out.of.patterns.new)

# Get capitalized
capitilized.cities <- str_to_title(cities[pattern.indeces, 3])
# Check if they are correctly converted
head(capitilized.cities)
tail(capitilized.cities)
# Looks correct so now write it into cities data.frame
cities[pattern.indeces,3] <- capitilized.cities

rm(pattern.indeces, capitilized.cities)

# Now I may create two lists:
# First will contain sets of districts corresponding to each region.
# Names of regions will be names for first list.
# Second list will contain sets of cities corresponding to each district.
# Names of districts will be names for second list.
# 
# This function will be used to lapply through regions
get.districts.for.region <- function(region){
    as.character(sort(unique(cities[cities[,1]==region,2])))
}
#
# This function will be used to lapply through districts
get.cities.for.district <- function(district){
    as.character(sort(unique(cities[cities[,2]==district,3])))
}
# Create sorted sets of regions and districts
regions <- as.character(sort(unique(cities[,1])))
districts <- as.character(sort(unique(cities[,2])))

# Creating first list
regions.lst <- lapply(regions, get.districts.for.region)
names(regions.lst) <- regions
# Creating second list
districts.lst <- lapply(districts, get.cities.for.district)
names(districts.lst) <- districts

rm(get.districts.for.region, get.cities.for.district,
   districts, regions)


# Last step - generating .js script with these two 
# lists (associative-arrays) to use from JS.

# This function just add quotes to set of words and returns set
# of words with quotes
add.quotes <- function(words){
    paste0('"', words, '"')
}

# This one create text for JS array with strings, represented as
# character vector words
crt.js.array <- function(words){
    paste0(
        "[",
        paste0(add.quotes(words), collapse = ", "),
        "]"
    )
}

# This one pretty complex to describe. It will return text for
# js array of length 2, where first element is key (region or 
# district) and second element is array of appropriate elements
# (districts or cities). Parameter key - is just name of region
# or district and lst is appropriate list of districts or cities.
crt.js.key.value.array <- function(key, lst){
    paste0("[",add.quotes(key),", ",crt.js.array(lst[[key]]),"]")
}

# And this one is last. It will create JS associated array from
# lst parameter (must has names). It gives variable name as given 
# parameter varname for this associated array in .js script. 
crt.js.assoc.array <- function(lst, varname, vartype='const'){
    sp = " "
    nl = "\n"
    
    paste0(
        vartype, sp, varname, sp, "=", sp, "new Map([", nl,
        paste0(lapply(names(lst), 
                      function(name) crt.js.key.value.array(name,lst)),
               collapse = ",\n"), nl,
        "]);"
    )
}

# And now create script
script <- paste(
    crt.js.assoc.array(regions.lst, "regions"),
    crt.js.assoc.array(districts.lst, "districts"),
    sep="\n\n")

# Very last thing - create a .js file with this script
write(script, "regionsDistrictsCities.js")

rm(cities,
   regions.lst, districts.lst,
   add.quotes, crt.js.array, crt.js.assoc.array,
   crt.js.key.value.array,
   script)
