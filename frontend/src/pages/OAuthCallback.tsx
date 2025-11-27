import { useEffect } from 'react';
import { useNavigate, useSearchParams } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';
import apiClient from '../api';

const OAuthCallback = () => {
    const [searchParams] = useSearchParams();
    const navigate = useNavigate();
    const { login } = useAuth();

    useEffect(() => {
        const token = searchParams.get('token');
        const error = searchParams.get('error');

        if (error) {
            alert('Login failed: ' + error);
            navigate('/', { replace: true });
            return;
        }

        if (token) {
            // Fetch user profile using the token
            apiClient.get('/api/auth/me', {
                headers: { Authorization: `Bearer ${token}` }
            })
                .then(({ data }) => {
                    if (data.success) {
                        login({
                            token,
                            profile: data.data,
                        });
                        navigate('/dashboard', { replace: true });
                    } else {
                        throw new Error('Failed to fetch profile');
                    }
                })
                .catch((err) => {
                    console.error('Profile fetch error:', err);
                    navigate('/', { replace: true });
                });
        } else {
            navigate('/', { replace: true });
        }
    }, [searchParams, navigate, login]);

    return (
        <div className="screen fallback-screen">
            <div className="loader" />
            <p>Completing login...</p>
        </div>
    );
};

export default OAuthCallback;
