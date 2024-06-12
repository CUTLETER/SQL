 -- �����ϸ� �Լ� ù��° �Ű����� ��ġ���� COLUMN���� ���ٰ� ���� ��

-- ���ڿ� �Լ�
SELECT 'HELLO WORLD' FROM DUAL; -- DUAL = SQL���� �����ϰ� �����ϱ� ���� ������ ���̺�
SELECT LOWER ('HELLO WORLD') FROM DUAL;
SELECT LOWER (FIRST_NAME), UPPER(FIRST_NAME), INITCAP(FIRST_NAME) FROM EMPLOYEES;

-- LENGTH ���ڿ� ����
SELECT FIRST_NAME, LENGTH (FIRST_NAME) FROM EMPLOYEES ORDER BY LENGTH (FIRST_NAME) DESC;

-- INSTR ���ڿ� ã��
SELECT FIRST_NAME, INSTR (FIRST_NAME, 'a') FROM EMPLOYEES; -- a�� �ִ� ��ġ�� ��ȯ�� , ������ 0�� ��ȯ��

-- SUBSTR ���ڿ� �ڸ���
SELECT FIRST_NAME, SUBSTR (FIRST_NAME, 3) FROM EMPLOYEES; -- 3��° ��ġ���� �߶��
SELECT FIRST_NAME, SUBSTR (FIRST_NAME, 3), SUBSTR (FIRST_NAME, 3, 2) FROM EMPLOYEES; --3��° ��ġ�� �������� �ι�° ��ġ���� �߶��

-- CONCAT ���ڿ� ��ġ��
SELECT FIRST_NAME ||' '|| LAST_NAME, CONCAT(FIRST_NAME,LAST_NAME) FROM EMPLOYEES;

-- LPAD, RPAD ������ �����ϰ� Ư�����ڷ� ä��
SELECT 'ABC' FROM DUAL;
SELECT LPAD ('ABC', 10, '*') FROM DUAL; -- ABC���̸� 10���� �ø��� ��� �ִ� ���� �ڸ��� *�� ä��
SELECT LPAD (FIRST_NAME, 10, '*') FROM EMPLOYEES;
SELECT RPAD (FIRST_NAME, 10, '*') FROM EMPLOYEES;

-- LTRIM, RTRIM. TRIM : ���� ���� �Ǵ� ���� ����
SELECT TRIM('     HELLO WORLD     ') FROM DUAL;
SELECT LTRIM('     HELLO WORLD     ') FROM DUAL;
SELECT RTRIM('     HELLO WORLD     ') FROM DUAL;
SELECT LTRIM ('JAVAHAHAJAVA', 'JAVA') FROM DUAL;
SELECT RTRIM ('JAVAHAHAAAAAAAAAAAAAAAAAAAAAAJAVA', 'JAVA') FROM DUAL;

--REPLACE ���ڿ� ����
SELECT REPLACE ('���� ���� �뱸 �λ� ���', ' ' , '->') FROM  DUAL; -- ������ ȭ��ǥ��
SELECT REPLACE ('���� ���� �뱸 �λ� ���', ' ', '') FROM DUAL; -- ���� ����



