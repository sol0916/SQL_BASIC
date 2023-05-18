--��������
--SELECT���� SELECT�������� ���� ���� : ��Į�� ��������
--SELECT���� FROM�������� ���� ���� : �ζ��κ�
--SELECT���� WHERE�������� ���� : ��������
--���������� �ݵ�� () �ȿ� �����ϴ�

--������ �������� - ���ϵǴ� ���� 1���� ��������

SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'Nancy';

SELECT * 
FROM EMPLOYEES 
WHERE SALARY > (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'Nancy');


--EMPLOYEE_ID�� 103���� ����� ������ ����
SELECT JOB_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = 103;

SELECT *
FROM EMPLOYEES
WHERE JOB_ID = (SELECT JOB_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = 103);


--��������, ������ �̾�� �մϴ�. �÷����� 1�� �����մϴ�.
--ERROR
SELECT *
FROM EMPLOYEES
WHERE JOB_ID = (SELECT JOB_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = 103 OR EMPLOYEE_ID = 104);


--------------------------------------------------------------------------------

--������ �������� - ���� ��������� IN, ANY, ALL�� ���մϴ�
SELECT SALARY
FROM EMPLOYEES
WHERE FIRST_NAME = 'David';

--IN ������ ���� ã��  = IN(4800, 6800, 9500)
SELECT *
FROM EMPLOYEES
WHERE SALARY IN (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David');

--ANY �ּҰ� ���� ŭ, �ִ밪 ���� ����
--�޿��� 9500���� ���� �����, �޿��� 4800���� ū �����
SELECT *
FROM EMPLOYEES
WHERE SALARY < ANY (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David');

--ALL �ִ밪 ���� ŭ, �ּҰ� ���� ����
--�޿��� 4800���� ���� �����, �޿��� 9500���� ���� �����
SELECT *
FROM EMPLOYEES
WHERE SALARY < ALL (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David');

--EXISTS �غ���


--������ IT_PROG�� ����麸�� ū �޿��� �޴� �����
SELECT * FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG';

SELECT * FROM EMPLOYEES
WHERE SALARY > ALL (SELECT SALARY FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG');

-- ������ IT_PROG�� ������� �ּҰ����� ū �޿��� �޴� �����
SELECT * FROM EMPLOYEES
WHERE SALARY > ANY (SELECT SALARY FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG');


--------------------------------------------------------------------------------
--��Į�� ��������
--JOIN�ÿ� Ư�����̺��� 1�÷��� ������ �� �� �����մϴ�.
SELECT FIRST_NAME,
       EMAIL,
       (SELECT DEPARTMENT_NAME FROM DEPARTMENTS D WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID)
FROM EMPLOYEES E
ORDER BY FIRST_NAME;

--���� ���� ���
SELECT FIRST_NAME,
       EMAIL,
       DEPARTMENT_NAME
FROM EMPLOYEES E
LEFT JOIN DEPARTMENTS D ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
ORDER BY FIRST_NAME;



--�� �μ��� �Ŵ��� �̸��� ����ϰ� �ʹ�?

----------------------������ �ڵ�
--JOIN
SELECT D.*,
       E.FIRST_NAME
FROM DEPARTMENTS D LEFT JOIN EMPLOYEES E ON D.MANAGER_ID = E.EMPLOYEE_ID;

SELECT D.*,
      (SELECT FIRST_NAME FROM EMPLOYEES E WHERE E.EMPLOYEE_ID = D.MANAGER_ID)
FROM DEPARTMENTS D;


--��Į�������� ������ ����
SELECT * FROM JOBS; --JOB TITLE
SELECT * FROM DEPARTMENTS;  --DEPARTMENT_NAME
SELECT * FROM EMPLOYEES; 

SELECT E.FIRST_NAME,
       E.JOB_ID,
       (SELECT JOB_TITLE FROM JOBS J WHERE J.JOB_ID = E.JOB_ID) AS JOB_TITLE,
       (SELECT DEPARTMENT_NAME FROM DEPARTMENTS D WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID) AS DEPARTMENT_NAME
FROM EMPLOYEES E;

--�� �μ��� ������� ��� + �μ� ����
SELECT DEPARTMENT_ID, COUNT(*) FROM EMPLOYEES GROUP BY DEPARTMENT_ID;

--�� �μ��� ������� ��� + �μ� ����
SELECT D.*,
       NVL((SELECT COUNT(*) FROM EMPLOYEES E WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID 
       GROUP BY DEPARTMENT_ID),0)       
FROM DEPARTMENTS D;


--------------------------------------------------------------------------------
--�ζ��� ��
--��¥ ���̺� ����
--ROWNUM�� ��ȸ�� �����̱� ������, ORDER�� ���� ���Ǹ� ROWNUM�� ���̴� ���� 
--����1
SELECT FIRST_NAME,
       SALARY, 
       ROWNUM
FROM (SELECT * 
        FROM EMPLOYEES
        ORDER BY SALARY DESC);

--����2        
SELECT ROWNUM,
       A.*
FROM (SELECT FIRST_NAME,
             SALARY
      FROM EMPLOYEES
      ORDER BY SALARY
      ) A;
      
      
-------------------
--ROWNUM�� ������ 1��°���� ��ȸ�� �����ϱ� ������  1�� ������ �ƴϸ� ���� �� ����
SELECT FIRST_NAME,
       SALARY, 
       ROWNUM
FROM (SELECT * 
        FROM EMPLOYEES
        ORDER BY SALARY DESC)
WHERE ROWNUM BETWEEN 1 AND 10;

-- 2��° �ζ��κ信�� ROWNUM�� RN���� �÷�ȭ
SELECT *
FROM (SELECT FIRST_NAME,
             SALARY, 
             ROWNUM AS RN
      FROM (SELECT * 
                FROM EMPLOYEES
                ORDER BY SALARY DESC)
        )
WHERE RN >= 51 AND RN <= 60;


--�ζ��� ���� ����
SELECT TO_CHAR(REGDATE, 'YY-MM-DD') AS REGDATE,
       NAME
FROM (SELECT 'ȫ�浿' AS NAME, SYSDATE AS REGDATE FROM DUAL
        UNION ALL
        SELECT '�̼���', SYSDATE FROM DUAL);
        
        
--�ζ��� ���� ����
--�μ��� �����
SELECT D.*,
       E.TOTAL
FROM DEPARTMENTS D
LEFT JOIN (SELECT DEPARTMENT_ID, 
            COUNT(*) AS TOTAL
            FROM EMPLOYEES
            GROUP BY DEPARTMENT_ID) E
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID;


--����
--������(��Һ�) VS ������ ��������(IN, ANY, ALL)
--��Į������ - LEFT JOIN�� ���� ����, �ѹ��� 1���� �÷��� ������ �� 
--�ζ��� �� - FROM�� ���� ��¥ ���̺�
