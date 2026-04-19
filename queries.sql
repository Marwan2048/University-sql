-- ---------------------------------------------------------------

-- 1)Retrieve all students who are taught by teacher "Omar"

SELECT * FROM Students 
WHERE student_id IN
( SELECT student_id FROM student_course 
WHERE course_id IN 
( SELECT course_id FROM  Courses
WHERE  teacher_id IN ( SELECT teacher_id FROM Teacher  WHERE first_name = "Omar") )
);

-- ---------------------------------------------------------------

-- 2)Retrieve all teachers who teach courses assigned to Level 2

SELECT t.first_name , t.last_name , t.age  FROM Teacher  t
LEFT JOIN Courses c ON t.teacher_id = c.teacher_id
JOIN Level l ON l.level_id = c.level_id
WHERE l.name = "level 2";

-- ---------------------------------------------------------------


-- 3)Retrieve all course grades for student with student_id = 20

SELECT s.first_name , s.last_name ,  c.name as Course ,g.grade  FROM grades g
JOIN student_course sc ON sc.student_course_id = g.student_course_id
JOIN students s ON sc.student_id = s.student_id
JOIN Courses c ON sc.course_id = c.course_id
WHERE sc.student_id = 20;

-- ---------------------------------------------------------------

-- 4)Retrieve hall number where the course "AI" has an exam scheduled

SELECT h.hall_id, c.name as Course , c.hours ,number as hall_number FROM Hall h
JOIN exams e on h.hall_id = e.hall_id
JOIN Courses c on c.course_id = e.course_id
WHERE c.name = "AI";

-- ---------------------------------------------------------------

-- 5)Count the number of lectures that occur within the time range 10:30 AM to 2:00 PM

SELECT count(*) as num_of_lectures FROM lecture 
WHERE start_time >= '09:00:00' AND end_time <= '14:00:00';

-- ---------------------------------------------------------------

-- 6)Retrieve top 5 students ranked by their average grade percentage

-- ---------------------------------------------------------------

SELECT  sc.student_id , s.first_name , s.last_name  , ROUND(AVG(grade),2) AS percentage FROM Grades g
JOIN student_course sc ON g.student_course_id = sc.student_course_id
JOIN students s ON sc.student_id = s.student_id
GROUP BY sc.student_id
ORDER BY percentage DESC
LIMIT 5 ;

-- ---------------------------------------------------------------

-- 7)Retrieve the highest grade achieved in each course

SELECT  c.name as course  , MAX(g.grade) as Highest_grade FROM students s 
JOIN student_course sc on s.student_id = sc.student_id
JOIN courses c ON c.course_id = sc.course_id  
JOIN Grades g on sc.student_course_id = g.student_course_id
GROUP BY c.name;

-- ---------------------------------------------------------------

-- 8)Return teachers who are not teaching any course

SELECT * FROM Teacher
WHERE teacher_id NOT IN (SELECT teacher_id FROM Courses);

-- ---------------------------------------------------------------

-- 9)Return students who are enrolled in 2 courses only

SELECT s.first_name , s.last_name ,COUNT(*) AS num_courses_enrolled FROM students s
JOIN student_course sc ON s.student_id = sc.student_id
GROUP BY s.student_id
HAVING num_courses_enrolled = 2;

-- ---------------------------------------------------------------

-- 10)Return students who have at least one grade below 80

SELECT s.first_name , s.last_name ,s.age , c.name as Course , g.grade as Grade FROM students s
JOIN student_course sc ON s.student_id = sc.student_id 
JOIN grades g ON sc.student_course_id = g.student_course_id
JOIN Courses c  ON c.course_id = sc.course_id
WHERE g.grade < 80;

-- ---------------------------------------------------------------

-- 11)Return the most used hall (highest number of lectures)

SELECT   hall_id , COUNT(*) AS num_of_lectures FROM Lecture
GROUP BY hall_id
ORDER BY COUNT(*) DESC
LIMIT 1 ;

-- ---------------------------------------------------------------

-- 12)Return students who are enrolled in ALL courses of their level

SELECT s.first_name , s.last_name ,s.student_id, l.level_id , COUNT(*) AS num_of_courses FROM Students s
JOIN student_course sc ON s.student_id = sc.student_id
JOIN courses c  ON c.course_id = sc.course_id 
JOIN Level l ON l.level_id = c.level_id
GROUP BY s.student_id ,l.level_id 
HAVING COUNT(*) IN (
					SELECT  COUNT(*)  FROM courses c
					JOIN Level l
					ON l.level_id = c.level_id
					GROUP BY l.level_id
					)
AND l.level_id IN (
				SELECT l.level_id  FROM courses c
				JOIN Level l
				ON l.level_id = c.level_id
				GROUP BY l.level_id);

