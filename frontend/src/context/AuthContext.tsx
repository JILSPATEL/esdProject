import type { ReactNode } from 'react';
import { createContext, useContext, useEffect, useMemo, useState } from 'react';

const SESSION_STORAGE_KEY = 'erp-auth'; // Unique per tab
const LOGIN_EVENT_KEY = 'erp-login-event'; // Shared across tabs

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
  // Initialize state from sessionStorage (Tab-specific)
  const [authState, setAuthState] = useState<AuthState>(() => {
    if (typeof window === 'undefined') return defaultState;

    const stored = sessionStorage.getItem(SESSION_STORAGE_KEY);
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
    sessionStorage.setItem(SESSION_STORAGE_KEY, JSON.stringify(payload));

    // Broadcast login event to other tabs
    if (payload.profile?.email) {
      localStorage.setItem(LOGIN_EVENT_KEY, JSON.stringify({
        email: payload.profile.email,
        timestamp: Date.now()
      }));
    }
  };

  const logout = () => {
    setAuthState(defaultState);
    sessionStorage.removeItem(SESSION_STORAGE_KEY);
  };

  // Listen for login events from other tabs
  useEffect(() => {
    const handleStorageChange = (event: StorageEvent) => {
      if (event.key === LOGIN_EVENT_KEY && event.newValue) {
        try {
          const loginEvent = JSON.parse(event.newValue);

          // If the SAME user logged in from another tab, logout this tab
          // (Enforces single session per user)
          if (authState.profile?.email === loginEvent.email) {
            // Check if it's a recent event (to avoid stale events on reload)
            // But localStorage events only fire on change, so it's fresh.
            logout();
          }

          // If a DIFFERENT user logged in, do nothing.
          // This tab stays logged in as User A, while other tab is User B.

        } catch (e) {
          // Ignore invalid JSON
        }
      }
    };

    window.addEventListener('storage', handleStorageChange);
    return () => window.removeEventListener('storage', handleStorageChange);
  }, [authState.profile?.email]);

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
