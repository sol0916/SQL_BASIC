--시퀀스 (순차적으로 증가하는 값) - PK에 많이 사용됨

SELECT * FROM user_sequences;

--사용자 시퀀스 생성
CREATE SEQUENCE DEPTS_SEQ 
    START WITH 1 --시작 값
    INCREMENT BY 1 --증가할 값
    MAXVALUE 10 --최댓값
    MINVALUE 1 --최솟값
    NOCACHE --캐쉬와 사이클은 무조건 NO로 붙이기
    NOCYCLE;
    
--시퀀스 삭제 (단, 사용되고 있는 시퀀스라면 주의)
DROP SEQUENCE DEPTS_SEQ;

DROP TABLE DEPTS;
CREATE TABLE DEPTS AS (SELECT * FROM DEPARTMENTS WHERE 1=2);  
ALTER TABLE DEPTS ADD CONSTRAINT DEPTS_PK PRIMARY KEY (DEPARTMENT_ID); --PK

--NEXTVAL (한번 사용한 값은 후진이 없다 전진만 있다)
SELECT DEPTS_SEQ.NEXTVAL FROM DUAL; --시퀀스의 다음값 (공유)
--CURRVAL
SELECT DEPTS_SEQ.CURRVAL FROM DUAL; --시퀀스의 현재 값

--시퀀스 사용
--MAX값을 10으로 지정했기 때문에 10을 초과할 수 없음 (현재 행과 무관)
--시퀀스의 최대값에 도달하면 더이상 사용할 수 없음
INSERT INTO DEPTS VALUES(DEPTS_SEQ.NEXTVAL, 'TEST', 100, 1000); 

SELECT * FROM DEPTS;

--시퀀스 수정 
ALTER SEQUENCE DEPTS_SEQ MAXVALUE 99999;
ALTER SEQUENCE DEPTS_SEQ INCREMENT BY 10;

--시퀀스 빠른 생성(기본 옵션으로 생성)
CREATE SEQUENCE DEPTS2_SEQ;
SELECT * FROM USER_SEQUENCES;

--시퀀스 초기화 (시퀀스가 테이블에서 사용되고 있는 경우면, 시퀀스 DROP하면 안됩니다)
--1. 현재 시퀀스 확인
SELECT DEPTS_SEQ.CURRVAL FROM DUAL;
--2. 증가값을 음수로 변경
ALTER SEQUENCE DEPTS_SEQ INCREMENT BY -29; --현재 시퀀스 -1로 감소
--3. 시퀀스 실행
SELECT DEPTS_SEQ.NEXTVAL FROM DUAL;
--4. 시퀀스 증가값을 다시 1로 변경
ALTER SEQUENCE DEPTS_SEQ INCREMENT BY 1;
--이후부터 시퀀스는 2부터 시작


--시퀀스 VS 년별로 시퀀스 VS 랜덤한 문자열
CREATE TABLE DEPTS3 (
    DEPT_NO VARCHAR2(30) PRIMARY KEY,
    DEPT_NAME VARCHAR2(30)
);

CREATE SEQUENCE DEPTS3_SEQ NOCACHE;

--20230523-00001-상품번호
--TO_CHAR(SYSDATE, 'YYYYMMDD'), LPAD(데이터, 자리수, '채울값')
INSERT INTO DEPTS3 VALUES(TO_CHAR(SYSDATE, 'YYYYMMDD')|| '-' 
                          ||LPAD(DEPTS_SEQ.NEXTVAL,5,'0')|| '-' 
                          ||'상품번호', 
                          'TEST');
                          
SELECT * FROM DEPTS3;