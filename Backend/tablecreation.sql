-- Active: 1697515802955@@127.0.0.1@3306@sprinthub
CREATE TABLE User(  
    User_ID int NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT 'Primary Key',
    Name VARCHAR(50),
    Username VARCHAR(50),
    Password VARCHAR(50),
    Role VARCHAR(60),
    Sprint_ID int
) COMMENT 'User Login Table';

CREATE TABLE Sprint(
    Sprint_ID int NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT 'Primary Key',
    Sprint_Name VARCHAR(50),
    Sprint_Start_Date DATE,
    Sprint_End_Date DATE,
    Sprint_Status VARCHAR(50),
    Sprint_Description VARCHAR(50),
    MASTER_ID int,
    STORY_ID int
) COMMENT 'Sprint Table';

CREATE TABLE Story(
    Story_ID int NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT 'Primary Key',
    Story_Name VARCHAR(50),
    Story_Description VARCHAR(50),
    Story_Status VARCHAR(50),
    Story_Priority VARCHAR(50),
    Attachement_ID int
) COMMENT 'Story Table';

CREATE TABLE Attachement(
    Attachement_ID int NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT 'Primary Key',
    Attachement_Name VARCHAR(50),
    Attachement_URL VARCHAR(50)
) COMMENT 'Attachement Table';

CREATE TABLE Scrum_Master(
    MASTER_ID int NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT 'Primary Key',
    USER_ID int 
) COMMENT 'Scrum Master Table';

CREATE TABLE Project(
    Project_ID int NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT 'Primary Key',
    Project_Name VARCHAR(50),
    Project_Description VARCHAR(50),
    Project_Status VARCHAR(50),
    Project_Start_Date DATE,
    Project_End_Date DATE,
    Project_Story_ID int,
    Project_Sprint_ID int,
    Budget int
) COMMENT 'Project Table';

CREATE TABLE Project_Budget(
    Budget int,
    Project_ID int
) COMMENT 'Project Budget Table';
