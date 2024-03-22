<template>
  <div class="card">
    <Toolbar style="border-radius: 3rem; padding: 1rem 1rem 1rem 1.5rem">
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
          <Button label="Login" icon="pi pi-user" @click="visible = true" />
          <Dialog v-model:visible="visible" modal :pt="{ root: 'border-none', mask: { style: 'backdrop-filter: blur(2px)' } }">
            <template #container="{ closeCallback }">
              <div class="login-container">
                <div class="login-title">Login</div>
                <div class="p-float-label">
                  <InputText id="username" v-model="username" />
                  <label for="username">Username</label>
                </div>
                <div class="p-float-label">
                  <InputText id="password" v-model="password" />
                  <label for="password">Password</label>
                </div>
                <div class="flex align-items-center gap-3">
                  <Button label="Cancel" @click="closeCallback" text class="cancel-button" />
                  <Button label="Sign-In" @click="closeCallback" text class="signin-button" />
                </div>
              </div>
            </template>
          </Dialog>
        </div>
      </template>
    </Toolbar>
  </div>
  <div class="landing-page">
    <div class="content">
      <h1>Benvingut a Auto Resposta!</h1>
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

const router = useRouter();
const visible = ref(false);
</script>

<style scoped>
@font-face {
  font-family: 'San Francisco';
  src: url('https://github.com/sahibjotsaggu/San-Francisco-Pro-Fonts/raw/master/SF-Pro-Display-Regular.otf') format('otf');
}

.landing-page {
  font-family: 'San Francisco', Arial, sans-serif;
  background-color: #ffffff;
  height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
  overflow: hidden;
}

.content {
  text-align: center;
  display: flex;
  flex-direction: column;
  align-items: center;
}

h1, h2 {
  color: #333;
}

.image-container {
  width: auto;
  max-height: 100%;
  overflow: hidden;
}

.landing-image {
  width: 60%;
  height: auto;
  overflow: hidden;
}

.login-container {
  background-color: #f8f8f8;
  border-radius: 12px;
  padding: 40px;
  text-align: center;
  box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.1);
}

.login-title {
  color: #000;
  font-size: 24px;
  margin-bottom: 40px;
}

.p-float-label {
  margin-bottom: 30px;
}

.cancel-button, .signin-button {
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

.signin-button {
  background-color: #0070e0;
  border: 1px solid #0070e0;
  color: #fff;
  margin-left: 50px;
}

.cancel-button:hover {
  background-color: #ccc;
}

.signin-button:hover {
  background-color: #005bb2;
}
</style>
