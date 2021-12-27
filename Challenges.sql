#Q1) We want to reward our users who have been around the longest.  Find the 5 oldest users.
	 SELECT * FROM users ORDER BY created_at LIMIT 5;
     
#Q2) What day of the week do most users register on? We need to figure out when to schedule and ad campaign.
	 SELECT DAYNAME(created_at) as day, COUNT(created_at) as day_count FROM users GROUP BY day ORDER BY day_count DESC LIMIT 1;
     

#Q3) We want to target our inactive users with an email campaign. Find the users who have never posted a photo.
	 SELECT * FROM users WHERE id NOT IN (SELECT user_id FROM photos);
     
#Q4) We're running a new contest to see who can get the most likes on a single photo. WHO WON?
	 SELECT users.id as user_id, users.username as username, photos.id as photo_id, photos.image_url as url, COUNT(likes.user_id) as like_count FROM likes JOIN photos ON likes.photo_id=photos.id JOIN users ON photos.user_id=users.id GROUP BY likes.photo_id ORDER BY like_count DESC LIMIT 1;

#Q5) Our Investors want to know. How many times does the average user post? Total number of photos/total number of users.
	 SELECT ROUND((SELECT COUNT(id) FROM photos)/(SELECT COUNT(id) FROM users),2) as photo_posting_avg_time;

#Q6) User ranking by postings higher to lower?
     SELECT users.id, users.username, COUNT(photos.id) as photos_posted FROM users JOIN photos ON users.id=photos.user_id GROUP BY users.id ORDER BY photos_posted DESC;

#Q7) Total numbers of users who have posted at least one time.
     SELECT COUNT(DISTINCT user_id) as user_posted_atleast_once FROM photos;
     
#Q8) A brand wants to know which hashtags to use in a post. What are the top 5 most commonly used hashtags?
	 SELECT tags.id as tag_id, tags.tag_name as tag_name, COUNT(photo_tags.tag_id) as tag_count FROM tags JOIN photo_tags ON tags.id=photo_tags.tag_id GROUP BY tags.id ORDER BY tag_count DESC LIMIT 5;
     
#Q9) We have a small problem with bots on our site. Find users who have liked every single photo on the site and Commented on every single photo.
	 SELECT users.id as user_id, users.username as username, COUNT(users.id) as total_likes_by_user FROM users JOIN likes ON users.id=likes.user_id GROUP BY users.id HAVING total_likes_by_user = (SELECT COUNT(*) FROM photos);
	 SELECT users.id as user_id, users.username as username, COUNT(comments.user_id) as total_comment FROM users JOIN comments ON users.id=comments.user_id GROUP BY users.id HAVING total_comment = (SELECT COUNT(DISTINCT comments.photo_id) FROM comments);
     
#Q10) We also have a problem with celebrities. Find users who have never commented on a photo.
	  SELECT users.id as user_id, users.username as username, comments.comment_text FROM users LEFT JOIN comments ON users.id=comments.user_id WHERE comments.comment_text IS NULL;