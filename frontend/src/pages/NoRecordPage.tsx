import { useNavigate } from 'react-router-dom';

const NoRecordPage = () => {
  const navigate = useNavigate();

  const handleBackToLogin = () => {
    void navigate('/');
  };

  return (
    <div className="screen login-screen">
      <div className="login-card">
        <div className="brand-logo">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
            <circle cx="12" cy="12" r="10" />
            <line x1="12" y1="8" x2="12" y2="12" />
            <line x1="12" y1="16" x2="12.01" y2="16" />
          </svg>
        </div>

        <h1 className="login-title">No Records Found</h1>
        <p className="login-subtitle">
          Sorry, there's no payment history for you. Please contact the admin team or try signing in with a different institute email.
        </p>

        <button className="btn btn-primary login-btn-full" onClick={handleBackToLogin}>
          <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
            <line x1="19" y1="12" x2="5" y2="12" />
            <polyline points="12 19 5 12 12 5" />
          </svg>
          Back to Login
        </button>

        <div className="login-footer">
          Need help? Contact your administrator.
        </div>
      </div>
    </div>
  );
};

export default NoRecordPage;
