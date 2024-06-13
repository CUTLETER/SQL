-- ��ȯ �Լ�
-- �� ��ȯ �Լ�
-- �ڵ� �� ��ȯ�� ��������(���ڿ� ���� ��, ���ڿ� ��¥ ��)

SELECT * FROM EMPLOYEES WHERE SALARY >= '20000'; -- 20000 ���ڷ� �ᵵ �ڵ� �� ��ȯ �ż� �˻��� �� �������� ����
SELECT * FROM EMPLOYEES WHERE HIRE_DATE >= '08/01/01'; -- ���� -> ��¥ �ڵ� �� ��ȯ

-- ���� �� ��ȯ (�ڵ����� ���� ���� ��)
-- TO_CHAR -> ��¥�� ���ڷ�
SELECT TO_CHAR (SYSDATE, 'YYYY-MM-DD HH:MI:SS') AS �ð� FROM DUAL;
SELECT TO_CHAR (SYSDATE, 'YY-MM-DD AM|PM HH12:MI:SS') AS �ð� FROM DUAL;
SELECT TO_CHAR (SYSDATE, 'YYYY"��" MM"��" DD"��"') AS �ð� FROM DUAL;  --DATE ���� ���� �ƴ� ���� ������ "" �ֵ���ǥ��

--TO_CHAR -> ���ڸ� ���ڷ�
SELECT TO_CHAR (20000, '999999999') AS RESULT FROM DUAL; -- 9�ڸ� ���ڷ� ǥ�� (���� 9�� ����)
SELECT TO_CHAR (20000, '099,9999999') AS RESULT FROM DUAL; -- ������ �ڸ� 0���� ä��
SELECT TO_CHAR (20000, '999') AS RESULT FROM DUAL; -- �ڸ��� �����ϸ� ### ���
SELECT TO_CHAR (20000.123, '999999999.9999') AS RESULT FROM DUAL; -- ���� 6�ڸ�, �Ǽ� 4�ڸ�
SELECT TO_CHAR (20000, '$999,999,999') AS RESULT FROM DUAL; -- �޷�
SELECT TO_CHAR (20000, 'L999,999,999') AS RESULT FROM DUAL; -- ���� ����ȭ�� ��ȣ ǥ��

-- ������ ȯ���� 1372.17���� �� SALARY ���� ��ȭ�� ǥ���ϱ�
SELECT SALARY, TO_CHAR (SALARY * 1372.17, 'L999,999,999') AS ��ȭ FROM EMPLOYEES;

--TO DATE ���ڸ� ��¥��
SELECT TO_DATE ('2024-06-13', 'YYYY-MM-DD') FROM DUAL; -- �⺻������ ��¥ǥ������� ���ƿ�
SELECT TO_DATE ('2024�� 6�� 13��', 'YYYY"��" MM"��" DD"��"') FROM DUAL; -- ��¥ ���� ���ڰ� �ƴ϶�� "" �ֵ���ǥ��
SELECT TO_DATE ('24-06-13 11�� 30�� 23��', 'YYYY-MM-DD HH"��" MI"��" SS"��"') FROM DUAL;

--------- 2024�� 6�� 13���� ���ڷ� ��ȯ�Ѵٸ�?
SELECT TO_CHAR(TO_DATE ('240613', 'YY-MM-DD'), 'YYYY"��" MM"��" DD"��"') AS �� FROM DUAL;

--TO_NUMBER ���ڸ� ���ڷ�
SELECT '4000'-1000 FROM DUAL; -- �ڵ� �� ��ȯ
SELECT TO_NUMBER ('4000') - 1000 FROM DUAL; -- ����� �� ��ȯ
SELECT '$5,500' - 1000 FROM DUAL; -- �ڵ� �� ��ȯ �Ұ���
SELECT TO_NUMBER ('$5,500', '$9,999') - 1000 FROM DUAL; -- �ڵ� �� ��ȯ�� �Ұ����� ��쿣 ���Ŀ� ���� ���ڸ� ���ڷ� �� ��ȯ ��Ű��

---------------------------------------------------

--NULL ó�� �Լ�
--NVL (���, NULL�� ���)
SELECT NVL(1000, 0) AS �׽�Ʈ, NVL(NULL,0) AS �׽�Ʈ FROM DUAL;
SELECT NULL + 1000 FROM DUAL; -- ���ڿ��� ���꿡 NULL ���� ���� ����� NULL ����
SELECT FIRST_NAME, SALARY, COMMISSION_PCT, SALARY + SALARY * COMMISSION_PCT FROM EMPLOYEES;
SELECT FIRST_NAME, SALARY, COMMISSION_PCT, SALARY + SALARY * NVL( COMMISSION_PCT, 0 ) AS �����޿� FROM EMPLOYEES;

--NVL2 (��� ��, NULL�� �ƴ� ���, NULL�� ���)
SELECT NVL2 (NULL, 'NULL�� �ƴմϴ�', 'NULL�Դϴ�') FROM DUAL;
SELECT NVL2 (143, 'NULL�� �ƴմϴ�', 'NULL�Դϴ�') FROM DUAL;

SELECT FIRST_NAME, SALARY, COMMISSION_PCT, NVL2(COMMISSION_PCT, SALARY + SALARY * COMMISSION_PCT, SALARY) AS �����޿� FROM EMPLOYEES;

--COALESCE (��, ��, ��...)  ù��°�� NULL�� �ƴ� ���� ��ȯ ������
SELECT COALESCE(1,2,3) FROM DUAL; 
SELECT COALESCE(NULL, 2,3,4) FROM DUAL;
SELECT COALESCE(1,NULL,3,4) FROM DUAL;
SELECT COALESCE(NULL, NULL, 3, NULL, 4) FROM DUAL;
SELECT COMMISSION_PCT, COALESCE(COMMISSION_PCT,0) FROM EMPLOYEES; -- NVL�� �Ȱ���

-- DECODE (���, �񱳰�, �����, �񱳰�2, �����2, ..., ELSE��)
SELECT DECODE('A', 'A', 'A�Դϴ�') FROM DUAL; -- IF��
SELECT DECODE('X','A','A�Դϴ�', 'A�� �ƴմϴ�') FROM DUAL; -- IF~ELSE����
SELECT DECODE('B', 'A', 'A�Դϴ�'
                               , 'B', 'B�Դϴ�'
                               , 'C', 'C�Դϴ�'
                               , '���� �ƴմϴ�') 
FROM DUAL; -- IF~ELSE IF~ELSE ����


SELECT * FROM EMPLOYEES;

SELECT JOB_ID, DECODE(JOB_ID, 'IT_PROG', SALARY * 1.1
                                      , 'AD_VP', SALARY * 1.2
                                      , 'FI_MGR', SALARY * 1.3
                                      , SALARY
                                      ) AS �޿�
FROM EMPLOYEES;


-- CASE~WHEN~THEN~ELSE~END (SWITCH���� �����)
SELECT JOB_ID,
            CASE JOB_ID WHEN 'IT_PROG' THEN SALARY * 1.1
                                 WHEN 'AD_VP' THEN SALARY * 1.2
                                 WHEN 'FI_MGR' THEN SALARY * 1.3
                                 ELSE SALARY
            END AS �޿�
FROM EMPLOYEES;


-- �񱳿� ���� ������ WHEN���� �� ���� ����
SELECT JOB_ID,
            CASE WHEN JOB_ID = 'IT_PROG' THEN SALARY * 1.1
                     WHEN JOB_ID = 'AD_VP' THEN SALARY * 1.2
                     WHEN JOB_ID = 'FI_MGR' THEN SALARY * 1.3
                     ELSE SALARY
            END AS �޿�
FROM EMPLOYEES;

------------------------------------

--���� 1.
--�������ڸ� �������� EMPLOYEE���̺��� �Ի�����(hire_date)�� �����ؼ� �ټӳ���� 10�� �̻���
--����� ������ ���� ������ ����� ����ϵ��� ������ �ۼ��� ������. 
--���� 1) �ټӳ���� ���� ��� ������� ����� �������� �մϴ�.
SELECT EMPLOYEE_ID AS �����ȣ,
            CONCAT (FIRST_NAME || ' ' , LAST_NAME) AS �����,
            HIRE_DATE AS �Ի�����,
            TRUNC((SYSDATE - HIRE_DATE) / 365) AS �ټӳ�� 
            FROM EMPLOYEES
            WHERE FLOOR ((SYSDATE - HIRE_DATE) / 365) >= 10
            ORDER BY FLOOR ((SYSDATE - HIRE_DATE) / 365) DESC;

--���� 2.
--EMPLOYEE ���̺��� manager_id�÷��� Ȯ���Ͽ� first_name, manager_id, ������ ����մϴ�.
--100�̶�� �����塯 
--120�̶�� �����塯
--121�̶�� ���븮��
--122��� �����ӡ�
--�������� ������� ���� ����մϴ�.
--���� 1) �μ��� 50�� ������� ������θ� ��ȸ�մϴ�?
--���� 2) DECODE�������� ǥ���غ�����.
SELECT FIRST_NAME AS ����, 
            MANAGER_ID AS MAN_ID, DEPARTMENT_ID AS �μ�, DECODE (MANAGER_ID, 100, '����',
                                                                                 120, '����',
                                                                                 121, '�븮',
                                                                                 122, '����',
                                                                                 '���')
                                                                                 AS ����
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN 50;
                                                                                                                        
--���� 3) CASE�������� ǥ���غ�����.
SELECT FIRST_NAME AS ����, MANAGER_ID AS ID, DEPARTMENT_ID, 
            CASE MANAGER_ID WHEN 100 THEN '����'
                                          WHEN 120 THEN '����'
                                          WHEN 121 THEN '�븮'
                                          WHEN 122 THEN '����'
                                          ELSE '���'
                                          END AS ����
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN 50;


--
--
--���� 3. 
--EMPLOYEES ���̺��� �̸�, �Ի���, �޿�, ���޴�� �� ����մϴ�.
--����1) HIRE_DATE�� XXXX��XX��XX�� �������� ����ϼ���. 
--����2) �޿��� Ŀ�̼ǰ��� �ۼ�Ʈ�� ������ ���� ����ϰ�, 1300�� ���� ��ȭ�� �ٲ㼭 ����ϼ���.
--����3) ���޴���� 5�� ���� �̷�� ���ϴ�. �ټӳ���� 5�� ������ ���޴������ ����մϴ�.
--����4) �μ��� NULL�� �ƴ� �����͸� ������� ����մϴ�.
SELECT FIRST_NAME AS �̸�,
            TO_CHAR(HIRE_DATE, 'YYYY"��" MM"��" DD"��"') AS �Ի糯¥,
            TO_CHAR((SALARY + (SALARY * NVL(COMMISSION_PCT, 0)))*1300, 'L999,999,999') AS �޿�, 
            TRUNC((SYSDATE - HIRE_DATE)/365) AS �ټӳ��,
            DECODE (MOD (FLOOR((SYSDATE - HIRE_DATE)/365),5), 0, '���� ���') AS ���޿���
FROM EMPLOYEES
                         WHERE DEPARTMENT_ID IS NOT NULL;






