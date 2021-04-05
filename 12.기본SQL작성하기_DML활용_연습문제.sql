-- 외래키를 가진 테이블을 먼저 삭제
DROP TABLE lectrue;
DROP TABLE enroll;
DROP TABLE student;

-- 외래키가 없는 테이블을 나중에 삭제
DROP TABLE course;
DROP TABLE professor;


-- 1. professor 테이블
CREATE TABLE professor
(
    professor_no VARCHAR2(5),  -- 기본키
    professor_name VARCHAR2(15),
    professor_major VARCHAR2(30)
);


-- 2. course 테이블
CREATE TABLE course
(
    course_no varchar2(10),   -- 기본키
    course_name VARCHAR2(30),
    course_grade NUMBER(3,2)
);

-- 3. student 테이블
CREATE TABLE student
(   
    student_no varchar2(10),   -- 기본키
    student_name VARCHAR2(15),
    student_address VARCHAR2(100),
    student_grade NUMBER(1),
    professor_no varchar2(5)  -- professor 테이블의 professor_no를 참조하는 외래키
);


-- 4. enroll 테이블
CREATE TABLE enroll
(
    enroll_no NUMBER,   -- 기본키
    student_no varchar2(10),   -- student 테이블의 student_no를 참조하는 외래키
    course_no varchar2(10),    -- course 테이블의 course_no를 참조하는 외래키
    enroll_date DATE
);


-- 5. lecture 테이블
CREATE TABLE lecture
(
    lecture_no NUMBER,   -- 기본키
    professor_no varchar2(5),   -- professor 테이블의 professor_no를 참조하는 외래키
    enroll_no NUMBER,     -- enroll 테이블의 enroll_no를 참조하는 외래키
    lecture_name VARCHAR2(100),
    lecture_room_no VARCHAR2(30)
);



-- 6. 기본키 제약조건 추가
ALTER TABLE professor ADD CONSTRAINT professor_pk PRIMARY KEY(professor_no);
ALTER TABLE course ADD CONSTRAINT course_pk PRIMARY KEY(course_no);
ALTER TABLE student ADD CONSTRAINT student_pk PRIMARY KEY(student_no);
ALTER TABLE enroll ADD CONSTRAINT enroll_pk PRIMARY KEY(enroll_no);
ALTER TABLE lecture ADD CONSTRAINT lecture_pk PRIMARY KEY(lecture_no);


-- 7. 외래키 제약조건 추가
ALTER TABLE student ADD CONSTRAINT student_professor_fk FOREIGN KEY(professor_no) REFERENCES professor(professor_no);
ALTER TABLE enroll ADD CONSTRAINT enroll_student_fk FOREIGN KEY(student_no) REFERENCES student(student_no);
ALTER TABLE enroll ADD CONSTRAINT enroll_course_fk FOREIGN KEY(course_no) REFERENCES course(course_no);
ALTER TABLE lecture ADD CONSTRAINT lecture_professor_fk FOREIGN KEY(professor_no) REFERENCES professor(professor_no);
ALTER TABLE lecture ADD CONSTRAINT lecture_enroll_fk FOREIGN KEY(enroll_no) REFERENCES enroll(enroll_no);




-- 8. professor 테이블 데이터 입력
INSERT INTO professor (professor_no, professor_name, professor_major) VALUES ('AB000', '브레드', '영문학');
INSERT INTO professor (professor_no, professor_name, professor_major) VALUES ('AB200', '앨리스', '실용음악');
INSERT INTO professor (professor_no, professor_name, professor_major) VALUES ('SS300', '크리스', '경영');


-- 9. course 테이블 데이터 입력
INSERT INTO course (course_no, course_name, course_grade) VALUES (301, '영어', 2.01);
INSERT INTO course (course_no, course_name, course_grade) VALUES (303, '음악', 4.35);
INSERT INTO course (course_no, course_name, course_grade) VALUES (302, '사회', 3.20);


-- 10. student 테이블 데이터 입력
INSERT INTO student VALUES (10101, '보라돌이', '서울', '1', 'AB000');
INSERT INTO student VALUES (10102, '나나', '인천', '2', 'SS300');
INSERT INTO student VALUES (10103, '뽀', '부산', '3', 'AB200');

-- 11. enroll 테이블 데이터 입력
INSERT INTO enroll (enroll_no, student_no, course_no, enroll_date) VALUES (100, 10101, 301, SYSDATE);
INSERT INTO enroll (enroll_no, student_no, course_no, enroll_date) VALUES (101, 10103, 302, SYSDATE);
INSERT INTO enroll (enroll_no, student_no, course_no, enroll_date) VALUES (102, 10102, 303, SYSDATE);


-- 12. lectrue 테이블 데이터 입력
INSERT INTO lecture VALUES (5000, 'SS300', 100, '경영이론', 'A101');
INSERT INTO lecture VALUES (5001, 202, 101, '기초피아노연주', 'B101');
INSERT INTO lecture VALUES (5002, 201, 102, '영어문법', 'C107');



-- 13. 변경된 내용을 DB에 저장한다.
COMMIT;   -- INSERT, UPDATE, DELETE 문은 필요


















    
    
    
    
    
    
    
    
    
    