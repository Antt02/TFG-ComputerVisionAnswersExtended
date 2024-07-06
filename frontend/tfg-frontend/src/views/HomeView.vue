<template>
  <div class="card">
    <Toolbar style="padding: 1rem 1rem 1rem 1.5rem; z-index: 1;">
      <template #start>
        <div class="flex align-items-center gap-2">
          <svg viewBox="0 0 35 40" fill="none" xmlns="http://www.w3.org/2000/svg" style="width: 2rem; margin-right: 1rem">
            <!-- Icono -->
          </svg>
          <Button label="Sobre Nosaltres" text plain />
          <Button label="Els Nostres Serveis" text plain />
          <Button label="Contacte" text plain />
        </div>
      </template>
      <template #end>
        <div class="card flex justify-content-center">
          <Button label="Login" icon="pi pi-user" @click="loginVisible = true" />
            <Dialog v-model:visible="loginVisible" modal :pt="{ root: 'border-none', mask: { style: 'backdrop-filter: blur(2px)' } }">
              <template #container="{ closeCallback }">
                <div class="login-container">
                  <div class="login-title">Login</div>
                    <form @submit.prevent="handleLogin">
                      <div class="p-float-label">
                        <InputText id="username" v-model="username" type="username"/>
                        <label for="username">Username</label>
                      </div>
                      <div class="p-float-label">
                        <InputText id="password" v-model="password" type="password"/>
                        <label for="password">Password</label>
                      </div>
                      <div class="flex align-items-center gap-3">
                        <Button label="Cancel" @click="closeCallback" text class="cancel-button" />
                        <Button type="submit" label="Sign-In" text class="signin-button" />
                      </div>
                    </form>
                  </div>
              </template>
          </Dialog>
        <span style="display:inline-block; width: 10px;"></span>
        <Button label="Register" icon="pi pi-user" @click="registerVisible = true" />
          <Dialog v-model:visible="registerVisible" modal :pt="{ root: 'border-none', mask: { style: 'backdrop-filter: blur(2px)' } }">
            <template #container="{ closeCallback }">
              <div class="register-container">
                <div class="register-title">Register</div>
                <form @submit.prevent="handleRegister">
                  <div class="p-float-label">
                    <InputText id="username" v-model="username" type="username"/>
                    <label for="username">Username</label>
                  </div>
                  <div class="p-float-label">
                    <InputText id="password" v-model="password" type="password"/>
                    <label for="password">Password</label>
                  </div>
                  <div class="p-float-label">
                    <InputText id="email" v-model="email" type="email"/>
                    <label for="email">Email</label>
                  </div>
                  <div class="flex align-items-center gap-3">
                    <Button label="Cancel" @click="closeCallback" text class="cancel-button" />
                    <Button type="submit" label="Sign-Up" text class="signup-button" />
                  </div>
                </form>
              </div>
            </template>
          </Dialog>
        </div>
      </template>
    </Toolbar>
  </div>
  <div class="landing-page">
    <div class="content">
      <h1>
        <span class="line1">Benvingut a</span><br>
        <span class="line2">Auto Resposta!</span>
      </h1>
      <h2>L'eina de processament de respostes automàtica</h2>
      <div class="image-container">
        <img class="landing-image" src="../components/pc_phone.png" alt="Mockup" />
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue';
import { useRouter } from 'vue-router';
import { useToast } from "primevue/usetoast";
import { useUserStore } from '../stores/UserStore';

import axios from 'axios'

const router = useRouter();
const store = useUserStore();
const loginVisible = ref(false);
const registerVisible = ref(false);
const username = ref('');
const password = ref('');
const toast = useToast();

const handleLogin = () => {
  if (process.env.NODE_ENV != "development"){
      axios.post('http://127.0.0.1:8081/login', {
      username: username.value,
      password: password.value
    })
    .then(response => {
      console.log(response.data);
      const { username, email } = response.data;
      console.log("---- STORE USER ---")
      store.login(username, email)
      console.log(store.getUser)
      router.push('/dashboard');
    })
    .catch(error => {
      if (error.response) {
        const statusCode = error.response.status;
        switch (statusCode) {
          case 400:
            toast.add({ severity: 'error', summary: 'Login Error', detail: 'Introduce el usuario y la contraseña', life: 3000 });
            break;
          case 401:
            toast.add({ severity: 'error', summary: 'Login Error', detail: 'Contraseña incorrecta', life: 3000 });
            break;
          case 404:
            toast.add({ severity: 'error', summary: 'Login Error', detail: 'Usuario no encontrado', life: 3000 });
            break;
          default:
            toast.add({ severity: 'error', summary: 'Login Error', detail: 'Error inesperado', life: 3000 });
        }
      } else {
        toast.add({ severity: 'error', summary: 'Login Error', detail: 'Error: ' + error.message, life: 3000 });
      }
    });
  }else{ //For development
    store.login("admin-dev", "admin-dev")
    router.push('/dashboard');
  }

};

