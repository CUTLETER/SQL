--���� �Լ�

-- ROUND �ݿø�
SELECT 45.923 FROM DUAL;
SELECT ROUND (45.923) FROM DUAL; -- �ڸ��� ���������� ���� ���ڸ� �ݿø�
SELECT ROUND (45.923, 0) FROM DUAL; -- 0 �� ��������
SELECT ROUND (45.923, 2) FROM DUAL; -- �Ҽ��� 2��° �ڸ����� �ݿø�
SELECT ROUND (45.923,-1) FROM DUAL; -- ���� �ݿø�

-- TRUNC ����
SELECT TRUNC (45.923),TRUNC  (45.923, 0),TRUNC (45.923, 2),TRUNC  (45.923,-1) FROM DUAL;

-- ABS ���밪 ��ȯ
-- CEIL �ø�
--FLOOR ����
SELECT ABS(-23), CEIL(3.14), FLOOR (3.14) FROM DUAL;

--MOD ������ (���� / �� ���ϸ� ��)
SELECT 5/3 FROM DUAL; -- ��
SELECT MOD (5, 3) FROM DUAL; -- ������

-------------------------------------------------------

-- ��¥ �Լ�
SELECT SYSDATE FROM DUAL; -- �� �� ��
SELECT SYSTIMESTAMP FROM DUAL; -- �� �� �� �� �� ��

--��¥�� ���굵 ������
SELECT HIRE_DATE, HIRE_DATE +1, HIRE_DATE -1 FROM EMPLOYEES; -- ���� DAY �������� ������ ��

SELECT FIRST_NAME, SYSDATE - HIRE_DATE FROM EMPLOYEES;-- �Ի��� ���� ��ĥ?
SELECT FIRST_NAME, (SYSDATE - HIRE_DATE) / 7 FROM EMPLOYEES; -- �Ի��� ���� �� ��?
SELECT FIRST_NAME, (SYSDATE - HIRE_DATE) / 365 FROM EMPLOYEES; -- �Ի��� ���� �� ��?

-- ��¥�� �ݿø��� ����
SELECT ROUND (SYSDATE), TRUNC (SYSDATE) FROM DUAL; -- ROUND 24�ð� �������� �ݿø� ��Ŵ (24�� �������� �� �������� +1)
SELECT ROUND (SYSDATE, 'MONTH'), TRUNC (SYSDATE, 'MONTH') FROM DUAL; -- �� �������� �ݿø� (�̹� ���� ���� �̻� �������� �� +1)
SELECT ROUND (SYSDATE, 'YEAR'), TRUNC (SYSDATE, 'YEAR') FROM DUAL; -- �� �������� �ݿø� (�̹� �⵵�� ���� �̻��̸� ��+1)


