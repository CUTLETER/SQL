-- PLSQL 제어문

-- IF문 틀
-- IF 조건절 THEN
--ELSIF 조건절 (ELSEIF XXX) THEN
-- ELSE
-- END IF;

SET SERVEROUTPUT ON;


DECLARE
        POINT NUMBER := TRUNC(DBMS_RANDOM.VALUE(1,101));
BEGIN
        DBMS_OUTPUT.PUT_LINE('점수 : ' || POINT);

--        IF POINT >= 90 THEN
--            DBMS_OUTPUT.PUT_LINE('A 학점');
--        ELSIF POINT >=80 THEN
--            DBMS_OUTPUT.PUT_LINE('B 학점');
--        ELSIF POINT >=70 THEN
--            DBMS_OUTPUT.PUT_LINE('C 학점');
--        ELSE
--            DBMS_OUTPUT.PUT_LINE('F 학점');
--        END IF;

        CASE WHEN POINT >= 90 THEN DBMS_OUTPUT.PUT_LINE('A 학점');
                 WHEN POINT >= 80 THEN DBMS_OUTPUT.PUT_LINE('B 학점');
                 WHEN POINT >= 70 THEN DBMS_OUTPUT.PUT_LINE('C 학점');
                 ELSE DBMS_OUTPUT.PUT_LINE('F 학점');
        END CASE;         

END;


--------------------------------------------------------------------------------------

-- WHILE문

DECLARE
        CNT NUMBER := 1;
BEGIN
        WHILE CNT <=9
        LOOP
            DBMS_OUTPUT.PUT_LINE(' 3 X '|| CNT || ' = ' ||CNT * 3);
            
            CNT := CNT + 1;
        END LOOP;
    
END;

--------------------------------------------------------------------------------------
-- FOR문

DECLARE
BEGIN
        FOR I IN 1..9 --  변수 I는 1부터 9까지
        LOOP
--       CONTINUE WHEN I = 5; -- I 가 5 면 다음으로 (5일 때 출력 생략)
            DBMS_OUTPUT.PUT_LINE(' 3 X '|| I || ' = ' || I * 3);
--       EXIT WHEN I = 5; -- I 가 5 면 반복문 탈출함
        END LOOP;

END;

--------------------------------------------------------------------------------------

-- 2단부터 9단까지 출력하는 익명 블록

DECLARE
        CNT NUMBER := 1;
BEGIN
        WHILE CNT <=9
        LOOP
            FOR I IN 2..9
            LOOP
                DBMS_OUTPUT.PUT_LINE( I ||' X '|| CNT || '=' || I * CNT);
            END LOOP;
            CNT := CNT + 1;
        END LOOP;   
END;

--------------------------------------------------------------------------------------

-- CURSOR 커서

DECLARE
        NAME VARCHAR2(30);
BEGIN
        -- SELECT한 결과가 여러 행이라서 에러 발생 : 이럴 때 쓰는 게 커서!
        SELECT FIRST_NAME 
        FROM EMPLOYEES 
        WHERE JOB_ID = 'IT_PROG';
        
        DBMS_OUTPUT.PUT_LINE(NAME);
END;

-----

DECLARE
        NM VARCHAR2(30); -- 일반 변수
        SALARY NUMBER;
        CURSOR X IS SELECT FIRST_NAME, SALARY FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG';
BEGIN
        OPEN X; -- 커서 열기
            DBMS_OUTPUT.PUT_LINE('---------커서 OPEN--------');
        LOOP
            FETCH X INTO NM, SALARY; -- NM 변수와 SALARY 변수 저장
            EXIT WHEN X%NOTFOUND; -- X 커서에 더 이상 읽을 데이터가 없으면 TRUE
           
            DBMS_OUTPUT.PUT_LINE(NM);
            DBMS_OUTPUT.PUT_LINE(SALARY);
            
        END LOOP;
        
        DBMS_OUTPUT.PUT_LINE('----------커서 CLOSE---------');
        DBMS_OUTPUT.PUT_LINE('데이터 수 : ' || X%ROWCOUNT); -- 커서에서 읽어온 데이터의 수
        
        CLOSE X; -- 커서 닫기
    
END;
--------------------------------------------------------------------------------------
-- 연습 문제
--1. 부서벌 급여합을 출력하는 커서구문을 작성해봅시다.
DECLARE
        IDD NUMBER;
        SUMM NUMBER;
        CURSOR XX IS SELECT DEPARTMENT_ID, SUM(SALARY) FROM EMPLOYEES GROUP BY DEPARTMENT_ID ORDER BY DEPARTMENT_ID DESC;
BEGIN
        OPEN XX;
        
        LOOP
            FETCH XX INTO IDD, SUMM;
            EXIT WHEN XX%NOTFOUND;
            
            DBMS_OUTPUT.PUT_LINE('부서 ID : '||IDD);
            DBMS_OUTPUT.PUT_LINE(' 총급여 : '||SUMM);
            
        END LOOP;
        
        CLOSE XX;
END;

--2. 사원테이블의 연도별 급여합을 구하여 EMP_SAL에 순차적으로 INSERT하는 커서구문을 작성해봅시다.
SELECT * FROM EMP_SAL;

DECLARE
        YYEAR NUMBER;
        SSUM NUMBER;
        CURSOR XXX IS SELECT A, SUM(SALARY) AS B FROM (SELECT TO_CHAR(HIRE_DATE, 'YYYY') AS A, SALARY FROM EMPLOYEES) GROUP BY A ORDER BY A;
BEGIN

--        OPEN XXX;
--        
--        LOOP
--            FETCH XXX INTO YYEAR, SSUM;
--            EXIT WHEN XXX%NOTFOUND;
--            
--            DBMS_OUTPUT.PUT_LINE('입사년도 : ' || YYEAR);
--            DBMS_OUTPUT.PUT_LINE('총급여 : ' || SSUM);
--            
--            INSERT INTO EMP_SAL (YEARS, SALARY)
--            VALUES (YYEAR, SSUM);
--        
--        END LOOP;
--        
--        CLOSE XXX;

        FOR  I IN XXX -- 커서를 FOR IN구문에 넣으면 위에 쓰여진 OPEN, CLOSE 생략 가능해짐
        LOOP
--                 DBMS_OUTPUT.PUT_LINE(I.A || ' '  || I.B); -- 출력
                 INSERT INTO EMP_SAL VALUES (I.A, I.B);
                 
        END LOOP;

END;















