select * 
from artist

select *
from canvas_size

select *
from image_link

select *
from museum

select *
from museum_hours

select *
from product_size

select *
from subject

select *
from work

--Fetch all the paintings which are not displayed on any museums?

select *
from work
where museum_id is null

--Are there museuems without any paintings?

select count(museum_id) AS m_without_paintings
from museum where not exists (select museum_id
							  from work
							  where museum_id is not null)
						
-- How many paintings have an asking price of more than their regular price? 

select count(sale_price)
	   from product_size 
	   where sale_price>regular_price;

-- Identify the paintings whose asking price is less than 50% of its regular price

with t1 as (select work_id, name
		    from work),
			
t2 as (select work_id, sale_price, regular_price
	   from product_size 
	   where sale_price< (0.50*regular_price))
	   
select t2.work_id, name, sale_price, regular_price
from t1 
join t2
on t1.work_id=t2.work_id
order by work_id

--Which canvas size costs the most?

with t1 as (select size_id, height, width, label
            from canvas_size), 
	  
t2 as (select size_id, sale_price
	   from product_size)

select t2.size_id, label, sale_price
from t1 
join t2
on t1.size_id=t2.size_id
order by sale_price desc
limit 1;

--Identify the museums with invalid city information in the given dataset

select *
from museum
where city ~ '^[0-9]'

--Fetch the top 10 most famous painting subject

with t1 as (select subject, count(subject) AS total_count
			from subject
			group by subject
			order by total_count desc),

t2 as (select *, dense_rank() over (order by total_count desc) as rank
	   from t1)
	   
select *
from t2
where rank<=10;

--Identify the museums which are open on both Sunday and Monday. Display museum name, city.

select museum_id, mh.day
from museum_hours mh
where mh.day='Sunday' or 'Monday'

-------------------------------------------------------------------------------------------------------
UPDATE museum_hours
SET day = REPLACE(day, 'Thusday', 'Thursday')
WHERE day LIKE '%Thusday%';

-------------------------------------------------------------------------------------------------------
--How many museums are open every single day?

with t1 as (select count(distinct day) as total_days
			from museum_hours),
			
t2 as (select m.museum_id, day
	   from museum_hours mh
	   join museum m
	   on mh.museum_id=m.museum_id
	   group by m.museum_id, day
	   order by museum_id),
	   
t3 as (select museum_id, count(1) as no_of_days
	   from t2
	   group by museum_id)
	   
select count(museum_id)
from t1
join t3
on t1.total_days=t3.no_of_days

OR 

select count(1)
	from (select museum_id, count(1)
		  from museum_hours
		  group by museum_id
		  having count(1) = 7) x;

--Which are the top 5 most popular museum? (Popularity is defined based on most no of paintings in a museum)

with t1 as (select m.museum_id as mid, m.name as names, m.city as city_name, m.country as country_name, w.name
from museum m
join work w
on m.museum_id=w.museum_id
group by m.museum_id, m.name, m.city, m.country, w.name
order by m.museum_id),

t2 as (select mid, names as museums, count(1) as total_paintings
	   from t1
	   group by mid, names)
select museums,country_name, city_name, total_paintings
from t1
join t2
on t1.mid=t2.mid
group by museums, country_name, city_name, total_paintings
order by total_paintings desc
limit 5;

--Who are the top 5 most popular artists? (Popularity is defined based on most no of paintings done by an artist)

with t1 as (select a.artist_id as id, a.full_name as artist_name, w.name, a.nationality,  w.style
from artist a
join work w
on a.artist_id=w.artist_id
where w.style is not null
group by a.artist_id, a.full_name, w.name, a.nationality,  w.style
order by a.artist_id),

t2 as (select id, artist_name, count(1) as total_paintings
	   from t1
	   group by id, artist_name)
	   
select t2.id, t2.artist_name, nationality, style, total_paintings, dense_rank() over (order by total_paintings desc) as rank
from t1
join t2
on t1.id=t2.id
group by t2.id, t2.artist_name, nationality, style, total_paintings
limit 5;

--Display the 3 least popular canva sizes

select *
from product_size ps
left join canvas_size cs
on ps.size_id=cs.size_id

--------------------------------------------------------------------------------------------------------------
--Which museum is open for the longest during a day. Display museum name, state and hours open and which day?

select m.museum_id, m.name, m.state, mh.day, mh.open, mh.close, (close-open) as diff
from museum m
join museum_hours mh
on m.museum_id=mh.museum_id
group by m.museum_id, m.name, m.state, mh.day, mh.open, mh.close
order by diff desc
limit 1;

--Which museum has the most no. of most popular painting style?

with t1 as (select m.museum_id, m.name, w.style, count(style) as no_of_paintings
from museum m
join work w
on m.museum_id=w.museum_id
group by m.museum_id, m.name, w.style
order by no_of_paintings desc),

t2 as (select *, rank() over (order by no_of_paintings desc)
	   from t1)
select name, style, no_of_paintings
from t2
where t2.rank<=1;

--Identify the artists whose paintings are displayed in multiple countries.

with t1 as (select distinct a.full_name as artist, m.country
from work w 
join artist a on a.artist_id=w.artist_id
join museum m on m.museum_id=w.museum_id)

select  artist, count(1) as no_of_countries
from t1
group by artist
having count(1)>1
order by no_of_countries desc
-------------------------------------------------------------------------------------------------------------------------
--Display the country and the city with most no of museums. Output 2 seperate columns to mention the city and country. 
--If there are multiple value, seperate them with comma.

with cte_country as 
			(select country, count(1)
			, rank() over(order by count(1) desc) as rnk
			from museum
			group by country),
		cte_city as
			(select city, count(1)
			, rank() over(order by count(1) desc) as rnk
			from museum
			group by city)
	select string_agg(distinct country.country,', '), string_agg(city.city,', ')
	from cte_country country
	cross join cte_city city
	where country.rnk = 1
	and city.rnk = 1;
--------------------------------------------------------------------------------------------------------------------------



















































































































