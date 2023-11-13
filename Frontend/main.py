import streamlit as st
import mysql.connector

def create_connection():
    return mysql.connector.connect(
        host="127.0.0.1",
        user="root",
        password="Anshul@2004",
        database="sprinthub",
        port=3306
    )

def execute_query(connection, query):
    cursor = connection.cursor()
    cursor.execute(query)
    connection.commit()
    cursor.close()

def execute_select_query(connection, query):
    cursor = connection.cursor(dictionary=True)
    cursor.execute(query)
    result = cursor.fetchall()
    cursor.close()
    return result

def login():
    st.title("Login")
    username = st.text_input("Username")
    password = st.text_input("Password", type="password")
    login_button = st.button("Login")

    if login_button:
        connection = create_connection()
        login_query = f"SELECT * FROM User WHERE Username='{username}' AND Password='{password}'"
        user_data = execute_select_query(connection, login_query)

        if user_data:
            st.success("Login successful!")

            if user_data[0]["Role"] == "Admin":
                st.success("Redirecting to Admin page...")
            elif user_data[0]["Role"] == "User":
                st.success("Redirecting to User page")

        else:
            st.error("Invalid username or password")

        connection.close()

def handle_signup(name, username, password, role, sprint_id):
    connection = create_connection()

    # Inserting data into User table
    signup_query = f"INSERT INTO User (Name, Username, Password, Role, Sprint_ID) VALUES ('{name}', '{username}', '{password}', '{role}', {sprint_id or 'NULL'})"
    execute_query(connection, signup_query)

    st.success("Sign up successful! Redirecting to login page...")
    connection.close()

def home_page():
    st.markdown(
        """
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
            }

            .header {
                text-align: center;
                padding: 20px 0;
            }

            .container {
                border-radius: 10px;
                box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
                padding: 30px;
                text-align: center;
                margin: 20px auto;
                max-width: 800px;
            }

            h1 {
                color: #660066;
                font-size: 36px;
            }

            p {
                font-size: 18px;
                line-height: 1.6;
            }
        </style>
        """,
        unsafe_allow_html=True
    )

    st.markdown(
        """
        <div class="header">
            <h1>Welcome to Sprint Hub</h1>
        </div>

        <div class="container">
            <p>Sprint Hub is a powerful Agile project management tool designed to streamline your software development projects. With features tailored for Scrum, Kanban, and Agile methodologies, Sprint Hub empowers teams to plan, execute, and optimize their projects with ease.</p>
        </div>
        """
        ,
        unsafe_allow_html=True
    )

def user_page():
    return

def admin_page():
    st.title("Admin Page")

    selected_table = st.selectbox("Select Table", ["Home", "User", "Sprint", "Story", "Attachement", "Scrum_Master", "Project", "Project_Budget", "Team_Member", "Team", "Task", "Scrum_Meeting", "Retrospective_Meeting", "Comments", "Phone_Number", "Acceptance_Criteria"])

    if selected_table == "Home":
        st.write("Welcome to the Admin Page. Select a table from the dropdown to perform CRUD operations.")


    if selected_table == "User":
        display_user_table()

        # Add new user form
        st.subheader("Add New User")
        name = st.text_input("Name")
        username = st.text_input("Username")
        password = st.text_input("Password", type="password")
        role = st.text_input("Role")
        sprint_id = st.text_input("Sprint ID (Optional)")
        add_button = st.button("Add User", key="add_user")
        if add_button:
            add_user(name, username, password, role, sprint_id)

        # Update existing user form
        st.subheader("Update User")
         # Form input for update
        user_id = st.text_input("User ID")
        name = st.text_input("New Name (Optional)")
        username = st.text_input("New Username (Optional)")
        password = st.text_input("New Password (Optional)", type="password")
        role = st.text_input("New Role (Optional)")
        sprint_id = st.text_input("New Sprint ID (Optional)")

        # Submit button for update
        update_button = st.button("Update User")

        if update_button:
        # Call the update_user function with the provided values
            update_user(user_id, Name=name, Username=username, Password=password, Role=role, Sprint_ID=sprint_id)


        # Delete user form
        st.subheader("Delete User")
        delete_user_id = st.text_input("User ID to Delete")
        delete_button = st.button("Delete User", key="delete_user")
        if delete_button:
            delete_user(delete_user_id)

    elif selected_table == "Sprint":
        display_sprint_table()

        # Add new sprint form
        st.subheader("Add New Sprint")
        sprint_name = st.text_input("Sprint Name")
        sprint_start_date = st.date_input("Sprint Start Date")
        sprint_end_date = st.date_input("Sprint End Date")
        sprint_status = st.text_input("Sprint Status")
        sprint_description = st.text_input("Sprint Description")
        master_id = st.text_input("Master ID (Optional)")
        story_id = st.text_input("Story ID (Optional)")
        add_sprint_button = st.button("Add Sprint", key="add_sprint")
        if add_sprint_button:
            add_sprint(sprint_name, sprint_start_date, sprint_end_date, sprint_status, sprint_description, master_id, story_id)

        # Update existing sprint form
        st.subheader("Update Sprint")
        sprint_id = st.text_input("Sprint ID")
        sprint_name = st.text_input("New Sprint Name (Optional)")
        sprint_start_date = st.date_input("New Sprint Start Date (Optional)")
        sprint_end_date = st.date_input("New Sprint End Date (Optional)")
        sprint_status = st.text_input("New Sprint Status (Optional)")
        sprint_description = st.text_input("New Sprint Description (Optional)")
        master_id = st.text_input("New Master ID (Optional)")
        story_id = st.text_input("New Story ID (Optional)")

        # Submit button for update
        update_sprint_button = st.button("Update Sprint")
        if update_sprint_button:
            # Call the update_sprint function with the provided values
            update_sprint(sprint_id, Sprint_Name=sprint_name, Sprint_Start_Date=sprint_start_date, Sprint_End_Date=sprint_end_date, Sprint_Status=sprint_status, Sprint_Description=sprint_description, MASTER_ID=master_id, STORY_ID=story_id)

        # Delete sprint form
        st.subheader("Delete Sprint")
        delete_sprint_id = st.text_input("Sprint ID to Delete")
        delete_sprint_button = st.button("Delete Sprint", key="delete_sprint")
        if delete_sprint_button:
            delete_sprint(delete_sprint_id)
    
    elif selected_table == "Story":
        display_story_table()
        story_operations()


