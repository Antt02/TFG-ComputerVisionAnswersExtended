<template>
  <div class="full-page">
    <Toolbar class="toolbar">
      <template #start>
        <div class="toolbar-start">
          <svg viewBox="0 0 35 40" fill="none" xmlns="http://www.w3.org/2000/svg" class="toolbar-icon">
            <!-- Icono -->
          </svg>
          <Button label="Sobre Nosaltres" text plain />
          <Button label="Els Nostres Serveis" text plain />
          <Button label="Contacte" text plain />
        </div>
      </template>
      <template #end>
        <div class="toolbar-end">
          <Button label="Logout" icon="pi pi-sign-out" @click="handleLogout"/>
        </div>
      </template>
    </Toolbar>
    <div class="form-container">
      <!-- Número de expediente, número de acción formativa y número de grupo -->
      <div class="form-row">
        <div class="form-group">
          <div class="p-float-label">
            <InputText id="expedient_number" v-model="integer" type="integer" />
            <label for="expedient_number">Número d'expedient</label>
          </div>
        </div>
        <div class="form-group">
          <div class="p-float-label">
            <AutoComplete id="accio_formativa" v-model="value" :suggestions="accions_formatives" @complete="accions_formatives_search" />
            <label for="accio_formativa">Número de l'Acció Formativa</label>
          </div>
        </div>
        <div class="form-group">
          <div class="p-float-label">
            <InputText id="group_number" v-model="integer" type="integer" />
            <label for="group_number">Número de Grup</label>
          </div>
        </div>
      </div>

      <!-- Denominación y modalidad -->
      <div class="form-row">
        <div class="form-group">
          <div class="p-float-label">
            <InputText v-model="denomination" mode='disabled'/>
            <label for="denomination">Denominación</label>
          </div>
        </div>
        <div class="form-group">
          <Dropdown v-model="selectedModality" :options="modality" optionLabel="mode" placeholder="Selecciona Una Modalitat" class="w-full md:w-14rem" />
        </div>
      </div>

      <!-- Calendario de inicio y fin -->
      <div class="form-row">
        <div class="form-group">
          <div class="p-float-label">
            <Calendar v-model="start_date" dateFormat="dd/mm/yy" />
            <label for="start_date">Data d'Inici</label>
          </div>
        </div>
        <div class="form-group">
          <div class="p-float-label">
            <Calendar v-model="end_date" dateFormat="dd/mm/yy" />
            <label for="end_date">Data Finalització</label>
          </div>
        </div>
      </div>

      <!-- Uploads de la primera y última página -->
      <div class="form-row">
        <div class="form-group">
          <div class="card upload-card">
            <Toast />
            <FileUpload name="demo[]" url="/api/upload" @upload="firstPageUpload($event)" :multiple="true" accept="image/*" :maxFileSize="1000000">
              <template #empty>
                <p>Primera Pàgina</p>
              </template>
            </FileUpload>
          </div>
        </div>
        <div class="form-group">
          <div class="card upload-card">
            <Toast />
            <FileUpload name="demo[]" url="/api/upload" @upload="secondPageUpload($event)" :multiple="true" accept="image/*" :maxFileSize="1000000">
              <template #empty>
                <p>Segona Pàgina</p>
              </template>
            </FileUpload>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from "vue";
import { useToast } from "primevue/usetoast";
import { useRouter } from "vue-router";

const toast = useToast();
const router = useRouter();

const value = ref("");
const accions_formatives = ref([]);

const accions_formatives_search = (event) => {
  accions_formatives.value = [...Array(10).keys()].map((item) => event.query + '-' + item); //TODO: Implementar lógica coger datos de bbdd
}
const selectedModality = ref();
const modality = ref([
    { mode: 'Presencial'},
    { mode: 'Virtual'}
]);
const start_date = ref();
const end_date = ref();
const integer = ref();
const denomination = ref("");

const firstPageUpload = () => {
    toast.add({ severity: 'info', summary: 'Success', detail: 'File Uploaded', life: 3000 });
};
const secondPageUpload = () => {
    toast.add({ severity: 'info', summary: 'Success', detail: 'File Uploaded', life: 3000 });
};

const handleLogout = () => {
  // Lógica para cerrar sesión (ejemplo: eliminar credenciales de sesión)
  router.push('/'); // Redirigir a la página de inicio (u otra página deseada)
};
</script>

<style scoped>
.full-page {
  display: flex;
  flex-direction: column;
  height: 100vh;
  padding: 20px;
}

.toolbar {
  flex: 0;
}

.form-container {
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
}

.form-row {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  gap: 20px;
  margin-bottom: 10px;
  margin-top: 35px;
}

.form-group {
  flex: 1;
  max-width: 400px; /* Aumenta el ancho del formulario */
}

.p-float-label {
  width: 100%;
}

.card.upload-card {
  width: 600px; /* Aumenta el ancho de los uploads */
  height: 500px; /* Aumenta la altura de los uploads */
  margin-bottom: 10px;
}

.toolbar-start {
  display: flex;
  align-items: center;
  gap: 10px;
}

.toolbar-icon {
  width: 2rem;
}

.toolbar-end {
  margin-left: auto;
}
</style>
