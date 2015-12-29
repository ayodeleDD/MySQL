# Design a table structure for following conditions:
# A user can write many articles. Each written article will fall under one category.
# Remember that many articles can be written under same category. The users can be of two types admin or normal. A user can post multiple comments on an article.

CREATE DATABASE blog;

USE blog;

CREATE TABLE Users (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  type ENUM('normal', 'admin') NOT NULL,
  name VARCHAR(40),
  PRIMARY KEY (id)
);

CREATE TABLE Categories (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  category VARCHAR(50),
  PRIMARY KEY (id)
);

CREATE TABLE Comments (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  article_id INT UNSIGNED NOT NULL,
  user_id INT UNSIGNED NOT NULL,
  comment TEXT,
  PRIMARY KEY(id),
  FOREIGN KEY (user_id) REFERENCES Users (id),
  FOREIGN KEY (article_id) REFERENCES Articles (id)
);

CREATE TABLE Articles (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id INT UNSIGNED NOT NULL,
  category_id INT UNSIGNED NOT NULL,
  title VARCHAR(100) NOT NULL,
  FOREIGN KEY (user_id) REFERENCES Users (id),
  FOREIGN KEY (category_id) REFERENCES Categories (id),
  PRIMARY KEY(id)
);

INSERT INTO Users (type, name) VALUES
('admin', 'user1'),
('normal', 'user2'),
('admin', 'user3'),
('normal', 'user4'),
('normal', 'user5');

INSERT INTO Categories (category) VALUES
('Academic'),
('Career'),
('Financial'),
('Personal'),
('Practical'),
('Social'),
('How-To');

INSERT INTO Articles (user_id, category_id, title) VALUES
(1, 5, 'An Ambush at Noon'),
(2, 4, 'My American Dream is Happiness in Marriage'),
(5, 7, 'How-to Empower the African Woman'),
(3, 7, 'How-to Format Your Hard Disk Drive'),
(5, 6, 'My Marketing Manifesto in 500 Words'),
(4, 6, 'The Complete Buffer Guide to Social Media Success'),
(1, 2, '7 Best Experience-Building Jobs For New Grads'),
(1, 1, 'A lambda-calculus interpreter in C++ templates.'),
(4, 2, 'What Defines GREAT Company Culture?'),
(3, 1, '3 Qualities of Successful Ph.D. Students.');

INSERT INTO Comments (user_id, article_id, comment) VALUES
(2, 1, 'Comment 1'),
(2, 2, 'Comment 11'),
(2, 2, 'Comment 12'),
(2, 2, 'Comment 15'),
(3, 4, 'Comment 13'),
(3, 4, 'Comment 16'),
(3, 4, 'Comment 17'),
(5, 8, 'Comment 8'),
(5, 9, 'Comment 9');

INSERT INTO Comments (user_id, article_id, comment) VALUES
(2, 2, 'Comment 18');

# (i)select all articles whose author's name is user3 (Do this exercise using variable also).
SELECT title as 'Article Titles'
FROM Articles INNER JOIN Users
ON Articles.user_id = Users.id
WHERE name = 'User3';

# Using variable:
SET @user_id = (
  SELECT id
  FROM Users
  WHERE name = 'User3'
);

SELECT title as 'Article Titles'
FROM Articles
WHERE Articles.user_id = @user_id;

# For all the articles being selected above, select all the articles and also the comments associated with those articles in a single query (Do this using subquery also).

SELECT Articles.title AS 'Article Title', Comments.comment AS 'Comments'
FROM Articles INNER JOIN Users
ON Articles.user_id = Users.id INNER JOIN Comments
ON Comments.article_id = Articles.id WHERE Users.name = 'User3';

# Using SubQuery
SELECT Articles.title AS 'Article Title', Comments.comment AS 'Comments'
FROM Articles INNER JOIN Users
ON Articles.user_id = Users.id INNER JOIN Comments
ON Comments.article_id = Articles.id WHERE Users.id IN (
  SELECT id FROM Users
  WHERE name = 'user3'
);

# Write a query to select all articles which do not have any comments (Do using subquery also)
SELECT title FROM Articles
LEFT JOIN Comments
ON Articles.id = Comments.article_id
WHERE comment IS NULL;

SELECT title FROM Articles
WHERE NOT EXISTS (
  SELECT article_id
  FROM Comments
  WHERE Comments.article_id = Articles.id
);

# Write a query to select article which has maximum comments
SELECT article_id AS 'Article ID', MAX(count) AS 'Comment Count'
FROM (
  SELECT Comments.article_id, COUNT(Comments.article_id) AS count
  FROM Articles
  INNER JOIN Comments ON Articles.id = Comments.article_id
  GROUP BY Comments.article_id
  ORDER BY COUNT( Comments.article_id ) DESC
) AS Max_Count;

# Write a query to select article which does not have more than one comment by the same user (do this using left join and group by)
SELECT Articles.title, COUNT(Comments.comment) AS 'Comment Count'
FROM Articles LEFT JOIN Comments
ON Articles.id = Comments.article_id
GROUP BY Articles.id
HAVING COUNT(Comments.comment) = 1;
