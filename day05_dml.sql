create table emp_10
as
select * from emp where 1=2;
select * from emp_10;

insert into emp_10 (empno,job,ename,hiredate,mgr,sal,comm,deptno)
values (1000,'MANAGER','TOM',SYSDATE,NULL,2000,NULL,10);
commit;
desc emp_10;

alter table emp_10 add constraint EMP_10_ENAME_NN NOT NULL (ENAME);--[x]
--테이블 수준에서 낫널 불가

alter table emp_10 modify ename varchar2(20) not null;

insert into emp_10 (EMPNO,ENAME,job, mgr, sal) values (1001,'JAMES','SALESMAN',1000,3000);

select * from emp_10;

insert into emp_10 
select * from emp where deptno=10;


--   insert 절의 열의 개수와 서브쿼리의 열의 개수가 좌측에서 부터 1대1로
--	 대응하며 자료형과 길이가 같아야 한다.

--UPDATE 테이블명 SET 컬럼이름1='자료1', 컬럼이름2='자료2' ....
--  WHERE 조건(컬럼)='조건값'



select * from emp2;

--EMP테이블을 카피하여 EMP2테이블을 만들되 데이터와 구조를 모두 복사하세요
create table emp2 
as 
select * from emp;
--EMP2에서 사번이 7788인 사원의 부서번호를 10번 부서로 수정하세요.
update emp2 set deptno=10 where empno=7788;
--EMP2에서 사번이 7369인 사원의 부서를 30번 부서로 급여를 3500으로 수정하세요
update emp2 set deptno=30,sal=3500 where empno=7369;

select * from emp2;
create table member2 
as 
select *from member;
select *from member;
select * from member2;
--   2] 등록된 고객 정보 중 고객의 나이를 현재 나이에서 모두 5를 더한 값으로 
--	      수정하세요.
    update member2 set age=age+5;
--	 2_1] 고객 중 13/09/01이후 등록한 고객들의 마일리지를 350점씩 올려주세요.
    update member2 set mileage=mileage+350 where reg_date>'13/09/01';
--3] 등록되어 있는 고객 정보 중 이름에 '김'자가 들어있는 모든 이름을 '김' 대신
--	     '최'로 변경하세요.
    update member2 set name=REPLACE (NAME,'김','최') WHERE NAME LIKE '김%';

UPDATE시 무결성 제약 조건 신경써야함


CREATE TABLE DEPT2
AS SELECT * FROM DEPT;

--DEPT2테이블의 DEPTNO에 대해 PRIMARY KEY 제약조건을 추가하세요

ALTER TABLE DEPT2 ADD CONSTRAINT DEPT2_DEPTNO_PK PRIMARY KEY (DEPTNO);

--EMP2 테이블의 DEPTNO에 대해 FOREIGN KEY 제약조건을 추가하되 DEPT2의 DEPTNO를 외래키로 참조하도록 하세요

ALTER TABLE EMP2 ADD CONSTRAINT EMP2_FK FOREIGN KEY (DEPTNO)
REFERENCE DEPT2(DEPTNO);

#DELETE FROM 테이블명  WHERE 조건(컬럼)='조건값'


-- EMP2테이블에서 사원번호가 7499인 사원의 정보를 삭제하라.
    DELETE FROM EMP2 WHERE EMPNO=7499;
--- EMP2테이블의 자료 중 부서명이 'SALES'인 사원의 정보를 삭제하라.
    DELETE FROM EMP2 WHERE DEPTNO= (SELECT DEPTNO FROM DEPT2 WHERE DNAME = 'SALES');
    SELECT * FROM EMP2;
    ROLLBACK;
---- PRODUCTS2 를 만들어서 테스트하기
CREATE TABLE PRODUCTS2 AS SELECT * FROM PRODUCTS;
--1] 상품 테이블에 있는 상품 중 상품의 판매 가격이 10000원 이하인 상품을 모두 
--	      삭제하세요.
    SELECT *FROM PRODUCTS2;
    DELETE FROM PRODUCTS2 WHERE OUTPUT_PRICE<=10000;
--
--	2] 상품 테이블에 있는 상품 중 상품의 대분류가 도서인 상품을 삭제하세요.
    DELETE FROM PRODUCTS2 WHERE CATEGORY_FK = 
    (SELECT CATEGORY_CODE FROM CATEGORY WHERE CATEGORY_NAME LIKE '%도서%'
    AND MOD(CATEGORY_CODE,100)=0);
    DELETE FROM PRODUCTS2;
    COMMIT;

    TCL: TRANSACTION CONTROL LANGUAGE
    -COMMIT
    -ROLLBACK
    -SAVEPOINT(표준 X, 오라클이ㅔ만 있음)

UPDATE EMP2 SET ENAME ='CHARSE' WHERE EMPNO=7788;

SELECT * FROM EMP2;

UPDATE EMP2 SET DEPTNO=30 WHERE EMPNO=7788;
--SAVEPOINT 포인트명;
SAVEPOINT POINT1;--저장점 설정

UPDATE EMP2 SET JOB='MANAGER';

ROLLBACK TO SAVEPOINT POINT1;

SELECT * FROM EMP2;
COMMIT;

select * from emp;
//검색할 사원이 이름을 입력받아서 해당 사원 정보를 출력
		//사번, 사원명,부서명,입사일,근무지 출력
select empno,ename,e.deptno,hiredate, d.loc 
from emp e join dept d
on d.deptno=e.deptno
where ename='JONES';
