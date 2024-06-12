SELECT * FROM EMPLOYEES;

--���� 1.
--EMPLOYEES ���̺� ���� �̸�, �Ի����� �÷����� �����ؼ� �̸������� �������� ��� �մϴ�.
SELECT FIRST_NAME, HIRE_DATE FROM EMPLOYEES ORDER BY FIRST_NAME;
--���� 1) �̸� �÷��� first_name, last_name�� �ٿ��� ����մϴ�.
SELECT CONCAT (FIRST_NAME, LAST_NAME) AS NAME, HIRE_DATE FROM EMPLOYEES ORDER BY FIRST_NAME;
--���� 2) �Ի����� �÷��� xx/xx/xx�� ����Ǿ� �ֽ��ϴ�. xxxxxx���·� �����ؼ� ����մϴ�.
SELECT CONCAT (FIRST_NAME, LAST_NAME) AS NAME, REPLACE (HIRE_DATE, '/', '') FROM EMPLOYEES ORDER BY FIRST_NAME;
--
--
--���� 2.
--EMPLOYEES ���̺� ���� phone_numbe�÷��� ###.###.####���·� ����Ǿ� �ִ�
SELECT PHONE_NUMBER FROM EMPLOYEES;
--���⼭ ó�� �� �ڸ� ���� ��� ���� ������ȣ (02)�� �ٿ� ��ȭ ��ȣ�� ����ϵ��� ������ �ۼ��ϼ���
SELECT CONCAT ('(02) ', SUBSTR(PHONE_NUMBER, '1')) FROM EMPLOYEES;
--
--
--���� 3. EMPLOYEES ���̺��� JOB_ID�� it_prog�� ����� �̸�(first_name)�� �޿�(salary)�� ����ϼ���.
SELECT FIRST_NAME, SALARY, JOB_ID FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG';
--���� 1) ���ϱ� ���� ���� �ҹ��ڷ� �Է��ؾ� �մϴ�.(��Ʈ : lower �̿�)
SELECT LOWER (FIRST_NAME),SALARY, JOB_ID FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG';
--���� 2) �̸��� �� 3���ڱ��� ����ϰ� �������� *�� ����մϴ�. 
SELECT LOWER (RPAD (SUBSTR(FIRST_NAME, 1,3), 10, '*')) AS NAME, SALARY, JOB_ID FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG';
--�� ���� �� ��Ī�� name�Դϴ�.(��Ʈ : rpad�� substr �Ǵ� substr �׸��� length �̿�)
--���� 3) �޿��� ��ü 10�ڸ��� ����ϵ� ������ �ڸ��� *�� ����մϴ�. 
SELECT LOWER (RPAD (SUBSTR(FIRST_NAME, 1,3), 10, '*')) AS NAME, RPAD(SALARY,10,'*'), JOB_ID FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG';
--�� ���� �� ��Ī�� salary�Դϴ�.(��Ʈ : lpad �̿�)


