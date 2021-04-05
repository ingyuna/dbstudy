-- 오라클 내장 함수

-- 1. 집계 함수

DROP TABLE score;
CREATE TABLE score
(
    kor NUMBER(3),
    eng NUMBER(3),
    mat NUMBER(3)
);

INSERT INTO score (kor, eng, mat) VALUES (10, 10, 10);
INSERT INTO score (kor, eng, mat) VALUES (20, 20, 20);
INSERT INTO score (kor, eng, mat) VALUES (30, 30, 30);
INSERT INTO score (kor, eng, mat) VALUES (90, 90, 90);
INSERT INTO score (kor, eng, mat) VALUES (100, 100, 100);

-- 1) 국어(kor) 점수의 합계를 구한다.
SELECT SUM(kor) FROM score;   -- 칼럼이 1개인 테이블로 보여진다.
SELECT SUM(kor) 합계 FROM score;  -- 칼럼의 이름이 '합계'이다.
SELECT SUM(kor) AS 국어점수합계 FROM score;  -- 칼럼이 이름이 '국어점수합계'이다.

-- 2) 모든 점수의 합계를 구한다.
SELECT SUM(kor, eng, mat) FROM score;  -- 칼럼을 1개만 지정할 수 있다. 
SELECT SUM(kor) + SUM(eng) + SUM(mat) AS 전체점수합계 FROM score;

-- 3) 국어(kor) 점수의 평균을 구한다.
SELECT AVG(kor) AS 국어점수평균 FROM score;

-- 4) 영어(eng) 점수의 최대값을 구한다.
SELECT MAX(eng) AS 영어점수최대값 FROM score;

-- 5) 수학(mat) 점수의 최소값을 구한다.
SELECT MIN(mat) AS 수학점수최소값 FROM score;

-- 'NAME' 칼럼을 추가하고, 적당한 이름을 삽입하시오.
ALTER TABLE score ADD NAME VARCHAR2(20);
UPDATE score SET NAME = 'JADU   ' WHERE kor = 10;
UPDATE score SET NAME = '   jjanggu' WHERE kor = 20;
UPDATE score SET NAME = 'WILK  ' WHERE kor = 30;
UPDATE score SET NAME = ' ddoongi' WHERE kor = 90;
UPDATE score SET NAME = '   CHOCO   ' WHERE kor = 100;

-- 국어점수 중 임의로 2개를 NULL로 수정하시오.
UPDATE score SET kor = NULL WHERE NAME = 'WILK';
UPDATE score SET kor = NULL WHERE NAME = 'CHOCO';

-- 6) 이름의 개수를 구하시오.
SELECT COUNT(name) FROM score;

-- 7) 국어점수의 개수를 구하시오.
SELECT COUNT(kor) FROM score;        -- NULL은 갯수에 포함되지 않기때문에 3이 나온다.

-- 8) 학생의 개수를 구하시오.
SELECT COUNT(*) FROM score;     -- *는 전체 칼럼을 의미한다. 어떤 칼럼이든 하나라도 데이터가 포함되어 있으면 개수를 구한다.


-- 2. 문자함수

-- 1) 대소문자 관련 함수
SELECT INITCAP(name) FROM score;  -- 첫 글자만 대문자, 나머지 소문자
SELECT UPPER(name) FROM score;    -- 모두 대문자
SELECT LOWER(name) FROM score;    -- 모두 소문자


-- 2) 문자열의 길이 반환 함수
SELECT LENGTH(name) FROM score;


-- 3) 문자열의 일부 반환 함수
select substr(name, 2, 3) from score;      -- (시작이 1입니다.) 2번째 글자부터 3글자를 반환한다.


-- 4) 문자열에서 특정 문자의 포함된 위치 반환 함수
SELECT instr(NAME, 'J') FROM score;   -- 대문자 J의 위치를 반환된다. 없으면 0을 반환한다.
SELECT instr(upper(name), 'J') from score;   -- 모든 제이(J, j)의 위치를 반환한다.


-- 5)  왼쪽 패딩
SELECT lpad(NAME, 10, '*') FROM score;

-- 6) 오른쪽 패딩
SELECT rpad(NAME, 10, '*') FROM score;

-- 모든 name을 오른쪽 맞춤해서 출력
SELECT lpad(NAME, 10, ' ') FROM score;


-- 모든 name을 다음과 같이 출력
-- JADU : JA**
-- jjanggu : jj*****
-- WILK : WI**
-- ddonggi : dd*****
-- CHOCO : CH***
select rpad(substr(NAME, 1, 2), length(name), '*') from score;

