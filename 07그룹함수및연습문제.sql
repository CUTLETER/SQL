-- �׷��Լ�
-- NULL�� ���ܵ� �����Ϳ� ���ؼ� �����
SELECT MAX(SALARY), MIN(SALARY), SUM(SALARY), AVG(SALARY), COUNT(SALARY) FROM EMPLOYEES;
--MIN�� MAX�� ��¥, ���ڿ��� �����
SELECT MIN(HIRE_DATE), MIN(FIRST_NAME) FROM EMPLOYEES;
SELECT MAX(HIRE_DATE), MAX(FIRST_NAME) FROM EMPLOYEES;
--COUNT �Լ��� �� ���� ��� ��� (��ü ���� ����, NULL�� �ƴ� ���� ����) 
SELECT COUNT(*), COUNT(COMMISSION_PCT) FROM EMPLOYEES;

--�μ��� 80���� ��� �� Ŀ�̼��� ���� ���� ���?
SELECT MAX(COMMISSION_PCT) FROM EMPLOYEES WHERE DEPARTMENT_ID = 80;

--�׷��ռ��� �Ϲ� COLUMN�̶� ���ÿ� ���XXXXXXXX �׷��Լ��� 1�ุ ����
SELECT FIRST_NAME, AVG(SALARY) FROM EMPLOYEES;
--���� ���� �ϰ� ���� �� OVER ���̸� �Ϲ� �÷��� ���ÿ� ��� ��������
SELECT FIRST_NAME, AVG(SALARY) OVER(), COUNT(*) OVER(), SUM(SALARY) OVER() FROM EMPLOYEES;

-- GROUP BY�� -> WHERE�� ORDER�� ���̿� ����� ��
SELECT DEPARTMENT_ID,
            SUM(SALARY),
            AVG(SALARY),
            MIN(SALARY),
            MAX(SALARY),
            COUNT(*)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID;

-- GROUPȭ ��Ų �÷��� SELECT������ ���� �� ����
SELECT DEPARTMENT_ID,
            FIRST_NAME
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID;

-- 2�� �̻��� �׷�ȭ (���� �׷�)
SELECT DEPARTMENT_ID, JOB_ID,
            SUM(SALARY) AS �μ��������޿�����,
            AVG(SALARY) AS �μ��������޿����,
            MIN(SALARY),
            MAX(SALARY),
            COUNT(*) AS �μ��ο���,
            COUNT(*) OVER() AS ��üī��Ʈ --COUNT(*) OVER() ����ϸ� �� ���� ������ ��� ������
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID, JOB_ID
ORDER BY DEPARTMENT_ID;

-- �׷��Լ��� WHERE�� ���� �� ����
SELECT DEPARTMENT_ID,
            AVG(SALARY)
FROM EMPLOYEES
WHERE AVG (SALARY) >=5000 --�׷��� ������ ���� ���� HAVING�̶�� ���� ����, WHERE XXXXXXXXX
GROUP BY DEPARTMENT_ID;

----------------------------------------------------------

--HAVING�� - GROUP BY�� ���ǽ� (=SELECT�� WHERE�� ����)
SELECT DEPARTMENT_ID, SUM(SALARY), COUNT(*)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING SUM (SALARY) >=100000 OR COUNT(*) >= 5;

--

SELECT DEPARTMENT_ID, JOB_ID, AVG (SALARY), COUNT(*), COUNT(COMMISSION_PCT)
FROM EMPLOYEES
WHERE JOB_ID NOT LIKE 'SA$'
GROUP BY DEPARTMENT_ID, JOB_ID
HAVING AVG(SALARY) >= 10000
ORDER BY AVG(SALARY) DESC;

-- �μ� ���̵� NULL�� �ƴ� ������ �߿��� �Ի����� 05�⵵�� ������� �޿� ���, �޿��� ���� ���ϰ�
-- ��� �޿��� 5000 �̻��� �����͸� ���ؼ� �μ� ���̵�� ��������

SELECT DEPARTMENT_ID, AVG(SALARY), SUM (SALARY)
FROM EMPLOYEES
WHERE DEPARTMENT_ID IS NOT NULL AND HIRE_DATE LIKE '05%'
GROUP BY DEPARTMENT_ID
HAVING AVG(SALARY) >= 5000 
ORDER BY DEPARTMENT_ID DESC;

---------------------------------------------------------

-- ROLLUP - GROUP BY���� �Բ� ���ǰ� ���� �׷쿡 �հ�, �Ѱ� ���� ����
SELECT DEPARTMENT_ID,
            SUM (SALARY),
            AVG (SALARY)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID;

SELECT DEPARTMENT_ID,
            SUM (SALARY),
            AVG (SALARY)
FROM EMPLOYEES
GROUP BY ROLLUP (DEPARTMENT_ID); -- ��ü �׷쿡 ���� �Ѱ�

--

SELECT DEPARTMENT_ID, 
            JOB_ID,
            SUM (SALARY),
            AVG (SALARY)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID, JOB_ID
ORDER BY DEPARTMENT_ID;

SELECT DEPARTMENT_ID, 
            JOB_ID,
            SUM (SALARY),
            AVG (SALARY)
FROM EMPLOYEES
GROUP BY ROLLUP (DEPARTMENT_ID, JOB_ID) -- �Ѱ�, �ֱ׷쿡 ���� �Ѱ� ���� ����
ORDER BY DEPARTMENT_ID;


