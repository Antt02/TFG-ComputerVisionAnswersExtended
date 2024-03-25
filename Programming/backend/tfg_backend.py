import fastapi
import time
import mysql.connector
import bcrypt
import uvicorn

def connect_db():
    global connection
    try:
        time.sleep(50) #Wait to db to finish starting
        connection = mysql.connector.connect(
            host="mysql",
            user="user",
            password="password",
            database="db"
        )
        print("Connected Backend to tb", flush=True)
    except Exception as e:
        print("Error:", e)


app = fastapi.FastAPI()

@app.get("/test")
def test():
    return {"message": "Working Service"}

@app.post("/register")
def register(username: str, password: str, email: str):
    cursor = connection.cursor()
    try:
        password_bytes = password.encode("utf-8")
        hashed_pw = bcrypt.hashpw(password_bytes, bcrypt.gensalt(14))
        cursor.execute("INSERT INTO users (username, password, email) VALUES (%s, %s, %s)", (username, hashed_pw.decode("utf-8"), email))
        connection.commit()
        return {"message": "User registered successfully"}
    except mysql.connector.Error as err:
        raise fastapi.HTTPException(status_code=500, detail=f"Internal server error: {err}")
    finally:
        cursor.close()



@app.post("/login")
def login(username: str, password: str):
    cursor = connection.cursor()
    cursor.execute("SELECT password FROM users WHERE username = %s", (username,))
    user_data = cursor.fetchone()
    cursor.close()

    if user_data:
        hashed_pw = user_data[0].encode("utf-8")
        if bcrypt.checkpw(password.encode("utf-8"), hashed_pw):
            return {"message": "Login successful"}
        else:
            raise fastapi.HTTPException(status_code=401, detail="Incorrect password")
    else:
        raise fastapi.HTTPException(status_code=404, detail="User not found")

if __name__ == "__main__":
    connect_db()
    uvicorn.run(app, host="0.0.0.0", port=8081)