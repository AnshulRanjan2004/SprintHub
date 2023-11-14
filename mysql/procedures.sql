DELIMITER //

CREATE PROCEDURE CloseSprintWithEffortCalculation(
    IN p_Sprint_ID INT
)
BEGIN
    DECLARE total_effort INT DEFAULT 0;

    -- Calculate total effort spent on tasks
    SELECT COALESCE(SUM(Task_Effort), 0) INTO total_effort
    FROM Task
    WHERE Sprint_ID = p_Sprint_ID;

    -- Update Sprint table with closing status, end date, and total effort
    UPDATE Sprint
    SET Sprint_Status = 'Closed',
        Sprint_End_Date = CURRENT_DATE,
        Sprint_Effort = total_effort
    WHERE Sprint_ID = p_Sprint_ID;
END //

DELIMITER ;


DELIMITER //

CREATE PROCEDURE AssignTeamToSprint(
    IN p_Sprint_ID INT,
    IN p_Team_ID INT
)
BEGIN
    DECLARE team_name VARCHAR(50);

    -- Get the team name
    SELECT Team_Name INTO team_name
    FROM Team
    WHERE Team_ID = p_Team_ID;

    -- Update the Sprint table with the assigned team
    UPDATE Sprint
    SET Team_Assigned = team_name
    WHERE Sprint_ID = p_Sprint_ID;
END //

DELIMITER ;


DELIMITER //

CREATE FUNCTION CountCommentsForTask(
    p_Task_ID INT
)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE comment_count INT;

    SELECT COUNT(*) INTO comment_count
    FROM Comments
    WHERE Comment_Task_ID = p_Task_ID;

    RETURN comment_count;
END //

DELIMITER ;



DELIMITER //
CREATE PROCEDURE UpdateProjectBudget(
    IN p_Project_ID INT,
    IN p_New_Budget INT
)
BEGIN
    -- Update the project budget
    UPDATE Project_Budget
    SET Budget = p_New_Budget
    WHERE Project_ID = p_Project_ID;
END //
DELIMITER ;




DELIMITER //
CREATE PROCEDURE AssignUserToTeam(
    IN p_User_ID INT,
    IN p_Team_ID INT
)
BEGIN
    -- Update the Team_Member table with the assigned team
    UPDATE Team_Member
    SET Team_ID = p_Team_ID
    WHERE USER_ID = p_User_ID;
END //
DELIMITER ;



DELIMITER //
CREATE PROCEDURE GetUserRole(
    IN p_User_ID INT
)
BEGIN
    DECLARE user_role VARCHAR(60);

    -- Get the user role
    SELECT Role INTO user_role
    FROM User
    WHERE User_ID = p_User_ID;

    -- Display the user role
    SELECT user_role AS 'User Role';
END //
DELIMITER ;



DELIMITER //
CREATE PROCEDURE GetTeamMembers(
    IN p_Team_ID INT
)
BEGIN
    -- Get the team members
    SELECT User.Name AS 'Team Member'
    FROM User
    JOIN Team_Member ON User.User_ID = Team_Member.USER_ID
    WHERE Team_Member.Team_ID = p_Team_ID;
END //
DELIMITER ;



DELIMITER //

-- Drop the existing procedure if it exists
DROP PROCEDURE IF EXISTS GetProjectDetails;

CREATE PROCEDURE GetProjectDetails(
    IN p_Project_ID INT
)
BEGIN
    -- Get project details
    SELECT
        Project.Project_Name AS 'Project Name',
        Project.Project_Description AS 'Project Description',
        Sprint.Sprint_Name AS 'Current Sprint',
        Story.Story_Name AS 'Current Story'
    FROM Project
    LEFT JOIN Sprint ON Project.Project_Sprint_ID = Sprint.Sprint_ID
    LEFT JOIN Story ON Project.Project_Story_ID = Story.Story_ID
    WHERE Project.Project_ID = p_Project_ID;
END //

DELIMITER ;