-- 7) 문자열 연결 함수
-- Oracle에서 연산자 || 는 OR이 아니라, 연결 연산자이다.

-- JADU 10 10 10
SELECT name || ' ' || kor || ' ' || eng || ' ' || mat FROM score;

SELECT CONCAT(name, ' ') FROM score;
SELECT CONCAT(CONCAT(Name, ' '), kor) FROM score;

-- 8) 불필요한 문자열 제거 함수 (좌우만 가능하고, 중간에 포함된 건 불가능)
-- 공백 제거 위주로 본다.

SELECT LTRIM(name) FROM score;   -- 왼쪽 공백을 제거
SELECT LENGTH(LTRIM(name)) FROM score;   -- 왼쪽 공백을 제거 후 글자수 세기 
SELECT RTRIM(name) FROM score;
SELECT LENGTH(RTRIM(name)) FROM score;
SELECT TRIM(name) FROM score;
SELECT LENGTH(TRIM(name)) FROM score;

-- 다음 데이터를 삽입한다.
-- 80, 80, 80, james bond
insert into score (kor, eng, mat, name) values (80, 80, 80, 'james bond');

-- 아래와 같이 출력한다.
-- first_name  last_name
-- james        bond
select 
    substr(name, 1, instr(name, ' ') - 1) AS first_name,    -- -1은 공백 바로 전까지 가져오라는 뜻. 
    substr(name, instr(name, ' ') + 1) AS last_name      -- +1은 공백 바로 다음부터.
 FROM
   score;
   
-- 3.숫자 함수

-- 테이블을 사용하지 않는 SELECT문에서는 DUAL 테이블을 사용합니다. 
DESC DUAL;
SELECT DUMMY FROM DUAL;

-- 1) 반올림 함수
-- ROUND(값, 자릿수)
SELECT ROUND(123.4567, 2) FROM DUAL;   -- 소수 자릿수 2자리로 반올림 123.46    
SELECT ROUND(123.4567, 1) FROM DUAL;   -- 소수 자릿수 2자리로 반올림 123.5   
SELECT ROUND(123.4567, 0) FROM DUAL;   -- 정수로 반올림 123
SELECT ROUND(123.4567) FROM DUAL;      -- 정수로 반올림 123
SELECT ROUND(123.4567, -1) FROM DUAL;   --십의 자리로 반올림 120   
SELECT ROUND(123.4567, -2) FROM DUAL;   -- 백의 자리로 반올림 100   

-- 2) 올림 함수
-- CEIL(값) : 정수로 올림
-- 자릿수 조정을 계산을 통해서 처리합니다.
SELECT CEIL(123.4567) FROM DUAL;  -- 124

-- (1) 소수 자릿수 2자리로 올림
-- 100을 곱한다. -> CEIL() 처리한다. -> 100으로 나눈다.
SELECT CEIL(123.4567 * 100) / 100 FROM DUAL;

-- (2) 소수 자릿수 1자리로 올림
-- 10을 곱한다. -> CEIL() 처리한다. -> 10으로 나눈다.
SELECT CEIL(123.4567 * 10) / 10 FROM DUAL;

-- (3) 십의 자리로 올림
-- 10의 -1제곱(0.1)을 곱한다. -> CEIL() 처리한다. -> 10의 -1제곱으로 나눈다.
SELECT CEIL(123.4567 * 0.1) / 0.1 FROM DUAL;

-- (4) 백의 자리로 올림
-- 10의 -2제곱(0.01)을 곱한다. -> CEIL() 처리한다. -> 10의 -2제곱으로 나눈다. 
SELECT CEIL(123.4567 * 0.01) / 0.01 FROM DUAL;


-- 3) 내림 함수
-- FLLOR(값) : 정수로 내림 
-- CEIL()와 같은 방식으로 사용합니다.
SELECT FLOOR(567.8989 * 100) / 100 FROM DUAL;
SELECT FLOOR(567.8989 * 10) / 10 FROM DUAL;
SELECT FLOOR(567.8989 * 1) / 1 FROM DUAL;
SELECT FLOOR(567.8989) FROM DUAL;
SELECT FLOOR(567.8989 * 0.1) / 0.1 FROM DUAL;
SELECT FLOOR(567.8989 * 0.01) / 0.01 FROM DUAL;


