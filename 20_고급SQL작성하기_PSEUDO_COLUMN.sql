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