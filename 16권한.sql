
--1. USER ����
CREATE USER USER01 IDENTIFIED BY USER01; --���̵� USER01, ��й�ȣ USER01

--2. USER ���� �ο�
GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW, CREATE SEQUENCE 
TO USER01;

--REVOKE CREATE SESSION FROM USER01; --���� ȸ��

--3. �����Ͱ� ����Ǵ� �������� ���� (���̺� �����̽� ����)
--ALTER USER ������ DEFAULT TABLESPACE ���̺����̽��� QUOTA UNLAMITED ON ���̺����̽���

ALTER USER USER01 DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;

--4. ���� ���� (���̺� ���� > ������ ���� > ~~~ ����)
--CASCADE�� ���̺� ���� �������� ������
DROP USER USER01 CASCADE;

--------------------------------------------------------------------------------
--role�� �̿��� ���� ����
CREATE USER USER01 IDENTIFIED BY USER01;

GRANT RESOURCE, CONNECT /*DBA*/ TO USER01;

ALTER USER USER01 DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;


--��й�ȣ ���湮
ALTER USER USER01 IDENTIFIED BY 1234;


--------------------------------------------------------------------------------
--���콺�� �����ϱ�
--1. DBA���� ������ > �ٸ� ����� > ����� ����
--1. DBA���� ������ > �ٸ� ����� > ����� ����
