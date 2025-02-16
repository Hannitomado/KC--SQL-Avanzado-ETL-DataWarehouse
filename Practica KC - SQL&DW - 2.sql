-- Creamos una condicion para no crear las tablas si estas ya existen
DROP TABLE IF EXISTS student_assignments, instructor_courses, bootcamp_courses, payments, enrollments, assignments, instructors, courses, bootcamps, students;

-- Creamos la tabla students 
CREATE TABLE students (
    student_ID SERIAL PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255),
    phone VARCHAR(20),
    address TEXT
);
-- Añadimos las restricciones para students
ALTER TABLE students
ALTER COLUMN name SET NOT NULL;
ALTER TABLE students
ALTER COLUMN email SET NOT NULL;

ALTER TABLE students
ADD CONSTRAINT unique_email UNIQUE (email);

-- Crear la tabla bootcamps
CREATE TABLE bootcamps (
    bootcamp_ID SERIAL PRIMARY KEY,
    name VARCHAR(255),
    duration INT,
    cost NUMERIC(10,2)
);

-- Añadimos las restricciones para bootcamps
ALTER TABLE bootcamps
ALTER COLUMN name SET NOT NULL;
ALTER TABLE bootcamps
ALTER COLUMN duration SET NOT NULL;
ALTER TABLE bootcamps 
ALTER COLUMN cost SET NOT NULL;

-- Crear la tabla courses
CREATE TABLE courses (
    course_ID SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    hours INT NOT NULL
);

-- Añadimos las restricciones para courses
ALTER TABLE courses 
ALTER COLUMN title SET NOT NULL;
ALTER TABLE courses
ALTER COLUMN hours SET NOT NULL;

-- Crear la tabla instructors
CREATE TABLE instructors (
    instructor_ID SERIAL PRIMARY KEY,
    name VARCHAR(255),
    specialization VARCHAR(255)
);

-- Añadimos las restricciones para instructors
ALTER TABLE instructors
ALTER COLUMN name SET NOT NULL;
ALTER TABLE instructors
ALTER COLUMN specialization SET NOT NULL;

-- Crear la tabla assignments
CREATE TABLE assignments (
    assignment_ID SERIAL PRIMARY KEY,
    course_ID INT,
    title VARCHAR(255),
    description TEXT,
    max_score INT
);

-- Añadimos las restricciones para assignments
ALTER TABLE assignments
ADD CONSTRAINT fk_assignments_course FOREIGN KEY (course_ID) REFERENCES courses(course_ID) ON DELETE CASCADE;
ALTER TABLE assignments
ALTER COLUMN course_ID SET NOT NULL;
ALTER TABLE assignments
ALTER COLUMN title SET NOT NULL;
ALTER TABLE assignments
ALTER COLUMN max_score SET NOT NULL;

-- Crear la tabla enrollments
CREATE TABLE enrollments (
    enrollment_ID SERIAL PRIMARY KEY,
    student_ID INT,
    bootcamp_ID INT,
    enrollment_Date DATE,
    completion_status VARCHAR(20) CHECK (completion_status IN ('No Iniciado', 'Iniciado', 'Completado')) DEFAULT 'No Iniciado',
    completion_date DATE,
    progress_percentage NUMERIC(5,2) DEFAULT 0.00
);

-- Añadimos las restricciones para enrollments
ALTER TABLE enrollments
ADD CONSTRAINT fk_enrollments_student FOREIGN KEY (student_ID) REFERENCES students(student_ID) ON DELETE CASCADE;
ALTER TABLE enrollments
ADD CONSTRAINT fk_enrollments_bootcamp FOREIGN KEY (bootcamp_ID) REFERENCES bootcamps(bootcamp_ID) ON DELETE CASCADE;
ALTER TABLE enrollments
ALTER COLUMN student_ID SET NOT NULL;
ALTER TABLE enrollments
ALTER COLUMN bootcamp_ID SET NOT NULL;
ALTER TABLE enrollments
ALTER COLUMN enrollment_date SET NOT NULL;
ALTER TABLE enrollments
ALTER COLUMN completion_status SET NOT NULL;
ALTER TABLE enrollments
ALTER COLUMN progress_percentage SET NOT NULL;

-- Crear la tabla payments
CREATE TABLE payments (
    payment_ID SERIAL PRIMARY KEY,
    student_ID INT,
    amount NUMERIC(10,2),
    payment_date DATE
);

-- Añadimos las restricciones para payments
ALTER TABLE payments
ADD CONSTRAINT fk_payments_student FOREIGN KEY (student_ID) REFERENCES students(student_ID) ON DELETE CASCADE;
ALTER TABLE payments
ALTER COLUMN student_ID SET NOT NULL;
ALTER TABLE payments
ALTER COLUMN amount SET NOT NULL;
ALTER TABLE payments
ALTER COLUMN payment_date SET NOT NULL;

-- Crear la tabla bootcamp_courses (tabla conjunta entre bootcamps y courses)
CREATE TABLE bootcamp_courses (
	bootcamp_course_ID SERIAL PRIMARY KEY,
    bootcamp_ID INT,
    course_ID INT,
    FOREIGN KEY (bootcamp_ID) REFERENCES bootcamps(bootcamp_ID) ON DELETE CASCADE,
    FOREIGN KEY (course_ID) REFERENCES courses(course_ID) ON DELETE CASCADE,
    UNIQUE (bootcamp_ID, course_ID)
);

-- Añadimos las restricciones para bootcamp_courses
ALTER TABLE bootcamp_courses
ALTER COLUMN bootcamp_ID SET NOT NULL;
ALTER TABLE bootcamp_courses
ALTER COLUMN course_ID SET NOT NULL;


-- Crear la tabla instructor_courses (tabla conjunta entre instructor y courses)
CREATE TABLE instructor_courses (
	instructor_course_ID SERIAL PRIMARY KEY,
    instructor_ID INT,
    course_ID INT,
    FOREIGN KEY (instructor_ID) REFERENCES instructors(instructor_ID) ON DELETE CASCADE,
    FOREIGN KEY (course_ID) REFERENCES courses(course_ID) ON DELETE CASCADE,
    UNIQUE (instructor_ID, course_ID)
);

-- Añadimos las restricciones para instructor_courses
ALTER TABLE instructor_courses
ALTER COLUMN instructor_ID SET NOT NULL;
ALTER TABLE instructor_courses
ALTER COLUMN course_ID SET NOT NULL;


-- Crear la tabla students_assignments (tabla conjunta entre students y assignments)
CREATE TABLE student_assignments (
	student_assignment_ID SERIAL PRIMARY KEY,
    student_ID INT,
    assignment_ID INT,
    submission_date DATE,
    score INT,
    status VARCHAR(20) CHECK (status IN ('No Iniciado', 'Iniciado', 'Completado')) DEFAULT 'No Iniciado',
    FOREIGN KEY (student_ID) REFERENCES students(student_ID) ON DELETE CASCADE,
    FOREIGN KEY (assignment_ID) REFERENCES assignments(assignment_ID) ON DELETE CASCADE,
    UNIQUE (student_ID, assignment_ID)
);

-- Añadimos las restricciones para student_assignments
ALTER TABLE student_assignments
ALTER COLUMN student_ID SET NOT NULL;
ALTER TABLE student_assignments
ALTER COLUMN assignment_ID SET NOT NULL;
ALTER TABLE student_assignments
ALTER COLUMN status SET NOT NULL;

