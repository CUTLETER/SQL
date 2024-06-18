--트랜잭션
--오직 DML문에 대해서만 트랜잭션을 수행할 수 있음 (DDL문은 실행시키자마자 바로 반영됨)

--오토 커밋 확인
SHOW AUTOCOMMIT;
--오토 커밋 ON
SET AUTOCOMMIT ON;
SET AUTOCOMMIT OFF; -- 보통은 꺼둠

-----------------------

SELECT * FROM DEPTS;

DELETE FROM DEPTS WHERE DEPARTMENT_ID = 10;
SAVEPOINT DEPT10; -- 실제로 많이 쓰진 않음, 트랜잭션이 일어난 지점

DELETE FROM DEPTS WHERE DEPARTMENT_ID = 20;
SAVEPOINT DEPT20;

DELETE FROM DEPTS WHERE DEPARTMENT_ID = 30;

ROLLBACK TO DEPT20; -- 30번 살아남
ROLLBACK TO DEPT10; -- 20번까지 살아남
ROLLBACK; -- 마지막 커밋 이후로 돌아감

-- 흔히 하는 실수
INSERT INTO DEPTS VALUES (280, 'AA', NULL, 1800); -- 데이터가 임시 저장된 상태
COMMIT; -- 데이터가 최종 반영됨

-- 트랜잭션 4원칙 ACID (SQLD 시험에 나옴)