-- CUBE - �Ѿ�, ���� �׷��� �Ѱ���� �߰���
SELECT DEPARTMENT_ID,
            JOB_ID,
            SUM(SALARY),
            AVG(SALARY)
FROM EMPLOYEES
GROUP BY CUBE (DEPARTMENT_ID, JOB_ID)
ORDER BY DEPARTMENT_ID;

-- GROUPING �Լ� - GROUP BY�� �������(���� �����ϸ鼭) ���� '0'�� ��ȯ�ϰ�, �Ѿ� �Ǵ� ť��� �������(���ٰ� �������) ���� ���� '1'�� ��ȯ��
SELECT DEPARTMENT_ID,
            JOB_ID,
            AVG(SALARY),
            GROUPING (DEPARTMENT_ID),
            GROUPING (JOB_ID)
FROM EMPLOYEES
GROUP BY ROLLUP (DEPARTMENT_ID, JOB_ID)
ORDER BY DEPARTMENT_ID;

SELECT DECODE ( GROUPING (DEPARTMENT_ID), 1, '�Ѱ�', DEPARTMENT_ID),
            DECODE (GROUPING (JOB_ID), 1, '�Ұ�', JOB_ID),
            AVG(SALARY),
            GROUPING (DEPARTMENT_ID),
            GROUPING (JOB_ID)
FROM EMPLOYEES
GROUP BY ROLLUP (DEPARTMENT_ID, JOB_ID)
ORDER BY DEPARTMENT_ID;




-- ���� ����

--���� 1.
--��� ���̺��� JOB_ID�� ��� ���� ���ϼ���.
--��� ���̺��� JOB_ID�� ������ ����� ���ϼ���. ������ ��� ������ �������� �����ϼ���.
--�ÿ� ���̺��� JOB_ID�� ���� ���� �Ի����� ���ϼ���. JOB_ID�� �������� �����ϼ���.
SELECT JOB_ID, AVG (SALARY), COUNT(*)
FROM EMPLOYEES
GROUP BY JOB_ID
ORDER BY JOB_ID DESC, AVG (SALARY) DESC;

SELECT JOB_ID, MIN(HIRE_DATE)
FROM EMPLOYEES
GROUP BY JOB_ID
ORDER BY  MIN(HIRE_DATE);


--���� 2.
--��� ���̺��� �Ի� �⵵ �� ��� ���� ���ϼ���.
SELECT TO_CHAR(HIRE_DATE, 'YY'), COUNT(*)
FROM EMPLOYEES
GROUP BY TO_CHAR(HIRE_DATE, 'YY');


--���� 3.
--�޿��� 1000 �̻��� ������� �μ��� ��� �޿��� ����ϼ���. �� �μ� ��� �޿��� 2000�̻��� �μ��� ���
SELECT DEPARTMENT_ID, TRUNC (AVG (SALARY),0)
FROM EMPLOYEES
WHERE SALARY >= 1000
GROUP BY DEPARTMENT_ID
HAVING AVG (SALARY) >= 2000;


--
--���� 4.
--��� ���̺��� commission_pct(Ŀ�̼�) �÷��� null�� �ƴ� �������
--department_id(�μ���) salary(����)�� ���, �հ�, count�� ���մϴ�.
--���� 1) ������ ����� Ŀ�̼��� �����Ų �����Դϴ�.
--���� 2) ����� �Ҽ� 2° �ڸ����� ���� �ϼ���.
SELECT DEPARTMENT_ID, 
             TRUNC (AVG (SALARY+(SALARY*COMMISSION_PCT)), 2), SUM (SALARY), COUNT(*)
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NOT NULL
GROUP BY DEPARTMENT_ID;


--���� 5.
--�μ����̵� NULL�� �ƴϰ�, �Ի����� 05�⵵ �� ������� �μ� �޿���հ�, �޿��հ踦 ��ձ��� ���������մϴ�
--����) ����� 10000�̻��� �����͸�
SELECT DEPARTMENT_ID, AVG(SALARY), SUM(SALARY)
FROM EMPLOYEES
WHERE DEPARTMENT_ID IS NOT NULL AND HIRE_DATE LIKE '05%'
GROUP BY DEPARTMENT_ID
HAVING AVG(SALARY) >= 10000
ORDER BY AVG (SALARY) DESC;


--���� 6.
--������ ������, ���հ踦 ����ϼ���
SELECT DECODE(GROUPING (JOB_ID), 1, '�հ�', JOB_ID), SUM(SALARY), AVG(SALARY)
FROM EMPLOYEES
GROUP BY ROLLUP(JOB_ID)
ORDER BY JOB_ID;


--���� 7.
--�μ���, JOB_ID�� �׷��� �Ͽ� ��Ż, �հ踦 ����ϼ���.
--GROUPING() �� �̿��Ͽ� �Ұ� �հ踦 ǥ���ϼ���

SELECT DECODE (GROUPING (DEPARTMENT_ID), 1, '�հ�', DEPARTMENT_ID),
             DECODE (GROUPING (JOB_ID), 1, '�Ұ�', JOB_ID),
             AVG(SALARY)
FROM EMPLOYEES
GROUP BY ROLLUP (DEPARTMENT_ID, JOB_ID)
ORDER BY SUM (SALARY);