def display_user_table():
    connection = create_connection()
    query = "SELECT * FROM User"
    result = execute_select_query(connection, query)
    connection.close()

    # Display the result using Streamlit
    st.table(result)

def add_user(name, username, password, role, sprint_id):
    connection = create_connection()

    # Inserting data into User table
    query = f"INSERT INTO User (Name, Username, Password, Role, Sprint_ID) VALUES ('{name}', '{username}', '{password}', '{role}', {sprint_id or 'NULL'})"
    execute_query(connection, query)

    connection.close()
    st.success("User added successfully!")

def update_user(user_id, **kwargs):
    connection = create_connection()

    # Generate the SET clause for the UPDATE query
    set_values = []

    for key, value in kwargs.items():
        if value is not None and value != "":
            set_values.append(f"{key} = '{value}'")
        else:
            set_values.append(f"{key} = {key}")  # Keep the field unchanged

    set_clause = ", ".join(set_values)

    # Construct the UPDATE query
    update_query = f"UPDATE User SET {set_clause} WHERE User_ID = {user_id}"

    # Execute the UPDATE query
    execute_query(connection, update_query)

    st.success(f"User with ID {user_id} updated successfully!")

    connection.close()

def delete_user(user_id):
    connection = create_connection()

    # Deleting data from User table
    query = f"DELETE FROM User WHERE User_ID={user_id}"
    execute_query(connection, query)

    connection.close()
    st.success("User deleted successfully!")


    connection = create_connection()

    # Delete data from Sprint table
    delete_query = f"DELETE FROM Sprint WHERE Sprint_ID = {sprint_id}"
    execute_query(connection, delete_query)

    st.success("Sprint deleted successfully!")
    connection.close()

def display_sprint_table():
    connection = create_connection()
    query = "SELECT * FROM Sprint"
    result = execute_select_query(connection, query)
    connection.close()

    if result:
        st.subheader("Sprint Table")
        st.table(result)
    else:
        st.info("No data available in Sprint table.")

def add_sprint(Sprint_Name, Sprint_Start_Date, Sprint_End_Date, Sprint_Status, Sprint_Description, MASTER_ID=None, STORY_ID=None):
    connection = create_connection()
    query = f"INSERT INTO Sprint (Sprint_Name, Sprint_Start_Date, Sprint_End_Date, Sprint_Status, Sprint_Description, MASTER_ID, STORY_ID) VALUES ('{Sprint_Name}', '{Sprint_Start_Date}', '{Sprint_End_Date}', '{Sprint_Status}', '{Sprint_Description}', {MASTER_ID or 'NULL'}, {STORY_ID or 'NULL'})"
    execute_query(connection, query)
    connection.close()

    st.success("Sprint added successfully!")

def update_sprint(sprint_id, **kwargs):
    connection = create_connection()

    # Generate the SET clause for the UPDATE query
    set_values = []

    for key, value in kwargs.items():
        if value is not None and value != "":
            set_values.append(f"{key} = '{value}'")
        else:
            set_values.append(f"{key} = {key}")  # Keep the field unchanged

    set_clause = ", ".join(set_values)

    # Construct the UPDATE query
    update_query = f"UPDATE Sprint SET {set_clause} WHERE Sprint_ID = {sprint_id}"

    # Execute the UPDATE query
    execute_query(connection, update_query)

    st.success(f"Sprint with ID {sprint_id} updated successfully!")

    connection.close()

def delete_sprint(Sprint_ID):
    connection = create_connection()
    query = f"DELETE FROM Sprint WHERE Sprint_ID={Sprint_ID}"
    execute_query(connection, query)
    connection.close()

    st.success("Sprint deleted successfully!")

def add_story(Story_Name, Story_Description, Story_Status, Story_Priority, Attachement_ID):
    connection = create_connection()
    add_story_query = f"INSERT INTO Story (Story_Name, Story_Description, Story_Status, Story_Priority, Attachement_ID) VALUES " \
                      f"('{Story_Name}', '{Story_Description}', '{Story_Status}', '{Story_Priority}', {Attachement_ID or 'NULL'})"
    execute_query(connection, add_story_query)

    st.success("Story added successfully!")

    connection.close()

def update_story(story_id, **kwargs):
    connection = create_connection()
    set_values = []

    for key, value in kwargs.items():
        if value is not None and value != "":
            set_values.append(f"{key} = '{value}'")
        else:
            set_values.append(f"{key} = {key}")  # Keep the field unchanged

    set_clause = ", ".join(set_values)

    # Construct the UPDATE query
    update_query = f"UPDATE Story SET {set_clause} WHERE Story_ID = {story_id}"

    # Execute the UPDATE query
    execute_query(connection, update_query)

    st.success(f"Story with ID {story_id} updated successfully!")

    connection.close()

def delete_story(story_id):
    connection = create_connection()

    # Deleting data from Story table
    delete_story_query = f"DELETE FROM Story WHERE Story_ID = {story_id}"
    execute_query(connection, delete_story_query)

    st.success(f"Story with ID {story_id} deleted successfully!")

    connection.close()

def display_story_table():
    connection = create_connection()

    story_query = "SELECT * FROM Story"
    story_data = execute_select_query(connection, story_query)
    connection.close()
    st.table(story_data)
    connection.close()

def story_operations():
    st.subheader("Story Operations")

    # Add new story form
    st.subheader("Add New Story")
    Story_Name = st.text_input("Story Name")
    Story_Description = st.text_input("Story Description")
    Story_Status = st.text_input("Story Status")
    Story_Priority = st.text_input("Story Priority")
    Attachement_ID = st.text_input("Attachment ID (Optional)")
    add_button = st.button("Add Story", key="add_story")
    if add_button:
        add_story(Story_Name, Story_Description, Story_Status, Story_Priority, Attachement_ID)

    # Update existing story form
    st.subheader("Update Story")
    # Form input for update
    story_id = st.text_input("Story ID")
    Story_Name = st.text_input("New Story Name (Optional)")
    Story_Description = st.text_input("New Story Description (Optional)")
    Story_Status = st.text_input("New Story Status (Optional)")
    Story_Priority = st.text_input("New Story Priority (Optional)")
    Attachement_ID = st.text_input("New Attachment ID (Optional)")

    # Submit button for update
    update_button = st.button("Update Story")
    if update_button:
        # Call the update_story function with the provided values
        update_story(story_id, Story_Name=Story_Name, Story_Description=Story_Description,
                     Story_Status=Story_Status, Story_Priority=Story_Priority, Attachement_ID=Attachement_ID)

    # Delete story form
    st.subheader("Delete Story")
    delete_story_id = st.text_input("Story ID to Delete")
    delete_button = st.button("Delete Story", key="delete_story")
    if delete_button:
        delete_story(delete_story_id)

def main():

    pages = ["Home", "Signup", "Login", "Users", "Admins"]
    page = st.sidebar.radio("Select Page", pages)

    if page == "Home":
        home_page()

    elif page == "Signup":
        st.title("Sign Up")

        name = st.text_input("Name")
        username = st.text_input("Username")
        password = st.text_input("Password", type="password")
        role = st.text_input("Role")
        sprint_id = st.text_input("Sprint ID (Optional)")

        signup_button = st.button("Sign Up")

        if signup_button:
            handle_signup(name, username, password, role, sprint_id)

    elif page == "Login":
        login()

    elif page == "Users":
        user_page()

    elif page == "Admins":
        admin_page()

if __name__ == "__main__":
    main()
