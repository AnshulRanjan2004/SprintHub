import streamlit as st
import mysql.connector

# Function to establish a MySQL connection
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

def main():
    st.title("SprintHub Database Frontend")
    connection = create_connection()
    st.header("Users")
    users_query = "SELECT * FROM User"
    users_data = execute_select_query(connection, users_query)
    st.table(users_data)
    st.header("Sprints")
    sprints_query = "SELECT * FROM Sprint"
    sprints_data = execute_select_query(connection, sprints_query)
    st.table(sprints_data)
    connection.close()

if __name__ == "__main__":
    main()