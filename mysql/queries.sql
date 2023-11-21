-- Active: 1697515802955@@127.0.0.1@3306@sprinthub

--Correlated Queries
SELECT Project_Name
FROM Project p
WHERE p.Project_End_Date < CURDATE()
AND p.Project_Status <> 'Completed'
