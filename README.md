# Student Billing Management System (ESD Project)

A full-stack web application for managing student bills and payments with Google OAuth authentication, built with Spring Boot and React.

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Tech Stack](#tech-stack)
- [Project Structure](#project-structure)
- [Prerequisites](#prerequisites)
- [Setup Instructions](#setup-instructions)
- [Database Schema](#database-schema)
- [API Endpoints](#api-endpoints)
- [Authentication](#authentication)
- [Running the Application](#running-the-application)

## 🎯 Overview

This Enterprise Software Development (ESD) project is a comprehensive billing management system designed for students to view their bills, track payment history, and download payment receipts. The system uses Google OAuth for secure authentication and provides a modern React-based frontend interface.

## ✨ Features

### Authentication
- **Google OAuth 2.0 Login**: Secure authentication using Google accounts
- **JWT Token-based Authorization**: Stateless session management
- **Protected Routes**: Frontend route guards for authenticated users
- **User-Specific Single Session Enforcement**: 
  - Each user can only be logged in on ONE tab at a time
  - Same user re-login automatically logs out previous tabs within 1 second
  - Different users can be logged in simultaneously on different tabs
  - Real-time session synchronization across browser tabs
- **Advanced Tab Management**:
  - Unique tab ID generation and tracking
  - Periodic session validation checks (1-second interval)
  - Cross-tab logout synchronization via localStorage events

### Bill Management
- **View Bill History**: Students can see all their assigned bills
- **Bill Details**: Detailed view of individual bills with payment breakdown
- **Payment Tracking**: Track total paid amount and remaining balance
- **Payment Status**: Visual indication of paid vs. due bills

### Receipt Generation
- **PDF Receipt Download**: Generate and download detailed PDF receipts
- **Payment History**: Receipts include complete payment history
- **Professional Formatting**: Well-formatted receipts using iText PDF library

## 🛠️ Tech Stack

### Backend
- **Framework**: Spring Boot 3.2.0
- **Language**: Java 17
- **Security**: Spring Security with JWT
- **Database**: MySQL
- **ORM**: Spring Data JPA
- **PDF Generation**: iText 7.2.5
- **Authentication**: Google API Client 2.2.0
- **Build Tool**: Maven

### Frontend
- **Framework**: React 19.2.0
- **Language**: TypeScript 5.7.3
- **Routing**: React Router DOM 7.9.6
- **HTTP Client**: Axios 1.13.2
- **Build Tool**: Vite 7.2.4
- **Styling**: CSS

## 📁 Project Structure

```
esdProject/
├── src/main/java/com/erp/billing/
│   ├── controller/           # REST API Controllers
│   │   ├── AuthController.java
│   │   ├── BillController.java
│   │   └── ReceiptController.java
│   ├── dto/                  # Data Transfer Objects
│   │   ├── ApiResponse.java
│   │   ├── BillHistoryResponse.java
│   │   ├── BillResponse.java
│   │   ├── LoginRequest.java
│   │   ├── LoginResponse.java
│   │   └── PaymentResponse.java
│   ├── entity/               # JPA Entities
│   │   ├── Bill.java
│   │   ├── Student.java
│   │   ├── StudentBill.java
│   │   └── StudentPayment.java
│   ├── repository/           # Data Access Layer
│   ├── service/              # Business Logic Layer
│   ├── security/             # Security Configuration
│   │   ├── CustomUserDetailsService.java
│   │   ├── GoogleTokenVerifier.java
│   │   ├── JwtAuthenticationFilter.java
│   │   ├── JwtUtil.java
│   │   └── SecurityConfig.java
│   ├── mapper/               # Entity-DTO Mappers
│   └── exception/            # Exception Handlers
├── src/main/resources/
│   ├── application.properties
│   └── db/migration/         # Database Migration Scripts
├── frontend/
│   ├── public/
│   │   ├── images/          # Static assets
│   │   └── index.html       # HTML entry point (must be in root for Vite)
│   ├── src/
│   │   ├── components/      # Reusable components
│   │   │   ├── containers/  # Container components
│   │   │   └── presentation/ # Presentation components
│   │   ├── context/         # React Context (Auth with session management)
│   │   │   └── AuthContext.tsx
│   │   ├── pages/           # Page Components
│   │   │   ├── LoginPage.tsx
│   │   │   ├── DashboardPage.tsx
│   │   │   └── NoRecordPage.tsx
│   │   ├── types/           # TypeScript Type Definitions
│   │   │   └── global.d.ts
│   │   ├── api.ts           # Axios API client configuration
│   │   ├── App.tsx          # Main App Component
│   │   ├── App.css          # App-level styles
│   │   ├── index.tsx        # Entry Point
│   │   ├── index.css        # Global styles
│   │   └── react-app-env.d.ts  # React type definitions
│   ├── .env                 # Environment variables
│   ├── package.json
│   ├── vite.config.ts
│   └── README.md            # Frontend-specific documentation
├── schema.sql               # Database Schema
├── data.sql                 # Sample Data
└── pom.xml                  # Maven Configuration
```

## 📋 Prerequisites

- **Java Development Kit (JDK) 17** or higher
- **MySQL 8.0** or higher
- **Node.js 18** or higher
- **npm** or **yarn**
- **Maven 3.6+**
- **Google Cloud Console Account** (for OAuth credentials)

## 🚀 Setup Instructions

### 1. Clone the Repository

```bash
git clone <repository-url>
cd esdProject
```

### 2. Database Setup

Create a MySQL database and run the schema:

```bash
mysql -u root -p
CREATE DATABASE billing_system;
USE billing_system;
SOURCE schema.sql;
SOURCE data.sql;  # Optional: Load sample data
```

### 3. Google OAuth Setup

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select an existing one
3. Enable Google+ API
4. Create OAuth 2.0 Client ID (Web Application)
5. Add authorized JavaScript origins:
   - `http://localhost:5173` (Frontend)
   - `http://localhost:8080` (Backend)
6. Add authorized redirect URIs:
   - `http://localhost:5173/dashboard`
7. Copy the Client ID and Client Secret

### 4. Backend Configuration

Create or update `src/main/resources/application.properties`:

```properties
# Database Configuration
spring.datasource.url=jdbc:mysql://localhost:3306/billing_system
spring.datasource.username=your_mysql_username
spring.datasource.password=your_mysql_password
spring.jpa.hibernate.ddl-auto=none
spring.jpa.show-sql=true

# Google OAuth Configuration
spring.security.oauth2.client.registration.google.client-id=YOUR_GOOGLE_CLIENT_ID
spring.security.oauth2.client.registration.google.client-secret=YOUR_GOOGLE_CLIENT_SECRET

# JWT Configuration
jwt.secret=your_jwt_secret_key_minimum_256_bits
jwt.expiration=86400000

# Server Configuration
server.port=8080
```

### 5. Frontend Configuration

Create `frontend/.env`:

```env
VITE_API_BASE_URL=http://localhost:8080/api
VITE_GOOGLE_CLIENT_ID=YOUR_GOOGLE_CLIENT_ID
```

### 6. Install Dependencies

**Backend:**
```bash
mvn clean install
```

**Frontend:**
```bash
cd frontend
npm install
```

## 🗄️ Database Schema

### Tables

#### Students
- `student_id` (Primary Key)
- `roll_number` (Unique)
- `first_name`, `last_name`
- `email` (Unique)
- `password` (Encrypted)
- `cgpa`, `total_credits`, `graduate_year`
- Additional metadata fields

#### Bills
- `id` (Primary Key)
- `description`, `amount`
- `bill_date`, `deadline`
- Timestamps

#### Student_Bills (Junction Table)
- Links students to their assigned bills
- Prevents duplicate assignments

#### Student_Payment
- `id` (Primary Key)
- `student_id`, `bill_id` (Foreign Keys)
- `amount`, `payment_date`
- Payment description

#### View: vw_student_bill_balance
- Calculates total paid and remaining amounts per student per bill

## 🔌 API Endpoints

### Authentication

**POST** `/api/auth/login`
- **Description**: Authenticate user with Google ID token
- **Request Body**: `{ "credential": "GOOGLE_ID_TOKEN" }`
- **Response**: JWT token and user details

### Bills

**GET** `/api/bills/history`
- **Description**: Get all bills for authenticated student
- **Headers**: `Authorization: Bearer <JWT_TOKEN>`
- **Response**: List of bills with payment status

**GET** `/api/bills/{billId}`
- **Description**: Get detailed bill information
- **Headers**: `Authorization: Bearer <JWT_TOKEN>`
- **Response**: Bill details with payment history

### Receipts

**GET** `/api/receipts/{billId}/download`
- **Description**: Download PDF receipt for a bill
- **Headers**: `Authorization: Bearer <JWT_TOKEN>`
- **Response**: PDF file download

## 🔐 Authentication

### Google OAuth Flow

1. User clicks "Sign in with Google" on the frontend
2. Google Identity Services popup appears
3. User selects Google account and grants permissions
4. Frontend receives Google ID token (credential)
5. Frontend sends credential to backend `/api/auth/login`
6. Backend verifies token with Google API
7. Backend validates user email against `students` table
8. Backend generates JWT token
9. Frontend stores JWT token for subsequent requests
10. Frontend generates unique Tab ID and Session ID
11. Frontend begins periodic session validation

### Multi-Tab Session Management

**Same User Scenario:**
```
Tab 1: User A logs in → Dashboard visible (Tab ID: tab-123)
Tab 2: User A logs in again → Dashboard visible (Tab ID: tab-456)
Result: Tab 1 detects different session → Logs out within 1 second ✓
```

**Different User Scenario:**
```
Tab 1: User A (userA@example.com) logs in → Dashboard visible
Tab 2: User B (userB@example.com) logs in → Dashboard visible
Result: Both tabs remain logged in with their respective users ✓
```

**Technical Implementation:**
- Each browser tab generates a unique Tab ID on initialization
- Login action stores the active Tab ID in localStorage
- Every 1 second, each tab checks if it's still the active tab for its user
- When a new login occurs, the storage event triggers in all other tabs
- Tabs compare logged-in user emails before logging out
- Only tabs with the same user email are logged out

### Example Login Request

```bash
curl -X POST http://localhost:8080/api/auth/login \
  -H "Content-Type: application/json" \
  -d "{\"credential\": \"<GOOGLE_ID_TOKEN>\"}"
```

**Response:**
```json
{
  "status": "success",
  "message": "Google login successful",
  "data": {
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "studentId": 1,
    "email": "student@example.com",
    "firstName": "John",
    "lastName": "Doe"
  }
}
```

## ▶️ Running the Application

### Start Backend Server

```bash
mvn spring-boot:run
```

The backend will start on `http://localhost:8080`

### Start Frontend Development Server

```bash
cd frontend
npm run dev
```

The frontend will start on `http://localhost:5173`

### Build for Production

**Backend:**
```bash
mvn clean package
java -jar target/billing-0.0.1-SNAPSHOT.jar
```

**Frontend:**
```bash
cd frontend
npm run build
# Serve the dist/ folder with your preferred web server
```

## 📄 Additional Files

- **ESD_Project_UML.jpg**: UML diagrams for the project
- **usecase.png**: Use case diagram
- **projectDeliverables.pdf**: Complete project documentation

## 🔧 Development Notes

- The application uses CORS with `origins = "*"` for development. Configure appropriately for production.
- JWT tokens expire after 24 hours by default (configurable in application.properties)
- Database passwords are stored using BCrypt encryption
- All API responses follow a consistent `ApiResponse<T>` wrapper format
- **Authentication System**:
  - User-specific single session enforcement prevents same user from multiple active sessions
  - Different users can be logged in simultaneously on different browser tabs
  - Session validation occurs every 1 second via periodic checks
  - localStorage events provide real-time cross-tab synchronization
  - Tab IDs are unique per tab instance and persist for the tab's lifetime
- **Frontend File Structure**:
  - `index.html` must remain in root directory (Vite requirement)
  - Static assets are served from `public/` folder
  - React context manages global authentication state with tab tracking

## 📝 License

This project is developed as part of the Enterprise Software Development course.

---

**Developed by**: M.Tech Students  
**Course**: Enterprise Software Development (ESD)
