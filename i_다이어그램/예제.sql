### 'i_다이어그램' 폴더 >>> '예제' 파일 ###

# 학교 관리 시스템 #

/*
요구 사항
school_db 데이터베이스 생성

학생(Students) 테이블: 학생 ID, 이름, 전공, 입학년도를 포함
교수(Professors) 테이블: 교수 ID, 이름, 학과, 사무실 위치를 포함
강의(Courses) 테이블: 강의 ID, 강의명, 담당 교수 ID, 학점 수를 포함
수강(Enrollments) 테이블: 수강 ID, 학생 ID, 강의 ID, 수강년도, 학기를 포함

각 테이블의 ID는 기본 키로 설정
교수 ID는 강의 테이블에서 외래 키로 설정되어야 하며, 교수와 강의 사이의 관계 작성
학생 ID와 강의 ID는 수강 테이블에서 외래 키로 설정되어야 하며, 학생, 강의, 수강 사이의 다대다 관계 작성.

*/
create database `school_db`;

use `school_db`;

# 테이블 간 관계
### 
# 1. 교수-강의(1:N, 일대다)
# : 한 명의 교수는 여러 강의를 담당
# : 강의 테이블에서 담당교수ID가 존재 - FK
# : ERD 선: 점선 (비식별 관계)
# 	>> 교수 ID가 FK로만 사용 (PK X)

# 2. 학생 - 수강내역 - 강의 관계 (N:M, 다대다)
# : 학생은 여러 강의를 수강할 수 있고
# : 한 강의는 여러 학생이 수강할 수 있음
# >> 

create table `Students`(
		student_id int primary key,
    name varchar(20),
    major varchar(100),
    admissionYear Date
);

alter table `students` modify column admissionYear int;

create table `Professors`(
		professor_id int primary key,
	name varchar(20),
	department varchar(100),
	officeLocation varchar(100)
);



create table `Courses`(
		course_id int primary key,
	courseName varchar(100),
    professor_id int,
    numberCredit int,
	
	foreign key (professor_id) references `Professors` (professor_id)
);

create table `Enrollments`(
		enrollment_id int primary key,
	student_id int,
    course_id int,
    attendanceYear int,
    term int,
    
    foreign key (student_id) references `Students` (student_id),
    foreign key (course_id) references `Courses` (course_id)
);

-- Students
INSERT INTO Students VALUES (1, 'Alice', 'Computer Science', 2020);
INSERT INTO Students VALUES (2, 'Bob', 'Mathematics', 2021);
INSERT INTO Students VALUES (3, 'Charlie', 'Physics', 2022);

-- Professors
INSERT INTO Professors VALUES (1, 'Dr. Smith', 'Computer Science', 'Room 101');
INSERT INTO Professors VALUES (2, 'Dr. Johnson', 'Mathematics', 'Room 102');
INSERT INTO Professors VALUES (3, 'Dr. Williams', 'Physics', 'Room 103');

-- Courses
INSERT INTO Courses VALUES (1, 'Introduction to Programming', 1, 3);
INSERT INTO Courses VALUES (2, 'Calculus I', 2, 4);
INSERT INTO Courses VALUES (3, 'Mechanics', 3, 4);

-- Enrollments
INSERT INTO Enrollments VALUES (1, 1, 1, 2023, 1);
INSERT INTO Enrollments VALUES (2, 2, 2, 2023, 1);
INSERT INTO Enrollments VALUES (3, 3, 3, 2023, 1);

/*
전공이 컴퓨터 과학인 학생들의 이름과 입학년도를 조회하는 SQL 명령문을 작성
담당 교수 ID가 2인 강의의 강의명과 학점 수를 조회하는 SQL 명령문을 작성
2023년도 1학기에 수강하는 학생들의 목록을 조회하는 SQL 명령문을 작성 (학생 ID와 이름을 포함)
*/ 

select name,  admissionYear from `Students` where major = 'Computer Science';
select courseName,  numberCredit from `Courses` where professor_id = 2;

select * from Students S inner Join Enrollments E on S.student_id = E.student_id where term = 1 and attendanceYear = 2023;