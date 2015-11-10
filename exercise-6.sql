# We ran a campaign on a website, asking
# people to submit their email address, their city and phone number.The data was
# collected in a csv format The file is here... 
# http://dl.dropbox.com/u/628209/exercises/mysql/email_subscribers.txtFirst import this csv data into a mysql datbase.

CREATE DATABASE email_campaign;

USE email_campaign;

CREATE TABLE Subcribers (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  email_address VARCHAR(100) NOT NULL,
  phone_number VARCHAR(15) NOT NULL,
  city VARCHAR(50) NOT NULL,
  PRIMARY KEY(id)
);

# To Enable Load Data Option in MySQL as it is disabled by default
mysql --local-infile -u root -p

LOAD DATA LOCAL INFILE '~/Desktop/email_subscribers.txt'
INTO TABLE Subscribers FIELDS TERMINATED BY ',' 
(email_address, phone_number, city);

# From the database, we need to find the following information by
# writing a single sql statement for each.

# What all cities did people respond from
SELECT DISTINCT city FROM Subscribers;

# How many people responded from each city
SELECT city AS City,
COUNT(city) FROM Subscribers
GROUP BY city;

# Which city were the maximum respondents from?
SELECT city AS City,
COUNT(city) AS Number_of_Replies
FROM Subscribers
GROUP BY city
ORDER BY Number_of_Replies DESC LIMIT 1;

# What all email domains did people respond from?
SELECT email_address,
SUBSTRING_INDEX(email_address, '@', -1) AS 'Email Domains'
FROM Subscribers;

# Which is the most popular email domain among the respondents?
SELECT SUBSTRING_INDEX(email_address, '@', -1) AS Email_Domain,
COUNT(*) as Number_Of_Emails FROM Subscribers
GROUP BY Email_Domain
HAVING Number_Of_Emails = (
  SELECT COUNT(*) AS Counted
  FROM Subscribers
  GROUP BY SUBSTRING_INDEX(email_address, '@', -1)
  ORDER BY Counted DESC LIMIT 1
);
