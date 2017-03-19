
# R FOR DATA SCIENCE BOOK
# CHAPTER 1, 2 AND 3



# load libraries
# load tidyverse package to get ggplot2
# Check if tidyverse is installed
# install.packages("tidyverse")
# install.packages("xlsx")






library(tidyverse)
mpg
?mpg
ggplot(data=mpg) + 
  geom_point(mapping=aes(x = displ, y = hwy))

#exercises

ggplot(data=mpg)
mtcars
?mtcars
# 32 rows and 11 columns
?mpg
# drv describes wheteher the car is front, rear or all wheel drive
ggplot(data=mpg) +
  geom_point(mapping=aes(x = hwy, y = cyl))

ggplot(data=mpg) +
  geom_point(mapping=aes(x = class, y = drv))

# aesthetics - we can change the color, size and other attributes of the plot
ggplot(data=mpg) +
  geom_point(mapping=aes(x = displ, y = hwy, colour = class))
# this instruction does not work with american english (color)
ggplot(data=mpg) +
  geom_point(mapping=aes(x = displ, y = hwy, size = class, colour = class))

#top
ggplot(data=mpg) +
  geom_point(mapping=aes(x = displ, y = hwy, alpha = class))
#bottom
ggplot(data=mpg) + 
  geom_point(mapping=aes(x = displ, y = hwy, shape = class))

# changing the characteristics manually e.g. making the points blue
ggplot(data = mpg) +
  geom_point(mapping=aes(x = displ, y = hwy),color = "blue")

# Creating facets (subplots by splitting the variables)
ggplot(data=mpg) +
  geom_point(mapping=aes(x = displ, y = hwy), color = "red") +
  facet_wrap(~ class, nrow = 2)

ggplot(data=mpg) +
  geom_point(mapping=aes(x = displ, y = hwy), color = "blue") +
  facet_grid(drv ~ cyl)

# exercises

ggplot(data=mpg) +
  geom_point(mapping=aes(x = displ, y = hwy))+
  facet_wrap( ~ class, nrow = 2)

# Geometric Objects
# smooth geoms can also take linetypes
ggplot(data = mpg) +
  geom_smooth(mapping=aes(x = displ, y = hwy))
ggplot(data = mpg) +
  geom_smooth(mapping=aes(x = displ, y = hwy, linetype = drv))
# can even make more clear by coloring the data and overlaying the lines over the actual data
ggplot(data = mpg) +
  geom_smooth(mapping=aes(x = displ, y = hwy))
ggplot(data = mpg) +
  geom_smooth(mapping=aes(x = displ, y = hwy, group = drv))
ggplot(data = mpg) +
  geom_smooth(
    mapping=aes(x = displ, y = hwy, colour = drv),
    show.legend = FALSE
    )

# dISPLAYING MULTIPLE GEOMS ON GGPLOT

ggplot(data = mpg) +
  geom_point(mapping = aes(x= displ, y = hwy, color = drv))+
  geom_smooth(mapping = aes(x = displ, y = hwy, color = drv, linetype = drv))

#Using mappings to streamline code

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point() + 
  geom_smooth()
#or even further refine
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping=aes(colour = class)) + #, show.legend = FALSE) + 
  geom_smooth()
#with mappings can also select subsets of the data
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping=aes(colour = class)) + 
  geom_smooth(
    data = filter(mpg, class == "subcompact"),
    se = FALSE
  )


# Practice #
ggplot(data=mpg, mapping = aes(x = displ, y = hwy)) +
  geom_jitter(shape = 21, color = "grey", size= 3, fill="magenta", alpha = 1/2, height = .5, width = .5) +
  geom_smooth(data=subset(mpg, drv == "r"), color = "red")

ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = class)) + 
  geom_point() + 
  geom_smooth()

# EXERCISES

# These two will produce the same results - the mapping is more efficient in the first example though
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()
# second
ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))



# Recreating the code to create the graphs in the book
# 1
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
         geom_point() +
         geom_smooth(se = FALSE)
# 2
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth(mapping=aes(group=drv), se = FALSE) #ojo group no puede separarse con espacio
# 3
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, colour=drv)) +
  geom_point() +
  geom_smooth(se = FALSE)
# 4
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color=drv)) +
  geom_smooth(se = FALSE)
# 5
ggplot(data=mpg, mapping= aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color=drv))+
  geom_smooth(mapping = aes(linetype=drv), se = FALSE)
# 6
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color=drv)) +
  geom_point()

# STATISTICAL TRANSFORMATIONS
?diamonds

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut))
# it is the same as using the stat calculated by the function geom  - geom bar uses stat_count
ggplot(data = diamonds) + 
  stat_count(mapping = aes(x = cut))

demo <- tribble(
  ~a, ~b,
  "bar_1", 20,
  "bar_2", 30,
  "bar_3", 40
)
ggplot(data = demo) + 
  geom_bar( mapping = aes(x = a, y = b), stat="identity")

