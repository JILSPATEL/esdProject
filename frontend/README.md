# ERP Billing Portal - Frontend

A modern React-based frontend application for the ERP Billing System, featuring secure Google OAuth authentication and bill management for students.

## 🚀 Features

### 🔐 Advanced Authentication System
- **Google OAuth Integration**: Secure login using institutional Google accounts
- **User-Specific Single Session Enforcement**: 
  - Each user can only be logged in on ONE tab at a time
  - When the same user logs in from a new tab, all previous tabs are automatically logged out
  - Different users can be logged in simultaneously on different tabs
  - Real-time session synchronization across browser tabs (max 1-second delay)
- **Automatic Session Management**: 
  - Tab-specific authentication tracking
  - Periodic session validation checks
  - Cross-tab logout synchronization

### 📊 Dashboard Features
- **Bill History Viewing**: Display of due and paid bills
- **Payment Tracking**: View payment details and amounts
- **PDF Receipt Downloads**: Download bill receipts directly from the dashboard
- **Real-time Updates**: Automatic refresh of bill data
- **User Profile Display**: Shows logged-in user information

### 🎨 User Interface
- Modern, responsive design
- Clean and intuitive navigation
- Error handling with user-friendly messages
- Loading states for better UX

## 🛠️ Tech Stack

- **Framework**: React 19.2.0
- **Build Tool**: Vite 7.2.4
- **Language**: TypeScript 5.7.3
- **Routing**: React Router DOM 7.9.6
- **HTTP Client**: Axios 1.13.2
- **Authentication**: Google OAuth 2.0
- **Styling**: Custom CSS
- **Linting**: ESLint with TypeScript support

## 📋 Prerequisites

- Node.js (v18 or higher recommended)
- npm or yarn
- Google OAuth Client ID (for authentication)
- Backend API running on `http://localhost:8080` (or configured URL)

## 🔧 Installation & Setup

1. **Clone the repository**
   ```bash
   cd frontend
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```

3. **Configure environment variables**
   
   Create a `.env` file in the root directory:
   ```env
   VITE_GOOGLE_CLIENT_ID=your-google-client-id
   VITE_API_BASE_URL=http://localhost:8080
   ```

4. **Start the development server**
   ```bash
   npm run dev
   ```
   
   The application will be available at `http://localhost:5173`

## 📁 Project Structure

```
frontend/
├── public/
│   ├── images/              # Static assets (logos, icons)
│   │   ├── react.svg
│   │   └── vite.svg
│   └── index.html           # HTML entry point
├── src/
│   ├── components/          # Reusable components
│   │   ├── containers/      # Container components
│   │   └── presentation/    # Presentation components
│   ├── context/             # React Context providers
│   │   └── AuthContext.tsx  # Authentication context & logic
│   ├── pages/               # Page components
│   │   ├── DashboardPage.tsx    # Main dashboard
│   │   ├── LoginPage.tsx        # Login page
│   │   └── NoRecordPage.tsx     # No record found page
│   ├── types/               # TypeScript type definitions
│   │   └── global.d.ts
│   ├── api.ts               # Axios API client configuration
│   ├── App.tsx              # Main app component
│   ├── App.css              # App-level styles
│   ├── index.tsx            # Application entry point
│   ├── index.css            # Global styles
│   └── react-app-env.d.ts   # React type definitions
├── .env                     # Environment variables
├── package.json             # Dependencies and scripts
├── tsconfig.json            # TypeScript configuration
├── vite.config.ts           # Vite configuration
└── README.md                # This file
```

## 🔐 Authentication Flow

### How It Works

1. **Initial Login**
   - User clicks "Sign in with Google" button
   - Google OAuth popup appears
   - After successful authentication, user is redirected to dashboard
   - A unique Tab ID and Session ID are generated

2. **Multi-Tab Behavior**
   
   **Same User Scenario:**
   ```
   Tab 1: User A logs in → Dashboard visible
   Tab 2: User A logs in again → Dashboard visible on Tab 2
   Tab 1: Automatically logs out within 1 second ✓
   ```
   
   **Different User Scenario:**
   ```
   Tab 1: User A logs in → Dashboard visible
   Tab 2: User B logs in → Dashboard visible on Tab 2
   Tab 1: Remains logged in (User A) ✓
   Tab 2: Remains logged in (User B) ✓
   ```

3. **Session Validation**
   - Every 1 second, each tab checks if it's still the active session
   - If same user logs in elsewhere, old tabs detect and logout immediately
   - Different users can coexist in different tabs

4. **Logout**
   - User clicks logout button
   - All session data is cleared
   - User is redirected to login page

## 🌐 Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `VITE_GOOGLE_CLIENT_ID` | Google OAuth 2.0 Client ID | `449387068368-xxx.apps.googleusercontent.com` |
| `VITE_API_BASE_URL` | Backend API base URL | `http://localhost:8080` |

## 📜 Available Scripts

| Command | Description |
|---------|-------------|
| `npm run dev` | Start development server with hot reload |
| `npm run build` | Build production-ready application |
| `npm run preview` | Preview production build locally |
| `npm run lint` | Run ESLint to check code quality |

## 🔒 Security Features

- **Token-based Authentication**: JWT tokens stored in localStorage
- **Axios Interceptors**: Automatic token attachment to API requests
- **Protected Routes**: Automatic redirect to login if not authenticated
- **Session Isolation**: Each tab maintains its own session state
- **User-Specific Enforcement**: Only same user sessions are invalidated

## 🌟 Key Implementation Details

### AuthContext
- Manages global authentication state
- Generates unique tab and session IDs
- Implements periodic session checks (1-second interval)
- Listens for localStorage changes across tabs
- Validates user email for session enforcement

### API Client
- Configured Axios instance with base URL
- Request interceptors for automatic token injection
- Error handling for 401 (Unauthorized) responses

### Protected Dashboard
- Auto-redirects to login if no token present
- Fetches bill history on mount
- Handles API errors gracefully
- Supports PDF receipt downloads

## 🐛 Troubleshooting

**Issue**: Cannot login after logout
- **Solution**: Clear browser localStorage and try again

**Issue**: Multiple tabs not syncing properly
- **Solution**: Ensure browser allows localStorage events (not in incognito mode)

**Issue**: Google login button not appearing
- **Solution**: Check if `VITE_GOOGLE_CLIENT_ID` is correctly set in `.env`

**Issue**: API calls failing
- **Solution**: Verify backend is running and `VITE_API_BASE_URL` is correct

## 📄 License

© 2025 ERP Billing System — All rights reserved.

## 👥 Contributing

This is an academic project. For contributions or issues, please contact the development team.

---

**Built with React + TypeScript + Vite**
