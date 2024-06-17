-- 서브쿼리 (SELECT 구문의 특정 위치에 다시 SELECT가 들어가는 문장)

-- 단일행 서브쿼리 :  서브쿼리의 결과가 1행인 서브쿼리
-- 예시) 낸시보다 급여가 높은 사람 찾는 법
-- 1. 먼저 낸시의 급여를 찾는다
SELECT * FROM EMPLOYEES WHERE FIRST_NAME = 'Nancy';
-- 2. 찾은 낸시의 급여를 WHERE절에 넣는다
SELECT * FROM EMPLOYEES WHERE SALARY >= 12008;
-- 서브쿼리로 한꺼번에 적어보면?
SELECT * FROM EMPLOYEES WHERE SALARY >= (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'Nancy');

--예시2) 103번과 직업이 같은 사람 찾는법
SELECT JOB_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = 103;
SELECT * FROM EMPLOYEES WHERE JOB_ID = (SELECT JOB_ID FROM EMPLOYEES WHERE EMPLOYEE_ID  = 103);

-- 주의할 점 : 서브쿼리에 들어가는 비교대상 컬럼은 정확히 1개여야 함
SELECT * FROM EMPLOYEES
WHERE JOB_ID = (SELECT * FROM EMPLOYEES WHERE EMPLOYEE_ID = 103); -- 에러

-- 스티븐이 두 명일 때 (서브쿼리 결과가 2개 이상)
SELECT SALARY
FROM EMPLOYEES
WHERE FIRST_NAME = 'Steven';

-- 여러 행이 나오는 구문이라면 다중행 서브쿼리 연산자를 써서 처리해야 함, 단일행XXXXXXX
SELECT SALARY FROM EMPLOYEES
WHERE SALARY >= (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'Steven'); 

----------------------------------------------------

-- 다중행 서브쿼리 : 위에서처럼 서브쿼리의 결과가 2개 이상 반환되는 경우 IN, ANY, ALL 써야 함

-- ANY, ALL 예시

SELECT SALARY
FROM EMPLOYEES
WHERE FIRST_NAME = 'David'; -- 세 명의 데이비드 (4800, 6800, 9500)