ggplot(data=diamonds) +
  geom_bar(mapping = aes(x = cut, y = ..prop.., group = 1)) 
# reason for group = 1  http://stackoverflow.com/questions/39878813/r-ggplot-geom-bar-meaning-of-aesgroup-1

ggplot(data = diamonds) +
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.ymin = min,
    fun.ymax = max,
    fun.y = median
  )
  

ggplot(data=mpg, mapping = aes(x = displ, y = hwy)) +
  geom_col() 
  geom_point(color = "blue", alpha = 0.25) 
  geom_smooth(color = "orange", se = FALSE)

r<- ggplot(mpg, aes(fl)) + geom_bar()
r + theme_light()

# we can control the color of the bars using color or fill
ggplot(data = diamonds) +
  geom_bar(mapping=aes(x = cut, fill = cut))

#these two charts end up being one on top of the other
ggplot(
  data = diamonds,
  mapping = aes(x = cut, fill = clarity)
) +
  geom_bar(alpha = 1/5, position = "identity")

ggplot(
  data = diamonds,
  mapping = aes(x = cut, color = clarity)
) +
  geom_bar(fill = NA, position = "identity")
#stacking

#position = "fill" stacks the bar while position = "dodge" creates bars side-by-side
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "fill")
ggplot(data=diamonds) +
  geom_bar(mapping=aes(x= cut, fill = clarity), position = "dodge")



## good charts - second one shows how to use SUBSETS of data!!
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(position = "jitter", shape = 21, fill = "magenta", size = 2, alpha = 1/3) +
  geom_smooth(color="blue")

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(position = "jitter", shape = 21, fill = "magenta", size = 2, alpha = 1/3) +
  geom_smooth(data = subset(mpg, drv == "r"), color="blue")
# position jitter has its own shorthand: geom_jitter()

# EXERCISES
# how I would improve it:
ggplot(data = mpg) + geom_point(mapping = aes(x = cty, y = hwy), position = "jitter")
# Option two, with color and using geom_jitter  
## GREAT CHART
ggplot(data = mpg) + 
  geom_jitter(mapping = aes(x = cty, y = hwy), shape = 21, fill = "magenta", alpha = 1/3)        
#geom_count() - instead of jitter, shows the density of overlapping points by counting them  
ggplot(data = mpg) + geom_count(mapping = aes(x = cty, y = hwy),shape = 21, fill = "magenta", alpha = 1/3)
# controlling jittering
ggplot(data = mpg) + 
  geom_jitter(mapping = aes(x = cty, y = hwy), shape = 21, fill = "magenta", alpha = 1/3, width=0.2, height=0.2)
# visualization using boxplot
ggplot(data = mpg) +
  geom_boxplot(mapping=aes(x = drv, y = hwy), fill="magenta", alpha = 1/4, colour = "darkblue")

# Coordinate Systems
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) +
  geom_boxplot() +
  coord_flip()

# Spatial data on ggplot THIS DOESN'T WORK WITHOUT PACKAGE "maps"
nz <- map_data("nz")
ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", color = "black")
#polar coordinates

bar <- ggplot(data = diamonds) +
  geom_bar(
    mapping = aes(x = cut, fill = cut),
    show.legend = FALSE,
    width = 1
  ) +
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL)

bar + coord_flip()
bar + coord_polar()

#EXERCISES
# Turn a stacked bar chart into a pie chart
#This is a coxcomb chart - essentially a bar chart in polar coordinates
ggplot(data=diamonds, mapping = aes(x = cut, fill = clarity)) +
  geom_bar(data = subset(diamonds, cut == "Fair"), position = "dodge") + coord_polar() +
  ggtitle("Position = Identity") #this adds the title to the plot

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = cut), width = 1) + 
  coord_polar()

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = factor(1), fill = cut), width = 1) + 
  coord_polar(theta = "y") + labs(x="hello", fill="Cut of the Diamonds")


ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_point() +
  geom_abline() +
  coord_fixed()

# CHAPTER 3
# The language of data manipulation is made up of six functions:
# filter() arrange() select() mutate() and summarize()
# They are then combined with group_by() to make up all possible transpositions of data
# filter() - pick observations
# arrange() reorder rows
# select() - pick variables by their names
# mutate() - create new variables with functions on existing variables
# summarize() - collapse many values to a single summary

filter(flights, day == 1, month == 1)
# functions never modify the inputs so we have to save results in a new data frame using <- 

jan1 <- filter(flights, day ==1, month ==1)
View(jan1)
# if you wrap the instruction in parentheses it creates the data frame and prints it
# (jan1 <-  filter(flights, day == 1, month == 1))
# If you want to compare something, but the value is not exact, you can use the instruction near()
near(sqrt(2) ^ 2, 2)
# In this case the answer is not exactly 2, but near(2) so it becomes TRUE

# Logical operators work the same way as in STATA
filter(flights, month == 11 | month == 12)
# regla de De Morgan: !(x & y) = !x | !y and !(x | y) = !x & !y 
# Se puede usar %in% para indicar que algo esta dentro de algo mas
filter (flights, month %in% c(11, 12))
# to determine if there is a missing value, we use is.na()
x <- NA
is.na(x)

#filter() only includes rows where condition is TRUE; it excludes both FALSE and NA values
# to check for flighst that are delayes in departure or arrivale by more than 2 hours:
filter(flights, !(dep_delay<120 & arr_delay<120))

# Exercises 
# all flights that had an arrival delay of two or more hours
filter(flights, arr_delay >= 120)
# destination is Houston IAH or HOU
filter(flights, dest == "HOU" | dest == "IAH")
# were operated by UNITED, American or Delta
?flights
airlines
filter(flights, carrier == "AA" | carrier == "UA" | carrier == "DL")
# departed in summer, june, july or august
filter(flights, month %in% c(7,8,9))
filter(flights, month <= 9 & month >= 7)
# arrived more than two hours late but didn't leave late
filter(flights, arr_delay > 120 & dep_delay <= 0) #could have arrived early!!! 
# were delayed by at least an hour, but made up more than 30 minutes in flight
filter(flights, dep_delay >= 60 & (dep_delay - arr_delay) > 30)
# departed between midnight and 6 am inclusive
filter(flights, dep_time <= 600 | dep_time == 2400)
# between() is also useful, how use to simplify the code above?
?between()
# shortcut for x >= left & x<= right
filter(flights, between(month,7,9))
filter(flights, month %in% c(7:9))
# how many flights have missing dep_time? what other variables are missing? what do these represent?
filter(flights, is.na(dep_time))
filter(flights, is.na(arr_time))
filter(flights, is.na(dep_delay))
# there are some data points missing

# Arranging rows with arrange()

arrange(flights, year, month, day)
# desc() allows to arrange by descending order
arrange(flights, desc(arr_delay))
# missing values are stored at the end
df <- tibble(x = c(2, 5, NA))
df
arrange(df, x)
arrange(df, desc(x))
arrange(df, -desc(x))

# Exercises 
# sort the data so that all the missing values are at the beginning
arrange(flights, desc(is.na(dep_time)))
# Sort flights to find the most delayed flight
arrange(flights, desc(dep_delay))
# left the earliest
arrange(flights, -desc(dep_delay))
# fastest flights > distance / time
arrange(flights, desc(distance/air_time))
# traveled the longest and shortest
arrange(flights, desc(distance))
airlines
View(arrange(flights, distance))

# Using select ()
# allows to narrow in on variables and subsets

select(flights, year, month, day)
select(flights, year:day) # : means everything between year and day
select(flights, -(year:day)) # in this case, the - makes it "except those between

#helper functions: starts_with() contains() ends_with() matches() num_range()
?select
# select can be used to rename variables but it isn't very useful b/c it drops the others
# instead we use rename
rename(flights, tail_num = tailnum)
# we can also use the everything() helper
select(flights, time_hour, air_time, everything()) # that way we can refer to "everything else"

# Exercises
# as many ways as possible to select dep_time, dep_delay arr_time and arr_delay
select(flights, starts_with("dep"), starts_with("arr"))
select(flights, dep_time, dep_delay, arr_time, arr_delay)
# what happens if you include the name of a variable several times
select(flights, dep_time, dep_time)
# nothing, only does iot once
# What is one_of()?
?one_of() #variables in a character vector
vars <- c("dep_time", "dep_hours")
select(flights, one_of(vars))
# gives the warning that only one of the variables in the vector is found!
select(flights, contains("TIME"))
# The default is to ignore the case
select(flights, contains("TIME", ignore.case = FALSE))

# Add new variables with mutate
# mutate always adds the column at the end of the data set
# first, create a smaller set:

flights_sml <- select(flights, year:day, ends_with("delay"), distance, air_time)
View(flights_sml)
View(arrange(flights_sml, desc(dep_delay)))
mutate(flights_sml, gain = arr_delay - dep_delay, speed = distance / air_time * 60)
# we can refer to newly created columns!
mutate(flights_sml, gain = arr_delay - dep_delay, hours = air_time / 60, gain_per_hour = gain / hours)
# if we only want to keep the new variables we can use transmute()
transmute(flights, gain = arr_delay - dep_delay, hours = air_time / 60, gain_per_hour = gain / hours)

# there are many functions that can be useful to create new data frames
# modular arithmetics - they can be useful to break apart numbers:
# %/% - integer division
# %% - remainder
transmute(flights, hour = dep_time %/% 100, minute = dep_time %% 100)
#logs - Try to use log2, easiest to interpret (see page 57)
# lags and leads - leading and lagging values
#cumulative and rolling aggregates:
x <- c(1:10)
lead(x)
lag(x)
cumsum(x)
cummean(x)
# also there are logicals and rankings
y <- c(1, 2, 2, NA, 3, 4)
min_rank(y)
min_rank(desc(y))
# Other options:
row_number(y)
dense_rank(y)
percent_rank(y)
cume_dist(y)

# EXERCISES - PG 58