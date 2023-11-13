-- Active: 1697515802955@@127.0.0.1@3306@sprinthub
DELIMITER //
CREATE TRIGGER EnsureSprintEndDateAfterStartDate
BEFORE INSERT ON Sprint
FOR EACH ROW
BEGIN
    IF NEW.Sprint_End_Date <= NEW.Sprint_Start_Date THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Sprint end date must be after the start date';
    END IF;
END;
//
DELIMITER ;


DELIMITER //
CREATE TRIGGER SprintStartDateValidation
BEFORE INSERT ON Sprint
FOR EACH ROW
BEGIN
    DECLARE projectStartDate DATE;
    
    -- Get the project start date associated with the sprint
    SELECT Project_Start_Date INTO projectStartDate
    FROM Project
    WHERE Project_ID = NEW.Project_ID;

    -- Check if the sprint start date is earlier than the project start date
    IF NEW.Sprint_Start_Date < projectStartDate THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Sprint start date cannot be earlier than the project start date';
    END IF;
END;
//
DELIMITER ;




/*
DELIMITER //
CREATE TRIGGER RoleChangeAuthorization
BEFORE UPDATE ON User
FOR EACH ROW
BEGIN
    IF NEW.Role <> OLD.Role AND OLD.Role NOT IN ('Admin', 'Manager') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Unauthorized to change user role';
    END IF;
END;
//
DELIMITER ;
*/



DELIMITER //
CREATE TRIGGER PhoneNumberValidation
BEFORE INSERT ON Phone_Number
FOR EACH ROW
BEGIN
    DECLARE phonePattern VARCHAR(50);
    
    -- Define the regular expression pattern for a valid phone number
    SET phonePattern = '^[0-9]{10}$';
    
    -- Check if the phone number matches the pattern
    IF NEW.Phone_Number NOT REGEXP phonePattern THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid phone number format. Please enter a 10-digit number.';
    END IF;
END;
//
DELIMITER ;


DELIMITER //
CREATE TRIGGER SprintMeetingDateValidation
BEFORE INSERT ON Scrum_Meeting
FOR EACH ROW
BEGIN
    DECLARE projectStartDate DATE;
    DECLARE projectEndDate DATE;
    
    -- Get the project start and end dates associated with the sprint
    SELECT Project_Start_Date, Project_End_Date
    INTO projectStartDate, projectEndDate
    FROM Project
    WHERE Project_ID = NEW.Sprint_ID;
    
    -- Check if the Sprint Meeting date is not within the project's start and end dates
    IF NEW.Meeting_Date < projectStartDate OR NEW.Meeting_Date > projectEndDate THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Sprint Meeting date must be within the project start and end dates';
    END IF;
END;
//
DELIMITER ;



DELIMITER //
CREATE TRIGGER SetDefaultUserRole
BEFORE INSERT ON User
FOR EACH ROW
BEGIN
    -- Check if the user's role is not specified (i.e., NULL or empty)
    IF NEW.Role IS NULL OR NEW.Role = '' THEN
        -- Set the default role to "User"
        SET NEW.Role = 'User';
    END IF;
END;
//
DELIMITER ;