-- 4) 절사 함수 (잘라버리는 -> TRUNCATE)
-- TRUNC(값, 자릿수)
SELECT TRUNC(567.8989, 2) FROM DUAL;    -- 소수 자릿수 2자리로 절사 567.89
SELECT TRUNC(567.8989, 1) FROM DUAL;    -- 소수 자릿수 1자리로 절사 567.8
SELECT TRUNC(567.8989, 0) FROM DUAL;    -- 정수로 절사 567
SELECT TRUNC(567.8989) FROM DUAL;       -- 정수로 절사 567
SELECT TRUNC(567.8989, -1) FROM DUAL;    -- 십의 자리로 절사 560
SELECT TRUNC(567.8989, -2) FROM DUAL;    -- 십의 자리로 절사 500

-- 내림과 절사의 차이는 있다.
-- 음수에서 차이가 발생한다.
SELECT FLOOR(-1.5) FROM DUAL;   -- -1.5보다 작은 정수 : -2
SELECT TRUNC(-1.5) FROM DUAL;   -- -1.5의 .5를 절사 : -1

-- 5) 절대값
-- ABS(값)
SELECT ABS(-5) FROM DUAL;

-- 6) 부호 판별
-- SIGN(값)
-- 값이 양수이면 1
-- 값이 음수이면 -1
-- 값이 0이면 0
SELECT SIGN(5) FROM DUAL;
SELECT SIGN(-5) FROM DUAL;
SELECT SIGN(0) FROM DUAL;

-- 7) 나머지 
-- MOD(A, B) : A를 B로 나눈 나머지
SELECT MOD(7,2) FROM DUAL;

-- 8) 제곱
-- POWER(A, B) : A의 B제곱 
SELECT POWER(10, 2) FROM DUAL;   -- 100
SELECT POWER(10, 1) FROM DUAL;   -- 10
SELECT POWER(10, 0) FROM DUAL;   -- 1
SELECT POWER(10, -1) FROM DUAL;   -- 0.1
SELECT POWER(10, -2) FROM DUAL;   -- 0.01


-- 4. 날짜 함수
-- 1) 현재 날짜 (타입이 DATE)
-- SYSDATE
SELECT SYSDATE FROM DUAL;

-- 2) 현재 날짜 (타입이 TIMESTAMP)
-- SYSTIMESTAMP
SELECT SYSTIMESTAMP FROM DUAL;

-- 3) 년/월/일/시/분/초 추출 
-- EXTRACT(단위 FROM 날짜)
SELECT EXTRACT(YEAR FROM SYSDATE) AS 현재년도, 
        EXTRACT(MONTH FROM SYSDATE) AS 현재월,
        EXTRACT(DAY FROM SYSDATE) AS 현재일,
        EXTRACT(HOUR FROM SYSTIMESTAMP) AS 현재시간,
        EXTRACT(MINUTE FROM SYSTIMESTAMP) AS 현재분,
        EXTRACT(SECOND FROM SYSTIMESTAMP) AS 현재초
  FROM DUAL;

-- 4) 날짜 연산(이전, 이후)
-- 1일 : 숫자 1
-- 12시간 : 숫자 0.5
SELECT SYSDATE + 1 AS 내일, 
        SYSDATE - 1 AS 어제,
        SYSDATE + 0.5 AS 열두시간후,
        SYSTIMESTAMP + 0.5 AS 열두시간후
  FROM DUAL;

-- 5) 개월 연산
-- ADD_MONTHS(날짜, N) : N개월 후 
SELECT ADD_MONTHS(SYSDATE, 3) AS 삼개월후,
        ADD_MONTHS(SYSDATE, -3) AS 삼개월전
  FROM DUAL;
-- MONTHS_BETWEEN(날짜1, 날짜2) : 두 날짜 사이 경과한 개월수 (날짜1 - 날짜2)
-- MONTHS_BETWEEN(최근날짜, 이전날짜)
SELECT MONTHS_BETWEEN(SYSDATE, TO_DATE('2021-01-01')) FROM DUAL;


-- 5. 형 변환 함수 
-- 1) 날짜 변환 함수
-- TO_DATE(문자열, [형식])
-- 형식
-- YYYY, YY
-- MM, M
-- DD, D
-- HH, H
-- MI
-- SS
SELECT TO_DATE('2021-04-01'),
        TO_DATE('2021/04/01'),
        TO_DATE('2021/01/04', 'YYYY/DD/MM'),
        TO_DATE('20210401', 'YYYYMMDD'),
        TO_DATE('0401, 21', 'MMDD, YY')
  FROM DUAL;
   
