# Testing Guide for Billing System Backend

## Prerequisites
1. MySQL database is running on WSL
2. Database `esd_project` exists with tables: `students`, `bills`, `student_bills`, `student_payment`
3. At least one student record exists in the database

## Step 1: Start the Spring Boot Application

Open a terminal in the project directory and run:

```bash
.\mvnw.cmd spring-boot:run
```

Wait for the application to start. You should see:
```
Started BillingApplication in X.XXX seconds
```

The application will run on: **http://localhost:8080**

## Step 2: Access the Test Page

Open your web browser and navigate to:
```
http://localhost:8080/test.html
```

## Step 3: Testing the Backend

### Test 1: Login

1. **Get a student email from your database:**
   - Connect to MySQL: `mysql -u root -p` (password: Jils@1863)
   - Run: `USE esd_project; SELECT email FROM students LIMIT 1;`
   - Copy the email address

2. **In the test.html page:**
   - Enter the student's email in the "Email" field
   - Enter the same email in the "Password" field (for demo purposes, email is used as password)
   - Click the "Login" button

3. **Expected Result:**
   - You should see a green success message
   - A JWT token will be displayed
   - The "Get Bill History" and "Download Receipt" buttons will be enabled

### Test 2: View Bill History

1. **After successful login:**
   - Click the "Get Bill History" button

2. **Expected Result:**
   - You should see:
     - **Due Bills**: Bills that haven't been fully paid
     - **Paid Bills**: Bills that have been fully paid
   - Each bill shows:
     - Bill ID, Description, Amount
     - Total Paid, Remaining Amount
     - Bill Date, Deadline
     - Payment History (if any payments were made)

### Test 3: Download Receipt

1. **After viewing bill history:**
   - Note a Bill ID from the displayed bills
   - Enter the Bill ID in the "Bill ID" field
   - Click "Download Receipt"

2. **Expected Result:**
   - A text file will be downloaded with the receipt details
   - The receipt includes:
     - Bill information
     - Payment history
     - Total amounts

## Testing with API Endpoints Directly

You can also test using tools like Postman or curl:

### 1. Login Endpoint
```bash
POST http://localhost:8080/api/auth/login
Content-Type: application/json

{
  "email": "student@example.com",
  "password": "student@example.com"
}
```

**Response:**
```json
{
  "success": true,
  "message": "Login successful",
  "data": {
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "email": "student@example.com",
    "studentId": 1,
    "message": "Login successful"
  }
}
```

### 2. Get Bill History
```bash
GET http://localhost:8080/api/bills/history
Authorization: Bearer YOUR_JWT_TOKEN_HERE
```

**Response:**
```json
{
  "success": true,
  "message": "Bill history retrieved successfully",
  "data": {
    "dueBills": [...],
    "paidBills": [...]
  }
}
```

### 3. Get Specific Bill Details
```bash
GET http://localhost:8080/api/bills/1
Authorization: Bearer YOUR_JWT_TOKEN_HERE
```

### 4. Download Receipt
```bash
GET http://localhost:8080/api/receipts/1/download
Authorization: Bearer YOUR_JWT_TOKEN_HERE
```

## Troubleshooting

### Issue: "Invalid email or password"
- **Solution:** Make sure the email exists in the `students` table
- For demo purposes, password should match the email

### Issue: "No bills found"
- **Solution:** Ensure there are records in `student_bills` table linking students to bills

### Issue: CORS errors
- **Solution:** The application is configured to allow CORS from all origins. If issues persist, check the SecurityConfig

### Issue: Connection refused
- **Solution:** 
  1. Make sure MySQL is running: `sudo service mysql start` (in WSL)
  2. Verify database connection in `application.properties`
  3. Check if port 8080 is available

## Sample Database Queries

To set up test data:

```sql
-- Insert a test student
INSERT INTO students (roll_number, first_name, last_name, email) 
VALUES ('ST001', 'John', 'Doe', 'john.doe@example.com');

-- Insert a test bill
INSERT INTO bills (description, amount, bill_date, deadline) 
VALUES ('Tuition Fee', 5000.00, '2024-01-01', '2024-02-01');

-- Link student to bill
INSERT INTO student_bills (student_id, bill_id) 
VALUES (1, 1);

-- Add a payment (optional)
INSERT INTO student_payment (student_id, bill_id, description, amount, payment_date) 
VALUES (1, 1, 'Partial Payment', 2000.00, '2024-01-15 10:00:00');
```

## Notes

- The authentication uses email as password for demo purposes
- JWT tokens expire after 24 hours (86400000 ms)
- All API endpoints except `/api/auth/login` require authentication
- The test.html file is accessible without authentication for testing purposes

