# Take back up of the db you created for
# practice/exercise and send it to me. Now create a new database named "restored" and
# restore that backup into this DB.

mysqldump -u root -p blog > blog.sql

CREATE DATEBASE restored;

mysql -u root -p restored < blog.sql
