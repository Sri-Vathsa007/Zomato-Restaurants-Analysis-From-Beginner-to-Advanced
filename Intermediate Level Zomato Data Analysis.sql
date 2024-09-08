-- INTERMEDIATE LEVEL QUESTIONS

-- 1. Find the most common cuisine type for restaurants in each area.

SELECT area, `cuisines type`, count(`cuisines type`) from zomato
group by 1,2
order by 1,2 desc;

-- 2. Calculate the rank for each restaurant in its respective area based on the rating 
-- and then filters out the top 3 ranked restaurants for each area.

WITH RankedRestaurants AS (
  SELECT `restaurant name`, area, DENSE_RANK() OVER (PARTITION BY area ORDER BY `rate (out of 5)` DESC) AS r
  FROM Zomato
)
SELECT `restaurant name`, area, r
FROM RankedRestaurants
WHERE r <= 3;

-- 3. Calculate the average rating of restaurants that offer both online ordering and table booking, 
-- and compare it to the average rating of those that offer only one or neither.

WITH CTE_AvgRating AS (
    SELECT 
        CASE 
            WHEN online_order = 'Yes' AND `table booking`= 'Yes' THEN 'Both'
            WHEN online_order = 'Yes' AND `table booking` = 'No' THEN 'Online Only'
            WHEN online_order = 'No' AND `table booking` = 'Yes' THEN 'Booking Only'
            ELSE 'Neither'
        END AS Service_Type,
        AVG(`rate (out of 5)`) AS avg_rating
    FROM Zomato
    GROUP BY Service_Type
)
SELECT * 
FROM CTE_AvgRating;

-- 4. Find the difference in average rating between restaurants that 
-- offer online ordering and those that do not, then display this difference for each area.

WITH CTE_AvgRating AS (
    SELECT 
        area,
        CASE 
            WHEN online_order = 'Yes' THEN 'Online Order'
            ELSE 'No Online Order'
        END AS order_type,
        AVG(`rate (out of 5)`) AS avg_rating
    FROM Zomato
    GROUP BY area, order_type
)
SELECT area, 
       MAX(CASE WHEN order_type = 'Online Order' THEN avg_rating END) AS avg_rating_online,
       MAX(CASE WHEN order_type = 'No Online Order' THEN avg_rating END) AS avg_rating_no_online,
       COALESCE(MAX(CASE WHEN order_type = 'Online Order' THEN avg_rating END), 0) 
       - COALESCE(MAX(CASE WHEN order_type = 'No Online Order' THEN avg_rating END), 0) AS rating_difference
FROM CTE_AvgRating
GROUP BY area;

-- 5. List the names and ratings of restaurants that have more than 500 ratings and a rating above 4.5.

SELECT `restaurant name`, `rate (out of 5)` from zomato
where `num of ratings` >= 500 and `rate (out of 5)` >= 4.5;

