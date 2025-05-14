-- STUDENT RECORDS MANAGEMENT SYSTEM
-- Created by RAY OTIENO
-- Description: Creates the structure for managing students, courses, instructors, and grades.

-- Drop existing tables if they exist
DROP TABLE IF EXISTS grades, enrollments, users, students, courses, instructors, departments;

-- Departments Table
CREATE TABLE departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- Students Table
CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    date_of_birth DATE,
    gender ENUM('Male', 'Female', 'Other'),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- Instructors Table
CREATE TABLE instructors (
    instructor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- Courses Table
CREATE TABLE courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    course_code VARCHAR(10) NOT NULL UNIQUE,
    department_id INT,
    instructor_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id),
    FOREIGN KEY (instructor_id) REFERENCES instructors(instructor_id)
);

-- Enrollments Table (Many-to-Many between students and courses)
CREATE TABLE enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enrollment_date DATE DEFAULT CURRENT_DATE,
    UNIQUE(student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- Grades Table
CREATE TABLE grades (
    grade_id INT AUTO_INCREMENT PRIMARY KEY,
    enrollment_id INT NOT NULL,
    grade VARCHAR(2) CHECK (grade IN ('A', 'B', 'C', 'D', 'F', 'I')),
    FOREIGN KEY (enrollment_id) REFERENCES enrollments(enrollment_id)
);

-- Users Table (for login/admin functionality)
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('Admin', 'Instructor', 'Clerk') DEFAULT 'Clerk'
);

-- Insert dummy data

-- Insert Departments
INSERT INTO departments (name) VALUES 
('Computer Science'),
('Business Administration'),
('Engineering');

-- Insert Students
INSERT INTO students (first_name, last_name, email, date_of_birth, gender, department_id) VALUES
('Alice', 'Wanjiku', 'alice@example.com', '2000-06-15', 'Female', 1),
('Brian', 'Odhiambo', 'brian@example.com', '1999-03-22', 'Male', 2),
('Carol', 'Mutua', 'carol@example.com', '2001-12-05', 'Female', 1);

-- Insert Instructors
INSERT INTO instructors (first_name, last_name, email, department_id) VALUES
('Dr. John', 'Kariuki', 'john.kariuki@example.com', 1),
('Dr. Amina', 'Ali', 'amina.ali@example.com', 2);

-- Insert Courses
INSERT INTO courses (course_name, course_code, department_id, instructor_id) VALUES
('Database Systems', 'CS301', 1, 1),
('Business Ethics', 'BA202', 2, 2),
('Web Development', 'CS302', 1, 1);

-- Insert Enrollments
INSERT INTO enrollments (student_id, course_id, enrollment_date) VALUES
(1, 1, '2024-09-01'),
(2, 2, '2024-09-01'),
(1, 3, '2024-09-01'),
(3, 3, '2024-09-01');

-- Insert Grades
INSERT INTO grades (enrollment_id, grade) VALUES
(1, 'A'),
(2, 'B'),
(3, 'A'),
(4, 'C');

-- Insert Users
INSERT INTO users (username, password_hash, role) VALUES
('admin', 'hashedpassword123', 'Admin'),
('instructor1', 'hashedpassword456', 'Instructor');

