#Database permission query

# Create a DB named "vtapp", create a db user named 'vtapp_user'
# and give him permissions to access vtappDB
CREATE DATABASE vtapp;

USE vtapp;

CREATE USER 'vtapp_user'@'localhost'
IDENTIFIED BY 'vtapp_password';

GRANT ALL PRIVILEGES
ON vtapp.*
TO 'vtapp_user'@'localhost';

FLUSH PRIVILEGES;
