--INDEX
--인덱스는 PK, UK에서 자동생성되는 UNIQUE인덱스가 있습니다
--인덱스의 역할은 조회를 빠르게 해주는 HINT 역할을 합니다 
--많이 변경되지 않는 일반컬럼에 인덱스를 적용할 수 있습니다

CREATE TABLE EMPS_IT AS (SELECT * FROM EMPLOYEES WHERE 1=1);

--인덱스가 없을 때 조회 VS 인덱스 생성후 조회
SELECT * FROM EMPS_IT WHERE FIRST_NAME = 'Allan'; 

--인덱스생성 
--(인덱스는 조회를 빠르게 하긴 하지만, 
--무작위 하게 많이 생성하면 오히려 성능이 떨어질 수 있습니다)
CREATE INDEX EMPS_IT_IDX ON EMPS_IT (FIRST_NAME);
CREATE UNIQUE INDEX EMPS_IT_IDX ON EMPS_IT (FIRST_NAME); --유니크인덱스(컬럼값이 유니크해야 합니다)

--인덱스 삭제
DROP INDEX EMPS_IT_IDX;

--인덱스는 (결합인덱스) 여러 컬럼을 지정할 수 있습니다
CREATE INDEX EMPS_IT_IDX ON EMPS_IT (FIRST_NAME, LAST_NAME);
SELECT * FROM EMPS_IT WHERE FIRST_NAME = 'Allan'; --인덱스 적용됨
SELECT * FROM EMPS_IT WHERE FIRST_NAME = 'Allan' AND LAST_NAME = 'McEwen'; --인덱스 적용됨


--인덱스 활용
--FIRST_NAME 기준으로 순서
--인덱스를 기준으로 힌트를 주는 방법
SELECT *
FROM (SELECT /*+ INDEX_DESC(E EMPS_IT_IDX)*/
       ROWNUM RN,
       E.*        
      FROM EMPS_IT E)
WHERE RN > 10 AND RN <= 20;



