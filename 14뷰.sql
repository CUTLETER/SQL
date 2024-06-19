-- 뷰
-- 뷰는 제한적인 데이터를 쉽게 보기 위해서 미리 만들어 놓은 가상 테이블
-- 자주 사용되는 컬럼을 저장하면 관리가 쉬움
-- 뷰는 물리적으로 데이터가 저장된 것은 아니고 원본 테이블을 기반으로 한 가상 테이블이라고 생각하면 됨
-- 뷰를 만드려면 권한이 필요함

SELECT * FROM EMP_DETAILS_VIEW; -- 미리 만들어져 있는 뷰

SELECT * FROM USER_SYS_PRIVS; -- 뷰 생성할 권한 확인 CREATE VIEW

--단순 뷰 (하나의 테이블로 생성된 뷰)
CREATE OR REPLACE VIEW VIEW_EMP
AS (
        SELECT EMPLOYEE_ID AS EMP_ID,
                     FIRST_NAME || ' ' || LAST_NAME AS NAME,
                     JOB_ID,
                     SALARY
        FROM EMPLOYEES
        WHERE DEPARTMENT_ID = 60
);

SELECT * FROM VIEW_EMP; -- 가상 테이블 생성

-- 복합 뷰 (2개 이상의 테이블로 생성된 뷰)
 -- 기본 틀 만들어 놓기 
CREATE OR REPLACE VIEW VIEW_EMP_JOB
AS (

);

-- 들어갈 내용 적기
SELECT E.EMPLOYEE_ID,
             E.FIRST_NAME ||' ' || E.LAST_NAME AS NAME,
             J.JOB_TITLE,
             D.DEPARTMENT_NAME
FROM EMPLOYEES E
JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
LEFT JOIN JOBS J
ON E.JOB_ID = J.JOB_ID;

--합치기
CREATE OR REPLACE VIEW VIEW_EMP_JOB
AS (
        SELECT E.EMPLOYEE_ID,
             E.FIRST_NAME ||' ' || E.LAST_NAME AS NAME,
             J.JOB_TITLE,
             D.DEPARTMENT_NAME
        FROM EMPLOYEES E
        JOIN DEPARTMENTS D
        ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
        LEFT JOIN JOBS J
        ON E.JOB_ID = J.JOB_ID
);

-- 뷰를 이용하면 데이터를 손쉽게 조회할 수 있음
SELECT JOB_TITLE, COUNT(*) AS 사원수
FROM VIEW_EMP_JOB
GROUP BY JOB_TITLE;



-- 뷰의 수정 (OR REPLACE)
CREATE OR REPLACE VIEW VIEW_EMP_JOB
AS (
        SELECT E.EMPLOYEE_ID,
             FIRST_NAME ||' ' || LAST_NAME AS NAME,
             J.JOB_TITLE,
             J.MAX_SALARY, -- 수정
             J.MIN_SALARY,
             D.DEPARTMENT_NAME
        FROM EMPLOYEES E
        JOIN DEPARTMENTS D
        ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
        LEFT JOIN JOBS J
        ON E.JOB_ID = J.JOB_ID
);

-- 뷰의 삭제 DROP VIEW 
DROP VIEW VIEW_EMP_JOB;


-- 단순뷰는 뷰를 통해서 INSERT, UPDATE가 가능한데 제약 사항이 있음
SELECT * FROM VIEW_EMP;

--NAME, EMP_ID가 가상열이기 때문에 INSERT가 들어가지 못함
INSERT INTO VIEW_EMP VALUES (108, 'HONG', 'IT_PROG', 10000);

-- 원본 테이블의 NOT NULL 제약 조건에 위배되기 때문에 INSERT가 들어가지 못함
INSERT INTO VIEW_EMP(JOB_ID, SALARY) VALUES('IT_PROG', 10000);



--뷰의 옵션
-- WITH CHECK OPTION (WHERE절에 있는 컬럼의 변경을 금지함)
--WITH READ ONLY (SELECT만 허용함)
CREATE OR REPLACE VIEW VIEW_EMP
AS (
        SELECT EMPLOYEE_ID,
                     FIRST_NAME,
                     EMAIL,
                     JOB_ID,
                     DEPARTMENT_ID
        FROM EMPLOYEES
        WHERE DEPARTMENT_ID IN (60,70,80)
) /*WITH CHECK OPTION 특정 컬럼 값을 바꾸지 못하게 함*/ /*WITH READ ONLY 읽기 전용*/;
UPDATE VIEW_EMP SET DEPARTMENT_ID = 10 WHERE EMPLOYEE_ID = 103; -- CHECK 옵션 때문에 업데이트 불가
--------------------------------------------------------------------------------------

-- 얼마 전에 배운 인라인 뷰가 뷰였음
SELECT *
FROM (SELECT EMPLOYEE_ID,
                        FIRST_NAME,
                        EMAIL,
                        JOB_ID,
                        DEPARTMENT_ID
            FROM EMPLYOEES
            WHERE DEPARTMENT_ID IN (60,70,80)
            );


