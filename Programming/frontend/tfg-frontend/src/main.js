import { createApp } from 'vue'
import { createPinia } from 'pinia'
import App from './App.vue'
import PrimeVue from 'primevue/config';
import ToastService from 'primevue/toastservice'
import router from './router';
import axios from 'axios';

import 'primevue/resources/themes/lara-light-green/theme.css'
import 'primevue/resources/primevue.min.css'
import 'primeicons/primeicons.css'

import Button from "primevue/button"
import Toast from 'primevue/toast';
import InputText from 'primevue/inputtext';
import Toolbar from 'primevue/toolbar';
import Dialog from 'primevue/dialog';
import AutoComplete from 'primevue/autocomplete';
import FileUpload from 'primevue/fileupload';
import Dropdown from 'primevue/dropdown';
import Calendar from 'primevue/calendar';
import SelectButton from 'primevue/selectbutton';
import ProgressSpinner from 'primevue/progressspinner';
import Image from 'primevue/image';
import FloatLabel from 'primevue/floatlabel';
import ConfirmDialog from 'primevue/confirmdialog';
import ConfirmationService from 'primevue/confirmationservice';

const app = createApp(App);

app.use(router)
app.use(createPinia())
app.use(PrimeVue);
app.use(ToastService);
app.use(ConfirmationService);

app.component('Dropdown', Dropdown);
app.component('Button', Button);
app.component('AutoComplete', AutoComplete);
app.component('Toast', Toast)
app.component('InputText', InputText)
app.component('Toolbar', Toolbar);
app.component('Dialog', Dialog);
app.component('FileUpload', FileUpload);
app.component('Calendar', Calendar);
app.component('SelectButton', SelectButton);
app.component('ProgressSpinner', ProgressSpinner);
app.component('Image', Image);
app.component('FloatLabel', FloatLabel);
app.component('ConfirmDialog', ConfirmDialog);

app.config.globalProperties.$http = axios;

app.mount('#app')