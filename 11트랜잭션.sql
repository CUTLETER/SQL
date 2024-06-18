--Ʈ�����
--���� DML���� ���ؼ��� Ʈ������� ������ �� ���� (DDL���� �����Ű�ڸ��� �ٷ� �ݿ���)

--���� Ŀ�� Ȯ��
SHOW AUTOCOMMIT;
--���� Ŀ�� ON
SET AUTOCOMMIT ON;
SET AUTOCOMMIT OFF; -- ������ ����

-----------------------

SELECT * FROM DEPTS;

DELETE FROM DEPTS WHERE DEPARTMENT_ID = 10;
SAVEPOINT DEPT10; -- ������ ���� ���� ����, Ʈ������� �Ͼ ����

DELETE FROM DEPTS WHERE DEPARTMENT_ID = 20;
SAVEPOINT DEPT20;

DELETE FROM DEPTS WHERE DEPARTMENT_ID = 30;

ROLLBACK TO DEPT20; -- 30�� ��Ƴ�
ROLLBACK TO DEPT10; -- 20������ ��Ƴ�
ROLLBACK; -- ������ Ŀ�� ���ķ� ���ư�

-- ���� �ϴ� �Ǽ�
INSERT INTO DEPTS VALUES (280, 'AA', NULL, 1800); -- �����Ͱ� �ӽ� ����� ����
COMMIT; -- �����Ͱ� ���� �ݿ���

-- Ʈ����� 4��Ģ ACID (SQLD ���迡 ����)

