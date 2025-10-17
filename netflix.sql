create database Project ;

use Project;
select * from netflix_titles;
drop table netflix_titles ;
CREATE TABLE netflix
(
	show_id	VARCHAR(5),
	type    VARCHAR(10),
	title	VARCHAR(250),
	director VARCHAR(550),
	casts	VARCHAR(1050),
	country	VARCHAR(550),
	date_added	VARCHAR(55),
	release_year	INT,
	rating	VARCHAR(15),
	duration	VARCHAR(15),
	listed_in	VARCHAR(250),
	description VARCHAR(550)
);

select * from netflix;


select 
     count(*) as total_content 
                                 from netflix;


select distinct type  from netflix;     

-- Netflix Data Analysis using SQL
-- Solutions of 15 business problems
-- 1. Count the number of Movies vs TV Shows

SELECT 
	type,
	COUNT(*)
FROM netflix
GROUP BY 1;

-- 2. Find the most common rating for movies and TV shows

-- select type, max(rating) from netflix;   

select type,
            rating,count(*) 
                           from netflix 
                                         group by 1 , 2
                                                       order by 3 desc;


-- 3. List all movies released in a specific year (e.g., 2020)

select * from netflix  
                     where 
                            release_year = 2020;
                            
	-- 4. Find the top 5 countries with the most content on Netflix
select country, 
             count(show_id)
                           from netflix 
                                         group by 1
                                         order by 2 desc
													limit 5;


-- 5. Identify the longest movie
select * from netflix
                 where type = "Movie" 
                 and
                 duration = (select max(duration) from netflix);
                 
-- 6. Find content added in the last 5 years

select * from netflix where date_added = current_date - interval '5 years';
SELECT
*
FROM netflix
WHERE TO_DATE(date_added, 'Month DD, YYYY') >= CURRENT_DATE - INTERVAL '5 years';
currant_date -interval "5 YEARS";
				
SELECT * FROM netflix 
WHERE TO_DATE(date_added, 'Month DD, YYYY') >= CURRENT_DATE - INTERVAL '5 years';

SELECT * FROM netflix
WHERE STR_TO_DATE(date_added, '%M %d, %Y') >= DATE_SUB(CURRENT_DATE(), INTERVAL 5 YEAR);


-- 7. Find all the movies/TV shows by director 'Rajiv Chilaka'!
select * from netflix where director LIKE '%Rajiv Chilaka%';

-- 8. List all TV shows with more than 5 seasons
SELECT *
FROM netflix
WHERE 
	TYPE = 'TV Show'
	AND
	CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED) > 5;
    

 -- 9. Count the number of content items in each genre
 WITH RECURSIVE
	-- Step 1: Initialize the recursive query
	split_genres AS (
		SELECT
			SUBSTRING_INDEX(listed_in, ',', 1) AS genre,
			SUBSTRING_INDEX(listed_in, ',', - (LENGTH(listed_in) - LENGTH(REPLACE(listed_in, ',', '')))) AS rest_of_string,
			listed_in
		FROM netflix
		UNION ALL
		-- Step 2: Recursively find the next genre
		SELECT
			TRIM(SUBSTRING_INDEX(rest_of_string, ',', 1)) AS genre,
			SUBSTRING(rest_of_string, INSTR(rest_of_string, ',') + 1) AS rest_of_string,
			listed_in
		FROM split_genres
		WHERE INSTR(rest_of_string, ',') > 0
	)
-- Step 3: Group the results
SELECT
    TRIM(genre) AS genre,
    COUNT(*) AS total_content
FROM split_genres
WHERE TRIM(genre) != ''
GROUP BY 1
ORDER BY 2 DESC;	

select 
      unnest(string_to_arrar(listed_in,',')) as genre,
      count(show_id)
      from netflix
      group by 1;




-- 10. Find each year and the average numbers of content release by India on netflix. 
-- return top 5 year with highest avg content release !
SELECT 
	country,
	release_year,
	COUNT(show_id) as total_release,
    -- CAST is the correct MySQL syntax for type conversion
	ROUND(
        (COUNT(show_id) / CAST((SELECT COUNT(show_id) FROM netflix WHERE country = 'India') AS DECIMAL(10, 2))) * 100 
		,2
		) as avg_release
FROM netflix
WHERE country = 'India' 
GROUP BY country, release_year -- Group by 2 is valid, but using the column name is clearer
ORDER BY avg_release DESC 
LIMIT 5;


-- 11. List all movies that are documentaries
select * from netflix where listed_in
 like 'documentaries';

-- 12. Find all content without a director

select * from netflix where director is null;

-- 13. Find how many movies actor 'Salman Khan' appeared in last 10 years!

SELECT * FROM netflix
WHERE 
	casts LIKE '%Salman Khan%'
	AND 
	release_year > EXTRACT(YEAR FROM CURRENT_DATE) - 10;
    



-- 14. Find the top 10 actors who have appeared in the highest number of movies produced in India.

SELECT
    TRIM(actor.cast_member) AS actor,
    COUNT(*)
FROM
    netflix
JOIN
    JSON_TABLE(
        -- Convert the comma-separated string to a JSON array
        REPLACE(
            JSON_ARRAY(casts), 
            ',', 
            '","'
        ),
        -- Path to iterate over array elements
        '$[*]' 
        COLUMNS (
            cast_member VARCHAR(255) PATH '$'
        )
    ) AS actor
WHERE
    country = 'India'
GROUP BY
    1
ORDER BY
    2 DESC
LIMIT 10;

/*
Question 15:
Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
the description field. Label content containing these keywords as 'Bad' and all other 
content as 'Good'. Count how many items fall into each category.
*/
                                                    
                                                    

                                 
                                 
SELECT
    category,
	TYPE,
    COUNT(*) AS content_count
FROM (
    SELECT 
		*,
        CASE 
            WHEN description ILIKE '%kill%' OR description ILIKE '%violence%' THEN 'Bad'
            ELSE 'Good'
        END AS category
    FROM netflix
) AS categorized_content
GROUP BY 1,2
ORDER BY 2;

-- End


