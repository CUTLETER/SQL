-- 그룹함수
-- NULL이 제외된 데이터에 대해서 적용됨
SELECT MAX(SALARY), MIN(SALARY), SUM(SALARY), AVG(SALARY), COUNT(SALARY) FROM EMPLOYEES;
--MIN과 MAX는 날짜, 문자에도 적용됨
SELECT MIN(HIRE_DATE), MIN(FIRST_NAME) FROM EMPLOYEES;
SELECT MAX(HIRE_DATE), MAX(FIRST_NAME) FROM EMPLOYEES;
--COUNT 함수의 두 가지 사용 방법 (전체 행의 개수, NULL이 아닌 행의 개수) 
SELECT COUNT(*), COUNT(COMMISSION_PCT) FROM EMPLOYEES;

--부서가 80번인 사람 중 커미션이 가장 높은 사람?
SELECT MAX(COMMISSION_PCT) FROM EMPLOYEES WHERE DEPARTMENT_ID = 80;

--그룹합수는 일반 COLUMN이랑 동시에 사용XXXXXXXX 그룹함수는 1행만 나옴
SELECT FIRST_NAME, AVG(SALARY) FROM EMPLOYEES;
--굳이 굳이 하고 싶을 땐 OVER 붙이면 일반 컬럼과 동시에 사용 가능해짐
SELECT FIRST_NAME, AVG(SALARY) OVER(), COUNT(*) OVER(), SUM(SALARY) OVER() FROM EMPLOYEES;

-- GROUP BY절 -> WHERE절 ORDER절 사이에 적어야 함
SELECT DEPARTMENT_ID,
            SUM(SALARY),
            AVG(SALARY),
            MIN(SALARY),
            MAX(SALARY),
            COUNT(*)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID;

-- GROUP화 시킨 컬럼만 SELECT구문에 적을 수 있음
SELECT DEPARTMENT_ID,
            FIRST_NAME
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID;

-- 2개 이상의 그룹화 (하위 그룹)
SELECT DEPARTMENT_ID, JOB_ID,
            SUM(SALARY) AS 부서직무별급여총합,
            AVG(SALARY) AS 부서직무별급여평균,
            MIN(SALARY),
            MAX(SALARY),
            COUNT(*) AS 부서인원수,
            COUNT(*) OVER() AS 전체카운트 --COUNT(*) OVER() 사용하면 총 행희 개수를 출력 가능함
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID, JOB_ID
ORDER BY DEPARTMENT_ID;

-- 그룹함수는 WHERE절 적을 수 없음
SELECT DEPARTMENT_ID,
            AVG(SALARY)
FROM EMPLOYEES
WHERE AVG (SALARY) >=5000 --그룹의 조건을 적는 곳은 HAVING이라고 따로 있음, WHERE XXXXXXXXX
GROUP BY DEPARTMENT_ID;

----------------------------------------------------------

--HAVING절 - GROUP BY의 조건식 (=SELECT의 WHERE과 같음)
SELECT DEPARTMENT_ID, SUM(SALARY), COUNT(*)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING SUM (SALARY) >=100000 OR COUNT(*) >= 5;

--

SELECT DEPARTMENT_ID, JOB_ID, AVG (SALARY), COUNT(*), COUNT(COMMISSION_PCT)
FROM EMPLOYEES
WHERE JOB_ID NOT LIKE 'SA$'
GROUP BY DEPARTMENT_ID, JOB_ID
HAVING AVG(SALARY) >= 10000
ORDER BY AVG(SALARY) DESC;

-- 부서 아이디가 NULL이 아닌 데이터 중에서 입사일은 05년도인 사람들의 급여 평균, 급여의 합을 구하고
-- 평균 급여는 5000 이상인 데이터만 구해서 부서 아이디로 내림차순

SELECT DEPARTMENT_ID, AVG(SALARY), SUM (SALARY)
FROM EMPLOYEES
WHERE DEPARTMENT_ID IS NOT NULL AND HIRE_DATE LIKE '05%'
GROUP BY DEPARTMENT_ID
HAVING AVG(SALARY) >= 5000 
ORDER BY DEPARTMENT_ID DESC;

---------------------------------------------------------

-- ROLLUP - GROUP BY절과 함께 사용되고 상위 그룹에 합계, 총계 등을 구함
SELECT DEPARTMENT_ID,
            SUM (SALARY),
            AVG (SALARY)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID;

SELECT DEPARTMENT_ID,
            SUM (SALARY),
            AVG (SALARY)
FROM EMPLOYEES
GROUP BY ROLLUP (DEPARTMENT_ID); -- 전체 그룹에 대한 총계

--

SELECT DEPARTMENT_ID, 
            JOB_ID,
            SUM (SALARY),
            AVG (SALARY)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID, JOB_ID
ORDER BY DEPARTMENT_ID;

SELECT DEPARTMENT_ID, 
            JOB_ID,
            SUM (SALARY),
            AVG (SALARY)
FROM EMPLOYEES
GROUP BY ROLLUP (DEPARTMENT_ID, JOB_ID) -- 총계, 주그룹에 대한 총계 전부 나옴
ORDER BY DEPARTMENT_ID;


