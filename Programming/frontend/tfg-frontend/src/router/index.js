import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import About from '../views/AboutView.vue'
import Dashboard from '../views/DashboardView.vue'
import NotFound from '../views/NotFound.vue'

import { useToast } from "primevue/usetoast";

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
      meta: {requiresAuth: true},
    },
    { path: '/:pathMatch(.*)*', component: NotFound}
  ]
})
router.beforeEach((to, from) => {
  if (to.meta.requiresAuth) {  
  const toast = useToast();
    console.log("LogIn needed")
    toast.add({ severity: 'info', summary: 'LogIn', detail: 'You Should LogIn before that', life: 3000 });
    return {
      path: '/'
    }
  }
})
export default router
