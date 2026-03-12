import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vitejs.dev/config/
export default defineConfig({
  base: '/emotion-ebp-app/',
  plugins: [react()],
  server: {
    port: 3000,
    open: true
  },
  build: {
    outDir: 'dist'
  },
  assetsInclude: ['**/*.md'],
  optimizeDeps: {
    exclude: ['**/*.md']
  }
})