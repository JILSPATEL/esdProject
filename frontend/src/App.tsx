import { Navigate, Route, Routes } from 'react-router-dom';
import LoginPage from './pages/LoginPage';
import DashboardPage from './pages/DashboardPage';
import NoRecordPage from './pages/NoRecordPage';

import OAuthCallback from './pages/OAuthCallback';

const App = () => {
  return (
    <Routes>
      <Route path="/" element={<LoginPage />} />
      <Route path="/auth/callback" element={<OAuthCallback />} />
      <Route path="/dashboard" element={<DashboardPage />} />
      <Route path="/no-record" element={<NoRecordPage />} />
      <Route path="*" element={<Navigate to="/" replace />} />
    </Routes>
  );
};

export default App;
