import type { AxiosError } from 'axios';
import { useEffect, useMemo, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import apiClient from '../api';
import { useAuth } from '../context/AuthContext';

type Payment = {
  paymentId?: string | number;
  amount?: number | string | null;
  paymentDate?: string;
};

type BillSummary = {
  billId: string | number;
  description: string;
  amount?: number | string | null;
  remainingAmount?: number | string | null;
  payments?: Payment[];
};

type BillHistory = {
  dueBills: BillSummary[];
  paidBills: BillSummary[];
};

type BillHistoryResponse = {
  success: boolean;
  data: BillHistory;
  message?: string;
};

type ApiErrorResponse = {
  message?: string;
};

type TimelineEntry = {
  id: string;
  status: 'Due' | 'Paid';
  title: string;
  subtitle: string;
  billId: string | number;
  showDownload: boolean;
  paymentDate?: string;
  paymentId?: string | number;
};

const currencyFormatter = new Intl.NumberFormat('en-IN', {
  style: 'currency',
  currency: 'INR',
  maximumFractionDigits: 2,
});

const DashboardPage = () => {
  const { token, profile, logout } = useAuth();
  const navigate = useNavigate();
  const [history, setHistory] = useState<BillHistory>({ dueBills: [], paidBills: [] });
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');

  // Redirect to login if token is removed (e.g., logged out from another tab)
  useEffect(() => {
    if (!token) {
      void navigate('/', { replace: true });
    }
  }, [token, navigate]);

  useEffect(() => {
    const fetchHistory = async () => {
      try {
        const { data } = await apiClient.get<BillHistoryResponse>('/api/bills/history');
        if (data?.success) {
          setHistory(data.data || { dueBills: [], paidBills: [] });
        } else {
          setError('Unable to load bill history.');
        }
      } catch (err) {
        const axiosError = err as AxiosError<ApiErrorResponse>;
        if (axiosError.response?.status === 401) {
          logout();
          void navigate('/', { replace: true });
          return;
        }
        if (axiosError.response?.status === 404) {
          void navigate('/no-record', { replace: true });
          return;
        }
        setError(axiosError.response?.data?.message || 'Unable to load bill history.');
      } finally {
        setLoading(false);
      }
    };

    void fetchHistory();
  }, [logout, navigate]);

  const toNumber = (value: number | string | null | undefined) => Number(value ?? 0);

  const timelineEntries = useMemo<TimelineEntry[]>(() => {
    const dueEntries = history.dueBills.map<TimelineEntry>((bill) => ({
      id: `due-${bill.billId}`,
      status: 'Due',
      title: bill.description,
      subtitle: `Pending ${currencyFormatter.format(toNumber(bill.remainingAmount))} of total ${currencyFormatter.format(
        toNumber(bill.amount),
      )}`,
      billId: bill.billId,
      showDownload: false,
    }));

    const paidEntries: TimelineEntry[] = [];

    const formatInstallments = (bill: BillSummary) => {
      const payments = bill.payments || [];
      return payments.map<TimelineEntry>((payment, index) => ({
        id: `payment-${bill.billId}-${payment.paymentId ?? index}`,
        status: 'Paid',
        title: `Installment ${index + 1} of ${bill.description}`,
        subtitle: `Amount ${currencyFormatter.format(toNumber(payment.amount))} out of total ${currencyFormatter.format(
          toNumber(bill.amount),
        )}`,
        billId: bill.billId,
        showDownload: toNumber(payment?.amount) > 0,
        paymentDate: payment.paymentDate,
        paymentId: payment.paymentId,
      }));
    };

    history.paidBills.forEach((bill) => {
      paidEntries.push(...formatInstallments(bill));
    });

    history.dueBills.forEach((bill) => {
      paidEntries.push(...formatInstallments(bill));
    });

    // Sort paid entries by payment date in descending order (newest first)
    paidEntries.sort((a, b) => {
      if (!a.paymentDate || !b.paymentDate) return 0;
      return new Date(b.paymentDate).getTime() - new Date(a.paymentDate).getTime();
    });

    return [...dueEntries, ...paidEntries];
  }, [history]);

  const handleDownload = async (billId: string | number, paymentId?: string | number) => {
    try {
      const url = paymentId
        ? `/api/receipts/${billId}/download?paymentId=${paymentId}`
        : `/api/receipts/${billId}/download`;

      const response = await apiClient.get<Blob>(url, {
        responseType: 'blob' as const,
      });
      const blobUrl = window.URL.createObjectURL(new Blob([response.data]));
      const link = document.createElement('a');
      link.href = blobUrl;
      link.setAttribute('download', paymentId ? `receipt_partial_${paymentId}.pdf` : `receipt_${billId}.pdf`);
      document.body.appendChild(link);
      link.click();
      link.remove();
      window.URL.revokeObjectURL(blobUrl);
    } catch (err) {
      const axiosError = err as AxiosError<ApiErrorResponse>;
      if (axiosError.response?.status === 401) {
        logout();
        void navigate('/', { replace: true });
        return;
      }
      setError(axiosError.response?.data?.message || 'Failed to download receipt.');
    }
  };

  const onLogout = () => {
    logout();
    void navigate('/', { replace: true });
  };

  if (loading) {
    return (
      <div className="screen fallback-screen">
        <div className="spinner" />
        <p>Loading your payment history...</p>
      </div>
    );
  }

  if (error) {
    return (
      <div className="screen fallback-screen">
        <p className="error-msg">{error}</p>
        <button className="btn btn-primary" onClick={() => window.location.reload()}>
          Retry
        </button>
      </div>
    );
  }

  return (
    <div className="screen dashboard-screen">
      <div className="dashboard-container">
        <header className="dashboard-header">
          <div className="user-welcome">
            <h1>Welcome back, {profile?.firstName}</h1>
            <div className="user-roll">Roll Number: {profile?.rollNumber}</div>
          </div>
          <button className="btn btn-danger-outline" onClick={onLogout}>
            Logout
          </button>
        </header>

        <section className="timeline-section">
          <h2 className="section-title">Payment History</h2>

          <div className="timeline-list">
            {timelineEntries.map((entry) => (
              <div className="timeline-item" key={entry.id}>
                <div className={`timeline-icon ${entry.status === 'Paid' ? 'paid' : 'due'}`}>
                  {entry.status === 'Paid' ? (
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="3" strokeLinecap="round" strokeLinejoin="round">
                      <polyline points="20 6 9 17 4 12" />
                    </svg>
                  ) : (
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="3" strokeLinecap="round" strokeLinejoin="round">
                      <line x1="12" y1="5" x2="12" y2="19" />
                      <line x1="5" y1="12" x2="19" y2="12" />
                    </svg>
                  )}
                </div>

                <div className="timeline-content">
                  <div className="bill-details">
                    <span className={`status-badge ${entry.status === 'Paid' ? 'paid' : 'due'}`}>
                      {entry.status}
                    </span>
                    <h3>{entry.title}</h3>
                    <p>{entry.subtitle}</p>
                    {entry.paymentDate && (
                      <p className="payment-date">
                        Paid on: {new Date(entry.paymentDate).toLocaleDateString('en-IN', {
                          year: 'numeric',
                          month: 'long',
                          day: 'numeric',
                        })}
                      </p>
                    )}
                  </div>

                  {entry.showDownload && (
                    <button
                      className="action-btn"
                      onClick={() => void handleDownload(entry.billId, entry.paymentId)}
                      title="Download Receipt"
                    >
                      <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                        <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4" />
                        <polyline points="7 10 12 15 17 10" />
                        <line x1="12" y1="15" x2="12" y2="3" />
                      </svg>
                    </button>
                  )}
                </div>
              </div>
            ))}
          </div>
        </section>
      </div>
    </div>
  );
};

export default DashboardPage;
