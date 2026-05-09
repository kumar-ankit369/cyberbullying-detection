-- =========================================
-- Cyberbullying Detection Hive Queries
-- =========================================

-- Create database
CREATE DATABASE IF NOT EXISTS cyber_db;

-- Use database
USE cyber_db;

-- Create table
CREATE TABLE IF NOT EXISTS cyber (
    tweet STRING,
    label INT
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
    "separatorChar" = ",",
    "quoteChar" = "\""
)
STORED AS TEXTFILE;

-- Load dataset from HDFS
LOAD DATA INPATH '/project/clean_final.csv'
INTO TABLE cyber;

-- Show all tables
SHOW TABLES;

-- Display sample records
SELECT * FROM cyber LIMIT 10;

-- Count total records
SELECT COUNT(*) AS total_tweets
FROM cyber;

-- Count cyberbullying vs non-cyberbullying
SELECT label, COUNT(*) AS total
FROM cyber
GROUP BY label;

-- Show only cyberbullying tweets
SELECT *
FROM cyber
WHERE label = 1
LIMIT 10;

-- Find tweets containing hate words
SELECT *
FROM cyber
WHERE tweet LIKE '%hate%'
LIMIT 10;

-- Create view for bullying tweets
CREATE VIEW bullying_view AS
SELECT tweet
FROM cyber
WHERE label = 1;

-- Show data from view
SELECT * FROM bullying_view LIMIT 10;

-- Create partitioned table
CREATE TABLE IF NOT EXISTS cyber_partitioned (
    tweet STRING
)
PARTITIONED BY (label INT)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE;

-- Enable dynamic partitioning
SET hive.exec.dynamic.partition=true;
SET hive.exec.dynamic.partition.mode=nonstrict;

-- Insert into partitioned table
INSERT INTO TABLE cyber_partitioned
PARTITION(label)
SELECT tweet, label
FROM cyber;

-- Show partitions
SHOW PARTITIONS cyber_partitioned;
