#Alter Table Exercise

CREATE DATABASE Test;

USE Test;

CREATE TABLE testing_table (
  name VARCHAR(50) NOT NULL,
  contact_name VARCHAR(50) NOT NULL,
  roll_no VARCHAR(10) NOT NULL
) ENGINE=InnoDB

ALTER TABLE testing_table
DROP COLUMN name,
CHANGE contact_name username VARCHAR(50),
MODIFY roll_no INT NOT NULL,
ADD COLUMN `first_name` VARCHAR(20) NOT NULL,
ADD COLUMN `last_name` VARCHAR(20) NOT NULL AFTER `first_name`;