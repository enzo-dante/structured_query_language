-- exercise 1
-- who are our 5 oldest members so we can reward them for their loyalty?

SELECT *
FROM   users
ORDER  BY created_at
LIMIT  5;

-- exercise 2
-- what day of the week do most users register on to figure out when to schedule. anad campaign?

SELECT
        Date_format(created_at, '%W') AS 'Day of the Week',
        Count(*)                      AS 'Day Total'
FROM   users
GROUP  BY Date_format(created_at, '%W')
ORDER  BY 2 DESC
LIMIT  1; 

# alternative solution
SELECT Dayname(created_at) AS 'day',
       Count(*)            AS 'total'
FROM   users
GROUP  BY day
ORDER  BY total DESC
LIMIT  1; 

# exercise 3
# identify inactive users (users with no photos)

SELECT users.id,
       username
FROM   users
       LEFT JOIN photos
              ON users.id = photos.user_id
WHERE  image_url IS NULL
ORDER  BY users.id; 

# alternative RIGHT JOIN solution
SELECT users.id,
       username
FROM   photos
       RIGHT JOIN users
               ON photos.user_id = users.id
WHERE  image_url IS NULL
ORDER  BY users.id; 

# exercise 4
# identify most popular photo with most likes and the user who created it

SELECT username,
       likes.photo_id,
       photos.image_url,
       Count(likes.photo_id) AS 'total'
FROM   users
       INNER JOIN photos
               ON users.id = photos.user_id
       INNER JOIN likes
               ON photos.id = likes.photo_id
GROUP  BY likes.photo_id
ORDER  BY total DESC
LIMIT  1; 

# alternative solution
SELECT username,
       photos.id AS 'photo_id',
       photos.image_url,
       Count(*)  AS 'total'
FROM   photos
       INNER JOIN likes
               ON likes.photo_id = photos.id
       INNER JOIN users
               ON photos.user_id = users.id
GROUP  BY photos.id
ORDER  BY total DESC
LIMIT  1; 

# exercise 5
# How many times does the average user post? (calculate avg number of photos per user)

# easiest method is to use subquerries 

# total number of users
# total number of photos
# AVG = total photos / total users

SELECT Count(*) AS 'total photos'
FROM   photos;

SELECT Count(*) AS 'total users'
FROM   users;

SELECT ( 5 ) / ( 2 ) AS 'test';

SELECT Round((SELECT Count(*)
              FROM   photos) / (SELECT Count(*)
                                FROM   users), 2) AS 'avg photos per user'; 

# exercise 6
# what are the top 5 most commonly used hashtags?

SELECT tags.tag_name,
       Count(*) AS 'total'
FROM   photo_tags
       INNER JOIN tags
               ON photo_tags.tag_id = tags.id
GROUP  BY tags.id
ORDER  BY 2 DESC
LIMIT  5;

# exercise 7
# find users who have liked every single photo on the site (bot problem)

# INNER JOIN because you only want to track likes and the respective user and do not care about users that have not liked anything

SELECT Count(*) AS 'total photos'
FROM   photos; # 257

# HAVING functions like WHERE but HAVING can be used to filter a returned query

# HAVING must come after any JOINS and GROUP BY since it is used to filter the end result

# do not hardcode, use subqueries for dynamic updating

SELECT users.username AS 'users that liked every photo',
       Count(*) AS 'total_likes'
FROM   users
       INNER JOIN likes
               ON users.id = likes.user_id
GROUP  BY likes.user_id
HAVING total_likes = (SELECT Count(*)
                      FROM   photos)
ORDER  BY users.username; 

