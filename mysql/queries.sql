-- Active: 1697515802955@@127.0.0.1@3306@sprinthub

--Correlated Queries
SELECT Project_Name
FROM Project p
WHERE p.Project_End_Date < CURDATE()
AND p.Project_Status <> 'Completed';

SELECT u.Name AS User_Name
FROM User u
WHERE (
    SELECT COUNT(DISTINCT p.Project_ID)
    FROM Project p
    WHERE p.Project_Sprint_ID = u.Sprint_ID
) > 1

--Nested Queries


--Aggregation Queries
