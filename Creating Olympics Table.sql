--Using newly made olympics database

USE olympics;

CREATE TABLE olympics (
ID int,
Name varchar(255),
Sex varchar(255),
Age int,
Height float,
Weight float,
Team varchar(255),
NOC varchar(255),
Games varchar(255),
Year int,
Season varchar(255),
City varchar(255),
Sport varchar(255),
Event varchar(255),
Medal varchar(255),
NOC_Region varchar(255),
NOC_notes varchar(255)
);

--Loading Data Info File
LOAD DATA INFILE 'C:\Users\JessicaRobbin\Documents\SQL FILES\olympics_data.csv'
INTO TABLE olympics;

--Altering Data Types to account for nulls
ALTER TABLE olympics MODIFY COLUMN Height DOUBLE DEFAULT NULL;
ALTER TABLE olympics MODIFY COLUMN Weight DOUBLE DEFAULT NULL;
