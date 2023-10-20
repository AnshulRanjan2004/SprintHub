-- Active: 1697515802955@@127.0.0.1@3306
-- Insert values into the User table
INSERT INTO User (Name, Username, Password, Role, Sprint_ID) VALUES
    ('John Doe', 'johndoe', 'password123', 'Admin', NULL),
    ('Jane Smith', 'janesmith', 'securepass', 'User', NULL),
    ('Bob Johnson', 'bobjohnson', 'pass123', 'User', NULL);

-- Insert values into the Sprint table
INSERT INTO Sprint (Sprint_Name, Sprint_Start_Date, Sprint_End_Date, Sprint_Status, Sprint_Description, MASTER_ID, STORY_ID) VALUES
    ('Sprint 1', '2023-01-15', '2023-01-30', 'Active', 'First sprint', NULL, NULL),
    ('Sprint 2', '2023-02-01', '2023-02-15', 'Completed', 'Second sprint', NULL, NULL),
    ('Sprint 3', '2023-03-01', '2023-03-15', 'Active', 'Third sprint', NULL, NULL);

-- Insert values into the Story table
INSERT INTO Story (Story_Name, Story_Description, Story_Status, Story_Priority, Attachement_ID) VALUES
    ('User Authentication', 'Implement login functionality', 'In Progress', 'High', NULL),
    ('Database Schema', 'Design the database structure', 'Completed', 'Low', NULL),
    ('UI Redesign', 'Revamp the user interface', 'Active', 'Medium', NULL);

-- Insert values into the Attachement table
INSERT INTO Attachement (Attachement_Name, Attachement_URL) VALUES
    ('Attachment 1', 'http://example.com/attachment1.pdf'),
    ('Attachment 2', 'http://example.com/attachment2.doc');

-- Insert values into the Scrum_Master table
INSERT INTO Scrum_Master (USER_ID) VALUES
    (NULL),
    (NULL);

-- Insert values into the Project table
INSERT INTO Project (Project_Name, Project_Description, Project_Status, Project_Start_Date, Project_End_Date, Project_Story_ID, Project_Sprint_ID, Budget) VALUES
    ('Project A', 'Software development project', 'Active', '2023-01-01', '2023-12-31', NULL, NULL, NULL),
    ('Project B', 'Web application project', 'Completed', '2023-03-01', '2023-08-31', NULL, NULL, NULL);

-- Insert values into the Project_Budget table
INSERT INTO Project_Budget (Budget, Project_ID) VALUES
    (10000, NULL),
    (7500, NULL);

-- Insert values into the Team_Member table
INSERT INTO Team_Member (Description, USER_ID, Team_ID) VALUES
    ('Lead Developer', NULL, NULL),
    ('Designer', NULL, NULL),
    ('Developer', NULL, NULL);

-- Insert values into the Team table
INSERT INTO Team (Team_Name, Team_Description) VALUES
    ('Development Team', 'Software development team'),
    ('Design Team', 'UI/UX design team');

-- Insert values into the Task table
INSERT INTO Task (Task_Name, Task_Description, Task_Status, Task_Priority, Task_Start_Date, Task_End_Date, Sprint_ID, Attachment_ID) VALUES
    ('Implement Login UI', 'Create login form', 'In Progress', 'High', '2023-01-20', '2023-01-30', NULL, NULL),
    ('Database Modeling', 'Design database schema', 'Completed', 'Low', '2023-02-05', '2023-02-10', NULL, NULL),
    ('UI Redesign Mockup', 'Create UI mockup', 'Active', 'Medium', '2023-03-05', '2023-03-15', NULL, NULL);

-- Insert values into the Scrum_Meeting table
INSERT INTO Scrum_Meeting (Meeting_ID, Meeting_Notes, Meeting_Date, Sprint_ID) VALUES
    (1, 'Discuss sprint goals', '2023-01-15', NULL),
    (2, 'Review progress', '2023-02-01', NULL);

-- Insert values into the Retrospective_Meeting table
INSERT INTO Retrospective_Meeting (Meeting_ID, Meeting_Notes, Meeting_Date, Sprint_ID) VALUES
    (1, 'Identify improvements', '2023-01-30', NULL),
    (2, 'Reflect on the sprint', '2023-02-15', NULL);

-- Insert values into the Comments table
INSERT INTO Comments (Comment_Task, Comment_Timestamp, Comment_Task_ID) VALUES
    ('Good progress so far', '2023-01-25', NULL),
    ('Completed the database design', '2023-02-08', NULL),
    (NULL, '2023-03-10', NULL);

-- Insert values into the Phone_Number table
INSERT INTO Phone_Number (Phone_Number, USER_ID) VALUES
    ('123-456-7890', NULL),
    ('987-654-3210', NULL);

-- Insert values into the Acceptance_Criteria table
INSERT INTO Acceptance_Criteria (Acceptance_Criteria_Description, Acceptance_Story_ID) VALUES
    ('User can log in successfully', NULL),
    ('Database schema matches design', NULL);
