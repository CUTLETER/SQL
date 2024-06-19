-- ������ (���������� �����ϴ� ��)
-- �ַ� PK�� ����� �� ����
-- �����ͺ��̽����� �������� ���� ���� ���� (������ ���� ������)

SELECT * FROM USER_SEQUENCES;

-- ������ ���� (�ϱ��� ��)
CREATE SEQUENCE DEPTS_SEQ
        INCREMENT BY 1 -- �� �� ������ų ����
        START WITH 1-- ���۰� ����
        MAXVALUE 10
        NOCACHE -- ĳ�ÿ� �������� ���� ����
        NOCYCLE; -- �ִ밪�� �������� �� �� �ٽ� ���X

-- ������ ����
DROP TABLE DEPTS;
CREATE TABLE DEPTS (
        DEPT_NO NUMBER(2) PRIMARY KEY,
        DEPT_NAME VARCHAR(30)
);

-- ������ ��� (2����)
SELECT DEPTS_SEQ.CURRVAL FROM DUAL; -- ���� ������ (��� NEXTVAL�� ���� ����Ǿ�� ��)
SELECT DEPTS_SEQ.NEXTVAL FROM DUAL; -- ���� �������� ���� ����ŭ ���� ��Ŵ

-- ������ ����
INSERT INTO DEPTS VALUES (DEPTS_SEQ.NEXTVAL/*PK��*/, 'EXAMPLE'); -- 10 ���� ������
SELECT * FROM DEPTS;

-- ������ ����
ALTER SEQUENCE DEPTS_SEQ MAXVALUE 1000;
ALTER SEQUENCE DEPTS_SEQ INCREMENT BY 10;


-- �������� �̹� ���ǰ� �ִٸ� DROP �ȵ� XXXX
-- ���� �������� �ʱ�ȭ �ؾ� �Ѵٸ�?
-- �������� �������� ������ ���� �ʱ�ȭ�� ��ó�� �� ���� ����
SELECT DEPTS_SEQ.CURRVAL FROM DUAL;

-- 1. �������� ������ (���� �� -1)�� �ٲ�
ALTER SEQUENCE DEPTS_SEQ INCREMENT BY -39;
-- 2. ���� �������� ���� ���Ѽ� ���� ��Ŵ
SELECT DEPTS_SEQ.NEXTVAL FROM DUAL;
-- 3. ���� �������� ���ϴ� ������ �����ϸ� ���� ���� �ٽ� ���� ����
ALTER SEQUENCE DEPTS_SEQ INCREMENT BY 1;

--------------------------------------------------------------------------------------

-- ������ ���� (���߿� ���̺��� ������ ��, �����Ͱ� ��û ���ٸ� �������� ����� ����ؾ� ��)
-- ���ڿ� PK (�⵵ �� - �Ϸ� ��ȣ)
-- ��) �⵵�� �ٲ�� �������� �ʱ�ȭ �Ǵ� ��� 
CREATE TABLE DEPTS2 (
        DEPT_NO VARCHAR2(20) PRIMARY KEY,
        DEPT_NAME VARCHAR2(20)
);

INSERT INTO DEPTS2 VALUES (TO_CHAR(SYSDATE, 'YYYY-MM-') || LPAD(DEPTS_SEQ.NEXTVAL, 5, 0), 'EXAMPLE');

SELECT * FROM DEPTS2;

-- ������ ����
DROP SEQUENCE ��������;


--------------------------------------------------------------------------------------

-- INDEX
-- INDEX�� PK, UNIQUE�� �ڵ����� �����ǰ� ��ȸ�� ������ �����ִ� HINT ����
-- INDEX ������ ���� �ε����� ����� �ε����� ����
-- UNIQUE�� �÷����� (UNIQUE INDEX)���� �ε����� ����
-- �Ϲ� �÷����� ����� �ε����� ����
-- INDEX�� ��ȸ�� ������ ����������, DML����(����,����,����)�� ���� ���Ǵ� �÷��� ������ ���� ���� ������

CREATE TABLE EMPS_IT AS (SELECT * FROM EMPLOYEES);

-- �ε����� ���� �� ��ȸ -> FULL : �� ������ ã�Ƴ� (Ȯ���� F10)
SELECT * FROM EMPS_IT WHERE FIRST_NAME = 'Nancy';

-- ����� �ε��� ���� (����)
CREATE INDEX EMPS_IT_IX ON EMPS_IT (FIRST_NAME);

-- ����� �ε��� ���� �� ��ȸ -> INDEX �������� ã�Ƴ�, BY INDEX ROWID
SELECT * FROM EMPS_IT WHERE FIRST_NAME = 'Nancy';

-- �ε��� ���� (�ε����� �����ϴ��� ���̺� ������ ��ġ�� ����)
DROP INDEX EMPS_IT_IX;

-- ���� �ε��� (���� �� �÷��� ���ÿ� �ε����� ������)
CREATE INDEX EMPS_IT_IX ON EMPS_IT (FIRST_NAME, LAST_NAME);

SELECT * FROM EMPLOYEES WHERE FIRST_NAME = 'Nancy'; -- BY INDEX ROWID
SELECT * FROM EMPLOYEES WHERE FIRST_NAME = 'Nancy' AND LAST_NAME = 'Greenberg';  -- BY INDEX ROWID
SELECT * FROM EMPLOYEES WHERE LAST_NAME = 'Greenberg'; -- BY INDEX ROWID


-- ���� �ε��� (PK, UK ������ �ڵ� ������)
CREATE UNIQUE INDEX /*�ε�����*/ ;

