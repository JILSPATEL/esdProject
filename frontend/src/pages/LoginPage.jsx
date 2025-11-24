import { useEffect, useRef, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import apiClient from '../api/client';
import { useAuth } from '../context/AuthContext';

const LoginPage = () => {
  const { token, login } = useAuth();
  const navigate = useNavigate();
  const [scriptLoaded, setScriptLoaded] = useState(false);
  const [error, setError] = useState('');
  const buttonRef = useRef(null);
  const clientId = import.meta.env.VITE_GOOGLE_CLIENT_ID;

  useEffect(() => {
    if (token) {
      navigate('/dashboard', { replace: true });
    }
  }, [token, navigate]);

  useEffect(() => {
    if (window.google) {
      setScriptLoaded(true);
      return;
    }
    const script = document.createElement('script');
    script.src = 'https://accounts.google.com/gsi/client';
    script.async = true;
    script.defer = true;
    script.onload = () => setScriptLoaded(true);
    script.onerror = () => setError('Unable to load Google services. Please refresh.');
    document.body.appendChild(script);

    return () => {
      document.body.removeChild(script);
    };
  }, []);

  const handleCredentialResponse = async (response) => {
    setError('');
    if (!response?.credential) {
      setError('Google did not return a credential. Please try again.');
      return;
    }

    try {
      const { data } = await apiClient.post('/api/auth/login', {
        credential: response.credential,
      });

      if (data?.success) {
        const payload = {
          token: data.data.token,
          profile: {
            email: data.data.email,
            studentId: data.data.studentId,
            firstName: data.data.firstName,
            lastName: data.data.lastName,
            rollNumber: data.data.rollNumber,
          },
        };

        login(payload);
        navigate('/dashboard', { replace: true });
        return;
      }

      setError(data?.message || 'Unable to login. Please try again.');
    } catch (err) {
      if (err.response?.status === 401) {
        navigate('/no-record', { replace: true });
        return;
      }
      setError(err.response?.data?.message || 'Something went wrong. Please try again.');
    }
  };

  useEffect(() => {
    if (!scriptLoaded || !clientId || !window.google || !buttonRef.current) return;

    window.google.accounts.id.initialize({
      client_id: clientId,
      callback: handleCredentialResponse,
      ux_mode: 'popup',
    });

    window.google.accounts.id.renderButton(buttonRef.current, {
      theme: 'filled_black', // black button
      size: 'large',
      width: 320,
      shape: 'pill',
      text: 'signin_with',
    });
  }, [scriptLoaded, clientId]);

  return (
    <div className="screen login-screen">

      {/* NEW HEADER */}
      <div className="login-header">
        <h1 className="login-title">Welcome to ERP Billing Portal</h1>
        <p className="login-subtitle">Secure login using your institute Google Account</p>
      </div>

      {/* LOGIN CARD */}
      <div className="login-card">
        <div className="google-button-wrapper">
          <div ref={buttonRef} />
        </div>
        {error && <p className="error-text">{error}</p>}
      </div>

      {/* FOOTER */}
      <div className="login-footer">
        © 2025 ERP Billing System — All rights reserved.
      </div>
      
    </div>
  );
};

export default LoginPage;
