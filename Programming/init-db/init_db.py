import time
import mysql.connector

def create_tables_if_not_exist():
    try:
        connection = mysql.connector.connect(
            host="mysql",
            user="user",
            password="password",
            database="db"
        )

        cursor = connection.cursor()

        # Verificar si las tablas existen
        cursor.execute("SHOW TABLES LIKE 'USERS'")
        table_users_exists = cursor.fetchone()

        cursor.execute("SHOW TABLES LIKE 'ANSWERS'")
        table_answers_exists = cursor.fetchone()

        cursor.execute("SHOW TABLES LIKE 'QUESTIONS'")
        table_questions_exists = cursor.fetchone()

        cursor.execute("SHOW TABLES LIKE 'COURSES'")
        table_courses_exists = cursor.fetchone()

        # Si no existen, crearlas
        if not table_users_exists:
            cursor.execute("CREATE TABLE USERS (id INT AUTO_INCREMENT PRIMARY KEY, username VARCHAR(255), email VARCHAR(255), password VARCHAR(255))")  # Especifica las columnas aquí
        if not table_answers_exists:
            cursor.execute("CREATE TABLE ANSWERS (id INT AUTO_INCREMENT PRIMARY KEY)")  # Especifica las columnas aquí
        if not table_questions_exists:
            cursor.execute("CREATE TABLE QUESTIONS (id INT AUTO_INCREMENT PRIMARY KEY)")  # Especifica las columnas aquí
        if not table_courses_exists:
            cursor.execute("CREATE TABLE COURSES (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(50), number VARCHAR(3))")  # Especifica las columnas aquí

        connection.commit()

    except Exception as e:
        print("Error:", e)

    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()

if __name__ == "__main__":
    print("Waiting to database to be ready...", flush=True)
    time.sleep(50)
    print("Startingt init-db.py ...", flush=True)
    create_tables_if_not_exist()
    print("Finished init-db.py ...", flush=True)
