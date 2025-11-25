import type { AxiosError } from 'axios';
import { useEffect, useMemo, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import apiClient from '../api/client';
import { useAuth } from '../context/AuthContext';

type Payment = {
  paymentId?: string | number;
  amount?: number | string | null;
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
};

const currencyFormatter = new Intl.NumberFormat('en-IN', {
  style: 'currency',
  currency: 'INR',
  maximumFractionDigits: 2,
});

const DashboardPage = () => {
  const { profile, logout } = useAuth();
  const navigate = useNavigate();
  const [history, setHistory] = useState<BillHistory>({ dueBills: [], paidBills: [] });
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');

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
      }));
    };

    history.paidBills.forEach((bill) => {
      paidEntries.push(...formatInstallments(bill));
    });

    history.dueBills.forEach((bill) => {
      paidEntries.push(...formatInstallments(bill));
    });

    return [...dueEntries, ...paidEntries];
  }, [history]);

  const handleDownload = async (billId: string | number) => {
    try {
      const response = await apiClient.get<Blob>(`/api/receipts/${billId}/download`, {
        responseType: 'blob' as const,
      });
      const url = window.URL.createObjectURL(new Blob([response.data]));
      const link = document.createElement('a');
      link.href = url;
      link.setAttribute('download', `receipt_${billId}.txt`);
      document.body.appendChild(link);
      link.click();
      link.remove();
      window.URL.revokeObjectURL(url);
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
        <div className="loader" />
        <p>Loading your payment history...</p>
      </div>
    );
  }

  if (error) {
    return (
      <div className="screen fallback-screen">
        <p className="error-text">{error}</p>
        <button className="secondary-btn" onClick={() => window.location.reload()}>
          Retry
        </button>
      </div>
    );
  }

  return (
    <div className="screen dashboard-screen">
      <div className="dashboard-card">
        <header className="student-header">
          <div className="student-name">
            {profile?.firstName} {profile?.lastName}
          </div>
          <div className="student-roll">{profile?.rollNumber}</div>
        </header>

        <section className="timeline">
          {timelineEntries.map((entry, index) => (
            <div className="timeline-row" key={entry.id}>
              <div className="timeline-connector">
                <span className={`status-pill ${entry.status === 'Paid' ? 'paid' : 'due'}`}>{entry.status}</span>
                {index !== timelineEntries.length - 1 && <span className="connector-line" />}
              </div>

              <div className="timeline-card">
                <div className="timeline-text">
                  <p className="timeline-title">{entry.title}</p>
                  <p className="timeline-subtitle">{entry.subtitle}</p>
                </div>

                {entry.showDownload && (
                  <button
                    className="download-btn"
                    onClick={() => {
                      void handleDownload(entry.billId);
                    }}
                  >
                    <span className="download-icon" />
                  </button>
                )}
              </div>
            </div>
          ))}
        </section>

        <div className="actions">
          <button className="secondary-btn" onClick={onLogout}>
            Logout
          </button>
        </div>
      </div>
    </div>
  );
};

export default DashboardPage;
