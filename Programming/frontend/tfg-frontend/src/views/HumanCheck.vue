<template>
  <div>
    <Button label="Imatge Següent" icon="pi pi-arrow-right" iconPos="right" @click="showNextImage" :disabled="buttonDisabled"/>
    <img :src="currentImageSrc" alt="Imagen" width="250" />
  </div>
</template>

<script>
import { useUserStore } from '../stores/UserStore';

export default {
  data() {
    return {
      images: [],
      currentImageIndex: 0,
      buttonDisabled: false // Añade una propiedad para controlar el estado del botón
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
        const response = await fetch(`http://127.0.0.1:8081/humancheckimages/${username}?image_index=${this.currentImageIndex}`);
        
        if (response.ok) { // Verifica si la respuesta fue exitosa
          const imageData = await response.blob();
          this.images.push(URL.createObjectURL(imageData));
          this.buttonDisabled = false; // Restablece el estado del botón si la respuesta fue exitosa
        } else if (response.status === 404) { // Maneja el error 404
          this.buttonDisabled = true; // Deshabilita el botón si el índice no es correcto
        } else {
          console.error('Error al obtener las imágenes:', response.statusText);
        }
      } catch (error) {
        console.error('Error al obtener las imágenes:', error);
      }
    },
    showNextImage() {
      this.currentImageIndex = (this.currentImageIndex + 1);
      this.fetchImages();
    }
  },
  computed: {
    currentImageSrc() {
      return this.images[this.currentImageIndex];
    }
  }
};
</script>
