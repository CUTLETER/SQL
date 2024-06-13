--숫자 함수

-- ROUND 반올림
SELECT 45.923 FROM DUAL;
SELECT ROUND (45.923) FROM DUAL; -- 자릿수 지정없으면 정수 끝자리 반올림
SELECT ROUND (45.923, 0) FROM DUAL; -- 0 도 마찬가지
SELECT ROUND (45.923, 2) FROM DUAL; -- 소수점 2번째 자리까지 반올림
SELECT ROUND (45.923,-1) FROM DUAL; -- 정수 반올림

-- TRUNC 절삭
SELECT TRUNC (45.923),TRUNC  (45.923, 0),TRUNC (45.923, 2),TRUNC  (45.923,-1) FROM DUAL;

-- ABS 절대값 반환
-- CEIL 올림
--FLOOR 내림
SELECT ABS(-23), CEIL(3.14), FLOOR (3.14) FROM DUAL;

--MOD 나머지 (몫은 / 로 구하면 됨)
SELECT 5/3 FROM DUAL; -- 몫
SELECT MOD (5, 3) FROM DUAL; -- 나머지

-------------------------------------------------------

-- 날짜 함수
SELECT SYSDATE FROM DUAL; -- 년 월 일
SELECT SYSTIMESTAMP FROM DUAL; -- 년 월 일 시 분 초

--날짜는 연산도 가능함
SELECT HIRE_DATE, HIRE_DATE +1, HIRE_DATE -1 FROM EMPLOYEES; -- 일자 DAY 기준으로 연산이 됨

SELECT FIRST_NAME, SYSDATE - HIRE_DATE FROM EMPLOYEES;-- 입사한 이후 며칠?
SELECT FIRST_NAME, (SYSDATE - HIRE_DATE) / 7 FROM EMPLOYEES; -- 입사한 이후 몇 주?
SELECT FIRST_NAME, (SYSDATE - HIRE_DATE) / 365 FROM EMPLOYEES; -- 입사한 이후 몇 년?

-- 날짜의 반올림과 절삭
SELECT ROUND (SYSDATE), TRUNC (SYSDATE) FROM DUAL; -- ROUND 24시간 기준으로 반올림 시킴 (24시 기준으로 반 지났으면 +1)
SELECT ROUND (SYSDATE, 'MONTH'), TRUNC (SYSDATE, 'MONTH') FROM DUAL; -- 월 기준으로 반올림 (이번 달의 절반 이상 지났으면 월 +1)
SELECT ROUND (SYSDATE, 'YEAR'), TRUNC (SYSDATE, 'YEAR') FROM DUAL; -- 연 기준으로 반올림 (이번 년도의 절반 이상이면 연+1)


