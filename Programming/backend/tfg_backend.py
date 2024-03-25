import fastapi
import time
import mysql.connector
import bcrypt
import uvicorn
from pydantic import BaseModel

class User(BaseModel):
    username: str
    email: str
    password: str


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
def register(user: User):
    if not user.username or not user.password or not user.email:
        raise fastapi.HTTPException(status_code=400, detail="Missing username, password, or email in request")

    cursor = connection.cursor()
    try:
        password_bytes = user.password.encode("utf-8")
        hashed_pw = bcrypt.hashpw(password_bytes, bcrypt.gensalt(14))
        cursor.execute("INSERT INTO users (username, password, email) VALUES (%s, %s, %s)", (user.username, hashed_pw.decode("utf-8"), user.email))
        connection.commit()
        return {"message": "User registered successfully"}
    except mysql.connector.Error as err:
        raise fastapi.HTTPException(status_code=500, detail=f"Internal server error: {err}")
    finally:
        cursor.close()



@app.post("/login")
async def login(request: fastapi.Request):
    data = await request.json()

    username = data.get("username")
    password = data.get("password")

    if not username or not password:
        raise fastapi.HTTPException(status_code=400, detail="Missing username or password in request")

    cursor = connection.cursor()
    try:
        cursor.execute("SELECT password FROM users WHERE username = %s", (username,))
        user_data = cursor.fetchone()
        
        if user_data:
            hashed_pw = user_data[0].encode("utf-8")
            if bcrypt.checkpw(password.encode("utf-8"), hashed_pw):
                return {"message": "Login successful"}
            else:
                raise fastapi.HTTPException(status_code=401, detail="Incorrect password")
        else:
            raise fastapi.HTTPException(status_code=404, detail="User not found")
    except mysql.connector.Error as err:
        raise fastapi.HTTPException(status_code=500, detail=f"Internal server error: {err}")
    finally:
        cursor.close()

if __name__ == "__main__":
    connect_db()
    uvicorn.run(app, host="0.0.0.0", port=8081)