-- BEGINNER LEVEL QUESTIONS

-- 1. Retrieve all the restaurant names and their ratings.

SELECT `restaurant name`, `rate (out of 5)` FROM zomato;

-- 2. Find the average cost for two people for each type of restaurant.

SELECT `restaurant name`,`avg cost (two people)` FROM zomato;

-- 3. List the restaurants that offer online orders.

SELECT `restaurant name` FROM zomato
WHERE online_order = "Yes";

-- 4. Find all the restaurants located in a specific area. (Provide the count) and display top 3

SELECT area, COUNT(DISTINCT `restaurant name`) as "# of Restaurants" FROM zomato
GROUP BY area
ORDER BY `# of Restaurants` DESC
LIMIT 3;

-- 5. Display the distinct types of cuisines available by area

SELECT area, group_concat(DISTINCT `cuisines type`) FROM zomato
group by area;

-- 6. Count how many restaurants offer table booking and dont accept online order
SELECT COUNT(*) as "#" from zomato
WHERE `table booking` = "Yes" and online_order = "No";

-- 7. Find the restaurant with the highest number of ratings

SELECT `restaurant name`, MAX(`rate (out of 5)`) as "Max rating" from zomato
group by 1
order by 2 desc;

-- 8. List of Distinct Restaurant type available by area

SELECT group_concat(distinct `restaurant type`) as "Type" from zomato;

-- 9. List the Restaurant name of type  bar

SELECT `restaurant name` from zomato
where `restaurant type` LIKE "%Bar%";

-- 10. List all the restaurants that serve a specific cuisine type, such as "Italian" or "Chinese."

SELECT `restaurant name` from zomato
where `cuisines type` LIKE "%Chinese%" OR "%Italian%";

