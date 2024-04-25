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

    <div>
      <div v-if="loading" class="loading-spinner-container">
      <div class="card flex justify-content-center align-items-center">
        <ProgressSpinner />
      </div>
    </div>
    <div v-else>
      <div class="form-container">
        <!-- Número de expediente y acción formativa -->
        <div class="form-row">
          <div class="form-group">
            <div class="p-float-label">
              <InputText id="expedient_number" v-model="exp_number" type="integer" />
              <label for="expedient_number">Número d'expedient</label>
            </div>
          </div>
          <div class="form-group">
            <div class="p-float-label">
              <AutoComplete v-model="accio_formativa" inputId="accio_formativa" :suggestions="suggestions" @complete="accions_formatives_search" />
              <label for="accio_formativa">Acció Formativa</label>
            </div>
          </div>
        </div>
        
        <!-- Número de grupo y modalidad -->
      <div class="form-row">
        <!-- Número de grupo -->
        <div class="form-group">
          <div class="p-float-label">
            <InputText id="group_number" v-model="group_number" type="integer" />
            <label for="group_number">Número de Grup</label>
          </div>
        </div>
        <!-- Modalidad -->
        <div class="form-group">
          <div class="p-float-label">
            <SelectButton v-model="v_modality" :options="modality_options" aria-labelledby="Modalitat" />
          </div>
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
              <FileUpload name="files" url="http://127.0.0.1:8081/uploadfirstpage" @upload="firstPageUpload($event)" :multiple="true" accept="image/*" :maxFileSize="1000000000" @before-send="beforeSend">
                <template #empty>
                  <p>Primera Pàgina</p>
                </template>
              </FileUpload>
            </div>
          </div>

          <div class="upload-separator"></div> <!-- Separador -->

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

        <div class="submit-button-container">
          <Button label="Submit" icon="pi pi-check" iconPos="right" class="w-100" @click="submitForm"/>
        </div>

      </div>
    </div>
  </div>
</div>
</template>

<script setup>
import { onMounted, ref} from "vue";
import { useToast } from "primevue/usetoast";
import { useRouter } from "vue-router";
import { useUserStore } from '../stores/UserStore';

const toast = useToast();
const router = useRouter();
const store = useUserStore();

const accio_formativa = ref("");
const exp_number = ref("");
const group_number = ref("");

const start_date = ref();
const end_date = ref();
const integer = ref();
const denomination = ref("");

const loading = ref(false);

const accions_formatives = ref([]);
const suggestions = ref([]);

let tupleArray = [];

const accions_formatives_search = (event) => {
  const filteredTupleArray = tupleArray.filter(tuple => {
    const [id, name, number] = tuple;
    return number.includes(event.query) || name.toLowerCase().includes(event.query.toLowerCase());
  });

  // Formatea las sugerencias como número de acción formativa y nombre combinados
  suggestions.value = filteredTupleArray.map(tuple => `${tuple[2]} - ${tuple[1]}`); // Se asume que el número está en la tercera posición del tuple y el nombre en la segunda posición
};

onMounted(async () => {
  try {
    const response = await fetch('http://127.0.0.1:8081/accionsformatives');
    const accions_formatives_data = await response.json();
    accions_formatives.value = JSON.parse(accions_formatives_data);
    
    tupleArray = accions_formatives.value.map(item => [item.id, item.name, item.number]);

    console.log(tupleArray);
  } catch (error) {
    console.error('Error al obtener los datos del backend:', error);
  }
});


const v_modality = ref('Presencial');
const modality_options = ref(['Presencial', 'Virtual']);

const beforeSend = (request) => {
  request.xhr.setRequestHeader('Username', store.getUser.username);
  return request
}

const firstPageUpload = (event) => {
  const response = event.xhr.responseText;
  const responseData = JSON.parse(response);

  const responseStatus = responseData.state;

  if (responseStatus === 200) {
    // Mostrar el toast de éxito
    toast.add({ severity: 'info', summary: 'Success', detail: 'File Uploaded', life: 3000 });
  }
};

const secondPageUpload = () => {
    toast.add({ severity: 'info', summary: 'Success', detail: 'File Uploaded', life: 3000 });
};

const handleLogout = () => {
  store.logout()
  router.push('/');
};

const submitForm = () => {
  loading.value = true;
    fetch('http://127.0.0.1:8081/process', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Username' : store.getUser.username
      },
      body: JSON.stringify({
        "exp_number":exp_number.value,
        "accio_formativa":accio_formativa.value,
        "group_number":group_number.value,
        "v_modality":v_modality.value,
        "start_date":start_date._value,
        "end_date":end_date._value
      })
    })
    .then(response => {
      if (response.ok) {
        console.log('Processed');
      } else {
        console.error('Error al realizar la solicitud:', response.statusText);
      }
      loading.value = false
      router.push('/human_check');
    })
    .catch(error => {
      console.error('Error al realizar la solicitud:', error);
      loading.value = false
    });
  }
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
  max-width: 300px;
}

.p-float-label {
  width: 100%;
  max-width: 100%;
}

.card.upload-card {
  width: 500px;
  height: 300px;
  align-items: center;
  margin-bottom: 20px;
  box-sizing: border-box;
}


.upload-separator {
  width: 170px;
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

.submit-button-container {
  position: fixed;
  bottom: 0;
  right: 0;
  width: 100%;
  padding: 20px;
  text-align: right;
}

.loading-spinner-container {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  display: flex;
  justify-content: center;
  align-items: center;
  background-color: rgba(255, 255, 255, 0.7); /* Fondo semitransparente para resaltar el spinner */
  z-index: 9999; /* Asegúrate de que esté por encima de otros elementos */
}
</style>
