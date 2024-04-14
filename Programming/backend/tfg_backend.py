import fastapi
import time
import os
import asyncio
import subprocess
import uuid
import shutil
import mysql.connector
import bcrypt
import uvicorn
import json
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from typing import List

class User(BaseModel):
    username: str
    email: str
    password: str

def connect_db():
    global connection
    try:
        time.sleep(50) # Wait for db to start
        connection = mysql.connector.connect(
            host="mysql",
            user="user",
            password="password",
            database="db"
        )
        print("Conectado Backend a tb", flush=True)
    except Exception as e:
        print("Error:", e)

app = fastapi.FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=[
        "http://127.0.0.1:8080",
        "http://localhost:8080",
        "http://0.0.0.0:8080"
        ],
    allow_credentials=True,
    allow_methods=["GET", "POST", "PUT", "DELETE", "OPTIONS"],
    allow_headers=["*"],
)

@app.get("/test")
def test():
    return {"message": "Servicio Funcionando"}

@app.post("/register")
def register(user: User):
    if not user.username or not user.password or not user.email:
        raise fastapi.HTTPException(status_code=400, detail="Falta nombre de usuario, contraseña o correo electrónico en la solicitud")

    cursor = connection.cursor()
    try:
        password_bytes = user.password.encode("utf-8")
        hashed_pw = bcrypt.hashpw(password_bytes, bcrypt.gensalt(14))
        cursor.execute("INSERT INTO users (username, password, email) VALUES (%s, %s, %s)", (user.username, hashed_pw.decode("utf-8"), user.email))
        connection.commit()
        return {"message": "Usuario registrado correctamente"}
    except mysql.connector.Error as err:
        raise fastapi.HTTPException(status_code=500, detail=f"Error interno del servidor: {err}")
    finally:
        cursor.close()

@app.post("/login")
async def login(request: fastapi.Request):
    data = await request.json()

    username = data.get("username")
    password = data.get("password")

    User.username = username

    if not username or not password:
        raise fastapi.HTTPException(status_code=400, detail="Falta nombre de usuario o contraseña en la solicitud")

    cursor = connection.cursor()
    try:
        cursor.execute("SELECT password, username, email FROM users WHERE username = %s", (username,))
        user_data = cursor.fetchone()
        
        if user_data:
            hashed_pw = user_data[0].encode("utf-8")
            if bcrypt.checkpw(password.encode("utf-8"), hashed_pw):
                return {"message": "Inicio de sesión exitoso", "username": user_data[1], "email": user_data[2]}
            else:
                raise fastapi.HTTPException(status_code=401, detail="Contraseña incorrecta")
        else:
            raise fastapi.HTTPException(status_code=404, detail="Usuario no encontrado")
    except mysql.connector.Error as err:
        raise fastapi.HTTPException(status_code=500, detail=f"Error interno del servidor: {err}")
    finally:
        cursor.close()

@app.get("/accionsformatives")
async def accionsformatives():
    cursor = connection.cursor(dictionary=True)  # Para obtener resultados como diccionarios
    try:
        cursor.execute("SELECT * FROM COURSES")
        courses = cursor.fetchall()
        return json.dumps(courses) 
    except mysql.connector.Error as err:
        raise fastapi.HTTPException(status_code=500, detail=f"Error interno del servidor: {err}")
    finally:
        cursor.close()

@app.post("/uploadfirstpage")
async def uploadfirstpage(files: List[fastapi.UploadFile]):
    upload_id = uuid.uuid4()
    print(upload_id)
    save_path = os.path.join("/app/files", str(upload_id), "first_page")
    os.makedirs(save_path, exist_ok=True)
    for file in files:
        file_path = os.path.join(save_path, file.filename)
        try:
            # Save the file to the destination directory
            with open(file_path, "wb") as buffer:
                shutil.copyfileobj(file.file, buffer)
        except Exception as e:
            # Handle any errors that occur during file saving
            raise fastapi.exceptions.HTTPException(status_code=500, detail=f"Failed to save file: {e}")
        finally:
            # Close the file stream
            file.file.close()
    return{"state":200, "uploadid":upload_id}


@app.post("/process")
async def process(request: fastapi.Request):
    data = await request.json()
    upload_id = data.get("upload_id")

    try:
        os.chdir("ml_module")
        #os.chdir("files/" + str(upload_id) + "/first_page")
        process = await asyncio.create_subprocess_exec(
            'python', 'responses.py', str("../files/" + upload_id + "/first_page"),
            stdout=asyncio.subprocess.PIPE,
            stderr=asyncio.subprocess.PIPE
        )
        stdout, stderr = await process.communicate()
        if stdout:
            print(f"Salida estándar: {stdout.decode()}")
        if stderr:
            print(f"Error estándar: {stderr.decode()}")
    except Exception as e:
        print("Error al ejecutar el comando: ", e)

    print("Processing " + str(upload_id))
    return "Processing " + str(upload_id)
    

if __name__ == "__main__":
    connect_db()
    uvicorn.run(app, host="0.0.0.0", port=8081)