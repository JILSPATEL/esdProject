import type { ReactNode } from 'react';
import { createContext, useContext, useMemo, useState } from 'react';

const STORAGE_KEY = 'erp-auth';

type Profile = {
  email: string;
  studentId?: string;
  firstName?: string;
  lastName?: string;
  rollNumber?: string;
};

type AuthState = {
  token: string | null;
  profile: Profile | null;
};

type AuthContextValue = AuthState & {
  login: (payload: AuthState) => void;
  logout: () => void;
};

const defaultState: AuthState = {
  token: null,
  profile: null,
};

const AuthContext = createContext<AuthContextValue | null>(null);

type AuthProviderProps = {
  children: ReactNode;
};

export const AuthProvider = ({ children }: AuthProviderProps) => {
  const [authState, setAuthState] = useState<AuthState>(() => {
    const stored = localStorage.getItem(STORAGE_KEY);
    if (stored) {
      try {
        return JSON.parse(stored) as AuthState;
      } catch {
        return defaultState;
      }
    }
    return defaultState;
  });

  const login = (payload: AuthState) => {
    setAuthState(payload);
    localStorage.setItem(STORAGE_KEY, JSON.stringify(payload));
  };

  const logout = () => {
    setAuthState(defaultState);
    localStorage.removeItem(STORAGE_KEY);
  };

  const value = useMemo<AuthContextValue>(
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

export const useAuth = () => {
  const context = useContext(AuthContext);
  if (!context) {
    throw new Error('useAuth must be used within an AuthProvider');
  }
  return context;
};
