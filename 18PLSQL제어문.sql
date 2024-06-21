-- PLSQL ���

-- IF�� Ʋ
-- IF ������ THEN
--ELSIF ������ (ELSEIF XXX) THEN
-- ELSE
-- END IF;

SET SERVEROUTPUT ON;


DECLARE
        POINT NUMBER := TRUNC(DBMS_RANDOM.VALUE(1,101));
BEGIN
        DBMS_OUTPUT.PUT_LINE('���� : ' || POINT);

--        IF POINT >= 90 THEN
--            DBMS_OUTPUT.PUT_LINE('A ����');
--        ELSIF POINT >=80 THEN
--            DBMS_OUTPUT.PUT_LINE('B ����');
--        ELSIF POINT >=70 THEN
--            DBMS_OUTPUT.PUT_LINE('C ����');
--        ELSE
--            DBMS_OUTPUT.PUT_LINE('F ����');
--        END IF;

        CASE WHEN POINT >= 90 THEN DBMS_OUTPUT.PUT_LINE('A ����');
                 WHEN POINT >= 80 THEN DBMS_OUTPUT.PUT_LINE('B ����');
                 WHEN POINT >= 70 THEN DBMS_OUTPUT.PUT_LINE('C ����');
                 ELSE DBMS_OUTPUT.PUT_LINE('F ����');
        END CASE;         

END;


--------------------------------------------------------------------------------------

-- WHILE��

DECLARE
        CNT NUMBER := 1;
BEGIN
        WHILE CNT <=9
        LOOP
            DBMS_OUTPUT.PUT_LINE(' 3 X '|| CNT || ' = ' ||CNT * 3);
            
            CNT := CNT + 1;
        END LOOP;
    
END;

--------------------------------------------------------------------------------------
-- FOR��

DECLARE
BEGIN
        FOR I IN 1..9 --  ���� I�� 1���� 9����
        LOOP
--       CONTINUE WHEN I = 5; -- I �� 5 �� �������� (5�� �� ��� ����)
            DBMS_OUTPUT.PUT_LINE(' 3 X '|| I || ' = ' || I * 3);
--       EXIT WHEN I = 5; -- I �� 5 �� �ݺ��� Ż����
        END LOOP;

END;

--------------------------------------------------------------------------------------

-- 2�ܺ��� 9�ܱ��� ����ϴ� �͸� ���

DECLARE
        CNT NUMBER := 1;
BEGIN
        WHILE CNT <=9
        LOOP
            FOR I IN 2..9
            LOOP
                DBMS_OUTPUT.PUT_LINE( I ||' X '|| CNT || '=' || I * CNT);
            END LOOP;
            CNT := CNT + 1;
        END LOOP;   
END;

--------------------------------------------------------------------------------------

-- CURSOR Ŀ��

DECLARE
        NAME VARCHAR2(30);
BEGIN
        -- SELECT�� ����� ���� ���̶� ���� �߻� : �̷� �� ���� �� Ŀ��!
        SELECT FIRST_NAME 
        FROM EMPLOYEES 
        WHERE JOB_ID = 'IT_PROG';
        
        DBMS_OUTPUT.PUT_LINE(NAME);
END;

-----

DECLARE
        NM VARCHAR2(30); -- �Ϲ� ����
        SALARY NUMBER;
        CURSOR X IS SELECT FIRST_NAME, SALARY FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG';
BEGIN
        OPEN X; -- Ŀ�� ����
            DBMS_OUTPUT.PUT_LINE('---------Ŀ�� OPEN--------');
        LOOP
            FETCH X INTO NM, SALARY; -- NM ������ SALARY ���� ����
            EXIT WHEN X%NOTFOUND; -- X Ŀ���� �� �̻� ���� �����Ͱ� ������ TRUE
           
            DBMS_OUTPUT.PUT_LINE(NM);
            DBMS_OUTPUT.PUT_LINE(SALARY);
            
        END LOOP;
        
        DBMS_OUTPUT.PUT_LINE('----------Ŀ�� CLOSE---------');
        DBMS_OUTPUT.PUT_LINE('������ �� : ' || X%ROWCOUNT); -- Ŀ������ �о�� �������� ��
        
        CLOSE X; -- Ŀ�� �ݱ�
    
END;
--------------------------------------------------------------------------------------
-- ���� ����
--1. �μ��� �޿����� ����ϴ� Ŀ�������� �ۼ��غ��ô�.
DECLARE
        IDD NUMBER;
        SUMM NUMBER;
        CURSOR XX IS SELECT DEPARTMENT_ID, SUM(SALARY) FROM EMPLOYEES GROUP BY DEPARTMENT_ID ORDER BY DEPARTMENT_ID DESC;
BEGIN
        OPEN XX;
        
        LOOP
            FETCH XX INTO IDD, SUMM;
            EXIT WHEN XX%NOTFOUND;
            
            DBMS_OUTPUT.PUT_LINE('�μ� ID : '||IDD);
            DBMS_OUTPUT.PUT_LINE(' �ѱ޿� : '||SUMM);
            
        END LOOP;
        
        CLOSE XX;
END;

--2. ������̺��� ������ �޿����� ���Ͽ� EMP_SAL�� ���������� INSERT�ϴ� Ŀ�������� �ۼ��غ��ô�.
SELECT * FROM EMP_SAL;

DECLARE
        YYEAR NUMBER;
        SSUM NUMBER;
        CURSOR XXX IS SELECT A, SUM(SALARY) AS B FROM (SELECT TO_CHAR(HIRE_DATE, 'YYYY') AS A, SALARY FROM EMPLOYEES) GROUP BY A ORDER BY A;
BEGIN

--        OPEN XXX;
--        
--        LOOP
--            FETCH XXX INTO YYEAR, SSUM;
--            EXIT WHEN XXX%NOTFOUND;
--            
--            DBMS_OUTPUT.PUT_LINE('�Ի�⵵ : ' || YYEAR);
--            DBMS_OUTPUT.PUT_LINE('�ѱ޿� : ' || SSUM);
--            
--            INSERT INTO EMP_SAL (YEARS, SALARY)
--            VALUES (YYEAR, SSUM);
--        
--        END LOOP;
--        
--        CLOSE XXX;

        FOR  I IN XXX -- Ŀ���� FOR IN������ ������ ���� ������ OPEN, CLOSE ���� ��������
        LOOP
--                 DBMS_OUTPUT.PUT_LINE(I.A || ' '  || I.B); -- ���
                 INSERT INTO EMP_SAL VALUES (I.A, I.B);
                 
        END LOOP;

END;















