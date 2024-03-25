<template>
    <Toolbar style="border-radius: 3rem; padding: 1rem 1rem 1rem 1.5rem; z-index: 1;">
      <slot></slot>
    </Toolbar>
  </template>
  
  <script>
  import { Toolbar } from 'primevue/toolbar';
  
  export default {
    components: {
      Toolbar,
    },
  };
  </script>  