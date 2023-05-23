--������ (���������� �����ϴ� ��) - PK�� ���� ����

SELECT * FROM user_sequences;

--����� ������ ����
CREATE SEQUENCE DEPTS_SEQ 
    START WITH 1 --���� ��
    INCREMENT BY 1 --������ ��
    MAXVALUE 10 --�ִ�
    MINVALUE 1 --�ּڰ�
    NOCACHE --ĳ���� ����Ŭ�� ������ NO�� ���̱�
    NOCYCLE;
    
--������ ���� (��, ���ǰ� �ִ� ��������� ����)
DROP SEQUENCE DEPTS_SEQ;

DROP TABLE DEPTS;
CREATE TABLE DEPTS AS (SELECT * FROM DEPARTMENTS WHERE 1=2);  
ALTER TABLE DEPTS ADD CONSTRAINT DEPTS_PK PRIMARY KEY (DEPARTMENT_ID); --PK

--NEXTVAL (�ѹ� ����� ���� ������ ���� ������ �ִ�)
SELECT DEPTS_SEQ.NEXTVAL FROM DUAL; --�������� ������ (����)
--CURRVAL
SELECT DEPTS_SEQ.CURRVAL FROM DUAL; --�������� ���� ��

--������ ���
--MAX���� 10���� �����߱� ������ 10�� �ʰ��� �� ���� (���� ��� ����)
--�������� �ִ밪�� �����ϸ� ���̻� ����� �� ����
INSERT INTO DEPTS VALUES(DEPTS_SEQ.NEXTVAL, 'TEST', 100, 1000); 

SELECT * FROM DEPTS;

--������ ���� 
ALTER SEQUENCE DEPTS_SEQ MAXVALUE 99999;
ALTER SEQUENCE DEPTS_SEQ INCREMENT BY 10;

--������ ���� ����(�⺻ �ɼ����� ����)
CREATE SEQUENCE DEPTS2_SEQ;
SELECT * FROM USER_SEQUENCES;

--������ �ʱ�ȭ (�������� ���̺��� ���ǰ� �ִ� ����, ������ DROP�ϸ� �ȵ˴ϴ�)
--1. ���� ������ Ȯ��
SELECT DEPTS_SEQ.CURRVAL FROM DUAL;
--2. �������� ������ ����
ALTER SEQUENCE DEPTS_SEQ INCREMENT BY -29; --���� ������ -1�� ����
--3. ������ ����
SELECT DEPTS_SEQ.NEXTVAL FROM DUAL;
--4. ������ �������� �ٽ� 1�� ����
ALTER SEQUENCE DEPTS_SEQ INCREMENT BY 1;
--���ĺ��� �������� 2���� ����


--������ VS �⺰�� ������ VS ������ ���ڿ�
CREATE TABLE DEPTS3 (
    DEPT_NO VARCHAR2(30) PRIMARY KEY,
    DEPT_NAME VARCHAR2(30)
);

CREATE SEQUENCE DEPTS3_SEQ NOCACHE;

--20230523-00001-��ǰ��ȣ
--TO_CHAR(SYSDATE, 'YYYYMMDD'), LPAD(������, �ڸ���, 'ä�ﰪ')
INSERT INTO DEPTS3 VALUES(TO_CHAR(SYSDATE, 'YYYYMMDD')|| '-' 
                          ||LPAD(DEPTS_SEQ.NEXTVAL,5,'0')|| '-' 
                          ||'��ǰ��ȣ', 
                          'TEST');
                          
SELECT * FROM DEPTS3;