SET SERVEROUTPUT ON;


-- 스토어드 프로시저 (일련의 SQL 처리 과정을 집합처럼 묶어서 사용하는 구조)


--선언
CREATE OR REPLACE PROCEDURE NEW_JOB_POC -- 프로시저명
IS
BEGIN
        DBMS_OUTPUT.PUT_LINE('HELLO WORLD');
END;

--호출
EXEC NEW_JOB_POC;

--------------------------------------------------------------------------------------

-- 프로시저의 매개변수 IN
CREATE OR REPLACE PROCEDURE NEW_JOB_PROC -- 이름이 같으면 자동으로 수정됨 (REPLACE가 있어서)
        (P_JOB_ID IN VARCHAR2, -- 매개변수명과 타입 (크기 X)
         P_JOB_TITLE IN VARCHAR2,
         P_MIN_SALARY IN JOBS.MIN_SALARY%TYPE := 0, -- JOBS 테이블의 MIN_SALARY과 동일한 타입
         P_MAX_SALARY IN JOBS.MAX_SALARY%TYPE := 10000 -- DEFAULT 매개변수 (값이 존재함)
        )
IS
BEGIN
        INSERT INTO JOBS_IT VALUES(P_JOB_ID, P_JOB_TITLE, P_MIN_SALARY,P_MAX_SALARY);
        COMMIT;
END;


EXEC NEW_JOB_PROC('EXAMPLE', 'EXAMPLE', 1000, 10000);
EXEC NEW_JOB_PROC('EXAMPLE', 1000); -- 매개변수가 일치하지 않으면 에러 발생 
EXEC NEW_JOB_PROC('SAMPLE1', 'SAMPLE2'); -- DEFAULT 매개변수가 있다면 기본값으로 전달됨


SELECT * FROM JOBS_IT;

--------------------------------------------------------------------------------------

--PLSQL의 모든 구문(제어문, 탈출문, 커서 구문)을 프로시저에 쓸 수 있음
--JOB_ID가 존재하면 UPDATE, 없으면 INSERT

CREATE OR REPLACE PROCEDURE NEW_JOB_PROC
        ( A IN VARCHAR2, -- JOB_ID
          B  IN VARCHAR2,
          C  IN NUMBER,
          D  IN NUMBER
        )
IS
    CNT NUMBER; -- 지역변수를 만들 수도 있음
BEGIN
    SELECT COUNT(*)
    INTO CNT -- CNT에 값( 여기서는 COUNT(*) )을 저장함
    FROM JOBS_IT
    WHERE JOB_ID = A;

    IF CNT = 0 THEN -- 0개라면
        INSERT INTO JOBS_IT VALUES (A,B,C,D); 
    ELSE
        UPDATE JOBS_IT
        SET JOB_ID = A,
               JOB_TITLE = B,
               MIN_SALARY = C,
               MAX_SALARY = D
        WHERE JOB_ID = A;
    END IF;
    
    COMMIT; -- DML구문이라

END;


EXEC NEW_JOB_PROC('AD', 'ADMIN', 1000, 10000);
EXEC NEW_JOB_PROC('AD_VP', 'ADMIN2', 1000, 20000);

SELECT * FROM JOBS_IT;

--------------------------------------------------------------------------------------

-- OUT 매개변수 :  외부로 값을 돌려주기 위한 매개변수

CREATE OR REPLACE PROCEDURE NEW_JOB_PROC
        ( A IN VARCHAR2, 
          B  IN VARCHAR2,
          C  IN NUMBER,
          D  IN NUMBER,
          E OUT NUMBER -- 외부로 전달할 매개변수 E
        )
IS
    CNT NUMBER; -- 지역변수
BEGIN
    SELECT COUNT(*)
    INTO CNT
    FROM JOBS_IT
    WHERE JOB_ID = A;

    IF CNT = 0 THEN
        INSERT INTO JOBS_IT VALUES (A,B,C,D); 
    ELSE
        UPDATE JOBS_IT
        SET JOB_ID = A,
               JOB_TITLE = B,
               MIN_SALARY = C,
               MAX_SALARY = D
        WHERE JOB_ID = A;
    END IF;
    
-- OUT 매개변수에 값을 할당시킴
    E := CNT;
    
    COMMIT; 

END;

DECLARE
        CNT NUMBER;
BEGIN
        NEW_JOB_PROC('AD_VP', 'ADMIN', 1000, 10000, CNT); -- 익명블록 안에서는 EXEC 제외
        DBMS_OUTPUT.PUT_LINE('프로시저 내부에서 할당받은 값 : ' || CNT);
END;

--------------------------------------------------------------------------------------

--RETURN문 : 프로시저를 종료함
-- EXCEPTION WHEN OTHERS THEN : 예외 발생하면 실행됨
CREATE OR REPLACE PROCEDURE NEW_JOB_PROC2
        (P_JOB_ID IN JOBS.JOB_ID%TYPE
        )
IS
        CNT NUMBER;
        SALARY NUMBER;
