-- PLSQL (프로그램 SQL)
-- 실행시킬 범위를 드래그로 선택한 다음 F5로 컴파일 시켜서 실행시킴 (CTRL+ ENTER XXX)
-- 실행할 땐 항상 영역 잡아둘 것

-- 출력 구문을 위한 실행문
SET SERVEROUTPUT ON;

-- 익명 블록
DECLARE -- 변수의 선언
        V_NUM NUMBER; 
        V_NAME VARCHAR2(10) := '홍길동'; -- 선언과 초기화를 동시에 해도 됨
BEGIN -- 변수의 값을 지정
              V_NUM := 10;
--         V_NAME := '홍길동';

        DBMS_OUTPUT.PUT_LINE(V_NAME || '님의 나이는 ' || V_NUM || '입니다.');

END;



--DML구문과 함께 사용할 수 있음
--SELECT -> INSERT -> INSERT

DECLARE
        NAME VARCHAR2(30);
        SALARY NUMBER;
        LAST_NAME EMPLOYEES.LAST_NAME%TYPE; --EMPLOYEES 테이블의 LAST_NAME 컬럼과 동일한 타입으로 선언하겠단 의미
BEGIN
        SELECT FIRST_NAME, LAST_NAME, SALARY
        INTO NAME, LAST_NAME, SALARY -- 위에 선언된 변수에 차례대로 대입됨
        FROM EMPLOYEES
        WHERE EMPLOYEE_ID = 100;

        DBMS_OUTPUT.PUT_LINE(NAME);
        DBMS_OUTPUT.PUT_LINE(SALARY);
        DBMS_OUTPUT.PUT_LINE(LAST_NAME);

END;

--------------------------------------------------------------------------------------
-- 2008년 입사한 사원의 급여 평균을 구해서 새로운 테이블에 INSERT
SELECT AVG(SALARY)
FROM EMPLOYEES WHERE TO_CHAR(HIRE_DATE, 'YYYY') = 2008;


CREATE TABLE EMP_SAL(
        YEARS VARCHAR2(50),
        SALARY NUMBER(10)
);


DECLARE
        YEARS VARCHAR2(50) := 2008;
        SALARY NUMBER(10);
BEGIN
        SELECT AVG(SALARY)
        INTO SALARY -- 변수 SALARY에 대입
        FROM EMPLOYEES WHERE TO_CHAR(HIRE_DATE, 'YYYY') = YEARS;
        
        INSERT INTO EMP_SAL VALUES (YEARS, SALARY);
        COMMIT;
END;

SELECT * FROM EMP_SAL; -- 확인

--------------------------------------------------------------------------------------


--1. 사원 테이블에서 201번 사원의 이름과 이메일주소를 출력하는 익명 블록을 만들어 봅시다. EMPS_IT 테이블
DECLARE
        NAME VARCHAR2(10);
        EMAIL VARCHAR2(50);
BEGIN
        SELECT FIRST_NAME, EMAIL
        INTO NAME, EMAIL
        FROM EMPLOYEES
        WHERE EMPLOYEE_ID = 201;
        
        DBMS_OUTPUT.PUT_LINE('사원의 이름 : '||NAME);
        DBMS_OUTPUT.PUT_LINE('EMAIL : '||EMAIL);
END;

SELECT * FROM EMPLOYEES;


--2. 사원 테이블에서 사원번호가 제일 큰 사원을 찾아낸 뒤, 
--	 이 번호 +1번으로 아래의 사원을 emps테이블에 employee_id, last_name, email, hire_date, job_id를  신규 입력하는 익명 블록을 만들어 봅시다. EMPS_IT 테이블
--<사원명>   : steven
--<이메일>   : stevenjobs
--<입사일자> : 오늘날짜
--<JOB_ID> : CEO
DECLARE
        NUM NUMBER;
BEGIN
        SELECT MAX(EMPLOYEE_ID) + 1
        INTO NUM -- NUM에 대입
        FROM EMPLOYEES;

        INSERT INTO EMPS_IT (EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
        VALUES (NUM, 'STEVEN', 'STEVEN JOBS', SYSDATE, 'CEO');
        
        COMMIT;
END;

SELECT * FROM EMPS_IT;




