# Load packages for data manimulation and vizualization
library(tidyverse)
library(ggplot2)
library(dplyr)
library(tidyr)
library(lubridate)

# Load packages for geospatial mapping
library(maps)
library(ggthemes)
library(ggmap)

# check column names to see if they match before combining 
# datasets into a single one
colnames(dec_2021)
colnames(jan_2022)
colnames(feb_2022)
colnames(mar_2022)
colnames(apr_2022)
colnames(may_2022)
colnames(jun_2022)
colnames(jul_2022)
colnames(aug_2022)
colnames(sep_2022)
colnames(oct_2022)
colnames(nov_2022)

# Merge datasets
total_trips <- bind_rows(dec_2021, jan_2022, feb_2022,
                         mar_2022, apr_2022, may_2022,
                         jun_2022, jul_2022 ,aug_2022,
                         sep_2022, oct_2022, nov_2022,
                         .id = NULL)


# ADD columns for Date, Month, Year, Day of the week, ride length
total_trips$date <- as.Date(total_trips$started_at)
total_trips$month <- format(as.Date(total_trips$date), "%m")
total_trips$day <- format(as.Date(total_trips$date), "%d")
total_trips$year <- format(as.Date(total_trips$date), "%Y")
total_trips$day_of_week <- format(as.Date(total_trips$date), "%A")
total_trips$ride_length <- difftime(total_trips$ended_at,total_trips$started_at)

# Convert Ride Length from factor to numeric
is.factor(total_trips$ride_length)

total_trips$ride_length <- as.numeric(as.character(total_trips$ride_length))
is.numeric(total_trips$ride_length)

# Data Cleaning #

# Removing any empty rows or columns present
total_trips <- remove_empty(total_trips, which = c("cols"))
total_trips <- remove_empty(total_trips, which = c("rows"))

# Data Frame dimensions
dim(total_trips)

# Data frame summary
glimpse(total_trips)
summary(total_trips)

# omitting NA values in the entire dataframe
total_trips_v2 <- na.omit(total_trips)

# dimensions and summary of new dataframe
dim(total_trips_v2)
dim(total_trips)
glimpse(total_trips_v2)
summary(total_trips_v2)

# Checking for missing values
count(filter(total_trips_v2, start_lat==''), start_lat, member_casual, sort=TRUE)

glimpse(total_trips_v2)

#Removing duplicates
print(nrow(total_trips_v2))
total_trips_v3 <- total_trips_v2[!duplicated(total_trips_v2$ride_id), ]
print(nrow(total_trips_v3))

# Check structure of newly merged dataset
str(total_trips_v3)

#number of users by user type
total_rides <- total_trips_v3 %>% count(member_casual)

# bar graph comparison between number of casual riders and annual members
ggplot(data = total_rides, aes(x = member_casual, y = n, fill = member_casual)) + geom_col() + geom_text(aes(label = n, vjust = -0.2)) + ggtitle("Rider Count by Rider Type")

# total ride length by user type
total_ride_length <- total_trips_v3 %>% 
  group_by(member_casual)%>%
  summarise(total_length = sum(ride_length))

ggplot(data = total_ride_length, aes(x=member_casual, y=total_length , fill = member_casual)) + geom_col() + geom_text(aes(label = total_length , vjust = -0.2)) + ggtitle("Total Ride Length by Rider Type")

# Average ride length by user type 
all_avg <- total_trips_v3 %>%
  group_by(member_casual) %>%
  summarise(avg_length = mean(ride_length))

# plot on bar graph
ggplot(data = all_avg, aes(x=member_casual, y=avg_length, fill=member_casual)) +
  geom_col() +
  geom_text(aes(label = avg_length, vjust = -0.2)) +
  ggtitle("Average Ride Length by Rider Type")

# total user per month by user type 
month_user <- total_trips_v3 %>%
  group_by(month = round_date(started_at, unit = "month"), member_casual) %>%
  summarise(count = n_distinct(ride_id), .groups='drop')

# bar graph users per month by user type
ggplot(data = month_user) +
  geom_bar(aes(x=month, y=count, fill = member_casual), stat="identity", position=position_dodge()) +
  ggtitle("Number of Riders by Month")

# total ride time by per month by user type
month_length_user <- total_trips_v3 %>%
  group_by(month = round_date(started_at, unit = "month"), member_casual) %>%
  summarise(total_length = sum(ride_length), .groups='drop')

# plot bar graph
ggplot(data = month_length_user) +
  geom_bar(mapping = aes(x=month, y=total_length, fill=member_casual), stat="identity", position=position_dodge()) +
  ggtitle("Total Ride Length per Month by Rider Type")

# average ride time by per month by user type
month_avg_user <- total_trips_v3 %>%
  group_by(month = round_date(started_at, unit = "month"), member_casual) %>%
  summarise(avg_length = mean(ride_length), .groups='drop')

# plot bar graph
ggplot(data = month_avg_user) +
  geom_bar(mapping = aes(x=month, y=avg_length, fill=member_casual), stat="identity", position=position_dodge()) +
  ggtitle("Average Ride Length per Month by Rider Type")

# number of riders by week by user type
week_user <- total_trips_v3 %>%
  group_by(day_of_week, member_casual) %>%
  summarise(count = n_distinct(ride_id), .groups='drop')

# see trends across the week
ggplot(data = week_user) +
  geom_bar(mapping = aes(x=day_of_week, y=count, fill=member_casual), 
           stat="identity", 
           position=position_dodge()) +
  ggtitle("Number of Riders by Day of Week")

# total ride time by per week by user type
week_length_user <- total_trips_v3 %>%
  group_by(day_of_week, member_casual) %>%
  summarise(total_length = sum(ride_length), .groups='drop')

# plot bar graph on week_length_user
ggplot(data = week_length_user) +
  geom_bar(mapping = aes(x=day_of_week, y=total_length, fill=member_casual), 
           stat="identity", 
           position=position_dodge()) +
  ggtitle("Total Ride Length by Day of Week")

# average ride time by per week by user type 
week_user_avg <- total_trips_v3 %>%
  group_by(day_of_week, member_casual) %>%
  summarise(avg_length = mean(ride_length), .groups='drop')

# plot bar graph on week_user_avg
ggplot(data = week_user_avg) +
  geom_bar(mapping = aes(x=day_of_week, y=avg_length, fill=member_casual), 
           stat="identity", 
           position=position_dodge()) +
  ggtitle("Average Ride Length by Day of Week")

# create new df for hourly
total_trips_v4 <- separate(total_trips_v3, col=started_at, into=c('date',"time"), sep=" ")
total_trips_v5 <- separate(total_trips_v4, col=time, into=c('hour',"minute"), sep=":")
total_trips_hours <- select(total_trips_v5, -date, -minute)
total_trips_hours$hour <- as.numeric(as.character(total_trips_hours$hour))
summary(total_trips_hours)

# number of riders by hour by user type 
hour_user <- total_trips_hours %>%
  group_by(hour, member_casual) %>%
  summarise(count = n_distinct(ride_id), .groups='drop')

# bar graph number of riders by hour by user type
ggplot(data = hour_user) +
  geom_bar(mapping = aes(x=hour, y=count, fill = member_casual), stat="identity", position=position_dodge()) +
  ggtitle("Number of Riders by Hour")

# total ride time by hour by user type
hour_length_user <- total_trips_hours %>%
  group_by(hour, member_casual) %>%
  summarise(total_length = sum(ride_length), .groups='drop') 

# plot hour_length_user bar graph total ride time by hour by user type
ggplot(data = hour_length_user) +
  geom_bar(mapping = aes(x=hour, y=total_length, fill = member_casual), 
           stat="identity", 
           position=position_dodge()) +
  ggtitle("Total Ride Length by Hour")

# average ride time by per hour by user type
hour_user_avg <- total_trips_hours %>%
  group_by(hour, member_casual) %>%
  summarise(avg_length = mean(ride_length), .groups='drop')

# plot hour_user_avg on bar graph
ggplot(data = hour_user_avg) +
  geom_bar(mapping = aes(x=hour, y=avg_length, fill = member_casual), 
           stat="identity", 
           position=position_dodge()) + 
  ggtitle("Average Ride Length by Hour")
