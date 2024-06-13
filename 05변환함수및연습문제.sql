-- 변환 함수
-- 형 변환 함수
-- 자동 형 변환을 제공해줌(문자와 숫자 간, 문자와 날짜 간)

SELECT * FROM EMPLOYEES WHERE SALARY >= '20000'; -- 20000 문자로 써도 자동 형 변환 돼서 검색할 때 오류나지 않음
SELECT * FROM EMPLOYEES WHERE HIRE_DATE >= '08/01/01'; -- 문자 -> 날짜 자동 형 변환

-- 강제 형 변환 (자동으로 되지 않을 때)
-- TO_CHAR -> 날짜를 문자로
SELECT TO_CHAR (SYSDATE, 'YYYY-MM-DD HH:MI:SS') AS 시간 FROM DUAL;
SELECT TO_CHAR (SYSDATE, 'YY-MM-DD AM|PM HH12:MI:SS') AS 시간 FROM DUAL;
SELECT TO_CHAR (SYSDATE, 'YYYY"년" MM"월" DD"일"') AS 시간 FROM DUAL;  --DATE 포맷 값이 아닌 값을 쓰려면 "" 쌍따옴표로

--TO_CHAR -> 숫자를 문자로
SELECT TO_CHAR (20000, '999999999') AS RESULT FROM DUAL; -- 9자리 문자로 표현 (보통 9개 적음)
SELECT TO_CHAR (20000, '099,9999999') AS RESULT FROM DUAL; -- 부족한 자리 0으로 채움
SELECT TO_CHAR (20000, '999') AS RESULT FROM DUAL; -- 자리수 부족하면 ### 출력
SELECT TO_CHAR (20000.123, '999999999.9999') AS RESULT FROM DUAL; -- 정수 6자리, 실수 4자리
SELECT TO_CHAR (20000, '$999,999,999') AS RESULT FROM DUAL; -- 달러
SELECT TO_CHAR (20000, 'L999,999,999') AS RESULT FROM DUAL; -- 각국 지역화폐 기호 표기

-- 오늘의 환율이 1372.17원일 때 SALARY 값을 원화로 표현하기
SELECT SALARY, TO_CHAR (SALARY * 1372.17, 'L999,999,999') AS 원화 FROM EMPLOYEES;

--TO DATE 문자를 날짜로
SELECT TO_DATE ('2024-06-13', 'YYYY-MM-DD') FROM DUAL; -- 기본형태의 날짜표기법으로 돌아옴
SELECT TO_DATE ('2024년 6월 13일', 'YYYY"년" MM"월" DD"일"') FROM DUAL; -- 날짜 포맷 문자가 아니라면 "" 쌍따옴표로
SELECT TO_DATE ('24-06-13 11시 30분 23초', 'YYYY-MM-DD HH"시" MI"분" SS"초"') FROM DUAL;

--------- 2024년 6월 13일의 문자로 변환한다면?
SELECT TO_CHAR(TO_DATE ('240613', 'YY-MM-DD'), 'YYYY"년" MM"월" DD"일"') AS 날 FROM DUAL;

--TO_NUMBER 문자를 숫자로
SELECT '4000'-1000 FROM DUAL; -- 자동 형 변환
SELECT TO_NUMBER ('4000') - 1000 FROM DUAL; -- 명시적 형 변환
SELECT '$5,500' - 1000 FROM DUAL; -- 자동 형 변환 불가능
SELECT TO_NUMBER ('$5,500', '$9,999') - 1000 FROM DUAL; -- 자동 형 변환이 불가능할 경우엔 형식에 맞춰 문자를 숫자로 형 변환 시키기

---------------------------------------------------

--NULL 처리 함수
--NVL (대상값, NULL인 경우)
SELECT NVL(1000, 0) AS 테스트, NVL(NULL,0) AS 테스트 FROM DUAL;
SELECT NULL + 1000 FROM DUAL; -- 숫자에선 연산에 NULL 들어가면 최종 결과도 NULL 나옴
SELECT FIRST_NAME, SALARY, COMMISSION_PCT, SALARY + SALARY * COMMISSION_PCT FROM EMPLOYEES;
SELECT FIRST_NAME, SALARY, COMMISSION_PCT, SALARY + SALARY * NVL( COMMISSION_PCT, 0 ) AS 최종급여 FROM EMPLOYEES;

--NVL2 (대상 값, NULL이 아닌 경우, NULL인 경우)
SELECT NVL2 (NULL, 'NULL이 아닙니다', 'NULL입니다') FROM DUAL;
SELECT NVL2 (143, 'NULL이 아닙니다', 'NULL입니다') FROM DUAL;

SELECT FIRST_NAME, SALARY, COMMISSION_PCT, NVL2(COMMISSION_PCT, SALARY + SALARY * COMMISSION_PCT, SALARY) AS 최종급여 FROM EMPLOYEES;

--COALESCE (값, 값, 값...)  첫번째로 NULL이 아닌 값을 반환 시켜줌
SELECT COALESCE(1,2,3) FROM DUAL; 
SELECT COALESCE(NULL, 2,3,4) FROM DUAL;
SELECT COALESCE(1,NULL,3,4) FROM DUAL;
SELECT COALESCE(NULL, NULL, 3, NULL, 4) FROM DUAL;
SELECT COMMISSION_PCT, COALESCE(COMMISSION_PCT,0) FROM EMPLOYEES; -- NVL과 똑같음

