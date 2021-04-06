-- department 테이블
CREATE TABLE department
(
    dept_no NUMBER,
    dept_name VARCHAR2(10),
    location VARCHAR2(10)
);

-- employee 테이블
CREATE TABLE employee
(
    emp_no NUMBER,
    name VARCHAR2(10),
    depart NUMBER,
    position VARCHAR2(10),
    gender VARCHAR2(1),
    hire_date DATE,
    salary NUMBER
);

-- 기본키
ALTER TABLE department ADD CONSTRAINT department_pk PRIMARY KEY(dept_no);
ALTER TABLE employee ADD CONSTRAINT employee_pk PRIMARY KEY(emp_no);

-- 외래키
ALTER TABLE employee ADD CONSTRAINT employee_department_fk FOREIGN KEY(depart) REFERENCES department(dept_no);


-- department 테이블 데이터 삽입
INSERT INTO department 
        (dept_no, dept_name, location) 
VALUES 
      (1, '영업부', '대구');
INSERT INTO department (dept_no, dept_name, location) VALUES (2, '인사부', '서울');
INSERT INTO department (dept_no, dept_name, location) VALUES (3, '총무부', '대구');
INSERT INTO department (dept_no, dept_name, location) VALUES (4, '기획부', '서울');

-- employee 테이블 데이터 삽입
INSERT INTO employee 
      (emp_no, name, depart, position, gender, hire_date, salary)
VALUES
      (1001, '구창민', 1, '과장', 'M', '95-05-01', 5000000);
INSERT INTO employee VALUES(1002, '김민서', 1, '사원', 'M', '17-09-01', 2500000);
INSERT INTO employee VALUES(1003, '이은영', 2, '부장', 'F', '90-09-01', 5500000);
INSERT INTO employee VALUES(1004, '한성일', 2, '과장', 'M', '93-04-01', 5000000);

COMMIT;


-- 카테젼 곱
-- 두 테이블의 조인 조건(관계)이 잘못되거나 없을 때 나타난다.
SELECT
       e.emp_no
     , e.name
     , d.dept_name
     , e.position
     , e.hire_date
     , e.salary
  FROM employee e, department d;

SELECT
       e.emp_no
     , e.name
     , d.dept_name
     , e.position
     , e.hire_date
     , e.salary
  FROM employee e
 CROSS JOIN department d;











