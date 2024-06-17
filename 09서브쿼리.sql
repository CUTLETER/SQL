-- �������� (SELECT ������ Ư�� ��ġ�� �ٽ� SELECT�� ���� ����)

-- ������ �������� :  ���������� ����� 1���� ��������
-- ����) ���ú��� �޿��� ���� ��� ã�� ��
-- 1. ���� ������ �޿��� ã�´�
SELECT * FROM EMPLOYEES WHERE FIRST_NAME = 'Nancy';
-- 2. ã�� ������ �޿��� WHERE���� �ִ´�
SELECT * FROM EMPLOYEES WHERE SALARY >= 12008;
-- ���������� �Ѳ����� �����?
SELECT * FROM EMPLOYEES WHERE SALARY >= (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'Nancy');

--����2) 103���� ������ ���� ��� ã�¹�
SELECT JOB_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = 103;
SELECT * FROM EMPLOYEES WHERE JOB_ID = (SELECT JOB_ID FROM EMPLOYEES WHERE EMPLOYEE_ID  = 103);

-- ������ �� : ���������� ���� �񱳴�� �÷��� ��Ȯ�� 1������ ��
SELECT * FROM EMPLOYEES
WHERE JOB_ID = (SELECT * FROM EMPLOYEES WHERE EMPLOYEE_ID = 103); -- ����

-- ��Ƽ���� �� ���� �� (�������� ����� 2�� �̻�)
SELECT SALARY
FROM EMPLOYEES
WHERE FIRST_NAME = 'Steven';

-- ���� ���� ������ �����̶�� ������ �������� �����ڸ� �Ἥ ó���ؾ� ��, ������XXXXXXX
SELECT SALARY FROM EMPLOYEES
WHERE SALARY >= (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'Steven'); 

----------------------------------------------------

-- ������ �������� : ������ó�� ���������� ����� 2�� �̻� ��ȯ�Ǵ� ��� IN, ANY, ALL ��� ��

-- ANY, ALL ����

SELECT SALARY
FROM EMPLOYEES
WHERE FIRST_NAME = 'David'; -- �� ���� ���̺�� (4800, 6800, 9500)

