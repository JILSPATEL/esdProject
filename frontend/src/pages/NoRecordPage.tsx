import { useNavigate } from 'react-router-dom';

const NoRecordPage = () => {
  const navigate = useNavigate();

  const handleBackToLogin = () => {
    void navigate('/');
  };

  return (
    <div className="screen empty-screen">
      <div className="empty-card">
        <h1>Sorry, there&apos;s no payment history for you.</h1>
        <p>Please contact the admin team or try signing in with a different institute email.</p>
        <div className="empty-illustration" aria-hidden>
          <span className="sad-face">:(</span>
        </div>
        <button className="primary-btn" onClick={handleBackToLogin}>
          Back to Login
        </button>
      </div>
    </div>
  );
};

export default NoRecordPage;
