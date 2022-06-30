SELECT *
FROM [dbo].[Comments]

-- 1. How many post were made in each year?
SELECT COUNT(*) as number_of_posts, YEAR(CreationDate) as creation_year
FROM dbo.posts
GROUP BY YEAR(CreationDate)
ORDER BY creation_year

-- 2. How many votes were made in each day of the week?
SELECT COUNT(*) as number_of_votes, DATENAME(DW, CreationDate) as day_of_week
FROM dbo.Votes
GROUP BY DATENAME(DW, CreationDate)
ORDER BY 
	CASE DATENAME(DW, CreationDate)          
          WHEN 'Monday' THEN 1
          WHEN 'Tuesday' THEN 2
          WHEN 'Wednesday' THEN 3
          WHEN 'Thursday' THEN 4
          WHEN 'Friday' THEN 5
          WHEN 'Saturday' THEN 6
		  WHEN 'Sunday' THEN 7
     END

-- 3. List all comments created on "2012-12-19"
SELECT *
FROM dbo.Comments
WHERE CAST(CreationDate AS DATE) = '2012-12-19'

--Or
SELECT * 
FROM comments 
WHERE DATEDIFF(DAY, CreationDate, '2012-12-19') = 0

-- 4. List all users under the age of 33, living in London 
SELECT *
FROM dbo.Users u
WHERE Age < 33
	AND Location LIKE '%London%'

-- 5. Display the number of votes for each post title 

SELECT p.Title, COUNT(*) number_of_votes
FROM posts p
	JOIN Votes v
	ON p.Id = v.PostId
GROUP BY p.Title
ORDER BY COUNT(*) DESC

-- 6. Display comments created by users living in the same location as the post creator
SELECT p.Id AS 'post_id', p.Title, p.OwnerUserId AS 'post_created_by_user', u_p.Location AS 'post_user_location',
	c.Id AS 'cmt_id', u_c.Location AS 'cmt_user_location'
FROM  posts p
	JOIN Users u_p ON p.OwnerUserId = u_p.Id
	JOIN Comments c ON c.PostId= p.id
	JOIN Users u_c ON u_c.Id = c.UserId
WHERE u_c.Location = u_p.Location

-- 7. How many users have never voted ? 
-- C 1:
WITH "vote_cte" AS
	(
	SELECT u.Id	FROM Users u
	EXCEPT
	SELECT v.UserId	FROM Votes v
	)
SELECT COUNT(*) FROM vote_cte

-- C 2:
WITH "vote_cte" AS (
	SELECT u.Id
	FROM Users u
	WHERE NOT EXISTS(
		SELECT v.UserId
		FROM Votes v
		WHERE u.id = v.UserId
		)
)
SELECT COUNT(*) FROM vote_cte

-- 8 Display all posts having the highest amount of comments 
WITH "top_cmt_of_post" AS
	(
	SELECT p.id, p.Title, COUNT(*) AS no_cmt,
			DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) AS 'cmt_count_ranking'
	FROM posts p
		JOIN Comments c ON p.id = c.PostId
	GROUP BY p.id, p.Title
	)
SELECT *
FROM top_cmt_of_post
WHERE cmt_count_ranking = 1

-- 9. For each post, how many votes are coming from users living in Canada ?
--    What's their percentage of the total number of votes 

WITH no_vote_cte AS (	
	SELECT p.id, p.Title, COUNT(*) AS number_of_vote,
		SUM(
			CASE
				WHEN u.location LIKE '%canada%' THEN 1 ELSE 0
			END
		) AS 'votes_from_canada'
	FROM posts p
		JOIN Votes v ON p.id = v.PostId
		JOIN Users u ON v.UserId = u.Id
	GROUP BY p.id, p.Title
	)
SELECT *,
	FORMAT(CAST(votes_from_canada*100 AS FLOAT)/CAST(number_of_vote AS FLOAT),'N2') AS votes_percentage
FROM no_vote_cte


-- 10. How many hours in average, it takes to the first comment to be posted after a creation of a new post

-- C 1:
WITH time_to_cmt_cte AS(
	SELECT p.Title, MIN(DATEDIFF(HOUR, p.CreationDate, c.CreationDate)) AS time_to_cmt
	FROM posts p
		JOIN Comments c ON p.Id = c.PostId
	GROUP BY p.Title
	)

SELECT AVG(time_to_cmt) AS 'avg_num_of_hours'
FROM time_to_cmt_cte


-- C 2
WITH "COMMENTS-TIMING-CTE"
AS 
    (
    SELECT  p.Id AS 'post_id',
            p.Title AS 'post_title',
            p.CreationDate AS 'post_creation_date',
            c.CreationDate AS 'comment_creation_date',
            DENSE_RANK() OVER (PARTITION BY p.ID ORDER BY c.CreationDate) AS 'comment_rank'
    FROM posts p JOIN comments c
    ON   p.Id = c.postID
    )
SELECT AVG(DATEDIFF(HOUR, post_creation_date, comment_creation_date)) AS 'avg_num_of_hours'
FROM "COMMENTS-TIMING-CTE"
WHERE comment_rank = 1

-- 11. Whats the most common post tag ? 
--     Note, each post may have 1 or more tags. 
--     The goal of this question is to find the most common *single* tag
--C 1
WITH "cte_tags" (Tags) AS (
	SELECT CAST(Tags AS VARCHAR(MAX)) 
	FROM posts
	UNION ALL
	SELECT STUFF(Tags, 1, CHARINDEX('><' , Tags), '') 
	-- CHARINDEX lấy vị trí '><'
	-- STUFF thay thế từ vị trí 1 đến vị trí '><' bằng ''
	FROM cte_tags
	WHERE Tags  LIKE '%><%'
	), "cte_tags_counter" AS (
	SELECT CASE WHEN Tags LIKE '%><%' THEN LEFT(Tags, CHARINDEX('><', Tags))
				ELSE Tags
			END AS 'Tags'
	FROM cte_tags
	)
SELECT COUNT(*), Tags
FROM cte_tags_counter
GROUP BY Tags
ORDER BY COUNT(*) DESC

-- C 2
WITH "cte_tags" (Tags) AS(
	SELECT REPLACE(REPLACE(REPLACE(Tags, '><', ','), '<',''),'>','')
	FROM posts
	)
SELECT VALUE, COUNT(*) AS "no_tags"
FROM cte_tags
CROSS APPLY STRING_SPLIT(Tags, ',')
GROUP BY VALUE
ORDER BY COUNT(*) DESC


--12. Create a pivot table displaying how many posts were created for each year (Y axis) and each month (X axis)
SELECT *
FROM (
	SELECT YEAR(CreationDate) AS 'Year', DATENAME(MONTH, CreationDate) AS 'Month', id 
	FROM posts
)  AS s
PIVOT (
	COUNT(id)
	FOR [Month] IN ([January], [February], [March], [April], [May], [June], [July], [August], [September], [October], [November], [December])
) AS pvt
ORDER BY Year

-- Reference: https://ramkedem.com/