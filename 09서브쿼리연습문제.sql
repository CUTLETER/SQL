-- ���� ����

--���� 1.
--EMPLOYEES ���̺��� ��� ������� ��ձ޿����� ���� ������� �����͸� ��� �ϼ��� ( AVG(�÷�) ���)
--EMPLOYEES ���̺��� ��� ������� ��ձ޿����� ���� ������� ���� ����ϼ���
--EMPLOYEES ���̺��� job_id�� IT_PFOG�� ������� ��ձ޿����� ���� ������� �����͸� ����ϼ���.
SELECT *
FROM EMPLOYEES
WHERE SALARY > ALL (SELECT AVG(SALARY) FROM EMPLOYEES);

SELECT COUNT(*)
FROM EMPLOYEES
WHERE SALARY > ALL (SELECT AVG(SALARY) FROM EMPLOYEES);

SELECT *
FROM EMPLOYEES
WHERE SALARY > ALL (SELECT AVG(SALARY) FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG');


--���� 2.
--DEPARTMENTS���̺��� manager_id�� 100�� ����� department_id(�μ����̵�) ��
--EMPLOYEES���̺��� department_id(�μ����̵�) �� ��ġ�ϴ� ��� ����� ������ �˻��ϼ���.
SELECT *
FROM EMPLOYEES E
WHERE MANAGER_ID = (SELECT MANAGER_ID  FROM DEPARTMENTS D WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID AND D.MANAGER_ID = 100);

--*************************************���� 3.
--- EMPLOYEES���̺��� ��Pat���� manager_id���� ���� manager_id�� ���� ��� ����� �����͸� ����ϼ���
--- EMPLOYEES���̺��� ��James��(2��)���� manager_id�� ���� ��� ����� �����͸� ����ϼ���.
--- Steven�� ������ �μ��� �ִ� ������� ������ּ���.
--- Steven�� �޿����� ���� �޿��� �޴� ������� ����ϼ���.
SELECT *
FROM EMPLOYEES
WHERE MANAGER_ID > (SELECT MANAGER_ID FROM EMPLOYEES WHERE FIRST_NAME = 'Pat');

SELECT *
FROM EMPLOYEES
WHERE MANAGER_ID IN (SELECT MANAGER_ID FROM EMPLOYEES WHERE FIRST_NAME = 'James');


SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID FROM EMPLOYEES WHERE FIRST_NAME = 'Steven');

SELECT *
FROM EMPLOYEES
WHERE SALARY > ANY (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'Steven');



--���� 4.
--EMPLOYEES���̺� DEPARTMENTS���̺��� left �����ϼ���
--����) �������̵�, �̸�(��, �̸�), �μ����̵�, �μ��� �� ����մϴ�.
--����) �������̵� ���� �������� ����
SELECT E.EMPLOYEE_ID, CONCAT(E.FIRST_NAME ||' ', E.LAST_NAME), D.DEPARTMENT_ID, D.DEPARTMENT_NAME
FROM EMPLOYEES E
LEFT JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
ORDER BY EMPLOYEE_ID;


--���� 5.
--���� 4�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
SELECT EMPLOYEE_ID, CONCAT (FIRST_NAME||' ', LAST_NAME), DEPARTMENT_ID,
                                    (SELECT DEPARTMENT_NAME 
                                     FROM DEPARTMENTS D 
                                     WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID) 
FROM EMPLOYEES E
ORDER BY EMPLOYEE_ID;



--���� 6.
--DEPARTMENTS���̺� LOCATIONS���̺��� left �����ϼ���
--����) �μ����̵�, �μ��̸�, ��Ʈ��_��巹��, ��Ƽ �� ����մϴ�
--����) �μ����̵� ���� �������� ����
SELECT D.DEPARTMENT_ID, D.DEPARTMENT_NAME, L.STREET_ADDRESS, L.CITY
FROM DEPARTMENTS D
LEFT JOIN LOCATIONS L
ON D.LOCATION_ID = L.LOCATION_ID;

--���� 7.
--���� 6�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
SELECT D.DEPARTMENT_ID, D.DEPARTMENT_NAME, 
            (SELECT L.STREET_ADDRESS
            FROM LOCATIONS L 
            WHERE D.LOCATION_ID = L.LOCATION_ID),
            (SELECT L.CITY
            FROM LOCATIONS L
            WHERE D.LOCATION_ID = L.LOCATION_ID)
FROM DEPARTMENTS D;

--���� 8.
--LOCATIONS���̺� COUNTRIES���̺��� ��Į�� ������ ��ȸ�ϼ���.
--����) �����̼Ǿ��̵�, �ּ�, ��Ƽ, country_id, country_name �� ����մϴ�
--����) country_name���� �������� ����
SELECT L.LOCATION_ID, L.STREET_ADDRESS, 
            (SELECT C.COUNTRY_ID 
            FROM COUNTRIES C 
            WHERE L.COUNTRY_ID = C.COUNTRY_ID),
            (SELECT C.COUNTRY_NAME
            FROM COUNTRIES C
            WHERE L.COUNTRY_ID = C.COUNTRY_ID)
