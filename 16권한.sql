



--               ����ŬSYS�������� ������ ��



--------------------------------------------------------------------------------------

SELECT * FROM HR.EMPLOYEES; --HR�� EMPLOYEES ���̺� ��ȯ

-- ���� ���
SELECT * FROM ALL_USERS;

-- ���� ���� Ȯ��
SELECT * FROM USER_SYS_PRIVS;


-- ���� ����
CREATE USER USER01 IDENTIFIED BY USER01; -- ID USER01, PW USER01

-- ���� �ο� (���� ����, ���̺� ���� ����, �� ���� ����, ������ ���� ���� ���� ����)
GRANT CREATE SESSION, CREATE TABLE, CREATE SEQUENCE, CREATE VIEW, CREATE PROCEDURE TO USER01; --USER01 ���� ���� �ο�

-- ���̺����̽� ���� (�����͸� �����ϴ� �������� ����), �̰� �����ؾ� USER01���� ���̺� ����, ������ ���� �� ��������
ALTER USER USER01 DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;


-- ���� ȸ��
REVOKE CREATE SESSION FROM USER01; -- ���� ������ ������

-- ���� ����
DROP USER USER01;

--------------------------------------------------------------------------------------


-- �� ROLE : ������ �׷��� ���� ���� �ο�
CREATE USER USER01 IDENTIFIED BY USER01;

GRANT CONNECT, RESOURCE TO USER01; -- Ŀ��Ʈ�� ���� ��, ���ҽ��� ���� ��, DBA�� ������ ��

ALTER USER USER01 DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;
-- 'USERS' ���̺� �����̽��� �뷮 ������ unlimited�� �����ϰڴٴ� �ǹ�









