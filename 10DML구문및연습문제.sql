--INSERT
--���̺� ������ ������ Ȯ���ϴ� ���
DESC DEPARTMENTS;

--1. (�߿�) 
INSERT INTO DEPARTMENTS VALUES(280, 'DEVELOPER',NULL,1700); -- �� ����
SELECT * FROM DEPARTMENTS;

--DML���� Ʈ������� �׻� ��ϵ� (Ʈ����� : ����Ÿ���̽� ó�� �۾��� ��� �Ϸ�ǰų� �ƴϸ� ��� ��ҵǰ� �Ǵ� �۾��� ����)
ROLLBACK;

--2. �÷��� ���� ������ (�߿�), ���̺�� ���� () �ȿ��ٰ� �÷��� ����
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
--UPDATE EMPS SET SALARY = 1000,  COMMISSION_PCT = 0.1; -- �̷��� COMMISSION_PCT�� �� ���� 0.1�� �ٲ�, ������ ������ ��(KEY)�� WHERE�� �־�� ��
UPDATE EMPS SET SALARY = 1000,  COMMISSION_PCT = 0.1 WHERE EMPLOYEE_ID = 148; -- UPDATE�� �⺻ ����
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


--------------------------------------------------------------------------------------

--DELETE ����
--Ʈ������� �ֱ� ������, �����ϱ� ���� �ݵ�� SELECT������ ���� ���ǿ� �ش�Ǵ� �����͸� �� Ȯ���ϴ� ���� ���� ��
SELECT * FROM EMPS WHERE EMPLOYEE_ID = 148;

DELETE FROM EMPS WHERE EMPLOYEE_ID = 148; -- ������ KEY�� ���ؼ� ����� ���� ����

--DELETE������ �������� ��
DELETE FROM EMPS WHERE EMPLOYEE_ID IN (SELECT EMPLOYEE_ID FROM EMPLOYEES WHERE DEPARTMENT_ID = 80);
ROLLBACK;

--------------------------------------------------------------------------------------

--DELETE���� ���� ����Ǵ� ���� �ƴ�
--���� ����(PK-FK)�� ���� ���̺��̶�� ������ �������� ���� (=�������Ἲ ����) 

SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;
DELETE FROM DEPARTMENTS WHERE DEPARTMENT_ID = 100; -- �긦 FK�� ����ϴ� ���� �ֱ⿡(=EMPLOYEES ���̺�) �������� ����

--------------------------------------------------------------------------------------

--MERGE�� : Ÿ�� ���̺��� �����Ͱ� ������ UPDATE, ������  INSERT������ �����ϴ� ����
--MERGE INTO - Ÿ�� ���̺�
--USING (����������) - ��ĥ ���̺� 
--ON (������ Ű)
--WHEN MATCHED THEN - ��ġ�ϴ� ���
--           UPDATE SET Ű
--WHEN NOT MATCHED THEN - ��ġ���� �ʴ� ���
--           INSERT /*INTO ����*/ (�÷�) VALUES (��)

MERGE INTO EMPS A
USING (SELECT * FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG') B
ON (A.EMPLOYEE_ID = B.EMPLOYEE_ID)
WHEN MATCHED THEN
        UPDATE SET A.SALARY = B.SALARY,
                            A.COMMISSION_PCT = B.COMMISSION_PCT,
                            A.HIRE_DATE = SYSDATE
WHEN NOT MATCHED THEN
        INSERT /*INTO ����*/ (EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
        VALUES (B.EMPLOYEE_ID, B.LAST_NAME, B.EMAIL, B.HIRE_DATE, B.JOB_ID);
        
SELECT * FROM EMPS;

-- ������������ �ٸ� ���̺��� �������� �� �ƴ϶� ���� ���� ���� �� DUAL�� �� ���� ����
MERGE INTO EMPS A
USING DUAL
ON (A.EMPLOYEE_ID >= 107) -- ����
WHEN MATCHED THEN --��ġ�ϸ�
        UPDATE SET A.SALARY = 10000,
                            A.COMMISSION_PCT = 0.1,
                            A.DEPARTMENT_ID = 100
WHEN NOT MATCHED THEN --��ġ���� ������
        INSERT (EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
        VALUES (107, 'HONG', 'EXAMPLE', SYSDATE, 'DBA');

--------------------------------------------------------------------------------------

DROP TABLE EMPS; -- ���̺� ������

-- CTAS : ���̺�  ����
CREATE TABLE EMPS AS (SELECT * FROM EMPLOYEES); -- ���̺� ����, ������ ����
SELECT * FROM EMPS;

CREATE TABLE EMPS AS (SELECT * FROM EMPLOYEES WHERE 1 = 2); -- FALSE���� ������ ����(������)�� �����
SELECT * FROM EMPS;


--------------------------------------------------------------------------------------


--���� 1.
--DEPTS���̺��� ������ INSERT �ϼ���
SELECT * FROM DEPARTMENTS;
CREATE TABLE DEPTS AS (SELECT * FROM DEPARTMENTS);
INSERT INTO DEPTS VALUES (280, '����', NULL, 1800);
INSERT INTO DEPTS VALUES (290, 'ȸ���', NULL, 1800);
INSERT INTO DEPTS VALUES (300, '����', 301, 1800);
INSERT INTO DEPTS VALUES (310, '�λ�', 302, 1800);
INSERT INTO DEPTS VALUES (320, '����', 303, 1700);

--| DEPARTMENT_ID | DEPARTMENT_NAME | MANAGER_ID | LOCATION_ID |
--| --- | --- | --- | --- |
--| 280 | ���� | null | 1800 |
--| 290 | ȸ��� | null | 1800 |
--| 300 | ���� | 301 | 1800 |
--| 310 | �λ� | 302 | 1800 |
--| 320 | ���� | 303 | 1700 |



--���� 2.
--DEPTS���̺��� �����͸� �����մϴ�
--1. department_name �� IT Support �� �������� department_name�� IT bank�� ����
--2. department_id�� 290�� �������� manager_id�� 301�� ����
--3. department_name�� IT Helpdesk�� �������� �μ����� IT Help�� , �Ŵ������̵� 303����, �������̵�
--1800���� �����ϼ���
--4. �̻�, ����, ����, �븮 �� �Ŵ������̵� 301�� �ѹ��� �����ϼ���.

UPDATE DEPTS SET DEPARTMENT_NAME = 'IT Bank' WHERE DEPARTMENT_NAME = 'IT Support';
UPDATE DEPTS SET DEPARTMENT_ID = 301 WHERE DEPARTMENT_ID = 290;
UPDATE DEPTS SET DEPARTMENT_NAME = 'IT Help', MANAGER_ID = 303, LOCATION_ID = 1800 WHERE DEPARTMENT_NAME = 'IT Helpdesk';
UPDATE DEPTS SET MANAGER_ID = 301 WHERE DEPARTMENT_ID IN (290, 300,310, 320);

--���� 3.
--������ ������ �׻� primary key�� �մϴ�, ���⼭ primary key�� department_id��� �����մϴ�.
--1. �μ��� �����θ� ���� �ϼ���
--2. �μ��� NOC�� �����ϼ���
SELECT * FROM DEPTS WHERE DEPARTMENT_NAME = '����';
DELETE FROM DEPTS WHERE DEPARTMENT_ID = 320; -- ������ KEY������ �����
SELECT * FROM DEPTS WHERE DEPARTMENT_NAME = 'NOC';
DELETE FROM DEPTS WHERE DEPARTMENT_ID = 220; -- ������ KEY������ �����


--����4
--1. Depts �纻���̺��� department_id �� 200���� ū �����͸� ������ ������.
--2. Depts �纻���̺��� manager_id�� null�� �ƴ� �������� manager_id�� ���� 100���� �����ϼ���.
--3. Depts ���̺��� Ÿ�� ���̺� �Դϴ�.
--4. Departments���̺��� �Ź� ������ �Ͼ�� ���̺��̶�� �����ϰ� Depts�� ���Ͽ�
--��ġ�ϴ� ��� Depts�� �μ���, �Ŵ���ID, ����ID�� ������Ʈ �ϰ�, �������Ե� �����ʹ� �״�� �߰����ִ� merge���� �ۼ��ϼ���.
SELECT * FROM DEPTS WHERE DEPARTMENT_ID > 200;
DELETE FROM DEPTS WHERE DEPARTMENT_ID > 200;
UPDATE DEPTS SET MANAGER_ID = 100 WHERE MANAGER_ID IS NOT NULL;

MERGE 
INTO DEPTS D
USING (SELECT * FROM DEPARTMENTS) DS
ON (D.DEPARTMENT_ID = DS.DEPARTMENT_ID)
WHEN MATCHED THEN
            UPDATE SET D.DEPARTMENT_NAME = DS.DEPARTMENT_NAME,
                                D.MANAGER_ID = DS.MANAGER_ID,
                                D.LOCATION_ID = DS.LOCATION_ID
WHEN NOT MATCHED THEN
            INSERT VALUES (DS.DEPARTMENT_ID, DS.DEPARTMENT_NAME, DS.MANAGER_ID, DS.LOCATION_ID);


--���� 5
--1. jobs_it �纻 ���̺��� �����ϼ��� (������ min_salary�� 6000���� ū �����͸� �����մϴ�)
--2. jobs_it ���̺� �Ʒ� �����͸� �߰��ϼ���
--3. obs_it�� Ÿ�� ���̺� �Դϴ�
--jobs���̺��� �Ź� ������ �Ͼ�� ���̺��̶�� �����ϰ� jobs_it�� ���Ͽ�
--min_salary�÷��� 0���� ū ��� ������ �����ʹ� min_salary, max_salary�� ������Ʈ �ϰ� ���� ���Ե�
--�����ʹ� �״�� �߰����ִ� merge���� �ۼ��ϼ���.
CREATE TABLE JOBS_IT AS (SELECT * FROM JOBS WHERE MIN_SALARY >= 6000);

INSERT INTO JOBS_IT VALUES ('IT_DEV', 'IT������',6000,20000);
INSERT INTO JOBS_IT VALUES ('NET_DEV', '��Ʈ��ũ������',5000,20000);
INSERT INTO  JOBS_IT VALUES ('SEC_DEV', '���Ȱ�����',6000,19000);
`
--| JOB_ID | JOB_TITLE | MIN_SALARY | MAX_SALARY |
--| --- | --- | --- | --- |
--| IT_DEV | ����Ƽ������ | 6000 | 20000 |
--| NET_DEV | ��Ʈ��ũ������ | 5000 | 20000 |
--| SEC_DEV | ���Ȱ����� | 6000 | 19000 |

MERGE INTO JOBS_IT JI
USING (SELECT * FROM JOBS WHERE MIN_SALARY > 0) J
ON (JI.JOB_ID = J.JOB_ID)
WHEN MATCHED THEN
        UPDATE SET JI.MIN_SALARY = J.MIN_SALARY,
                            JI.MAX_SALARY = J.MAX_SALARY
WHEN NOT MATCHED THEN
        INSERT VALUES (J.JOB_ID, J.JOB_TITLE, J.MIN_SALARY, J.MAX_SALARY);
        

SELECT * FROM JOBS_IT;