FROM LOCATIONS L;

--------------------------------------------------------------------------------------
--���� 9.
--EMPLOYEES���̺� ���� first_name�������� �������� �����ϰ�, 41~50��° �������� �� ��ȣ, �̸��� ����ϼ���
SELECT *
FROM ();

SELECT *
FROM EMPLOYEES
ORDER BY FIRST_NAME DESC;

SELECT ROWNUM AS ����, A.*
FROM (SELECT *
FROM EMPLOYEES
ORDER BY FIRST_NAME DESC
) A;

SELECT ����, FIRST_NAME
FROM (SELECT ROWNUM AS ����, A.*
FROM (SELECT *
FROM EMPLOYEES
ORDER BY FIRST_NAME DESC
    ) A
)
WHERE  ���� BETWEEN 41 AND 50;


--���� 10.
--EMPLOYEES���̺��� hire_date�������� �������� �����ϰ�, 31~40��° �������� �� ��ȣ, ���id, �̸�, ��ȣ, 
--�Ի����� ����ϼ���.

SELECT *
FROM ();

SELECT *
FROM EMPLOYEES
ORDER BY HIRE_DATE;


SELECT ROWNUM AS ����, A.*
FROM (SELECT *
            FROM EMPLOYEES
            ORDER BY HIRE_DATE
)A;


SELECT ����, EMPLOYEE_ID, CONCAT (FIRST_NAME||' ', LAST_NAME), PHONE_NUMBER
FROM (SELECT ROWNUM AS ����,
                       A.*
            FROM (SELECT *
                       FROM EMPLOYEES
                       ORDER BY HIRE_DATE
    ) A
)
WHERE ���� BETWEEN 31 AND 40;


--���� 11.
--COMMITSSION�� ������ �޿��� ���ο� �÷����� ����� 10000���� ū ������� �̾� ������. (�ζ��κ並 ���� �˴ϴ�)


SELECT *
FROM (SELECT FIRST_NAME, SALARY, (SALARY + SALARY * NVL(COMMISSION_PCT,0)) AS "�ѱ޿�"
            FROM EMPLOYEES

) 
WHERE �ѱ޿� > 10000;

--------------------------------------------------------------------------------------

--����12
--EMPLOYEES���̺�, DEPARTMENTS ���̺��� left�����Ͽ�, �Ի��� �������� �������� 10-20��° �����͸� ����մϴ�.
--����) rownum�� �����Ͽ� ��ȣ(ROWNUM), �������̵�, �̸�, �Ի���, �μ��̸� �� ����մϴ�.
--����) hire_date�� �������� �������� ���� �Ǿ�� �մϴ�. rownum�� �������� �ȵǿ�.

----------------������ ����

SELECT *
FROM ();

SELECT E.EMPLOYEE_ID,
             CONCAT (FIRST_NAME ||' ', LAST_NAME) AS NAME,
            HIRE_DATE,
            DEPARTMENT_NAME
FROM EMPLOYEES E
LEFT JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
ORDER BY HIRE_DATE;

SELECT ROWNUM AS ����,
             A.*
FROM (
        SELECT E.EMPLOYEE_ID,
                     CONCAT (FIRST_NAME ||' ', LAST_NAME) AS NAME,
                    HIRE_DATE,
                    DEPARTMENT_NAME
        FROM EMPLOYEES E
        LEFT JOIN DEPARTMENTS D
        ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
        ORDER BY HIRE_DATE
) A;

SELECT *
FROM (
        SELECT ROWNUM AS ����,
                     A.*
        FROM (
                SELECT E.EMPLOYEE_ID,
                             CONCAT (FIRST_NAME ||' ', LAST_NAME) AS NAME,
                            HIRE_DATE,
                            DEPARTMENT_NAME
                FROM EMPLOYEES E
                LEFT JOIN DEPARTMENTS D
                ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
                ORDER BY HIRE_DATE
        ) A
)
WHERE ���� BETWEEN 10 AND 20;

-------------------- ���������� ����

SELECT EMPLOYEE_ID,
             CONCAT (FIRST_NAME ||' ', LAST_NAME) AS NAME,
             HIRE_DATE,
             DEPARTMENT_ID
FROM EMPLOYEES E
ORDER BY HIRE_DATE;

SELECT ROWNUM AS ����,
             A.*,
             (SELECT DEPARTMENT_NAME FROM DEPARTMENTS D WHERE A.DEPARTMENT_ID = D.DEPARTMENT_ID) AS DEPARTMENT_NAME
