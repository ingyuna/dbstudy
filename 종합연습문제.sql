DROP TABLE BUYS;
DROP TABLE USERS;

-- 사용자(USERS) 테이블 생성
CREATE TABLE USERS (
    USER_NO NUMBER,  -- 사용자번호
    USER_ID VARCHAR2(20) NOT NULL UNIQUE,  -- 아이디
    USER_NAME VARCHAR2(20),  -- 이름
    USER_YEAR NUMBER(4),  -- 태어난년도
    USER_ADDR VARCHAR2(100),  -- 주소
    USER_MOBILE1 VARCHAR2(3),  -- 010, 011 등
    USER_MOBILE2 VARCHAR2(8),  -- 12345678, 11111111 등
    USER_REGDATE DATE  -- 가입일
);

-- 구매(BUYS) 테이블 생성
CREATE TABLE BUYS (
    BUY_NO NUMBER,  -- 구매번호
    USER_ID VARCHAR2(20),  -- 구매자아이디
    PROD_NAME VARCHAR2(20),  -- 제품명
    PROD_CATEGORY VARCHAR2(20),  -- 제품카테고리
    PROD_PRICE NUMBER,  -- 제품가격
    BUY_AMOUNT NUMBER  -- 구매수량
);

1. 적절한 기본키와 외래키를 지정하시오.
ALTER TABLE users ADD CONSTRAINT users_pk PRIMARY KEY(user_no);
ALTER TABLE buys ADD CONSTRAINT buys_pk primary key(buy_no);
alter table buys add constraint buys_users_fk foreign key(user_id) references users(user_id);


2. 아래 INSERT문에서 사용되고 있는 사용자번호와 구매번호 대신 사용할 시퀀스를 생성하고 이를 INSERT문에 적용한 뒤 INSERT문을 실행하시오.
create sequence users_seq increment by 1 start with 1 nomaxvalue nocycle nocache;
create sequence buys_seq increment by 1 start with 1001 nomaxvalue nocycle nocache;


-- USERS 테이블에 레코드(행, ROW) 삽입하기
INSERT INTO USERS VALUES (users_seq.nextval, 'YJS', '유재석', 1972, '서울', '010', '11111111', '08/08/08');
INSERT INTO USERS VALUES (users_seq.nextval, 'KHD', '강호동', 1970, '경북', '011', '22222222', '07/07/07');
INSERT INTO USERS VALUES (users_seq.nextval, 'KKJ', '김국진', 1965, '서울', '019', '33333333', '09/09/09');
INSERT INTO USERS VALUES (users_seq.nextval, 'KYM', '김용만', 1967, '서울', '010', '44444444', '15/05/05');
INSERT INTO USERS VALUES (users_seq.nextval, 'KJD', '김제동', 1974, '경남', NULL, NULL, '13/03/03');
INSERT INTO USERS VALUES (users_seq.nextval, 'NHS', '남희석', 1971, '충남', '016', '55555555', '14/04/04');
INSERT INTO USERS VALUES (users_seq.nextval, 'SDY', '신동엽', 1971, '경기', NULL, NULL, '08/10/10');
INSERT INTO USERS VALUES (users_seq.nextval, 'LHJ', '이휘재', 1972, '경기', '011', '66666666', '06/04/04');
INSERT INTO USERS VALUES (users_seq.nextval, 'LKK', '이경규', 1960, '경남', '018', '77777777', '04/12/12');
INSERT INTO USERS VALUES (users_seq.nextval, 'PSH', '박수홍', 1970, '서울', '010', '88888888', '12/05/05');

-- BUYS 테이블에 레코드(행, ROW) 삽입하기
INSERT INTO BUYS VALUES (buys_seq.nextval, 'KHD', '운동화', '신발', 30, 2);
INSERT INTO BUYS VALUES (buys_seq.nextval, 'KHD', '노트북', '전자', 1000, 1);
INSERT INTO BUYS VALUES (buys_seq.nextval, 'KYM', '모니터', '전자', 200, 1);
INSERT INTO BUYS VALUES (buys_seq.nextval, 'PSH', '모니터', '전자', 200, 5);
INSERT INTO BUYS VALUES (buys_seq.nextval, 'KHD', '청바지', '의류', 50, 3);
INSERT INTO BUYS VALUES (buys_seq.nextval, 'PSH', '메모리', '전자', 80, 10);
INSERT INTO BUYS VALUES (buys_seq.nextval, 'KJD', '책', '의류', 15, 5);
INSERT INTO BUYS VALUES (buys_seq.nextval, 'LHJ', '책', '서적', 15, 2);
INSERT INTO BUYS VALUES (buys_seq.nextval, 'LHJ', '청바지', '의류', 50, 1);
INSERT INTO BUYS VALUES (buys_seq.nextval, 'PSH', '운동화', '신발', 30, 2);

