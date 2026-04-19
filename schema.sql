CREATE TABLE Students(
	student_id INT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    level_id INT,
    FOREIGN KEY (level_id) REFERENCES Level(level_id)
);

CREATE TABLE Courses(
    course_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    hours INT DEFAULT 3,
    teacher_id INT,
    level_id INT,
    FOREIGN KEY (teacher_id) REFERENCES Teacher(teacher_id),
    FOREIGN KEY (level_id) REFERENCES Level(level_id)
);

CREATE TABLE Level(
    level_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE Teacher(
    teacher_id INT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    age INT NOT NULL
);

CREATE TABLE Lecture(
    lecture_id INT PRIMARY KEY,
    start_time DATE NOT NULL,
    end_time DATE NOT NULL,
    hall_id INT,
    FOREIGN KEY (hall_id) REFERENCES Hall(hall_id)
);
ALTER TABLE Lecture MODIFY start_time TIME;
ALTER TABLE Lecture MODIFY end_time TIME;
CREATE TABLE Exams(
    exam_id INT PRIMARY KEY,
    course_id INT,
    hall_id INT,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id),
    FOREIGN KEY (hall_id) REFERENCES Hall(hall_id)
);

CREATE TABLE Hall(
    hall_id INT PRIMARY KEY,
    number INT NOT NULL
);

CREATE TABLE Student_Course(
    student_course_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

CREATE TABLE Level_Teacher(
    level_id INT,
    teacher_id INT,
    FOREIGN KEY (level_id) REFERENCES Level(level_id),
    FOREIGN KEY (teacher_id) REFERENCES Teacher(teacher_id)
);

CREATE TABLE Grades(
    grade_id INT PRIMARY KEY,
    grade INT NOT NULL,
    student_course_id INT,
    FOREIGN KEY (student_course_id) REFERENCES Student_Course(student_course_id)
);


-- Modify foreign keys with on delete constraint 


ALTER TABLE Students DROP FOREIGN KEY Students_ibfk_1;

ALTER TABLE Students
ADD CONSTRAINT Students_ibfk_1
FOREIGN KEY (level_id) REFERENCES Level(level_id)
ON DELETE SET NULL;



ALTER TABLE Courses DROP FOREIGN KEY Courses_ibfk_1;
ALTER TABLE Courses DROP FOREIGN KEY Courses_ibfk_2;

ALTER TABLE Courses
ADD CONSTRAINT Courses_ibfk_1
FOREIGN KEY (teacher_id) REFERENCES Teacher(teacher_id)
ON DELETE SET NULL;

ALTER TABLE Courses
ADD CONSTRAINT Courses_ibfk_2
FOREIGN KEY (level_id) REFERENCES Level(level_id)
ON DELETE SET NULL;


ALTER TABLE Lecture DROP FOREIGN KEY Lecture_ibfk_1;

ALTER TABLE Lecture
ADD CONSTRAINT Lecture_ibfk_1
FOREIGN KEY (hall_id) REFERENCES Hall(hall_id)
ON DELETE SET NULL;



ALTER TABLE Exams DROP FOREIGN KEY Exams_ibfk_1;
ALTER TABLE Exams DROP FOREIGN KEY Exams_ibfk_2;

ALTER TABLE Exams
ADD CONSTRAINT Exams_ibfk_1
FOREIGN KEY (course_id) REFERENCES Courses(course_id)
ON DELETE CASCADE;

ALTER TABLE Exams
ADD CONSTRAINT Exams_ibfk_2
FOREIGN KEY (hall_id) REFERENCES Hall(hall_id)
ON DELETE SET NULL;



ALTER TABLE Student_Course DROP FOREIGN KEY Student_Course_ibfk_1;
ALTER TABLE Student_Course DROP FOREIGN KEY Student_Course_ibfk_2;

ALTER TABLE Student_Course
ADD CONSTRAINT Student_Course_ibfk_1
FOREIGN KEY (student_id) REFERENCES Students(student_id)
ON DELETE CASCADE;

ALTER TABLE Student_Course
ADD CONSTRAINT Student_Course_ibfk_2
FOREIGN KEY (course_id) REFERENCES Courses(course_id)
ON DELETE CASCADE;



ALTER TABLE Level_Teacher DROP FOREIGN KEY Level_Teacher_ibfk_1;
ALTER TABLE Level_Teacher DROP FOREIGN KEY Level_Teacher_ibfk_2;

ALTER TABLE Level_Teacher
ADD CONSTRAINT Level_Teacher_ibfk_1
FOREIGN KEY (level_id) REFERENCES Level(level_id)
ON DELETE CASCADE;

ALTER TABLE Level_Teacher
ADD CONSTRAINT Level_Teacher_ibfk_2
FOREIGN KEY (teacher_id) REFERENCES Teacher(teacher_id)
ON DELETE CASCADE;



ALTER TABLE Grades DROP FOREIGN KEY Grades_ibfk_1;

ALTER TABLE Grades
ADD CONSTRAINT Grades_ibfk_1
FOREIGN KEY (student_course_id) REFERENCES Student_Course(student_course_id)
ON DELETE CASCADE;


