-- DECODE (대상값, 비교값, 결과값, 비교값2, 결과값2, ..., ELSE문)
SELECT DECODE('A', 'A', 'A입니다') FROM DUAL; -- IF문
SELECT DECODE('X','A','A입니다', 'A가 아닙니다') FROM DUAL; -- IF~ELSE구문
SELECT DECODE('B', 'A', 'A입니다'
                               , 'B', 'B입니다'
                               , 'C', 'C입니다'
                               , '전부 아닙니다') 
FROM DUAL; -- IF~ELSE IF~ELSE 구문


SELECT * FROM EMPLOYEES;

SELECT JOB_ID, DECODE(JOB_ID, 'IT_PROG', SALARY * 1.1
                                      , 'AD_VP', SALARY * 1.2
                                      , 'FI_MGR', SALARY * 1.3
                                      , SALARY
                                      ) AS 급여
FROM EMPLOYEES;


-- CASE~WHEN~THEN~ELSE~END (SWITCH문과 비슷함)
SELECT JOB_ID,
            CASE JOB_ID WHEN 'IT_PROG' THEN SALARY * 1.1
                                 WHEN 'AD_VP' THEN SALARY * 1.2
                                 WHEN 'FI_MGR' THEN SALARY * 1.3
                                 ELSE SALARY
            END AS 급여
FROM EMPLOYEES;


-- 비교에 대한 조건을 WHEN절에 쓸 수도 있음
SELECT JOB_ID,
            CASE WHEN JOB_ID = 'IT_PROG' THEN SALARY * 1.1
                     WHEN JOB_ID = 'AD_VP' THEN SALARY * 1.2
                     WHEN JOB_ID = 'FI_MGR' THEN SALARY * 1.3
                     ELSE SALARY
            END AS 급여
FROM EMPLOYEES;

------------------------------------

--문제 1.
--현재일자를 기준으로 EMPLOYEE테이블의 입사일자(hire_date)를 참조해서 근속년수가 10년 이상인
--사원을 다음과 같은 형태의 결과를 출력하도록 쿼리를 작성해 보세요. 
--조건 1) 근속년수가 높은 사원 순서대로 결과가 나오도록 합니다.
SELECT EMPLOYEE_ID AS 사원번호,
            CONCAT (FIRST_NAME || ' ' , LAST_NAME) AS 사원명,
            HIRE_DATE AS 입사일자,
            TRUNC((SYSDATE - HIRE_DATE) / 365) AS 근속년수 
            FROM EMPLOYEES
            WHERE FLOOR ((SYSDATE - HIRE_DATE) / 365) >= 10
            ORDER BY FLOOR ((SYSDATE - HIRE_DATE) / 365) DESC;

--문제 2.
--EMPLOYEE 테이블의 manager_id컬럼을 확인하여 first_name, manager_id, 직급을 출력합니다.
--100이라면 ‘부장’ 
--120이라면 ‘과장’
--121이라면 ‘대리’
--122라면 ‘주임’
--나머지는 ‘사원’ 으로 출력합니다.
--조건 1) 부서가 50인 사람들을 대상으로만 조회합니다?
--조건 2) DECODE구문으로 표현해보세요.
SELECT FIRST_NAME AS 성함, 
            MANAGER_ID AS MAN_ID, DEPARTMENT_ID AS 부서, DECODE (MANAGER_ID, 100, '부장',
                                                                                 120, '과장',
                                                                                 121, '대리',
                                                                                 122, '주임',
                                                                                 '사원')
                                                                                 AS 직급
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN 50;
                                                                                                                        
--조건 3) CASE구문으로 표현해보세요.
SELECT FIRST_NAME AS 성함, MANAGER_ID AS ID, DEPARTMENT_ID, 
            CASE MANAGER_ID WHEN 100 THEN '부장'
                                          WHEN 120 THEN '과장'
                                          WHEN 121 THEN '대리'
                                          WHEN 122 THEN '주임'
                                          ELSE '사원'
                                          END AS 직급
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN 50;


--
--
--문제 3. 
--EMPLOYEES 테이블의 이름, 입사일, 급여, 진급대상 을 출력합니다.
--조건1) HIRE_DATE를 XXXX년XX월XX일 형식으로 출력하세요. 
--조건2) 급여는 커미션값이 퍼센트로 더해진 값을 출력하고, 1300을 곱한 원화로 바꿔서 출력하세요.
--조건3) 진급대상은 5년 마다 이루어 집니다. 근속년수가 5의 배수라면 진급대상으로 출력합니다.
--조건4) 부서가 NULL이 아닌 데이터를 대상으로 출력합니다.
SELECT FIRST_NAME AS 이름,
            TO_CHAR(HIRE_DATE, 'YYYY"년" MM"월" DD"일"') AS 입사날짜,
            TO_CHAR((SALARY + (SALARY * NVL(COMMISSION_PCT, 0)))*1300, 'L999,999,999') AS 급여, 
            TRUNC((SYSDATE - HIRE_DATE)/365) AS 근속년수,
            DECODE (MOD (FLOOR((SYSDATE - HIRE_DATE)/365),5), 0, '진급 대상') AS 진급여부
FROM EMPLOYEES
                         WHERE DEPARTMENT_ID IS NOT NULL;