-- CUBE - 롤업, 서브 그룹의 총계까지 추가됨
SELECT DEPARTMENT_ID,
            JOB_ID,
            SUM(SALARY),
            AVG(SALARY)
FROM EMPLOYEES
GROUP BY CUBE (DEPARTMENT_ID, JOB_ID)
ORDER BY DEPARTMENT_ID;

-- GROUPING 함수 - GROUP BY로 만들어진(원래 존재하면서) 경우는 '0'을 반환하고, 롤업 또는 큐브로 만들어진(없다가 만들어진) 행인 경우는 '1'을 반환함
SELECT DEPARTMENT_ID,
            JOB_ID,
            AVG(SALARY),
            GROUPING (DEPARTMENT_ID),
            GROUPING (JOB_ID)
FROM EMPLOYEES
GROUP BY ROLLUP (DEPARTMENT_ID, JOB_ID)
ORDER BY DEPARTMENT_ID;

SELECT DECODE ( GROUPING (DEPARTMENT_ID), 1, '총계', DEPARTMENT_ID),
            DECODE (GROUPING (JOB_ID), 1, '소계', JOB_ID),
            AVG(SALARY),
            GROUPING (DEPARTMENT_ID),
            GROUPING (JOB_ID)
FROM EMPLOYEES
GROUP BY ROLLUP (DEPARTMENT_ID, JOB_ID)
ORDER BY DEPARTMENT_ID;




-- 연습 문제

--문제 1.
--사원 테이블에서 JOB_ID별 사원 수를 구하세요.
--사원 테이블에서 JOB_ID별 월급의 평균을 구하세요. 월급의 평균 순으로 내림차순 정렬하세요.
--시원 테이블에서 JOB_ID별 가장 빠른 입사일을 구하세요. JOB_ID로 내림차순 정렬하세요.
SELECT JOB_ID, AVG (SALARY), COUNT(*)
FROM EMPLOYEES
GROUP BY JOB_ID
ORDER BY JOB_ID DESC, AVG (SALARY) DESC;

SELECT JOB_ID, MIN(HIRE_DATE)
FROM EMPLOYEES
GROUP BY JOB_ID
ORDER BY  MIN(HIRE_DATE);


--문제 2.
--사원 테이블에서 입사 년도 별 사원 수를 구하세요.
SELECT TO_CHAR(HIRE_DATE, 'YY'), COUNT(*)
FROM EMPLOYEES
GROUP BY TO_CHAR(HIRE_DATE, 'YY');


--문제 3.
--급여가 1000 이상인 사원들의 부서별 평균 급여를 출력하세요. 단 부서 평균 급여가 2000이상인 부서만 출력
SELECT DEPARTMENT_ID, TRUNC (AVG (SALARY),0)
FROM EMPLOYEES
WHERE SALARY >= 1000
GROUP BY DEPARTMENT_ID
HAVING AVG (SALARY) >= 2000;


--
--문제 4.
--사원 테이블에서 commission_pct(커미션) 컬럼이 null이 아닌 사람들의
--department_id(부서별) salary(월급)의 평균, 합계, count를 구합니다.
--조건 1) 월급의 평균은 커미션을 적용시킨 월급입니다.
--조건 2) 평균은 소수 2째 자리에서 절삭 하세요.
SELECT DEPARTMENT_ID, 
             TRUNC (AVG (SALARY+(SALARY*COMMISSION_PCT)), 2), SUM (SALARY), COUNT(*)
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NOT NULL
GROUP BY DEPARTMENT_ID;


--문제 5.
--부서아이디가 NULL이 아니고, 입사일은 05년도 인 사람들의 부서 급여평균과, 급여합계를 평균기준 내림차순합니다
--조건) 평균이 10000이상인 데이터만
SELECT DEPARTMENT_ID, AVG(SALARY), SUM(SALARY)
FROM EMPLOYEES
WHERE DEPARTMENT_ID IS NOT NULL AND HIRE_DATE LIKE '05%'
GROUP BY DEPARTMENT_ID
HAVING AVG(SALARY) >= 10000
ORDER BY AVG (SALARY) DESC;


--문제 6.
--직업별 월급합, 총합계를 출력하세요
SELECT DECODE(GROUPING (JOB_ID), 1, '합계', JOB_ID), SUM(SALARY), AVG(SALARY)
FROM EMPLOYEES
GROUP BY ROLLUP(JOB_ID)
ORDER BY JOB_ID;


--문제 7.
--부서별, JOB_ID를 그룹핑 하여 토탈, 합계를 출력하세요.
--GROUPING() 을 이용하여 소계 합계를 표현하세요

SELECT DECODE (GROUPING (DEPARTMENT_ID), 1, '합계', DEPARTMENT_ID),
             DECODE (GROUPING (JOB_ID), 1, '소계', JOB_ID),
             AVG(SALARY)
FROM EMPLOYEES
GROUP BY ROLLUP (DEPARTMENT_ID, JOB_ID)
ORDER BY SUM (SALARY);
