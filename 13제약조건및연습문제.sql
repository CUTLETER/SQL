-- ���� ���� (�÷��� ���� ������ ����, ����, ���� �� �̻� ������ �����ϱ� ���� ����)
-- PRIMARY KEY : ���̺��� ���� ������ KEY, �ߺ� X, NULL X, ���̺� �ȿ��� ONLY ONE
-- NOT NULL : NULL�� ������� ����
-- UNIQUE KEY : �ߺ� X, NULL O
-- FOREIGN KEY : �����ϴ� ���̺��� PK�� �־���� Ű, �ߺ� O, NULL O
-- CHECK : �÷��� ���� ������ ����

-- ��ü ���� ���� Ȯ��
SELECT * FROM USER_CONSTRAINTS;

DROP TABLE DEPTS;

-- (�� ���� ���� ����)
CREATE TABLE DEPTS (
        DEPT_NO NUMBER (2)            CONSTRAINT DEPTS_DEPT_NO_PK PRIMARY KEY,
        DEPT_NAME VARCHAR2(30) /*CONSTRAINT DEPS_DEPT_NAME_NN -- 'NOT NULL'���� ���� ����*/ NOT NULL,
        DEPT_DATE DATE                   DEFAULT SYSDATE, -- ���� ������ �ƴ� (�÷��� �⺻��)
        DEPT_PHONE VARCHAR2(30)  CONSTRAINT DEPTS_DEPT_PHONE_UK UNIQUE,
        DEPT_GENDER CHAR(1)         CONSTRAINT DEPTS_DEPT_GENDER_CK CHECK( /*����*/ DEPT_GENDER IN ('F','M')),
        LOCA_ID NUMBER(4)              CONSTRAINT DEPTS_LOCA_ID_FK REFERENCES /*���� ���̺� (��Ű)*/ LOCATIONS (LOCATION_ID)
);

INSERT INTO DEPTS (DEPT_NO, DEPT_NAME, DEPT_PHONE, DEPT_GENDER, LOCA_ID) 
VALUES (1, NULL, '01012345678', 'F', 1700); -- DEPT_NAME�� NOT NULL ���࿡ �����

INSERT INTO DEPTS (DEPT_NO, DEPT_NAME, DEPT_PHONE, DEPT_GENDER, LOCA_ID) 
VALUES (1, 'HONG', '01012345678', 'X', 1700); -- DEPT_GENDER�� CHECK ���࿡ �����

INSERT INTO DEPTS (DEPT_NO, DEPT_NAME, DEPT_PHONE, DEPT_GENDER, LOCA_ID) 
VALUES (1, 'HONG', '01012345678', 'F', 100); -- LOCA_ID�� ���� ���࿡ �����

INSERT INTO DEPTS (DEPT_NO, DEPT_NAME, DEPT_PHONE, DEPT_GENDER, LOCA_ID) 
VALUES (1, 'HONG', '01012345678', 'F', 1700); -- ����!


-- (���̺� ���� ���� ����)
DROP TABLE DEPTS;
CREATE TABLE DEPTS (
        DEPT_NO NUMBER(2),
        DEPT_NAME VARCHAR2 (30) NOT NULL, --NOT NULL �� �� ������ ���� 
        DEPT_DATE DATE DEFAULT SYSDATE,
        DEPT_PHONE VARCHAR2(30),
        DEPT_GENDER CHAR(1),
        LOCA_ID NUMBER(4),
        CONSTRAINT DEPT_DEPT_NO_PK PRIMARY KEY (DEPT_NO/*, DEPT_NAME*/), -- �÷��� (����Ű(2�� �̻��� �÷��� PK�� ���� ��)�� ���̺� ������ ���� ������)
        CONSTRAINT DEPT_DEPT_PHONE_UK UNIQUE (DEPT_PHONE),
        CONSTRAINT DEPT_GENDER_CK CHECK (DEPT_GENDER IN ('F','M')),
        CONSTRAINT DEPT_LOCA_ID_FK FOREIGN KEY (LOCA_ID) REFERENCES LOCATIONS (LOCATION_ID)      
);

DROP TABLE DEPTS;

--------------------------------------------------------------------------------------

-- ALTER�� ���� ���� �߰�
CREATE TABLE DEPTS (
        DEPT_NO NUMBER(2),
        DEPT_NAME VARCHAR2 (30),
        DEPT_DATE DATE DEFAULT SYSDATE,
        DEPT_PHONE VARCHAR2(30),
        DEPT_GENDER CHAR(1),
        LOCA_ID NUMBER(4)
);
--PK �߰�
ALTER TABLE DEPTS ADD CONSTRAINT DEPT_DEPT_NO_PK PRIMARY KEY (DEPT_NO);

--NOT NULL�� �� ���� (MODIFY)�� �߰�
ALTER TABLE DEPTS MODIFY DEPT_NAME VARCHAR2(30) NOT NULL;

