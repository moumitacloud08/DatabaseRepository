--  Sample employee database 
--  See changelog table for details
--  Copyright (C) 2007,2008, MySQL AB
--  
--  Original data created by Fusheng Wang and Carlo Zaniolo
--  http://www.cs.aau.dk/TimeCenter/software.htm
--  http://www.cs.aau.dk/TimeCenter/Data/employeeTemporalDataSet.zip
-- 
--  Current schema by Giuseppe Maxia 
--  Data conversion from XML to relational by Patrick Crews
-- 
-- This work is licensed under the 
-- Creative Commons Attribution-Share Alike 3.0 Unported License. 
-- To view a copy of this license, visit 
-- http://creativecommons.org/licenses/by-sa/3.0/ or send a letter to 
-- Creative Commons, 171 Second Street, Suite 300, San Francisco, 
-- California, 94105, USA.
-- 
--  DISCLAIMER
--  To the best of our knowledge, this data is fabricated, and
--  it does not correspond to real people. 
--  Any similarity to existing people is purely coincidental.
-- 

DROP DATABASE IF EXISTS student;
CREATE DATABASE IF NOT EXISTS student;
USE student;

SELECT 'CREATING DATABASE STRUCTURE' as 'INFO';

DROP TABLE IF EXISTS student_info,
                     student_course;
                    

/*!50503 set default_storage_engine = InnoDB */;
/*!50503 select CONCAT('storage engine: ', @@default_storage_engine) as INFO */;

CREATE TABLE student_info (
    roll_no      INT             NOT NULL,
    full_name  VARCHAR(14)     NOT NULL,
    address  VARCHAR(14)     NOT NULL,
    phone  VARCHAR(10)     NOT NULL,
    age  INT(3)     NOT NULL,
    gender      ENUM ('M','F')  NOT NULL,
    PRIMARY KEY (roll_no)
);

CREATE TABLE student_course_info (
    course_id     INT         NOT NULL,
    roll_no      INT             NOT NULL
);



flush /*!50503 binary */ logs;

SELECT 'LOADING student' as 'INFO';
source load_student.dump ;
SELECT 'LOADING course' as 'INFO';
source load_course.dump ;

