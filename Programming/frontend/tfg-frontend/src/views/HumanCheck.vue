<template>
  <div style="display: flex; flex-direction: column; justify-content: center; align-items: center; height: 100vh;">
    <template v-if= !moreImages>
      <img :src="currentImageSrc" alt="Imagen" width="250" style="margin-bottom: 30px;" />
    </template>
    <template v-else>
      <div style="color: gray; margin-bottom: 30px;" >No queden més imatges per analitzar</div>
    </template>
    <div class="form-container">
      <div style="margin-bottom: 30px;">
        <FloatLabel>
          <InputText id="primeraResposta" v-model="primeraResposta" :disabled = "moreImages"/>
          <label for="primeraResposta">Primera Resposta</label>
        </FloatLabel>
      </div>
      <div>
        <FloatLabel>
          <InputText id="segonaResposta" v-model="segonaResposta" :disabled = "moreImages"/>
          <label for="segonaResposta">Segona Resposta</label>
        </FloatLabel>
      </div>
    </div>
    <Button label="Imatge Següent" icon="pi pi-arrow-right" iconPos="right" @click="showNextImage" style="margin-top: 30px" :disabled = "moreImages" />
    <Button label="Tornar a Inici" icon="pi pi-home" iconPos="right" @click="finished" style="margin-top: 30px" :disabled = "!moreImages" />
  </div>
  </template>
  
<script>  
  import axios from 'axios';
  import { useUserStore } from '../stores/UserStore';
  
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

          // Hacer lo que necesites con los valores extraídos
          console.log("Quest ID REGEX:", questId);
          console.log("File ID REGEX:", fileId);
          console.log("Answer REGEX:", answer);
          console.log("User REGEX:", user);
        } else {
         console.log("No se encontraron coincidencias");
        }
        //Remove image from user
        this.imageName = ""
        this.primeraResposta = ""
        this.segonaResposta = ""
        this.currentImageIndex++;
        this.fetchImages();
      },
      finished(){
        //Router redirect to Dashboard
        // Remove images from user
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