import axios from 'axios';

const apiClient = axios.create({
  baseURL: import.meta.env.VITE_API_BASE_URL || 'http://localhost:8080',
  withCredentials: true,
});

// Add a request interceptor to include the JWT token in the Authorization header
apiClient.interceptors.request.use(
  (config) => {
    // Get token from sessionStorage (Tab-specific)
    const authData = sessionStorage.getItem('erp-auth');
    if (authData) {
      try {
        const parsed = JSON.parse(authData);
        if (parsed.token) {
          config.headers.Authorization = `Bearer ${parsed.token}`;
        }
      } catch (error) {
        console.error('Failed to parse auth data:', error);
      }
    }
    return config;
  },
  (error) => {
    return Promise.reject(error);
  }
);

export default apiClient;