--UNIQUE �߰�
ALTER TABLE DEPTS ADD CONSTRAINT DEPT_DEPT_PHONE_UK UNIQUE (DEPT_PHONE);

--FK �߰�
ALTER TABLE DEPTS ADD CONSTRAINT DEPT_LOCA_ID_FK FOREIGN KEY (LOCA_ID) REFERENCES LOCATIONS (LOCATION_ID);

--CHECK �߰�
ALTER TABLE DEPTS ADD CONSTRAINT DEPT_DEPT_GENDER_CK CHECK(DEPT_GENDER IN ('F', 'M'));

--���� ���� ���� DROP
ALTER TABLE DEPTS DROP CONSTRAINT DEPT_DEPT_GENDER_CK;

--------------------------------------------------------------------------------------
-- ���� ����


--����1.
--������ ���� ���̺��� �����ϰ� �����͸� insert�غ�����.
CREATE TABLE MEM (
        M_NAME VARCHAR2(20) NOT NULL,
        M_NUM NUMBER(2)        CONSTRAINT MEM_MEMNUM_PK PRIMARY KEY,
        REG_DATE DATE            CONSTRAINT MEM_REGDATE_UK UNIQUE ,
        GENDER CHAR(1)           CONSTRAINT MEM_GENDER_CK CHECK (GENDER IN ('F','M')),
        LOCA NUMBER(4)           CONSTRAINT MEM_LOCA_LOC_LOCID_FK REFERENCES LOCATIONS (LOCATION_ID)
);

SELECT * FROM MEM;
INSERT INTO MEM VALUES ('AAA',1, TO_DATE('2018-07-01', 'YYYY-MM-DD'),'M',1800);
INSERT INTO MEM VALUES ('BBB',2,TO_DATE('2018-07-02', 'YYYY-MM-DD'),'F',1900);
INSERT INTO MEM VALUES ('CCC',3,TO_DATE('2018-07-03', 'YYYY-MM-DD'),'M',2000);
INSERT INTO MEM VALUES ('DDD',4,SYSDATE,'M',2000);
INSERT INTO MEM VALUES ('EEE',5,'2018-07-04','M',2000);

DELETE FROM MEM WHERE M_NAME = 'DDD';

--���̺� ���������� �Ʒ��� �����ϴ�. 
--����) M_NAME �� ���������� 20byte, �ΰ��� ������� ����
--����) M_NUM �� ������ 5�ڸ�, PRIMARY KEY �̸�(mem_memnum_pk) 
--����) REG_DATE �� ��¥��, �ΰ��� ������� ����, UNIQUE KEY �̸�:(mem_regdate_uk)
--����) GENDER ���������� 1byte, CHECK���� (M, F)
--����) LOCA ������ 4�ڸ�, FOREIGN KEY ? ���� locations���̺�(location_id) �̸�:(mem_loca_loc_locid_fk)

--| M_NAME | M_NUM | REG_DATE | GENDER | LOCA |
--| --- | --- | --- | --- | --- |
--| AAA | 1 | 2018-07-01 | M | 1800 |
--| BBB | 2 | 2018-07-02 | F | 1900 |
--| CCC | 3 | 2018-07-03 | M | 2000 |
--| DDD | 4 | ���ó�¥ | M | 2000 |

--����2.
--���� �뿩 �̷� ���̺��� �����Ϸ� �մϴ�.
--���� �뿩 �̷� ���̺���
--�뿩��ȣ(����) PK, ���⵵����ȣ(����), �뿩��(��¥), �ݳ���(��¥), �ݳ�����(Y/N)
--�� �����ϴ�.
--������ ���̺��� ������ ������.

CREATE TABLE BOOK (
        B_NUM NUMBER(2)                  CONSTRAINT BOOK_B_NUM_PK PRIMARY KEY,
        B_NUMBERING VARCHAR2(30) CONSTRAINT BOOK_B_NUMBERING_UK UNIQUE,
        B_START DATE,
        B_END DATE,
        B_YN CHAR(1)                          CONSTRAINT BOOK_B_YN CHECK (B_YN IN ('Y','N'))
);

INSERT INTO BOOK VALUES (1,'��.23.��',TO_DATE('2300-01-01', 'YYYY-MM-DD'), TO_DATE('2400-12-31','YYYY-MM-DD'),'Y');
INSERT INTO BOOK VALUES (2, '��.354.��', TO_DATE('2024-06-18', 'YYYY-MM-DD'), TO_DATE('2030-06-18', 'YYYY-MM-DD'), 'Y');
INSERT INTO BOOK VALUES (3, '��.12.��', TO_DATE('2001-05-29', 'YYYY-MM-DD'),NULL,'N');
INSERT INTO BOOK VALUES (4, '��.283.��', TO_DATE('1945-04-24', 'YYYY-MM-DD'), NULL, 'N');

SELECT * FROM BOOK;
```
