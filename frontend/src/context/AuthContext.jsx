import { createContext, useContext, useMemo, useState } from 'react';

const STORAGE_KEY = 'erp-auth';
const AuthContext = createContext(null);

const defaultState = {
  token: null,
  profile: null,
};

export const AuthProvider = ({ children }) => {
  const [authState, setAuthState] = useState(() => {
    const stored = localStorage.getItem(STORAGE_KEY);
    return stored ? JSON.parse(stored) : defaultState;
  });

  const login = (payload) => {
    setAuthState(payload);
    localStorage.setItem(STORAGE_KEY, JSON.stringify(payload));
  };

  const logout = () => {
    setAuthState(defaultState);
    localStorage.removeItem(STORAGE_KEY);
  };

  const value = useMemo(
    () => ({
      token: authState.token,
      profile: authState.profile,
      login,
      logout,
    }),
    [authState],
  );

  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>;
};

export const useAuth = () => useContext(AuthContext);

