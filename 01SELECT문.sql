-- 테이블명은 보통 복수형 -S
SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;
SELECT * FROM JOBS;

-- 특정 컬럼만 조회하기
SELECT FIRST_NAME, HIRE_DATE, EMAIL, SALARY FROM EMPLOYEES;
-- 문자와 날짜는 왼쪽 정렬, 숫자는 오른쪽 정렬됨

-- 컬럼명이 들어가는 자리에선 숫자 또는 날짜 연산도 가능함
SELECT FIRST_NAME, SALARY, SALARY + SALARY * 0.1 FROM EMPLOYEES;

-- PK는 EMPLYOEE_ID , FK는 DEPARTMENT_ID
SELECT * FROM EMPLOYEES;

-- *엘리어스(=별칭)*, AS 생략 가능하고 "" 있거나 없거나 띄어쓰기 넣을 거면 ""로 묶어주기
SELECT FIRST_NAME AS 별칭, SALARY 급여, SALARY + SALARY * 0.1 "최종 급여" FROM EMPLOYEES;

-- *문자열 간의 연결* ||
-- 홑따옴표 안에서 홑따옴표를 특수문자로 쓰고 싶다면 '''
SELECT 'HELLO' || ' WORLD' FROM EMPLOYEES;
SELECT FIRST_NAME || '''님의 급여는 ' || SALARY || '$입니다.' AS 급여 FROM EMPLOYEES;

-- *DISTINCT* (중복 제거) 키워드
SELECT DEPARTMENT_ID FROM EMPLOYEES;
SELECT DISTINCT DEPARTMENT_ID FROM EMPLOYEES; -- 중복되는 값을 제거하고 어떤 값이 있는지 파악 가능함

-- *ROWNUM* (조회된 순서), ROWID(레코드가 저장된 위치, 출력하면 데이터가 저장된 주소가 나옴)
SELECT EMPLOYEE_ID, FIRST_NAME, ROWID, ROWNUM FROM EMPLOYEES;


