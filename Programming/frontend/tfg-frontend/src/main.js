import { createApp } from 'vue'
import { createPinia } from 'pinia'
import App from './App.vue'
import PrimeVue from 'primevue/config';
import ToastService from 'primevue/toastservice'
import router from './router';

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

const app = createApp(App);

app.use(router)
app.use(createPinia())
app.use(PrimeVue);
app.use(ToastService);

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

app.mount('#app')