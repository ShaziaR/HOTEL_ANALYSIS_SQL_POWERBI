create database Hotel_Analysis;
use Hotel_Analysis;

--Fetching Data from tables:
select * from dbo.['2018$'];

select * from dbo.['2019$'];

select * from dbo.['2020$'];

--Appending all the tables into one :
select * into hotel_data from dbo.['2018$']
union
select * from dbo.['2019$']
union
select * from dbo.['2020$'];

select * from hotel_data;

--Exploratory data analysis?
--1)Is our hotel revenue growing yearly?
--2)Should we increase our parking lot size?
--3)What trends can we see in the data?

--year wise revenue for each hotel?
--To get Revenue?
--step:1 first add stays_in_week_nights and stays_in_weekend_nights 
--step:2 Then multiply with average daily ratio (adr) then we get revenue  
--(stays_in_week_nights+stays_in_weekend_nights)*adr)as revenue


--1)Is our hotel revenue growing yearly?
select arrival_date_year,sum((stays_in_week_nights+stays_in_weekend_nights)*adr)as revenue from hotel_data
group by arrival_date_year;

--revenue increased from 2018 to 2019 but then decreased again in 2020.

--revenue trend by hotel type

select arrival_date_year,hotel,sum((stays_in_week_nights+stays_in_weekend_nights)*adr)as revenue from hotel_data
group by arrival_date_year,hotel;
 
 --Q2)Should we increase our parking lot size?


select arrival_date_year,hotel,sum((stays_in_week_nights+stays_in_weekend_nights)*adr)as revenue,
concat(round((sum(required_car_parking_spaces)/sum(stays_in_week_nights +
stays_in_weekend_nights)) * 100, 2), '%') as parking_percentage from hotel_data
group by arrival_date_year,hotel
order by arrival_date_year;

--3)What trends can we see in the data?

select * from meal_cost$;
select * from market_segment$;

--join all the tables and create data model?

select * into hotel_data from dbo.['2018$']
union
select * from dbo.['2019$']
union
select * from dbo.['2020$'];

select * from hotel_data as a 
left join
market_segment$ as b 
on
a.market_segment=b.market_segment
left join
meal_cost$ as c
on c.meal=a.meal;