-- 2) 숫자 변환 함수
-- TO NUMBER(문자열)
SELECT TO_NUMBER('100') FROM DUAL;

SELECT name, kor
  FROM score
 WHERE kor >= '50';   -- 내부적으로 WHERE kor >= TO_NUMBER('50') 처리됩니다.
   
-- 3) 문자열 변환 함수
-- TO_CHAR(값, [형식]) 
SELECT TO_CHAR(123),  -- 문자열 '123'
        TO_CHAR(123, '999999'),  -- 문자열 '    123'   -> 숫자자리를 공백처리
        TO_CHAR(123, '000000'),  -- 문자열 '000123'   -> 숫자자리를 0으로 처리
        TO_CHAR(1234, '9,999'),   -- 문자열 '1,234'
        TO_CHAR(12345, '9,999'),  -- ###### (형식이 숫자보다 작은 경우)
        TO_CHAR(12345, '99,999'),  -- 문자열 '12,345'
        TO_CHAR(3.14, '9.999'), -- 문자열 '3.140'
        TO_CHAR(3.14, '9.99'),  -- 문자열 '3.14'
        TO_CHAR(3.14, '9.9'),  -- 문자열 '3.1'
        TO_CHAR(3.14, '9'),  -- 문자열 '3'
        TO_CHAR(3.5, '9')  -- 문자열 '4' (반올림)
  FROM DUAL;
   
-- (2) 날짜 형식
SELECT TO_CHAR(SYSDATE, 'YYYY.MM.DD'), 
        TO_CHAR(SYSDATE, 'YEAR MONTH DAY'),
        TO_CHAR(SYSDATE, 'HH:MI:SS')
  FROM DUAL;   
  
-- 6. 기타 함수
-- 1) NULL 처리 함수
SELECT * FROM SCORE;
UPDATE score SET kor = NULL WHERE TRIM(name) = 'JADU';  -- JADU 점수 : null 10 10
UPDATE score SET eng = 30 WHERE TRIM(name) = 'WILK';  -- WIL 점수 : 30 null 30 

-- 1) NULL 처리 함수
-- NVL(값, 값이 NULL일때 사용할 값)
SELECT kor,
        NVL(kor, 0) 
  FROM score;  -- NVL(kor, 0) : NULL 대신 0을 사용 

-- 집계함수(SUM, AVG, MAX, MIN, COUNT 등)들은 NULL 값을 무시합니다.
SELECT AVG(kor) AS 평균1,
        AVG(NVL(kor,0)) AS 평균2
  FROM score;
  
SELECT NVL(kor, 0) + eng + mat AS 총점 FROM score;

-- 2) NVL2(값, 값이 NULL이 아닐때, 값이 NULL일때)
SELECT NVL2(kor, kor + eng + mat, eng + mat) AS 총점 FROM score;

-- 2) 분기 함수
-- DECODE(표현식, 조건1, 결과1, 조건2, 결과2, ..., 기본값)
SELECT DECODE('봄',  -- 표현식(칼럼을 이용한 식)
              '봄', '꽃놀이',  -- 표현식이 '봄'이면 '꽃놀이'가 결과이다.
              '여름', '물놀이',
              '가을', '단풍놀이',
              '겨울', '눈싸움') AS 계절별놀이
  FROM DUAL;
   
-- 3) 분기 표현식
-- CASE 표현식
--  WHEN 비교식 THEN 결과값
--  ...
--  ELSE 나머지경우
-- END

-- CASE
--   WHEN 조건식 THEN 결과값
--   ...
--   ELSE 나머지경우
-- END

-- CASE 계절
--   WHEN '봄' THEN '꽃놀이'

-- CASE 평균
--  WHEN >= 90 THEN 'A학점'

SELECT name,
       (NVL(kor, 0) + eng + mat) / 3 AS 평균,
       (CASE 
          WHEN (NVL(kor, 0) + eng + mat) / 3 >= 90 THEN 'A학점'
          WHEN (NVL(kor, 0) + eng + mat) / 3 >= 80 THEN 'B학점'
          WHEN (NVL(kor, 0) + eng + mat) / 3 >= 70 THEN 'C학점'
          WHEN (NVL(kor, 0) + eng + mat) / 3 >= 60 THEN 'D학점'
          ELSE 'F학점'
        END) AS 학점
  FROM score;
   
   
   
   
   
   
   