BEGIN
        SELECT COUNT(*)
        INTO CNT
        FROM JOBS
        WHERE JOB_ID = P_JOB_ID;
        
        IF  CNT = 0 THEN
            DBMS_OUTPUT.PUT_LINE('값이 없다');
            RETURN; -- 프로시저 종료
        ELSE
            SELECT MAX_SALARY
            INTO SALARY
            FROM JOBS
            WHERE JOB_ID = P_JOB_ID;
            
            DBMS_OUTPUT.PUT_LINE('최대급여 : ' || SALARY);
            
        END IF;
        
            DBMS_OUTPUT.PUT_LINE('프로시저 정상 종료');
            
            -- 예외 처리 구문 (예외를 만나면 예외문장이 실행됨)
            EXCEPTION WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('예외가 발생했습니다');
            
END;

--

EXEC NEW_JOB_PROC2('AD'); -- RETURN문을 만나서 프로시저 종료
EXEC NEW_JOB_PROC2('AD_VP'); 


--------------------------------------------------------------------------------------

--1. 프로시저명 DEPTS_PROC
--- 부서번호, 부서명, 작업 flag(I: insert, U:update, D:delete)을 매개변수로 받아 
--DEPTS테이블에 각각 flag가 i면 INSERT, u면 UPDATE, d면 DELETE 하는 프로시저를 생성합니다.
--- 그리고 정상종료라면 commit, 예외라면 롤백 처리하도록 처리하세요.
--- 예외처리도 작성해주세요.
DROP TABLE DEPTS;

CREATE TABLE DEPTS AS (SELECT * FROM DEPARTMENTS WHERE 1=2);
DESC DEPTS;




CREATE OR REPLACE PROCEDURE DEPTS_PROC
        (P_DEPT_ID DEPARTMENTS.DEPARTMENT_ID%TYPE,
        P_DEPT_NAME DEPARTMENTS.DEPARTMENT_NAME%TYPE,
        P_IUD IN VARCHAR2
        )
IS
BEGIN

        IF P_IUD = 'I' THEN 
                INSERT INTO DEPTS (DEPARTMENT_ID, DEPARTMENT_NAME) VALUES(P_DEPT_ID, P_DEPT_NAME);
        ELSIF P_IUD = 'U' THEN
                UPDATE DEPTS
                SET DEPARTMENT_NAME = P_DEPT_NAME
                WHERE DEPARTMENT_ID = P_DEPT_ID;
                
        ELSIF P_IUD = 'D' THEN
                DELETE FROM DEPTS WHERE DEPARTMENT_ID = P_DEPT_ID;
        END IF;

        COMMIT;
        
        EXCEPTION WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('예외 처리 발생');

        ROLLBACK;

        
END;


 
SELECT * FROM DEPTS;

--2. 프로시저명 - SALES_PROC
--- sales테이블은 오늘의 판매내역이다.
--- day_of_sales테이블은 판매내역 마감시 오늘 일자의 총매출을 기록하는 테이블이다.
--- 마감시 sales의 오늘날짜 판매내역을 집계하여 day_of_sales에 집계하는 프로시저를 생성해보세요.
--조건) day_of_sales의 마감내역이 이미 존재하면 업데이트 처리



CREATE TABLE SALES(
    SNO NUMBER(5) CONSTRAINT SALES_PK PRIMARY KEY, -- 번호
    NAME VARCHAR2(30), -- 상품명
    TOTAL NUMBER(10), --수량
    PRICE NUMBER(10), --가격
    REGDATE DATE DEFAULT SYSDATE --날짜
);

CREATE TABLE DAY_OF_SALES(
    REGDATE DATE,
    FINAL_TOTAL NUMBER(10)
);


INSERT INTO SALES(SNO, NAME, TOTAL, PRICE) VALUES (1, '아메리카노', 3, 1000);
INSERT INTO SALES(SNO, NAME, TOTAL, PRICE) VALUES (2, '바닐라라떼', 2, 2000);
INSERT INTO SALES(SNO, NAME, TOTAL, PRICE) VALUES (3, '비엔나커피', 1, 3000);

--

SELECT * FROM SALES WHERE TO_CHAR(REGDATE, 'YYYYMMDD') = TO_CHAR(SYSDATE, 'YYYYMMDD');

--

CREATE OR REPLACE PROCEDURE SALES_PROC
IS
        FLAG NUMBER; -- 오늘 날짜 데이터가 있는지의 여부
        CNT NUMBER;
BEGIN

        -- 1. 오늘 날짜의 금액 SUM 구하기
        SELECT SUM(TOTAL * PRICE)
        INTO CNT
        FROM SALES WHERE TO_CHAR(REGDATE, 'YYYYMMDD') = TO_CHAR(SYSDATE, 'YYYYMMDD');
        
        -- 2. 마감 테이블의 오늘 날짜 마감 데이터가 있는지 확인하기
        SELECT COUNT(*)
        INTO FLAG
        FROM DAY_OF_SALES
        WHERE TO_CHAR(REGDATE, 'YYYYMMDD') = TO_CHAR(SYSDATE, 'YYYYMMDD');
        
        
        IF FLAG <> 0 THEN -- 데이터가 이미 있는 경우
            UPDATE DAY_OF_SALES
            SET FINAL_TOTAL = CNT -- 금액 합계
            WHERE TO_CHAR(REGDATE, 'YYYYMMDD') = TO_CHAR(SYSDATE, 'YYYYMMDD');
            
        ELSE -- 데이터가 없는 경우
            INSERT INTO DAY_OF_SALES VALUES ( SYSDATE, CNT);
            
        END IF;
        
        COMMIT;
        
END;


EXEC SALES_PROC;

SELECT * FROM DAY_OF_SALES;
