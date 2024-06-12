-- ���̺���� ���� ������ -S
SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;
SELECT * FROM JOBS;

-- Ư�� �÷��� ��ȸ�ϱ�
SELECT FIRST_NAME, HIRE_DATE, EMAIL, SALARY FROM EMPLOYEES;
-- ���ڿ� ��¥�� ���� ����, ���ڴ� ������ ���ĵ�

-- �÷����� ���� �ڸ����� ���� �Ǵ� ��¥ ���굵 ������
SELECT FIRST_NAME, SALARY, SALARY + SALARY * 0.1 FROM EMPLOYEES;

-- PK�� EMPLYOEE_ID , FK�� DEPARTMENT_ID
SELECT * FROM EMPLOYEES;

-- *�����(=��Ī)*, AS ���� �����ϰ� "" �ְų� ���ų� ���� ���� �Ÿ� ""�� �����ֱ�
SELECT FIRST_NAME AS ��Ī, SALARY �޿�, SALARY + SALARY * 0.1 "���� �޿�" FROM EMPLOYEES;

-- *���ڿ� ���� ����* ||
-- Ȭ����ǥ �ȿ��� Ȭ����ǥ�� Ư�����ڷ� ���� �ʹٸ� '''
SELECT 'HELLO' || ' WORLD' FROM EMPLOYEES;
SELECT FIRST_NAME || '''���� �޿��� ' || SALARY || '$�Դϴ�.' AS �޿� FROM EMPLOYEES;

-- *DISTINCT* (�ߺ� ����) Ű����
SELECT DEPARTMENT_ID FROM EMPLOYEES;
SELECT DISTINCT DEPARTMENT_ID FROM EMPLOYEES; -- �ߺ��Ǵ� ���� �����ϰ� � ���� �ִ��� �ľ� ������

-- *ROWNUM* (��ȸ�� ����), ROWID(���ڵ尡 ����� ��ġ, ����ϸ� �����Ͱ� ����� �ּҰ� ����)
SELECT EMPLOYEE_ID, FIRST_NAME, ROWID, ROWNUM FROM EMPLOYEES;


