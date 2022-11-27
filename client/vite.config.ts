import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

// https://vitejs.dev/config/
export default defineConfig(() => {
  const processEnvViteValues = Object.keys(process.env).reduce((accum: Record<string, any>, key: string) => {
    if (key.startsWith('VITE_APP')) {
      accum[key] = `'${process.env[key]}'`;
    }

    return accum;
  }, {});

  return {
    define: {
      ...processEnvViteValues
    },
    plugins: [vue()],
    server: {
      port: 3000
    }
  }
})
