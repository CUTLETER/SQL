-- 트리거 : 트리거는 테이블에 부착한 형태로 AFTER, BEFORE 트리거가 있음
-- AFTER는 DML문장이 타겟 테이블에 실행된 이후에 동작하는 트리거
-- BEFORE는 DML문장이 타겟 테이블에 실행되기 이전에 동작하는 트리거

SET SERVEROUTPUT ON;

CREATE TABLE TBL_TEST(
        ID VARCHAR2(30),
        TEXT VARCHAR2(30)
);


-- 트리거 생성
CREATE OR REPLACE TRIGGER TBL_TEST_TRG
        AFTER UPDATE OR INSERT OR DELETE -- 트리거 종류와 동작 시점
        ON TBL_TEST -- 부착할 테이블
        FOR EACH ROW -- 모든 행에 적용됨
BEGIN
        DBMS_OUTPUT.PUT_LINE('------트리거가 동작함------');
END;


INSERT INTO TBL_TEST VALUES ('AAA123', 'HELLO');
UPDATE TBL_TEST SET TEXT = 'BYE' WHERE ID = 'AAA123';
DELETE FROM TBL_TEST WHERE ID = 'AAA123';

--------------------------------------------------------------------------------------

--AFTER TRIGGER
-- :OLD = 참조 전 값 ( INSERT에선 입력 전 자료, UPDATE에선 변경 전 자료, DELETE에선 삭제 전 자료)


-- 원본테이블과 백업테이블 생성
CREATE TABLE TBL_USER(
    ID VARCHAR2(20) PRIMARY KEY,
    NAME VARCHAR2(20),
    ADDRESS VARCHAR2(30)
);

CREATE TABLE TBL_USER_BACKUP(
    ID VARCHAR2(20),
    NAME VARCHAR2(20),
    ADDRESS VARCHAR2(30),
    UPDATEDATE DATE DEFAULT SYSDATE,
    M_TYPE CHAR(10), --변경타입
    M_USER VARCHAR2(20) --변경한 사용자
);


-- TBL_USER 에 업데이트 OR 삭제가 일어나면 기존 데이터를 백업시킴
CREATE OR REPLACE TRIGGER TBL_USER_BACKUP_TRG
        AFTER UPDATE OR DELETE
        ON TBL_USER
        FOR EACH ROW
DECLARE -- 익명 블록 포함시켜서 변수 사용 가능해짐
        V VARCHAR2(10); -- 지역 변수 선언
BEGIN
        IF UPDATING THEN -- UPDATE가 일어나면 TRUE
                V := '수정';
        ELSIF DELETING THEN -- DELETE가 일어나면 TRUE
                V := '삭제';
        END IF;
        
        -- 변경되기 전 자료
        INSERT INTO TBL_USER_BACKUP VALUES ( :OLD.ID, :OLD.NAME, :OLD.ADDRESS, SYSDATE, V, USER() ); -- 변경 되기 전의 ID, NAME, ADDRESS
        
END;

INSERT INTO TBL_USER VALUES('AAA','AAA','AAA');
INSERT INTO TBL_USER VALUES('BBB','BBB','BBB');

UPDATE TBL_USER SET NAME = 'NEW_AAA' WHERE ID = 'AAA'; -- 트리거 동작함
DELETE FROM TBL_USER WHERE ID = 'BBB'; -- 트리거 동작함

SELECT * FROM TBL_USER_BACKUP;



-- BEFORE TRIGGER
-- :NEW 참조 후 값 ( INSERT : 입력할 자료, UPDATE : 수정할 자료)
CREATE OR REPLACE TRIGGER TBL_USER_TRG
        BEFORE INSERT
        ON TBL_USER
        FOR EACH ROW
BEGIN
        -- INSERT가 되기 전에 들어오는 데이터를 홍**처럼 변경시킴
        :NEW.NAME :=SUBSTR(:NEW.NAME, 1, 1) || '**';
        
END;


INSERT INTO TBL_USER VALUES ('CCC', '홍길동', '서울시');
INSERT INTO TBL_USER VALUES ('DDD', '이순신', '서울시');

SELECT * FROM TBL_USER;