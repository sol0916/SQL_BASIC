/*
VIEW는 제한적인 자료를 보기 위해 사용하는 가상테이블 입니다.
VIEW를 이용해서 필요한 컬럼을 정의해두면, 관리가 용이해 집니다.
VIEW를 통해서 데이터에 접근하면, 비교적 안전하게 데이터를 관리할 수 있습니다

*/

SELECT * FROM EMP_DETAILS_VIEW;

--뷰를 생성하려면 권한이 필요합니다
SELECT * FROM user_sys_privs;

--CREATE OR REPLACE VIEW
--뷰의 생성
CREATE OR REPLACE VIEW EMPS_VIEW
AS (
SELECT EMPLOYEE_ID,
       FIRST_NAME || ' ' || LAST_NAME AS NAME,
       JOB_ID,
       SALARY
FROM EMPLOYEES 
);

SELECT * FROM EMPS_VIEW;

--뷰의 수정은 OR REPLACE가 있으면 됩니다
CREATE OR REPLACE VIEW EMPS_VIEW
AS (
SELECT EMPLOYEE_ID,
       FIRST_NAME || ' ' || LAST_NAME AS NAME,
       JOB_ID,
       SALARY,
       COMMISSION_PCT
FROM EMPLOYEES
WHERE JOB_ID = 'IR_PROG'
);


--복합뷰
--JOIN을 ㅡ이용해서 필요한 데이터를 뷰로 생성함
CREATE OR REPLACE VIEW EMPS_VIEW
AS (
SELECT E.EMPLOYEE_ID,
       FIRST_NAME || ' ' || LAST_NAME AS NAME,
       D.DEPARTMENT_NAME,
       J.JOB_TITLE
FROM EMPLOYEES E 
LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
LEFT JOIN JOBS J ON E.JOB_ID = J.JOB_ID
);


SELECT * FROM EMPS_VIEW WHERE NAME LIKE '%Nancy%';

--뷰의 삭제
--DROP VIEW
DROP VIEW EMPS_VIEW;


--------------------------------------------------------------------------------

/*
VIEW를 통한 DML은 가능하긴 하지만, 몇가지 제약사항이 있습니다
1. 가상열이면 안됩니다.
2. JOIN을 이용한 테이블인 경우에도 안됩니다.
3. 원본테이블에 NOT NULL 제약이 있다면 안됩니다.
*/

SELECT * FROM EMPS_VIEW;

--1. 가상열이면 안됩니다. (NAME은 가상열)
INSERT INTO EMPS_VIEW(EMPLOYEE_ID, NAME, DEPARTMENT_NAME, JOB_TITLE) VALUES (1000, 'DEMO HONG', 'DEMO IT', 'DEMO IT PROG'); 

--2. JOIN을 이용한 테이블인 경우에도 안됩니다.
INSERT INTO EMPS_VIEW(DEPARTMENT_ID, DEPARTMENT_NAME) VALUES (1000, 'DEMO');

--3. 원본테이블에 NOT NULL제약이 있다면 안됩니다.
INSERT INTO EMPS_VIEW(EMPLOYEE_ID, JOB_TITLE) VALUES (300, 'TEST');


--뷰의 제약조건 READ ONLY
--DML문장이 뷰를 통해서는 할 수 없음
CREATE OR REPLACE VIEW EMPS_VIEW
AS (
    SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY
    FROM EMPLOYEES
) WITH READ ONLY;

