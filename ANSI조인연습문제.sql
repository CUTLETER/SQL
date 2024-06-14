--���� ����
--
--���� 1.
--EMPLOYEES ���̺��, DEPARTMENTS ���̺��� DEPARTMENT_ID�� ����Ǿ� �ֽ��ϴ�.
--EMPLOYEES, DEPARTMENTS ���̺��� ������� �̿��ؼ� 
--���� INNER , LEFT OUTER, RIGHT OUTER, FULL OUTER ���� �ϼ���. (�޶����� ���� ���� Ȯ��)
SELECT COUNT(*)
FROM EMPLOYEES E
INNER JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID  = E.DEPARTMENT_ID;

SELECT COUNT(*)
FROM EMPLOYEES E
LEFT JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

SELECT COUNT(*)
FROM EMPLOYEES E
RIGHT JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

SELECT COUNT(*)
FROM EMPLOYEES E
FULL OUTER JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

--���� 2.
--EMPLOYEES, DEPARTMENTS ���̺��� INNER JOIN�ϼ���
--����)employee_id�� 200�� ����� �̸�, department_id�� ����ϼ���
--����)�̸� �÷��� first_name�� last_name�� ���ļ� ����մϴ�
SELECT E.EMPLOYEE_ID, CONCAT(E.FIRST_NAME||' ',E.LAST_NAME), D.DEPARTMENT_ID
FROM EMPLOYEES E
JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE EMPLOYEE_ID = 200;


--���� 3.
--EMPLOYEES, JOBS���̺��� INNER JOIN�ϼ���
--����) ��� ����� �̸��� �������̵�, ���� Ÿ��Ʋ�� ����ϰ�, �̸� �������� �������� ����
--HINT) � �÷����� ���� ����� �ִ��� Ȯ��
SELECT CONCAT(E.FIRST_NAME||' ',E.LAST_NAME), E.JOB_ID, J.JOB_TITLE
FROM EMPLOYEES E
INNER JOIN JOBS J
ON E.JOB_ID = J.JOB_ID
ORDER BY FIRST_NAME;



--���� 4.
--JOBS���̺�� JOB_HISTORY���̺��� LEFT_OUTER JOIN �ϼ���.
SELECT *
FROM JOBS J
LEFT JOIN JOB_HISTORY JH
ON J.JOB_ID = JH.JOB_ID;

--���� 5.
--Steven King�� �μ����� ����ϼ���.
SELECT CONCAT(E.FIRST_NAME||' ', E.LAST_NAME), D.DEPARTMENT_NAME
FROM EMPLOYEES E
JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE E.FIRST_NAME IN 'Steven' AND E.LAST_NAME IN 'King';


--���� 6.
--EMPLOYEES ���̺�� DEPARTMENTS ���̺��� Cartesian Product(Cross join)ó���ϼ���
SELECT COUNT(*)
FROM EMPLOYEES E
CROSS JOIN DEPARTMENTS D;

--���� 7.
--EMPLOYEES ���̺�� DEPARTMENTS ���̺��� �μ���ȣ�� �����ϰ� SA_MAN ������� �����ȣ, �̸�, 
--�޿�, �μ���, �ٹ����� ����ϼ���. (Alias�� ���)
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.SALARY, D.DEPARTMENT_NAME, L.STREET_ADRESS
FROM EMPLOYEES E  
RIGHT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
RIGHT JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
WHERE E.JOB_ID IN 'SA_MAN';


--���� 8.
--employees, jobs ���̺��� ���� �����ϰ� job_title�� 'Stock Manager', 'Stock Clerk'�� ���� ������
--����ϼ���.
SELECT *
FROM EMPLOYEES E
RIGHT JOIN JOBS J
ON E.JOB_ID = J.JOB_ID
WHERE JOB_TITLE LIKE 'Stock%';

--���� 9.
--departments ���̺��� ������ ���� �μ��� ã�� ����ϼ���. LEFT OUTER JOIN ���
SELECT *
FROM DEPARTMENTS D
LEFT JOIN EMPLOYEES E
ON D.DEPARTMENT_ID =  E.DEPARTMENT_ID
WHERE E.EMPLOYEE_ID IS NULL;

--���� 10. 
--join�� �̿��ؼ� ����� �̸��� �� ����� �Ŵ��� �̸��� ����ϼ���
--��Ʈ) EMPLOYEES ���̺�� EMPLOYEES ���̺��� �����ϼ���.
SELECT CONCAT (E.FIRST_NAME || '>', E2.FIRST_NAME)
FROM EMPLOYEES E
RIGHT JOIN EMPLOYEES E2
ON E.EMPLOYEE_ID = E2.MANAGER_ID;


--���� 11. 
--EMPLOYEES ���̺��� left join�Ͽ� ������(�Ŵ���)��, �Ŵ����� �̸�, �Ŵ����� �޿� ���� ����ϼ���
--����) �Ŵ��� ���̵� ���� ����� �����ϰ� �޿��� �������� ����ϼ���
SELECT E2.FIRST_NAME, E2.FIRST_NAME,
             E.FIRST_NAME, E.SALARY
FROM EMPLOYEES E
RIGHT JOIN EMPLOYEES E2
ON E.EMPLOYEE_ID = E2.MANAGER_ID
WHERE E2.MANAGER_ID IS NOT NULL
ORDER BY E.SALARY DESC;