-- '���� ���� ���̺���� �޿�' ���� ���� �޴� ���
SELECT *
FROM EMPLOYEES
WHERE SALARY > ANY (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David');

-- '���� ���� ���̺���� �޿�'���� ���� �޴� ���
SELECT *
FROM EMPLOYEES
WHERE SALARY < ANY (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David');

-- '���� ���� ���̺���� �޿�'���� �� ���� �޴� ���
SELECT *
FROM EMPLOYEES
WHERE SALARY > ALL (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David');

-- '���� ���� ���̺���� �޿�'���� �� ���� �޴� ���
SELECT *
FROM EMPLOYEES 
WHERE SALARY < ALL ( SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David');

-- IN : ������ ������ �� ��ġ�ϴ� ������
-- ����) ���̺��� �μ��� ���� ���
SELECT DEPARTMENT_ID
FROM EMPLOYEES
WHERE FIRST_NAME = 'David';

SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID 
                                            FROM EMPLOYEES WHERE FIRST_NAME = 'David');

------------------------------------------------------

-- ��Į�� ���� : WHERE���� �ƴ� 'SELECT���� ���������� ����' ��� (JOIN�� ��ü��)
SELECT FIRST_NAME,
             DEPARTMENT_NAME
FROM EMPLOYEES E
LEFT JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

-- �̰� ��Į�� ������ �ٲ㺸��? (LEFT JOIN�� ����)
SELECT FIRST_NAME,
             (SELECT DEPARTMENT_NAME/*�굵 1���� �÷��� ����*/ FROM DEPARTMENTS D WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID /*JOIN�� ON ���� ����*/)
FROM EMPLOYEES E;             

-- ��Į�� ������ �ٸ� ���̺��� '1��'�� �÷��� ������ �� �� JOIN���� ������ �����
-- �Ʒ� ����ó�� ���� ���� ������ �� ���� ������ JOIN������ �������� �� ���� �� ����
SELECT FIRST_NAME,
             JOB_ID,
             (SELECT JOB_TITLE FROM JOBS J WHERE J.JOB_ID = E.JOB_ID),
             (SELECT MIN_SALARY FROM JOBS J WHERE J.JOB_ID = E.JOB_ID),
             (SELECT MAX_SALARY FROM JOBS J WHERE J.JOB_ID = E.JOB_ID)
FROM EMPLOYEES E;


-- ����
-- FIRST_NAME �÷�, DEPARTMENT_NAME, JOB_TITLE ���ÿ� ��������

--1. JOIN����
SELECT E.FIRST_NAME, D.DEPARTMENT_NAME, J.JOB_TITLE
FROM EMPLOYEES E
LEFT JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
LEFT JOIN JOBS J
ON E.JOB_ID = J.JOB_ID;

--2. ��Į�� ������
SELECT FIRST_NAME,
            (SELECT JOB_TITLE FROM JOBS J WHERE J.JOB_ID = E.JOB_ID),
            (SELECT DEPARTMENT_NAME FROM DEPARTMENTS D WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID)
FROM EMPLOYEES E;            

------------------------------------------------------------------

-- �ζ��� �� : FROM�� ������ �������� ���� ��
-- �ζ��� �信�� '���� �÷�'�� ����� �� �÷��� ���� ��ȸ�� �� �����

-- ���� ���� ���� ��ȣ �ȿ� �־ ��ġ�� ����� ����
SELECT *
FROM (); -- �� Ʋ�� ��ġ��

SELECT *
FROM EMPLOYEES;

SELECT *
FROM (SELECT *
           FROM EMPLOYEES);

----------------

SELECT ROWNUM,
             FIRST_NAME,
             SALARY
FROM EMPLOYEES
ORDER BY SALARY DESC; -- �޿� �������� ������ �Ǿ����� ROWNUM�� ���׹����� ���� 1

-- ����� ������ �ٽ� ��ȸ�ϱ�

SELECT *
FROM ();

SELECT FIRST_NAME,
             SALARY
FROM EMPLOYEES
ORDER BY SALARY DESC;

SELECT *
FROM (SELECT FIRST_NAME,
                        SALARY
            FROM EMPLOYEES
            ORDER BY SALARY DESC);

--------------------

SELECT ROWNUM,
             FIRST_NAME,
             SALARY
FROM (SELECT FIRST_NAME,
                        SALARY
           FROM EMPLOYEES
           ORDER BY SALARY DESC
           )
WHERE ROWNUM BETWEEN 1 AND 10; -- �޿� �������� ���ĵǰ� ROWNUM�� ��������� ����, �ٸ� ROWNUM ��ȸ�� ������ 1���� �����ؾ� ��

--ORDER�� ���� ��ų ����� �����, ROWNUM ���󿭷� �ٽ� ���� ��, �ٽ� ��ȸ�ϱ�

SELECT *
FROM ();


SELECT FIRST_NAME,
            SALARY
FROM EMPLOYEES
ORDER BY SALARY DESC;

SELECT *
FROM (SELECT FIRST_NAME,
            SALARY
            FROM EMPLOYEES
            ORDER BY SALARY DESC
);


SELECT ROWNUM AS ����,
                        FIRST_NAME,
                        SALARY
             FROM (
                        SELECT FIRST_NAME,
                                      SALARY
                        FROM EMPLOYEES
                        ORDER BY SALARY DESC
);

             
SELECT *
FROM ( 
            SELECT ROWNUM AS ����,
                        FIRST_NAME,
                        SALARY
             FROM (
                        SELECT FIRST_NAME,
                                      SALARY
                        FROM EMPLOYEES
                        ORDER BY SALARY DESC
    )
)
WHERE ���� BETWEEN 11 AND 20; -- �ȿ��� ������� ������ �ۿ��� ����� �� �ְ� ��


-- ����
--�ټӳ�� 5��° �Ǵ� ����鸸 ����ϱ�
--1. ���� �ټӳ����� ���� �����
SELECT FIRST_NAME, HIRE_DATE,
             TRUNC ((SYSDATE - HIRE_DATE) / 365) AS �ټӳ��
FROM EMPLOYEES
-- WHERE MOD (�ټӳ��,5)=0 ���� �߻�
ORDER BY �ټӳ�� DESC;

--2. Ʋ�� �־� ��ġ��
SELECT *
FROM (SELECT FIRST_NAME, HIRE_DATE,
             TRUNC ((SYSDATE - HIRE_DATE) / 365) AS �ټӳ��
            FROM EMPLOYEES
            ORDER BY �ټӳ�� DESC)
WHERE MOD (�ټӳ��, 5) = 0; -- �� �ȿ��� �ٽ� ��ȸ�ϱ�


-- �ζ��� �信�� ���̺� ALIAS�� ��ȸ�ϱ�

SELECT E.*,
             TRUNC ((SYSDATE - HIRE_DATE) / 365) AS �ټӳ��
FROM EMPLOYEES E
ORDER BY �ټӳ�� DESC;


SELECT ROWNUM AS ����,
             A.* --A�� ��� ���� ����Ŵ
FROM ( 
            SELECT E.*,
                         TRUNC ((SYSDATE - HIRE_DATE) / 365) AS �ټӳ��
            FROM EMPLOYEES E
            ORDER BY �ټӳ�� DESC

) A; -- FROM���� A��� ��Ī ����


