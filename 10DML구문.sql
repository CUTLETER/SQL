--INSERT
--���̺� ������ ������ Ȯ���ϴ� ���
DESC DEPARTMENTS;

--1. (�߿�) 
INSERT INTO DEPARTMENTS VALUES(280, 'DEVELOPER',NULL,1700); -- �� ����
SELECT * FROM DEPARTMENTS;

--DML���� Ʈ������� �׻� ��ϵ� (Ʈ����� : ����Ÿ���̽� ó�� �۾��� ��� �Ϸ�ǰų� �ƴϸ� ��� ��ҵǰ� �Ǵ� �۾��� ����)
ROLLBACK;

--2. �÷��� ���� ������ (�߿�)
INSERT INTO DEPARTMENTS (DEPARTMENT_ID, DEPARTMENT_NAME, LOCATION_ID) VALUES (280, 'DEVELOPER', 1700);
ROLLBACK;

--INSERT������ �������� (������)
INSERT INTO DEPARTMENTS(DEPARTMENT_ID, DEPARTMENT_NAME) VALUES ((SELECT MAX(DEPARTMENT_ID) +10 FROM DEPARTMENTS)/*=������ ��������*/, 'DEV' );
ROLLBACK;

-- ����Ŀ�� (���� ��)
CREATE TABLE EMPS AS (SELECT * FROM EMPLOYEES WHERE 1=2); -- ���̺� ���� ����
SELECT * FROM EMPS; -- Ʋ�� ����� ���� -> ���� ���̺��� Ư�� �����͸� ������ ����

INSERT INTO EMPS(EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
(SELECT EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID FROM EMPLOYEES WHERE JOB_ID = 'SA_MAN');

COMMIT; --Ʈ������� �ݿ��� (�����Ͱ� ���� �����)

--------------------------------------------------------------------------------------

--UPDATE
SELECT * FROM EMPS;
-- ������Ʈ ������ ����ϱ� ������ SELECT�� �ش� ���� '������' ������ Ȯ���ϰ� ������Ʈ ó���ؾ� ��
--UPDATE EMPS SET SALARY = 1000,  COMMISSION_PCT = 0.1; -- �̷��� COMMISSION_PCT�� �� ���� 0.1�� �ٲ�, ������ ������ ���� WHERE�� �־�� ��
UPDATE EMPS SET SALARY = 1000,  COMMISSION_PCT = 0.1 WHERE EMPLOYEE_ID = 148;
UPDATE EMPS SET SALARY = NVL (SALARY, 0) + 1000 WHERE EMPLOYEE_ID >= 145;


--������Ʈ ������ ����������
--1.���ϰ� ��������
UPDATE EMPS SET SALARY = (SELECT SALARY FROM EMPLOYEES WHERE EMPLOYEE_ID  = 100) WHERE EMPLOYEE_ID = 148;
--2.���� �� ��������
UPDATE EMPS 
SET (SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID) 
= (SELECT SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = 100) WHERE EMPLOYEE_ID = 148;
--3. WHERE������ �������� ������
UPDATE EMPS
SET SALARY = 1000
WHERE EMPLOYEE_ID IN (SELECT EMPLOYEE_ID FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG');



