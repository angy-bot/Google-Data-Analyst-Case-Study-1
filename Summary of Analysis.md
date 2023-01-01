# **Background** 

As a data analyst at Cyclistic, a fictional bike-share company in Chicago, I am responsible for this case study. The Cyclistic bicycle fleet has grown to 5,824 bicycles that are geotracking and locked into 692 stations across Chicago since its inception in 2016. It is possible to unlock the bikes at any station and return them to any other station within the system at any time.

The pricing plans offered by Cyclistic are three: single-ride passes, full-day passes, and annual memberships. A casual rider is a customer who purchases a single-ride or full-day pass. A Cyclistic member is someone who purchases an annual membership.

A new marketing strategy is being developed by the company to convert casual riders into annual members in order to increase revenue. In order to develop a data-driven marketing strategy, I will analyze bike usage data to determine how casual riders and annual members use Cyclistic bikes differently.

# **ASK stage**

**Business Task**</br>
Cyclistic bicycle membership differs from occasional use, and how occasional riders get influenced to join. This study aims to understand the differences and influence of annual members.

# **PREPARE Stage**

[Here](https://divvy-tripdata.s3.amazonaws.com/index.html) is a public dataset that I will use. Motivate International Inc. has made the data available under this license Since public datasets do not contain personal information, it is not possible to gauge how often riders use the same service. The data is uploaded to Rstudio, where R programming can be used for analysis.</br>
Based on data sorted by month, the analysis used the last 12 months, from December 2021 to November 2022.For the same reason, the data has been collected directly from customers at the company, which eliminates bias and credibility issues. It also meets the requirements for Reliable, Original, Comprehensive, Current, and Cited.</br>
During the preparation of the data for subsequent analysis, each data file was examined for integrity, duplicate entries were identified, and whether they were correctly written. In addition, they were examined to see if there were any missing values, and for this reason the start_station_name, start_station_id, end_station_name, and end_station_id columns were removed.

# **PROCESS Stage**

At this stage, the data has been imported individually for each month, and a total file has been created for each month. The data was cleaned and two new columns were added during this process.On the other hand, the second column determined when each ride began based on the day of the week. </br>
