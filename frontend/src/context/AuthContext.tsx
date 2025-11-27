import type { ReactNode } from 'react';
import { createContext, useContext, useEffect, useMemo, useRef, useState } from 'react';

const STORAGE_KEY = 'erp-auth';
const ACTIVE_TAB_KEY = 'erp-active-tab';
const TAB_CHECK_INTERVAL = 1000; // Check every second

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
  sessionId?: string | null;
  activeTabId?: string | null;
};

type AuthContextValue = AuthState & {
  login: (payload: AuthState) => void;
  logout: () => void;
};

const defaultState: AuthState = {
  token: null,
  profile: null,
  sessionId: null,
  activeTabId: null,
};

const AuthContext = createContext<AuthContextValue | null>(null);

type AuthProviderProps = {
  children: ReactNode;
};

const generateSessionId = (): string => {
  return `${Date.now()}-${Math.random().toString(36).substring(2, 15)}`;
};

const generateTabId = (): string => {
  return `tab-${Date.now()}-${Math.random().toString(36).substring(2, 15)}`;
};

export const AuthProvider = ({ children }: AuthProviderProps) => {
  // Generate unique tab ID that persists for this tab's lifetime
  const tabId = useRef(generateTabId());
  
  const [authState, setAuthState] = useState<AuthState>(() => {
    const stored = localStorage.getItem(STORAGE_KEY);
    if (stored) {
      try {
        const parsed = JSON.parse(stored) as AuthState;
        // Only restore auth if this tab is the active one
        if (parsed.activeTabId === tabId.current) {
          return parsed;
        }
      } catch {
        return defaultState;
      }
    }
    return defaultState;
  });

  const currentSessionId = useRef(authState.sessionId);

  // Keep ref in sync with authState.sessionId
  useEffect(() => {
    currentSessionId.current = authState.sessionId;
  }, [authState.sessionId]);

  const login = (payload: AuthState) => {
    const sessionId = generateSessionId();
    const newState = { ...payload, sessionId, activeTabId: tabId.current };
    currentSessionId.current = sessionId;
    setAuthState(newState);
    localStorage.setItem(STORAGE_KEY, JSON.stringify(newState));
    localStorage.setItem(ACTIVE_TAB_KEY, tabId.current);
  };

  const logout = () => {
    currentSessionId.current = null;
    setAuthState(defaultState);
    localStorage.removeItem(STORAGE_KEY);
    localStorage.removeItem(ACTIVE_TAB_KEY);
  };

  // Periodically check if this tab is still the active one
  useEffect(() => {
    const checkActiveTab = () => {
      // If not logged in, nothing to check
      if (!authState.token || !authState.profile?.email) return;

      const activeTab = localStorage.getItem(ACTIVE_TAB_KEY);
      const stored = localStorage.getItem(STORAGE_KEY);
      
      // If this tab is not the active tab, check if it's the same user
      if (activeTab !== tabId.current && stored) {
        try {
          const storedAuth = JSON.parse(stored) as AuthState;
          
          // Only logout if it's the SAME user who logged in from another tab
          if (storedAuth.profile?.email === authState.profile.email) {
            setAuthState(defaultState);
            currentSessionId.current = null;
          }
        } catch {
          // Invalid data, ignore
        }
      }
    };

    // Check immediately
    checkActiveTab();

    // Then check periodically
    const interval = setInterval(checkActiveTab, TAB_CHECK_INTERVAL);
    return () => clearInterval(interval);
  }, [authState.token, authState.profile?.email]);

  // Listen for storage changes from other tabs
  useEffect(() => {
    const handleStorageChange = (event: StorageEvent) => {
      // Check for active tab changes
      if (event.key === ACTIVE_TAB_KEY) {
        const newActiveTab = event.newValue;
        
        // If another tab became active and we're logged in, check if same user
        if (newActiveTab && newActiveTab !== tabId.current && authState.token) {
          const stored = localStorage.getItem(STORAGE_KEY);
          if (stored) {
            try {
              const storedAuth = JSON.parse(stored) as AuthState;
              
              // Only logout if it's the SAME user who logged in from another tab
              if (storedAuth.profile?.email === authState.profile?.email) {
                setAuthState(defaultState);
                currentSessionId.current = null;
              }
            } catch {
              // Invalid data, ignore
            }
          }
        }
        return;
      }

      // Handle auth storage changes
      if (event.key !== STORAGE_KEY) return;

      // If storage was cleared (logout in another tab), logout here too
      if (!event.newValue) {
        if (currentSessionId.current) {
          setAuthState(defaultState);
          currentSessionId.current = null;
        }
        return;
      }

      try {
        const newAuth = JSON.parse(event.newValue) as AuthState;
        
        // Only logout if it's the SAME user logging in from a different tab
        if (newAuth.activeTabId && newAuth.activeTabId !== tabId.current) {
          // Check if it's the same user
          if (newAuth.profile?.email === authState.profile?.email) {
            setAuthState(defaultState);
            currentSessionId.current = null;
          }
        }
      } catch {
        // Invalid data, ignore
      }
    };

    window.addEventListener('storage', handleStorageChange);
    return () => window.removeEventListener('storage', handleStorageChange);
  }, [authState.token, authState.profile?.email]);

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
