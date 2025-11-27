import axios from 'axios';

type StoredAuth = {
  token?: string | null;
};

const apiClient = axios.create({
  baseURL: import.meta.env.VITE_API_BASE_URL || 'http://localhost:8080',
});

apiClient.interceptors.request.use((config) => {
  const stored = localStorage.getItem('erp-auth');

  if (stored) {
    try {
      const parsed: unknown = JSON.parse(stored);

      if (typeof parsed === 'object' && parsed !== null && 'token' in parsed) {
        const token = (parsed as StoredAuth).token;

        if (token) {
          config.headers = {
            ...config.headers,
            Authorization: `Bearer ${token}`,
          };
        }
      }
    } catch {
      // ignore invalid payload
    }
  }

  return config;
});

export default apiClient;