// TODO: review and addapt propperly
const handleRegister = () => {
  if (process.env.NODE_ENV != "development"){
      axios.post('http://127.0.0.1:8081/register', {
      username: username.value,
      password: password.value
    })
    .then(response => {
      console.log(response.data);
      const { username, email } = response.data;
      console.log("---- STORE USER ---")
      store.login(username, email)
      console.log(store.getUser)
      // router.push('/dashboard');
    })
    .catch(error => {
      if (error.response) {
        const statusCode = error.response.status;
        switch (statusCode) {
          case 400:
            toast.add({ severity: 'error', summary: 'Login Error', detail: 'Introduce el usuario y la contraseña', life: 3000 });
            break;
          case 401:
            toast.add({ severity: 'error', summary: 'Login Error', detail: 'Contraseña incorrecta', life: 3000 });
            break;
          case 404:
            toast.add({ severity: 'error', summary: 'Login Error', detail: 'Usuario no encontrado', life: 3000 });
            break;
          default:
            toast.add({ severity: 'error', summary: 'Login Error', detail: 'Error inesperado', life: 3000 });
        }
      } else {
        toast.add({ severity: 'error', summary: 'Login Error', detail: 'Error: ' + error.message, life: 3000 });
      }
    });
  }else{ //For development
    store.login("admin-dev", "admin-dev")
    router.push('/dashboard');
  }

};
</script>

<style scoped>
@font-face {
  font-family: 'San Francisco';
  src: url('https://github.com/sahibjotsaggu/San-Francisco-Pro-Fonts/raw/master/SF-Pro-Display-Regular.otf') format('otf');
}

.landing-page {
  font-family: 'San Francisco', Arial, sans-serif;
  background-color: #ffffff;
  height: 89vh;
  display: flex;
  justify-content: center;
  vertical-align: center;
  position: relative; /* Añadimos posición relativa para contener el texto */
}

.content {
  text-align: center;
  display: flex;
  flex-direction: column;
  align-items: center;
  position: relative; /* Añadimos posición relativa para contener el texto */
  z-index: 2; /* Asegura que el texto esté sobre la barra de navegación */
}


h1 {
  margin-top: 20px;
  font-size: 70px;
  line-height: 60px;
  background: linear-gradient(to right, var(--primary-500), var(--primary-800)); /* Degradado de verde a verde oscuro */
  -webkit-background-clip: text; /* Clip para que el degradado solo afecte al texto */
  -webkit-text-fill-color: transparent; /* Relleno transparente para que el texto sea visible */
}

h2 {
  color: #333;
  margin-top: -20px; /* Espacio entre el h1 y el h2 */
}


.image-container {
  vertical-align: top;
  width: auto;
  max-height: auto;
  overflow: hidden;
  mask-image: linear-gradient(
    black 85%,
    transparent
  );
}

.landing-image {
  margin-top: 10px;
  width: 55%; /* Ancho del 80% del contenedor */
  height: auto; /* Altura automática para mantener la proporción */
  vertical-align: top;
}

.login-container, .register-container {
  background-color: #f8f8f8;
  border-radius: 12px;
  padding: 40px;
  text-align: center;
  box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.1);
}

.login-title, .register-title {
  color: #000;
  font-size: 24px;
  margin-bottom: 40px;
}

.p-float-label {
  margin-bottom: 30px;
}

.cancel-button, .signin-button, .signup-button {
  border-radius: 8px;
  padding: 12px 24px;
  font-weight: 500;
  cursor: pointer;
}

.cancel-button {
  background-color: #e5e5e5;
  border: 1px solid #ccc;
  color: #666;
}

.signin-button, .signup-button {
  background-color: #0070e0;
  border: 1px solid #0070e0;
  color: #fff;
  margin-left: 50px;
}

.cancel-button:hover {
  background-color: #ccc;
}

.signin-button:hover, .signup-button:hover {
  background-color: #005bb2;
}
</style>
