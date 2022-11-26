<script setup lang="ts">
import { ref, onMounted } from 'vue'

defineProps<{ msg: string }>()

const count = ref(0)
const name = ref('')
const email = ref('')
const password = ref('')
const users = ref([])

function reload() {
  fetch(import.meta.env.VITE_APP_API+'/api/users')
  .then((response) => response.json())
  .then(({data}) => {
    users.value = data;
  });
}

function submit() {
  fetch(import.meta.env.VITE_APP_API+'/api/users/create'+`?name=${name.value}&email=${email.value}&password=${password.value}`)
  .then(() => {
    reload();
  });
}

onMounted(async () => {
  reload();
})
</script>

<template>
  <h1>{{ msg }}</h1>

  <div class="card">
    <button type="button" @click="count++">count is {{ count }}</button>
    <p>
      Edit
      <code>components/HelloWorld.vue</code> to test HMR
    </p>
  </div>

  <p>
    Check out
    <a href="https://vuejs.org/guide/quick-start.html#local" target="_blank"
      >create-vue</a
    >, the official Vue + Vite starter
  </p>
  <p>
    Install
    <a href="https://github.com/johnsoncodehk/volar" target="_blank">Volar</a>
    in your IDE for a better DX
  </p>
  <p class="read-the-docs">Click on the Vite and Vue logos to learn more</p>

  <button @click="reload">Reload</button>
  <div>
    <ul>
      <li v-for="user in users" :key="user.id">
      {{user.name}}</li>
    </ul>
  </div>
  <div>
    <div>
      <input v-model="name" placeholder="name" />  
    </div>
    <div>
      <input v-model="email" placeholder="email"/>
    </div>
    <div>
      <input v-model="password" placeholder="password"/>
    </div>
    <div>
      <button @click="submit">Submit</button>
    </div>
  </div>
</template>

<style scoped>
.read-the-docs {
  color: #888;
}
</style>