FROM ( -- �ζ��κ� ��ü�� ���̺�� ����
        SELECT EMPLOYEE_ID,
                     CONCAT (FIRST_NAME ||' ', LAST_NAME) AS NAME,
                     HIRE_DATE,
                     DEPARTMENT_ID
        FROM EMPLOYEES E
        ORDER BY HIRE_DATE
) A;

SELECT *
FROM (
    SELECT ROWNUM AS ����,
                 A.*,
                 (SELECT DEPARTMENT_NAME FROM DEPARTMENTS D WHERE A.DEPARTMENT_ID = D.DEPARTMENT_ID) AS DEPARTMENT_NAME
    FROM ( -- �ζ��κ� ��ü�� ���̺�� ����
            SELECT EMPLOYEE_ID,
                         CONCAT (FIRST_NAME ||' ', LAST_NAME) AS NAME,
                         HIRE_DATE,
                         DEPARTMENT_ID
            FROM EMPLOYEES E
            ORDER BY HIRE_DATE
    ) A
)
WHERE ���� BETWEEN 10 AND 20;




--����13
--SA_MAN ����� �޿� �������� �������� ROWNUM�� �ٿ��ּ���.
--����) SA_MAN ������� ROWNUM, �̸�, �޿�, �μ����̵�, �μ����� ����ϼ���.

----------------------������ �� �������� (���� ���� ����� �ƴ�, ���� �پ��ϰ� �ϰ���)
SELECT ROWNUM AS ����,   
             A.*,
             D.DEPARTMENT_NAME
FROM ( -- �ζ��� ��� ���̺� �ڸ� ���� �� (JOIN �����̵� ����)
        SELECT FIRST_NAME,
                     SALARY,
                     DEPARTMENT_ID
        FROM EMPLOYEES
        WHERE JOB_ID = 'SA_MAN'
        ORDER BY SALARY DESC
) A
LEFT JOIN DEPARTMENTS D
ON A.DEPARTMENT_ID = D.DEPARTMENT_ID;


--����14
--DEPARTMENTS���̺��� �� �μ��� �μ���, �Ŵ������̵�, �μ��� ���� �ο��� �� ����ϼ���.
--����) �ο��� ���� �������� �����ϼ���.
--����) ����� ���� �μ��� ������� ���� �ʽ��ϴ�.
--��Ʈ) �μ��� �ο��� ���� ���Ѵ�. �� ���̺��� �����Ѵ�.

SELECT DEPARTMENT_ID, COUNT(*)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
ORDER BY COUNT(*) DESC;


SELECT D.DEPARTMENT_NAME, MANAGER_ID, A.*
FROM (
        SELECT DEPARTMENT_ID, COUNT(*) AS COUNT
        FROM EMPLOYEES
        GROUP BY DEPARTMENT_ID
)A
JOIN DEPARTMENTS D
ON A.DEPARTMENT_ID = D.DEPARTMENT_ID
ORDER BY A.COUNT DESC;


--����15
--�μ��� ��� �÷�, (�ּ�, �����ȣ - LOCATIONS �÷�), �μ��� ��� ������ ���ؼ� ����ϼ���.
--����) �μ��� ����� ������ 0���� ����ϼ���

SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;
SELECT * FROM LOCATIONS;

SELECT DEPARTMENT_ID, NVL(TRUNC(AVG(SALARY)),0)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID; -- �μ��� ��� ����

SELECT *
FROM(
        SELECT D.*, L.STREET_ADDRESS, L.POSTAL_CODE
        FROM DEPARTMENTS D
        LEFT JOIN LOCATIONS L
        ON D.LOCATION_ID = L.LOCATION_ID
) B
JOIN (
        SELECT DEPARTMENT_ID, NVL(TRUNC(AVG(SALARY)),0)
        FROM EMPLOYEES E
        GROUP BY DEPARTMENT_ID
) AVG ON B.DEPARTMENT_ID = AVG.DEPARTMENT_ID;

--����16
--���� 15����� ���� DEPARTMENT_ID�������� �������� �����ؼ� ROWNUM�� �ٿ� 1-10������ ������
--����ϼ���

SELECT ROWNUM, A.*
FROM(
        SELECT *
        FROM(
                SELECT D.*, L.STREET_ADDRESS, L.POSTAL_CODE
                FROM DEPARTMENTS D
                LEFT JOIN LOCATIONS L
                ON D.LOCATION_ID = L.LOCATION_ID
        ) B
        JOIN (
                SELECT DEPARTMENT_ID, NVL(TRUNC(AVG(SALARY)),0)
                FROM EMPLOYEES E
                GROUP BY DEPARTMENT_ID
        ) 
        AVG ON B.DEPARTMENT_ID = AVG.DEPARTMENT_ID
        ORDER BY B.DEPARTMENT_ID DESC
)A
WHERE ROWNUM BETWEEN 1 AND 10;

