-- 시퀀스
-- 1. 일렬번호 생성 객체이다.
-- 2. 주로 기본키(인공키)에서 사용한다.
-- 3. curravl : 시퀀스가 생성해서 사용한 현재 번호
-- 4. nextval : 시퀀스가 생성해야 할 다음 번호


-- 시퀀스 생성
CREATE SEQUENCE employee_seq
INCREMENT BY 1  -- 번호가 1씩 증가한다.
START WITH 1000  -- 번호 시작이 1000이다.
NOMAXVALUE -- 최대값 없음 (MAXVALUE 999999)
NOMINVALUE -- 최소값 없음
NOCYCLE  -- 번호 순환이 없다.
NOCACHE;  -- 메모리에 캐시하지 않는다. 항상 유지.

-- employee3 테이블에 행 삽입
-- emp_no는 시퀀스로 입력
INSERT INTO employee3
    (emp_no, name, depart, position, gender, hire_date, salary)
VALUES
    (employee_seq.nextval, '구창민', 1, '과장', 'M', '95-05-01', 5000000);
    
-- 시퀀스 값 확인
SELECT employee_seq.currval
  FROM dual;
  
-- 시퀀스 목록 확인
SELECT *
  FROM user_sequences;
  


-- ROWNUM : 가상 행 번호
-- ROWID : 데이터가 저장된 물리적 위치 정보 

SELECT ROWNUM
     , ROWID
     , emp_no
     , name
  FROM employee;
  
-- 최고 빠른 검색 : ROWID를 이용한 검색 (오라클의 검색 방식)
SELECT emp_no
     , name
  FROM employee
 WHERE ROWID = 'AAAFDnAABAAALCxAAC';
 
-- 그 다음 빠른 검색 : INDEX를 이용한 검색 (휴먼의 검색 방식)
SELECT emp_no
     , name
  FROM employee
 WHERE emp_no = 1003;
  
-- ROWNUM의 WHERE절 사용
-- 주의.
-- 1. 1을 포함하는 검색만 가능하다.
-- 2. 순서대로 몇 건을 추출하기 위한 목적이다.
-- 3. 특정 위치를 지정한 검색은 불가능하다.
SELECT emp_no
     , name
  FROM employee
 WHERE ROWNUM = 1;  -- 가능하다.
  
SELECT emp_no
     , name
  FROM employee
 WHERE ROWNUM = 2;  -- 불가능하다.
  
SELECT emp_no
     , name
  FROM employee
 WHERE ROWNUM BETWEEN 1 AND 3;   -- 가능하다.
  
SELECT emp_no
     , name
  FROM employee
 WHERE ROWNUM BETWEEN 3 AND 5;   -- 불가능하다.
 
-- 1 이외의 번호로 시작하는 모든 ROWNUM을 사용하기 위해서는 
-- ROWNUM에 별명을 주고 별명을 사용한다.

SELECT ROWNUM AS rn  -- 실행순서3
     , emp_no
     , name
  FROM employee   -- 실행순서1
 WHERE rn = 2;   -- 실행순서2
 
 
SELECT e.emp_no  -- 실행순서3
     , e.name
  FROM (SELECT ROWNUM AS rn
             , emp_no
             , name
          FROM employee) e  -- 실행순서1 (여기서 rn이 만들어진다.)
 WHERE e.rn= 2;   -- 실행순서2



-- 연습문제
-- 1. 다음 테이블을 생성한다.
-- 게시판(글번호, 글제목, 글내용, 글작성자, 작성일자)
-- 회원(회원번호, 아이디, 이름, 가입일자)
DROP TABLE BOARD;
DROP TABLE MEMBERS;

CREATE TABLE members
(
    member_no NUMBER,
    member_id VARCHAR2(30) NOT NULL UNIQUE,
    member_name VARCHAR2(15),
    member_date DATE
);

CREATE TABLE board
(
    board_no NUMBER,
    board_title VARCHAR2(1000),
    board_content VARCHAR2(4000),
    member_id VARCHAR2(30),
    board_date DATE
);
    

-- 2. 각 테이블에서 사용할 시퀀스를 생성한다.
-- 게시판 시퀀스(1~무제한)
-- 회원시퀀스(100000~999999)
DROP SEQUENCE BOARD_SEQ;
DROP SEQUENCE MEMBER_SEQ;
CREATE SEQUENCE member_seq INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE;
CREATE SEQUENCE board_seq INCREMENT BY 1 START WITH 100000 MAXVALUE 999999 NOCYCLE NOCACHE;


-- 3. 각 테이블에 적절한 기본키, 외래키, 데이터(5개)를 추가한다.
-- 기본키
ALTER TABLE members ADD CONSTRAINT members_pk primary key(member_no);
ALTER TABLE board ADD CONSTRAINT board_pk PRIMARY KEY(board_no);
-- 외래키
ALTER TABLE board ADD CONSTRAINT board_member_fk foreign key(member_id) REFERENCES members(member_id);

insert into members(member_no, member_id, member_name, member_date) values 
     (member_seq.nextval, 'apple', '사과', '21/04/01');
insert into members(member_no, member_id, member_name, member_date) values 
     (member_seq.nextval, 'strawberry', '딸기', '21/04/02');
insert into members(member_no, member_id, member_name, member_date) values 
     (member_seq.nextval, 'banana', '바나나', '21/04/03');
insert into members(member_no, member_id, member_name, member_date) values 
     (member_seq.nextval, 'grape', '포도', '21/04/04');
insert into members(member_no, member_id, member_name, member_date) values 
     (member_seq.nextval, 'orange', '오렌지', '21/04/05');


insert into board(board_no, board_title, board_content, member_id, board_date) values
     ( board_seq.nextval, '공지사항', '날씨가 추우니 옷을 따뜻하게 입으세요.', 'apple', '21/04/10');
insert into board(board_no, board_title, board_content, member_id, board_date) values
     ( board_seq.nextval, '필독[건의]', '건의사항이 있으면 작성해주세요.', 'grape', '21/04/11');
insert into board(board_no, board_title, board_content, member_id, board_date) values
     ( board_seq.nextval, '가입인사', '안녕하세요.반갑습니다', 'orange', '21/04/12');
insert into board(board_no, board_title, board_content, member_id, board_date) values
     ( board_seq.nextval, '수다', '날씨가 너무 좋네요.', 'strawberry', '21/04/13');
insert into board(board_no, board_title, board_content, member_id, board_date) values
     ( board_seq.nextval, '추천', '오늘의 음악 추천합니다.', 'banana', '21/04/14');

commit;

select * from board;
select * from members;

-- 4. 게시판을 글제목의 가나다순으로 정렬하고 첫 번째 글을 조회한다.
SELECT b.board_no
     , b.board_title
     , b.board_content
     , b.member_id
     , b.board_date
  FROM (SELECT board_no
             , board_title
             , board_content
             , member_id
             , board_date
         FROM board
        ORDER BY board_title) b
 WHERE ROWNUM = 1;




-- 5. 게시판을 글번호의 가나다순으로 정렬하고 1 ~ 3번째 글을 조회한다.
SELECT b.board_no
     , b.board_title
     , b.board_content
     , b.member_id
     , b.board_date
  FROM (SELECT board_NO
             , board_title
             , board_content
             , member_id
             , board_date
         FROM board
        ORDER BY board_no) b
 WHERE ROWNUM <= 3;



-- 6. 게시판을 최근 작성일자순으로 정렬하고 3 ~ 5번째 글을 조회한다.
SELECT a.*
  FROM (SELECT b.board_no
             , b.board_title
             , b.board_content
             , b.member_id
             , b.board_date
             , ROWNUM AS rn
         FROM (SELECT board_no
                    , board_title
                    , board_content
                    , member_id
                    , board_date
                 FROM board
                ORDER BY board_date DESC) b) a
 WHERE a.rn BETWEEN 3 AND 5;



-- 7. 가장 먼저 가입한 회원을 조회한다.
-- 가입일을 기준으로 오름차순 정렬하고 첫 번째 항목을 조회한다.
SELECT m.member_no
     , m.member_id
     , m.member_name
     , m.member_date
  FROM (SELECT member_no
             , member_id
             , member_name
             , member_date
          FROM members
         ORDER BY member_date) m 
 WHERE ROWNUM = 1;


-- 8. 3번째로 가입한 회원을 조회한다.
SELECT m2.member_no
     , m2.member_id
     , m2.member_name
     , m2.member_date
  FROM (SELECT m1.member_no
             , m1.member_id
             , m1.member_name
             , m1.member_date
             , ROWNUM AS rn 
          from (select member_no
                     , member_id
                     , member_name
                     , member_date
                 from members
                 order by member_date) m1) m2
 where m2.rn = 3;



-- 9. 가장 나중에 가입한 회원을 조회한다.
SELECT m.member_no
     , m.member_id
     , m.member_name
     , m.member_date
  FROM (SELECT member_no
             , member_id
             , member_name
             , member_date
          FROM members
         ORDER BY member_date DESC) m 
 WHERE ROWNUM = 1;
  