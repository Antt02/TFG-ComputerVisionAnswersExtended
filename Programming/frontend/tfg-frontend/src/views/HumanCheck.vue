<template>
  <div class="full-page">
    <Toolbar class="toolbar">
      <div class="toolbar-content">
        <div class="toolbar-start">
          <svg viewBox="0 0 35 40" fill="none" xmlns="http://www.w3.org/2000/svg" class="toolbar-icon">
            <!-- Icono -->
          </svg>
          <Button label="Sobre Nosaltres" text plain />
          <Button label="Els Nostres Serveis" text plain />
          <Button label="Contacte" text plain />
        </div>
        <div class="toolbar-end">
          <Button label="Logout" icon="pi pi-sign-out" @click="handleLogout"/>
        </div>
      </div>
    </Toolbar>

    <div class="container">
      <div class="header">
        <h1 class="title">Revisió manual d'imatges</h1>
        <div class="instructions">
          <p>Instruccions: En el requadre superior inserteu el número dels primers requadres de la imatge, en el segon els segons.</p>
          <p>En cas de no haver cap número, deixar en blanc.</p>
        </div>
      </div>

      <div class="content">
        <template v-if="!moreImages">
          <img :src="currentImageSrc" alt="Imagen" width="250" style="margin-bottom: 30px;" />
        </template>
        <template v-else>
          <div style="color: gray; margin-bottom: 30px;">No queden més imatges per analitzar</div>
        </template>

        <div class="form-container">
          <div style="margin-bottom: 30px;">
            <FloatLabel>
              <InputText id="primeraResposta" v-model="primeraResposta" :disabled="moreImages" />
              <label for="primeraResposta">Primera Resposta</label>
            </FloatLabel>
          </div>
          <div>
            <FloatLabel>
              <InputText id="segonaResposta" v-model="segonaResposta" :disabled="moreImages" />
              <label for="segonaResposta">Segona Resposta</label>
            </FloatLabel>
          </div>
        </div>
        <Button label="Imatge Següent" icon="pi pi-arrow-right" iconPos="right" @click="showNextImage" style="margin-top: 30px" :disabled="moreImages" />
        <Button label="Tornar a Inici" icon="pi pi-home" iconPos="right" @click="finished" style="margin-top: 30px" :disabled="!moreImages" />
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import { useUserStore } from '../stores/UserStore';
import { useRouter } from "vue-router";

export default {
  data() {
    return {
      images: [],
      currentImageIndex: 0,
      primeraResposta: "",
      segonaResposta: "",
      imageName: "",
      moreImages: false
    };
  },
  created() {
    this.fetchImages();
  },
  methods: {
    async fetchImages() {
      try {
        const store = useUserStore();
        const username = store.getUser.username;
        const response = await axios.get(`http://127.0.0.1:8081/humancheckimages/${username}?image_index=${this.currentImageIndex}`);
        if (response.status == 200) {
          const imageData = new Uint8Array(response.data.image);
          const blob = new Blob([imageData], {type:"image/png"});
          this.images.push(URL.createObjectURL(blob));
          this.imageName = response.data.imagename
          this.moreImages = false; 
        } else if (response.status == 404) { 
          this.moreImages = true;
        } else {
          console.error('Error al obtener las imágenes:', response.statusText);
        }
      } catch (error) {
        this.moreImages = true;
      }
    },
    showNextImage() {
      console.log("ImageName:", this.imageName);
      console.log("Primera respuesta:", this.primeraResposta);
      console.log("Segona resposta:", this.segonaResposta);

      const regexPattern = /questid_(.*?)_file_(.*?)_answer_(.*?)_(.*?)\.png/;

      const matches = this.imageName.match(regexPattern);
      if (matches) {
        const questId = matches[1];
        const fileId = matches[2];
        const answer = matches[3];
        const user = matches[4];

        console.log("Quest ID REGEX:", questId);
        console.log("File ID REGEX:", fileId);
        console.log("Answer REGEX:", answer);
        console.log("User REGEX:", user);

        const data ={
          resposta1: this.primeraResposta,
          resposta2: this.segonaResposta
        }
        const response = axios.post(`http://localhost:8081/updateanswer/${questId}/${answer}`, data);
      } else {
       console.log("No se encontraron coincidencias");
      }

      try{
        const store = useUserStore();
        const username = store.getUser.username;
        const response = axios.delete(`http://localhost:8081/deleteimage/${username}/${this.imageName}`);
      } catch (error) {
        console.error('Error al eliminar la imagen:', error);
      }

      this.imageName = ""
      this.primeraResposta = ""
      this.segonaResposta = ""
      this.currentImageIndex++;
      this.fetchImages();
    },
    finished(){
      const router = useRouter();
      router.push('/dashboard');
      console.log("user has finished")
    }
  },
  computed: {
    currentImageSrc() {
      return this.images[this.currentImageIndex];
    }
  }
};
</script>

<style scoped>
.container {
  display: flex;
  flex-direction: column;
  align-items: center;
  height: 100vh;
}

.header {
  text-align: center;
  margin-bottom: 30px;
}

.title {
  font-size: 45px;
  margin-bottom: 10px;
}

.instructions {
  font-size: 14px;
  color: gray;
}

.content {
  display: flex;
  flex-direction: column;
  align-items: center;
}
.toolbar-content {
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 100%;
}

.toolbar-start {
  display: flex;
  align-items: center;
  gap: 10px;
}

.toolbar-end {
  display: flex;
  align-items: center;
}

.toolbar-icon {
  width: 2rem;
}

.toolbar-end .p-button {
  margin-left: auto;
}
</style>