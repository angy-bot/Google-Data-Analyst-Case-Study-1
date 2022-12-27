# **Background** 

As a data analyst at Cyclistic, a fictional bike-share company in Chicago, I am responsible for this case study. The Cyclistic bicycle fleet has grown to 5,824 bicycles that are geotracking and locked into 692 stations across Chicago since its inception in 2016. It is possible to unlock the bikes at any station and return them to any other station within the system at any time.

The pricing plans offered by Cyclistic are three: single-ride passes, full-day passes, and annual memberships. A casual rider is a customer who purchases a single-ride or full-day pass. A Cyclistic member is someone who purchases an annual membership.

A new marketing strategy is being developed by the company to convert casual riders into annual members in order to increase revenue. In order to develop a data-driven marketing strategy, I will analyze bike usage data to determine how casual riders and annual members use Cyclistic bikes differently.

# **ASK stage**

**Business Task**</br>
Cyclistic bicycle membership differs from occasional use, and how occasional riders get influenced to join. This study aims to understand the differences and influence of annual members.

# **PREPARE Stage**

[Here](https://divvy-tripdata.s3.amazonaws.com/index.html) is a public dataset that I will use. Motivate International Inc. has made the data available under this license. Public datasets do not contain personal information, so it is not possible to determine how often a rider uses the same service. </br>
There was a slight variation in column names between the various datasets. However, within the 2021 - 2022 dataset, it is pertinent to note that the start and end stations, the start and end ride times, as well as the members and casual riders, are the key columns worth noting. Visualizing the data was also made easier by the latitude and longitude columns.</br>

# **PROCESS Stage**

This is the point at which the data has been processed. A thorough review was conducted to ensure that no errors were introduced, and further processing was performed to make the analysis more effective. As part of this process, Google Sheets was used. 

During data processing, two new columns were added. In this table, ride_length indicates the total ride time, and day_of_week indicates the day the ride started.
