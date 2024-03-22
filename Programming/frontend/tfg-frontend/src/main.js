import { createApp } from 'vue'
import App from './App.vue'
import PrimeVue from 'primevue/config';
import ToastService from 'primevue/toastservice'
import router from './router';

import 'primevue/resources/themes/aura-light-amber/theme.css'
import 'primevue/resources/primevue.min.css'
import 'primeicons/primeicons.css'

import Button from "primevue/button"
import Checkbox from 'primevue/checkbox';
import Toast from 'primevue/toast';
import InputText from 'primevue/inputtext';
import Toolbar from 'primevue/toolbar';
import Dialog from 'primevue/dialog';


const app = createApp(App);
app.use(router)
app.use(PrimeVue);
app.use(ToastService);

app.component('Button', Button);
app.component('Checkbox', Checkbox);
app.component('Toast', Toast)
app.component('InputText', InputText)
app.component('Toolbar', Toolbar);
app.component('Dialog', Dialog);

app.mount('#app')