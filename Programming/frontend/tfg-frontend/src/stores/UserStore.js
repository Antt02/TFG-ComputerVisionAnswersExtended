// UserStore.js

import { defineStore } from 'pinia'
import { computed } from 'vue'
import { ref } from 'vue'

const STORAGE_KEY = 'userStore'

export const useUserStore = defineStore('userStore', () => {
    const logged = ref(false)
    const user = ref(null)

    const isLogged = computed(() => logged.value)
    const getUser = computed(() => user.value)

    const login = (username, email) => {
        logged.value = true
        user.value = { username, email }
        // Guardar en almacenamiento local
        localStorage.setItem(STORAGE_KEY, JSON.stringify({ logged: true, user: { username, email } }))
    }

    const logout = () => {
        logged.value = false
        user.value = null
        // Eliminar del almacenamiento local
        localStorage.removeItem(STORAGE_KEY)
    }

    // Verificar el almacenamiento local al iniciar
    if (localStorage.getItem(STORAGE_KEY)) {
        const storedData = JSON.parse(localStorage.getItem(STORAGE_KEY))
        logged.value = storedData.logged
        user.value = storedData.user
    }

    return { isLogged, getUser, login, logout }
})
