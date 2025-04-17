### 뷰 연습 문제 ###
create database school;
use school;

create table `students`(
	student_Id int primary key,
    first_name varchar(50),
    last_name varchar(50),
    age int,
    major varchar(50)
);


create table `courses`(
	course_id int primary key,
    course_name varchar(100),
    instructor varchar(100),
    credit_hours int
);

create table `student_courses`(
	student_id int,
    course_id int,
    
    primary key (student_id, course_id)
);


INSERT INTO Students (Student_Id, first_name, last_name, Age, Major)
VALUES (1, 'John', 'Doe', 20, 'Computer Science'),
       (2, 'Jane', 'Smith', 22, 'Mathematics'),
       (3, 'Alice', 'Johnson', 19, 'Biology'),
       (4, 'Bob', 'Brown', 21, 'History');

INSERT INTO Courses (course_id, course_name, instructor, credit_hours)
VALUES (101, 'Introduction to Programming', 'Prof. Smith', 3),
       (102, 'Calculus I', 'Prof. Johnson', 4),
       (103, 'Biology 101', 'Prof. Davis', 3),
       (104, 'World History', 'Prof. Wilson', 3);
       
INSERT INTO student_courses(student_id, course_id)
VALUES (1, 101),
       (2, 102),
       (3, 103),
       (4, 104);
       
       
create view studentCourseView
as 
	select
		S.first_name as student_first_name,
		S.last_name as stuent_last_name,
        C.course_name as CourseName,
        C.instructor as course_instructor
	from
		student_courses sc
	inner join students S on sc.student_id = s.student_id
    inner join courses C on sc.course_id = C.course_id;
    
    
select * from studentCourseview;