-- '가장 적은 데이비드의 급여' 보다 많이 받는 사람
SELECT *
FROM EMPLOYEES
WHERE SALARY > ANY (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David');

-- '가장 많은 데이비드의 급여'보다 적게 받는 사람
SELECT *
FROM EMPLOYEES
WHERE SALARY < ANY (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David');

-- '가장 많은 데이비드의 급여'보다 더 많이 받는 사람
SELECT *
FROM EMPLOYEES
WHERE SALARY > ALL (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David');

-- '가장 적은 데이비드의 급여'보다 더 적게 받는 사람
SELECT *
FROM EMPLOYEES 
WHERE SALARY < ALL ( SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David');

-- IN : 다중행 데이터 중 일치하는 데이터
-- 예시) 데이비드와 부서가 같은 사람
SELECT DEPARTMENT_ID
FROM EMPLOYEES
WHERE FIRST_NAME = 'David';

SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID 
                                            FROM EMPLOYEES WHERE FIRST_NAME = 'David');

------------------------------------------------------

-- 스칼라 쿼리 : WHERE절이 아닌 'SELECT문에 서브쿼리가 들어가는' 경우 (JOIN을 대체함)
SELECT FIRST_NAME,
             DEPARTMENT_NAME
FROM EMPLOYEES E
LEFT JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

-- 이걸 스칼라 쿼리로 바꿔보면? (LEFT JOIN과 같음)
SELECT FIRST_NAME,
             (SELECT DEPARTMENT_NAME/*얘도 1개의 컬럼만 적기*/ FROM DEPARTMENTS D WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID /*JOIN의 ON 조건 적기*/)
FROM EMPLOYEES E;             

-- 스칼라 쿼리는 다른 테이블의 '1개'의 컬럼을 가지고 올 때 JOIN보다 구문이 깔끔함
-- 아래 예시처럼 많은 열을 가지고 올 때는 오히려 JOIN구문이 가독성은 더 좋을 수 있음
SELECT FIRST_NAME,
             JOB_ID,
             (SELECT JOB_TITLE FROM JOBS J WHERE J.JOB_ID = E.JOB_ID),
             (SELECT MIN_SALARY FROM JOBS J WHERE J.JOB_ID = E.JOB_ID),
             (SELECT MAX_SALARY FROM JOBS J WHERE J.JOB_ID = E.JOB_ID)
FROM EMPLOYEES E;


-- 예시
-- FIRST_NAME 컬럼, DEPARTMENT_NAME, JOB_TITLE 동시에 가져오기

--1. JOIN으로
SELECT E.FIRST_NAME, D.DEPARTMENT_NAME, J.JOB_TITLE
FROM EMPLOYEES E
LEFT JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
LEFT JOIN JOBS J
ON E.JOB_ID = J.JOB_ID;

--2. 스칼라 쿼리로
SELECT FIRST_NAME,
            (SELECT JOB_TITLE FROM JOBS J WHERE J.JOB_ID = E.JOB_ID),
            (SELECT DEPARTMENT_NAME FROM DEPARTMENTS D WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID)
FROM EMPLOYEES E;            

------------------------------------------------------------------

-- 인라인 뷰 : FROM절 하위에 서브쿼리 절이 들어감
-- 인라인 뷰에서 '가상 컬럼'을 만들고 그 컬럼에 대해 조회할 때 사용함

-- 따로 따로 적고 괄호 안에 넣어서 합치는 방식이 쉬움
SELECT *
FROM (); -- 이 틀에 합치기

SELECT *
FROM EMPLOYEES;

SELECT *
FROM (SELECT *
           FROM EMPLOYEES);

----------------

SELECT ROWNUM,
             FIRST_NAME,
             SALARY
FROM EMPLOYEES
ORDER BY SALARY DESC; -- 급여 기준으로 정렬은 되었지만 ROWNUM은 뒤죽박죽인 상태 1

-- 결과를 가지고 다시 조회하기

SELECT *
FROM ();

SELECT FIRST_NAME,
             SALARY
FROM EMPLOYEES
ORDER BY SALARY DESC;

SELECT *
FROM (SELECT FIRST_NAME,
                        SALARY
            FROM EMPLOYEES
            ORDER BY SALARY DESC);

--------------------

SELECT ROWNUM,
             FIRST_NAME,
             SALARY
FROM (SELECT FIRST_NAME,
                        SALARY
           FROM EMPLOYEES
           ORDER BY SALARY DESC
           )
WHERE ROWNUM BETWEEN 1 AND 10; -- 급여 기준으로 정렬되고 ROWNUM도 순서대로인 상태, 다만 ROWNUM 조회는 무조건 1부터 시작해야 함

--ORDER를 먼저 시킬 결과를 만들고, ROWNUM 가상열로 다시 만든 뒤, 다시 조회하기

SELECT *
FROM ();


SELECT FIRST_NAME,
            SALARY
FROM EMPLOYEES
ORDER BY SALARY DESC;

SELECT *
FROM (SELECT FIRST_NAME,
            SALARY
            FROM EMPLOYEES
            ORDER BY SALARY DESC
);


SELECT ROWNUM AS 가상열,
                        FIRST_NAME,
                        SALARY
             FROM (
                        SELECT FIRST_NAME,
                                      SALARY
                        FROM EMPLOYEES
                        ORDER BY SALARY DESC
);

             
SELECT *
FROM ( 
            SELECT ROWNUM AS 가상열,
                        FIRST_NAME,
                        SALARY
             FROM (
                        SELECT FIRST_NAME,
                                      SALARY
                        FROM EMPLOYEES
                        ORDER BY SALARY DESC
    )
)
WHERE 가상열 BETWEEN 11 AND 20; -- 안에서 만들어진 가상열을 밖에서 사용할 수 있게 됨


-- 예시
--근속년수 5년째 되는 사람들만 출력하기
--1. 먼저 근속년수라는 가상열 만들기
SELECT FIRST_NAME, HIRE_DATE,
             TRUNC ((SYSDATE - HIRE_DATE) / 365) AS 근속년수
FROM EMPLOYEES
-- WHERE MOD (근속년수,5)=0 에러 발생
ORDER BY 근속년수 DESC;

--2. 틀에 넣어 합치기
SELECT *
FROM (SELECT FIRST_NAME, HIRE_DATE,
             TRUNC ((SYSDATE - HIRE_DATE) / 365) AS 근속년수
            FROM EMPLOYEES
            ORDER BY 근속년수 DESC)
WHERE MOD (근속년수, 5) = 0; -- 저 안에서 다시 조회하기


-- 인라인 뷰에서 테이블 ALIAS로 조회하기

SELECT E.*,
             TRUNC ((SYSDATE - HIRE_DATE) / 365) AS 근속년수
FROM EMPLOYEES E
ORDER BY 근속년수 DESC;


SELECT ROWNUM AS 가상열,
             A.* --A의 모든 정보 가리킴
FROM ( 
            SELECT E.*,
                         TRUNC ((SYSDATE - HIRE_DATE) / 365) AS 근속년수
            FROM EMPLOYEES E
            ORDER BY 근속년수 DESC

) A; -- FROM절에 A라는 별칭 붙임