-- 3. 제품명이 '책'인데 제품카테고리가 '서적'이 아닌 구매 목록을 찾아서 제품카테고리를 '서적'으로 수정하시오.
UPDATE buys 
   SET prod_category = '서적' 
 WHERE prod_name = '책' 
   AND prod_category != '서적';


-- 4. 연락처1이 '011'인 사용자의 연락처1을 '010'으로 수정하시오.
UPDATE users 
   SET user_mobile1 = '010' 
 WHERE user_mobile1 = '011';


-- 5. 구매 테이블에서 사용자번호가 5인 사용자의 구매 정보를 삭제하시오.
-- BUYS 테이블에서 사용자번호(USER_NO)를 이용해서 사용자아이디(USER_ID)를 알아내기
SELECT u.user_id
  FROM users u, buys b
 WHERE u.user_id = b.user_id
   AND u.user_no = 5;

DELETE
  FROM buys
 WHERE user_id = (SELECT u.user_id
                    FROM users u, buys b
                   WHERE u.user_id = b.user_id
                     AND u.user_no = 5);
                     
--간단하게!
DELETE
  FROM buys b
 WHERE b.user_id = (SELECT u.user_id
                      FROM users u
                     WHERE u.user_no = 5);

-- 6. 연락처1이 없는 사용자를 조회하시오.
SELECT user_id
     , user_name
     , user_mobile1
  FROM users
 WHERE user_mobile1 IS NULL;
 

-- 7. 연락처2가 '5'로 시작하는 사용자를 조회하시오.
SELECT user_id
     , user_name
     , user_mobile2
  FROM users
 WHERE user_mobile2 LIKE '5%';


-- 8. 구매 이력이 있는 사용자들의 이름, 제품명, 제품가격, 구매수량을 조회하시오.
SELECT 
       u.user_name
     , b.prod_name
     , b.prod_price
     , b.buy_amount
  FROM users u INNER JOIN buys b
    ON u.user_id = b.user_id;


-- 9. 제품카테고리별로 그룹화하여 제품카테고리, 구매횟수, 총구매수량을 조회하시오.
SELECT 
       prod_category
     , COUNT(*) AS 구매횟수
     , SUM(buy_amount) AS 총구매수량
  FROM buys
 GROUP BY prod_category;


-- 10. 구매 이력이 있는 고객을 대상으로 어떤 고객이 어떤 제품을 구매했는지 알 수 있도록 고객명, 구매제품을 조회하시오.
SELECT 
       u.user_name AS 고객명
     , b.prod_name AS 구매제품명
  FROM users u INNER JOIN buys b
    ON u.user_id = b.user_id;
 

-- 11. 제품을 구매한 이력이 있는 고객아이디, 고객명, 총구매횟수를 조회하시오.
select 
       u.user_id as 고객아이디  -- b.user_id도 가능하다.
     , u.user_name as 고객명
     , count(buy_no) AS 총구매횟수
  FROM users u inner join buys b
    on u.user_id = b.user_id
 group by u.user_id, u.user_name;
 

-- 12. 구매 이력과 상관 없이 고객별 구매횟수를 조회하시오. 구매 이력이 없으면 구매횟수는 0으로 조회하시오.
SELECT
        u.user_id as 고객아이디
      , u.user_name as 고객명
      , COUNT(b.buy_no) AS 구매횟수
  FROM users u LEFT OUTER JOIN buys b  -- users 테이블의 모든 내용을 조회
    ON u.user_id = b.user_id
 GROUP BY u.user_id, u.user_name;

SELECT
        u.user_id AS 고객아이디
      , u.user_name AS 고객명
      , COUNT(b.buy_no) AS 구매횟수
  FROM users u, buys b  -- users 테이블의 모든 내용을 조회
  WHERE u.user_id = b.user_id(+)  -- left join 완성 / (+)을 해주면 왼쪽 조인 완성. 
 GROUP BY u.user_id, u.user_name;



-- 13. 구매 이력에 상관 없이 고객별 총 구매액을 조회하시오. 구매 이력이 없으면 총 구매액은 0으로 조회하시오.
-- 구매액 : 제품가격 * 구매수량
SELECT
       u.user_id AS 고객아이디
     , nvl(SUM(b.prod_price * b.buy_amount), 0) AS 총구매액
  FROM users u LEFT OUTER JOIN buys b
    ON u.user_id = b.user_id
 GROUP BY u.user_id;


-- 14. 제품카테고리가 '전자'인 제품을 구매한 고객명과 총 구매액을 조회하시오.
SELECT
       u.user_name
     , SUM(b.prod_price * b.buy_amount) AS 총구매액
  FROM users u INNER JOIN buys b
    ON u.user_id = b.user_id
 WHERE b.prod_category = '전자'
 GROUP BY u.user_name, u.user_id;  -- 동일한 이름의 사용자를 구분해서 출력하기 위해서 u.user_id를 추가함
 

-- 15. 구매횟수가 2회 이상인 고객명과 구매횟수를 조회하시오.
SELECT
       u.user_name AS 고객명
     , COUNT(b.buy_no) AS 구매횟수
  FROM users u INNER JOIN buys b
    ON u.user_id = b.user_id
 GROUP BY u.user_name, u.user_id
HAVING COUNT(b.buy_no) >= 2;


-- 16. USERS 테이블과 BUYS 테이블 각각 종속 관계를 확인하고 필요하다면 정규화하시오.
-- 제품명 - 제품카테고리 - 제품가격은 종속 관계가 있다.

DROP TABLE product;

-- 1) buys 테이블의 proud_name, prod_category, prod_price 칼럼을 이용해서 product 테이블을 생성하시오.
CREATE TABLE product
    AS (SELECT DISTINCT prod_name
             , prod_category
             , prod_price
          FROM buys);

-- 2) product 테이블에 제품번호(prod_no) 칼럼을 추가한다. 
ALTER TABLE product ADD prod_no NUMBER;


-- 3) 시퀀스를 생성하고, 제품번호(prod_no)에 입력한다.
create sequence product_seq increment by 1 start with 1 nomaxvalue nocycle nocache;
-- 제품명 : 운동화, 모니터, 메모리, 책, 노트북, 청바지
update product set prod_no = product_seq.nextval where prod_name = '운동화';
update product set prod_no = product_seq.nextval where prod_name = '모니터';
update product set prod_no = product_seq.nextval where prod_name = '메모리';
update product set prod_no = product_seq.nextval where prod_name = '책';
update product set prod_no = product_seq.nextval where prod_name = '노트북';
update product set prod_no = product_seq.nextval where prod_name = '청바지';

-- 4) 제품번호(prod_no)를 기본키로 설정한다.
ALTER TABLE product ADD CONSTRAINT product_pk PRIMARY KEY(prod_no);

-- 5) buys 테이블에 제품번호(prod_no) 칼럼을 추가한다.
ALTER TABLE buys ADD prod_no NUMBER;

-- 6) buys 테이블에 제품번호(prod_no)를 입력한다.
UPDATE buys b SET b.prod_no = (select p.prod_no from product p where p.prod_name = '운동화') where b.prod_name = '운동화';
UPDATE buys b SET b.prod_no = (select p.prod_no from product p where p.prod_name = '모니터') where b.prod_name = '모니터';
UPDATE buys b SET b.prod_no = (select p.prod_no from product p where p.prod_name = '메모리') where b.prod_name = '메모리';
UPDATE buys b SET b.prod_no = (select p.prod_no from product p where p.prod_name = '책') where b.prod_name = '책';
UPDATE buys b SET b.prod_no = (select p.prod_no from product p where p.prod_name = '노트북') where b.prod_name = '노트북';
UPDATE buys b SET b.prod_no = (select p.prod_no from product p where p.prod_name = '청바지') where b.prod_name = '청바지';

-- 7) buys 테이블의 제품번호(proud_no)를 product 테이블의 제품번호(prod_no)를 참조하는 외래키로 설정한다.
ALTER TABLE buys ADD CONSTRAINT buys_product_fk FOREIGN KEY(prod_no) REFERENCES product(proud_no);


-- 8) buys 테이블에서 prod_name, prod_category, prod_price 칼럼을 삭제한다.
ALTER TABLE buys DROP COLUMN prod_name;
ALTER TABLE buys DROP COLUMN prod_category;
ALTER TABLE buys DROP COLUMN prod_price;


