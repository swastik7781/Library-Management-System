# Backend Integration Guide - Library Management System

## Overview
This document outlines all frontend pages, forms, and expected backend functionality for seamless integration.

---

## 🔐 Authentication System

### Student Login (`student-login.html`)
**Form Action:** `student-dashboard.html`
**Fields:**
- SIC Number (text)
- Password (password)

**Backend Requirements:**
- Validate SIC number and password against database
- Create session/JWT token
- Redirect to student dashboard on success
- Return error message on failure

### Admin Login (`admin-login.html`)
**Form Action:** `admin-dashboard.html`
**Fields:**
- Admin ID (text)
- Password (password)

**Backend Requirements:**
- Validate admin credentials
- Create admin session with elevated privileges
- Redirect to admin dashboard
- Return error message on failure

---

## 👨‍🎓 Student Portal Pages

### 1. Student Dashboard (`student-dashboard.html`)
**Data Required:**
- Student name, SIC, branch, year
- Books borrowed count
- Books due soon count
- Pending fines amount
- List of currently borrowed books with:
  - Book title, author
  - Borrow date, due date
  - Days remaining
  - Book cover image URL

**API Endpoints Needed:**
```
GET /api/student/dashboard
Response: {
  student: { name, sic, branch, year },
  stats: { borrowed, dueSoon, fines },
  borrowedBooks: [{ id, title, author, borrowDate, dueDate, coverUrl }]
}
```

### 2. Browse Library (`books.html`)
**Features:**
- Search by title, author, ISBN, keywords
- Filter by:
  - Categories (CS, Math, Physics, Literature, Business, Engineering)
  - Authors
  - Academic Level (Undergraduate, Graduate, PhD, General)
  - Availability (Available, Checked Out, Reserved)

**API Endpoints Needed:**
```
GET /api/books?search=&category=&author=&level=&availability=
Response: {
  books: [{ id, title, author, category, isbn, status, coverUrl }],
  totalCount: number
}
```

### 3. Book Details (`book-details.html`)
**Data Required:**
- Book title, author, ISBN, category
- Description
- Availability status
- Cover image URL
- Publisher, publication year

**API Endpoints Needed:**
```
GET /api/books/:id
Response: { id, title, author, isbn, category, description, status, coverUrl, publisher, year }

POST /api/books/:id/borrow
Request: { studentId }
Response: { success, message, dueDate }
```

### 4. Student Profile (`student-profile.html`)
**Data Required:**
- Personal info (name, SIC, DOB, gender)
- Academic details (branch, year, semester, CGPA)
- Contact info (email, phone, address)
- Library stats (books borrowed, total read, fines, member since)

**API Endpoints Needed:**
```
GET /api/student/profile
Response: {
  personal: { name, sic, dob, gender },
  academic: { branch, year, semester, cgpa },
  contact: { email, phone, address },
  libraryStats: { borrowed, totalRead, fines, memberSince }
}

PUT /api/student/profile
Request: { updated fields }
Response: { success, message }
```

### 5. Announcements (`student-announcements.html`)
**Data Required:**
- List of announcements with:
  - Title, content
  - Date posted
  - "New" badge for recent announcements

**API Endpoints Needed:**
```
GET /api/announcements
Response: {
  announcements: [{ id, title, content, date, isNew }]
}
```

---

## 👨‍💼 Admin Portal Pages

### 1. Admin Dashboard (`admin-dashboard.html`)
**Data Required:**
- Total books, students, issued books
- Recent activities
- Quick stats

**API Endpoints Needed:**
```
GET /api/admin/dashboard
Response: {
  stats: { totalBooks, totalStudents, issuedBooks },
  recentActivities: [{ type, description, timestamp }]
}
```

### 2. Add Book (`add-book.html`)
**Form Fields:**
- Title, Author, ISBN
- Category, Publisher, Year
- Copies Available
- Description
- Cover Image Upload

**API Endpoints Needed:**
```
POST /api/admin/books
Request: FormData with all book details + image
Response: { success, message, bookId }
```

### 3. Manage Students (`manage-students.html`)
**Features:**
- View all students with pending dues
- Search students
- Add/Edit/Delete students
- **Block/Unblock students** based on dues or violations
- View student borrow history

**Table Columns:**
- SIC Number, Student Name, Branch, Year
- Books Issued
- **Pending Dues** (color-coded badges):
  - 🟢 Green (₹0) - No dues
  - 🟡 Yellow (₹1-₹100) - Low dues
  - 🔴 Red (>₹100) - High dues
- Status (Active/Blocked)
- Actions (Edit, Block/Unblock, Delete)

**API Endpoints Needed:**
```
GET /api/admin/students
Response: { students: [{ sic, name, branch, year, email, booksIssued, pendingDues, status }] }

POST /api/admin/students
Request: { student details }
Response: { success, message }

PUT /api/admin/students/:sic
Request: { updated fields }
Response: { success, message }

PUT /api/admin/students/:sic/block
Request: { blocked: true/false, reason: string }
Response: { success, message }

DELETE /api/admin/students/:sic
Response: { success, message }
```

### 4. Issue/Return Books (`issue-return.html`)
**Issue Book Form:**
- Student SIC
- Book ID/ISBN
- Issue Date, Due Date

**Return Book Form:**
- Student SIC
- Book ID
- Return Date
- Fine calculation (if overdue)

**API Endpoints Needed:**
```
POST /api/admin/issue
Request: { studentSic, bookId, issueDate, dueDate }
Response: { success, message, transactionId }

POST /api/admin/return
Request: { studentSic, bookId, returnDate }
Response: { success, message, fine }
```

### 5. Admin Announcements (`admin-announcements.html`)
**Features:**
- Create new announcements
- Edit/Delete announcements
- View all announcements

**API Endpoints Needed:**
```
POST /api/admin/announcements
Request: { title, content }
Response: { success, message, announcementId }

PUT /api/admin/announcements/:id
Request: { title, content }
Response: { success, message }

DELETE /api/admin/announcements/:id
Response: { success, message }
```

---

## 📞 Contact Form (`contact.html`)
**Form Fields:**
- Name, Email, Message

**API Endpoints Needed:**
```
POST /api/contact
Request: { name, email, message }
Response: { success, message }
```

---

## 🗄️ Database Schema Suggestions

### Students Table
```sql
- sic (PRIMARY KEY)
- name
- email
- password (hashed)
- phone
- dob
- gender
- branch
- year
- semester
- cgpa
- address
- member_since
- created_at
```

### Books Table
```sql
- id (PRIMARY KEY)
- isbn
- title
- author
- category
- publisher
- publication_year
- description
- copies_total
- copies_available
- cover_image_url
- created_at
```

### Transactions Table
```sql
- id (PRIMARY KEY)
- student_sic (FOREIGN KEY)
- book_id (FOREIGN KEY)
- issue_date
- due_date
- return_date (nullable)
- fine_amount
- status (issued/returned/overdue)
- created_at
```

### Admins Table
```sql
- id (PRIMARY KEY)
- admin_id (UNIQUE)
- name
- email
- password (hashed)
- created_at
```

### Announcements Table
```sql
- id (PRIMARY KEY)
- title
- content
- posted_date
- is_active
- created_by (admin_id)
```

---

## 🔒 Security Requirements

1. **Password Hashing:** Use bcrypt or similar
2. **Session Management:** Implement JWT or session-based auth
3. **Input Validation:** Sanitize all user inputs
4. **SQL Injection Prevention:** Use parameterized queries
5. **CORS:** Configure for frontend domain
6. **File Upload Security:** Validate image types and sizes

---

## 📝 Additional Notes

- All dates should be in ISO format
- Fine calculation: ₹10 per day overdue
- Book borrow limit: 3 books per student
- Borrow duration: 14 days default
- Image uploads should be stored in `/uploads/books/` and `/uploads/students/`
- Session timeout: 30 minutes of inactivity

---

## 🚀 Testing Credentials (for development)

**Student:**
- SIC: 23bcsf03
- Password: student123

**Admin:**
- Admin ID: admin001
- Password: admin123

---

## 📧 Contact
For any clarifications, contact the frontend developer.
