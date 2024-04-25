import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import About from '../views/AboutView.vue'
import Dashboard from '../views/DashboardView.vue'
import NotFound from '../views/NotFound.vue'
import HumanCheck from '../views/HumanCheck.vue'

import { useToast } from "primevue/usetoast";
import { useUserStore } from '../stores/UserStore';


const router = createRouter({
    history: createWebHistory(import.meta.env.BASE_URL),
    routes: [
        {
            path: '/',
            name: 'home',
            component: HomeView
        },
        {
            path: '/about',
            name: 'about',
            component: About
        },
        {
            path: '/dashboard',
            name: 'dashboard',
            component: Dashboard,
            meta: { requiresAuth: true },
        },
        {
            path: '/human_check',
            name: 'humancheck',
            component: HumanCheck,
            meta: { requiresAuth: true }
        },
        { path: '/:pathMatch(.*)*', component: NotFound }
    ]
})

router.beforeEach((to, from, next) => {
    const store = useUserStore();
    const toast = useToast();

    if (to.meta.requiresAuth) {
        console.log("LogIn needed")

        if (!store.isLogged) {
            // No está autenticado, redirigir a la página de inicio
            toast.add({ severity: 'info', summary: 'LogIn', detail: 'You Should LogIn before that', life: 3000 });
            next({
                path: '/'
            });
        } else {
            // Está autenticado, permitir acceso al panel de control
            next();
        }
    } else {
        console.log("Not needed login")
        next();
    }
})

export default router
