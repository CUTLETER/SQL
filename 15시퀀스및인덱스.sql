-- 시퀀스 (순차적으로 증가하는 값)
-- 주로 PK에 적용될 수 있음
-- 데이터베이스마다 시퀀스의 유무 차이 있음 (없으면 몹시 불편함)

SELECT * FROM USER_SEQUENCES;

-- 시퀀스 생성 (암기할 것)
CREATE SEQUENCE DEPTS_SEQ
        INCREMENT BY 1 -- 몇 씩 증가시킬 건지
        START WITH 1-- 시작값 설정
        MAXVALUE 10
        NOCACHE -- 캐시에 시퀀스를 두지 않음
        NOCYCLE; -- 최대값에 도달했을 때 또 다시 사용X

-- 시퀀스 적용
DROP TABLE DEPTS;
CREATE TABLE DEPTS (
        DEPT_NO NUMBER(2) PRIMARY KEY,
        DEPT_NAME VARCHAR(30)
);

-- 시퀀스 사용 (2가지)
SELECT DEPTS_SEQ.CURRVAL FROM DUAL; -- 현재 시퀀스 (대신 NEXTVAL가 먼저 실행되어야 함)
SELECT DEPTS_SEQ.NEXTVAL FROM DUAL; -- 현재 시퀀스를 증가 값만큼 증가 시킴

-- 시퀀스 적용
INSERT INTO DEPTS VALUES (DEPTS_SEQ.NEXTVAL/*PK값*/, 'EXAMPLE'); -- 10 까지 가능함
SELECT * FROM DEPTS;

-- 시퀀스 수정
ALTER SEQUENCE DEPTS_SEQ MAXVALUE 1000;
ALTER SEQUENCE DEPTS_SEQ INCREMENT BY 10;


-- 시퀀스가 이미 사용되고 있다면 DROP 안됨 XXXX
-- 만약 시퀀스를 초기화 해야 한다면?
-- 시퀀스의 증가값을 음수로 만들어서 초기화인 것처럼 쓸 수는 있음
SELECT DEPTS_SEQ.CURRVAL FROM DUAL;

-- 1. 시퀀스의 증가를 (현재 값 -1)로 바꿈
ALTER SEQUENCE DEPTS_SEQ INCREMENT BY -39;
-- 2. 현재 시퀀스를 전진 시켜서 감소 시킴
SELECT DEPTS_SEQ.NEXTVAL FROM DUAL;
-- 3. 현재 시퀀스가 원하는 값으로 도달하면 증가 값을 다시 돌려 놓음
ALTER SEQUENCE DEPTS_SEQ INCREMENT BY 1;

--------------------------------------------------------------------------------------

-- 시퀀스 응용 (나중에 테이블을 설계할 때, 데이터가 엄청 많다면 시퀀스의 사용을 고려해야 됨)
-- 문자열 PK (년도 값 - 일련 번호)
-- 예) 년도가 바뀌면 시퀀스가 초기화 되는 방식 
CREATE TABLE DEPTS2 (
        DEPT_NO VARCHAR2(20) PRIMARY KEY,
        DEPT_NAME VARCHAR2(20)
);

INSERT INTO DEPTS2 VALUES (TO_CHAR(SYSDATE, 'YYYY-MM-') || LPAD(DEPTS_SEQ.NEXTVAL, 5, 0), 'EXAMPLE');

SELECT * FROM DEPTS2;

-- 시퀀스 삭제
DROP SEQUENCE 시퀀스명;


--------------------------------------------------------------------------------------

-- INDEX
-- INDEX는 PK, UNIQUE에 자동으로 생성되고 조회를 빠르게 도와주는 HINT 역할
-- INDEX 종류는 고유 인덱스와 비고유 인덱스가 있음
-- UNIQUE한 컬럼에는 (UNIQUE INDEX)고유 인덱스가 쓰임
-- 일반 컬럼에는 비고유 인덱스가 쓰임
-- INDEX는 조회를 빠르게 도와주지만, DML구문(삽입,수정,삭제)이 많이 사용되는 컬럼은 오히려 성능 저하 유발함

CREATE TABLE EMPS_IT AS (SELECT * FROM EMPLOYEES);

-- 인덱스가 없을 때 조회 -> FULL : 다 뒤져서 찾아냄 (확인은 F10)
SELECT * FROM EMPS_IT WHERE FIRST_NAME = 'Nancy';

-- 비고유 인덱스 생성 (부착)
CREATE INDEX EMPS_IT_IX ON EMPS_IT (FIRST_NAME);

-- 비고유 인덱스 생성 후 조회 -> INDEX 기준으로 찾아냄, BY INDEX ROWID
SELECT * FROM EMPS_IT WHERE FIRST_NAME = 'Nancy';

-- 인덱스 삭제 (인덱스는 삭제하더라도 테이블에 영향을 미치지 않음)
DROP INDEX EMPS_IT_IX;

-- 결합 인덱스 (여러 개 컬럼을 동시에 인덱스로 지정함)
CREATE INDEX EMPS_IT_IX ON EMPS_IT (FIRST_NAME, LAST_NAME);

SELECT * FROM EMPLOYEES WHERE FIRST_NAME = 'Nancy'; -- BY INDEX ROWID
SELECT * FROM EMPLOYEES WHERE FIRST_NAME = 'Nancy' AND LAST_NAME = 'Greenberg';  -- BY INDEX ROWID
SELECT * FROM EMPLOYEES WHERE LAST_NAME = 'Greenberg'; -- BY INDEX ROWID


-- 고유 인덱스 (PK, UK 에서는 자동 생성됨)
CREATE UNIQUE INDEX /*인덱스명*/ ;

