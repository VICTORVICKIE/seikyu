import { CapacitorConfig } from '@capacitor/cli';

const config: CapacitorConfig = {
  appId: 'in.blacklunar.seikyu',
  appName: 'seikyu',
  webDir: 'dist',
  server: {
    androidScheme: 'https'
  }
};

export default config;
