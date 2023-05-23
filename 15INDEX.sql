--INDEX
--�ε����� PK, UK���� �ڵ������Ǵ� UNIQUE�ε����� �ֽ��ϴ�
--�ε����� ������ ��ȸ�� ������ ���ִ� HINT ������ �մϴ� 
--���� ������� �ʴ� �Ϲ��÷��� �ε����� ������ �� �ֽ��ϴ�

CREATE TABLE EMPS_IT AS (SELECT * FROM EMPLOYEES WHERE 1=1);

--�ε����� ���� �� ��ȸ VS �ε��� ������ ��ȸ
SELECT * FROM EMPS_IT WHERE FIRST_NAME = 'Allan'; 

--�ε������� 
--(�ε����� ��ȸ�� ������ �ϱ� ������, 
--������ �ϰ� ���� �����ϸ� ������ ������ ������ �� �ֽ��ϴ�)
CREATE INDEX EMPS_IT_IDX ON EMPS_IT (FIRST_NAME);
CREATE UNIQUE INDEX EMPS_IT_IDX ON EMPS_IT (FIRST_NAME); --����ũ�ε���(�÷����� ����ũ�ؾ� �մϴ�)

--�ε��� ����
DROP INDEX EMPS_IT_IDX;

--�ε����� (�����ε���) ���� �÷��� ������ �� �ֽ��ϴ�
CREATE INDEX EMPS_IT_IDX ON EMPS_IT (FIRST_NAME, LAST_NAME);
SELECT * FROM EMPS_IT WHERE FIRST_NAME = 'Allan'; --�ε��� �����
SELECT * FROM EMPS_IT WHERE FIRST_NAME = 'Allan' AND LAST_NAME = 'McEwen'; --�ε��� �����


--�ε��� Ȱ��
--FIRST_NAME �������� ����
--�ε����� �������� ��Ʈ�� �ִ� ���
SELECT *
FROM (SELECT /*+ INDEX_DESC(E EMPS_IT_IDX)*/
       ROWNUM RN,
       E.*        
      FROM EMPS_IT E)
WHERE RN > 10 AND RN <= 20;



