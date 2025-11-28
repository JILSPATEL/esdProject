const LoginPage = () => {
  const onLoginClick = () => {
    window.location.href = 'http://localhost:8080/login';
  };

  return (
    <div className="screen login-screen">
      <div className="login-card">
        <div className="brand-logo">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
            <path d="M12 2L2 7l10 5 10-5-10-5zM2 17l10 5 10-5M2 12l10 5 10-5" />
          </svg>
        </div>

        <h1 className="login-title">Payment History Portal</h1>
        <p className="login-subtitle">Sign in to manage your fees and payments</p>

        <button className="btn btn-primary login-btn-full" onClick={onLoginClick}>
          <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
            <path d="M15 3h4a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2h-4" />
            <polyline points="10 17 15 12 10 7" />
            <line x1="15" y1="12" x2="3" y2="12" />
          </svg>
          Sign in with Google
        </button>

        <div className="login-footer">
          &copy; 2025 ERP System. Secure & Encrypted.
        </div>
      </div>
    </div>
  );
};

export default LoginPage;
