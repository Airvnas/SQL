--day02_select.sql

select * from tab;
select * from emp;
select * from dept;
select * from salgrade;

select EMPNO, ENAME, SAL, SAL+500 ,SAL*12+NVL(COMM,0) "YEAR SAL" FROM EMP;

--NVL()
--NVL2(EXPR,값1,값2)" EXPR이 NULL이 아닐경우 값1, NULL일경우 값2
SELECT EMPNO,ENAME,MGR, NVL2(MGR,'관리자있음','관리자없음') "관리자 여부" FROM EMP;

SELECT ENAME||' IS A '||JOB AS "EMPLOYEE INFO" FROM EMP;

SELECT ENAME||':1 YEAR SALARY = '||SAL*12 AS "SAL INFO" FROM EMP;

--DISTINCT: 중복행 제거
SELECT JOB FROM EMP;
SELECT DISTINCT JOB FROM EMP;

SELECT DISTINCT DEPTNO, JOB FROM EMP ORDER BY DEPTNO;

-- [문제]
--	 1] EMP테이블에서 중복되지 않는 부서번호를 출력하세요.
SELECT DISTINCT DEPTNO FROM EMP;

--	 2] MEMBER테이블에서 회원의 이름과 나이 직업을 보여주세요.
SELECT NAME, AGE, JOB FROM MEMBER;

--	 3] CATEGORY 테이블에 저장된 모든 내용을 보여주세요.
SELECT * FROM CATEGORY;

--	 4] MEMBER테이블에서 회원의 이름과 적립된 마일리지를 보여주되,
--	      마일리지에 13을 곱한 결과를 "MILE_UP"이라는 별칭으로
--	      함께 보여주세요.
SELECT NAME, MILEAGE*13 AS "MILE_UP" FROM MEMBER;

--#특정 행 검색 - WHERE절 이용해서 조건부여

SELECT EMPNO, ENAME, JOB, SAL FROM EMP WHERE SAL>=3000;

--EMP테이블에서 담당업무가 MANAGER인 사원의
--정보를 사원번호,이름,업무,급여,부서번호로 출력하세요.
SELECT EMPNO,ENAME, JOB, SAL, DEPTNO 
FROM EMP 
WHERE JOB='MANAGER';
--SQL문은 대소문자 구분하지않지만, 값(리터럴)은 대소문자 구분

--EMP테이블에서 1982년 1월1일 이후에 입사한 사원의 
--사원번호,성명,업무,급여,입사일자를 출력하세요
SELECT EMPNO, ENAME, JOB, SAL, HIREDATE 
FROM EMP 
WHERE HIREDATE >'82/01/01' ;

--emp테이블에서 급여가 1300에서 1500사이의 사원의 이름,업무,급여,
--	부서번호를 출력하세요.
SELECT ENAME, JOB, SAL
FROM EMP
WHERE SAL BETWEEN 1300 AND 1500;

--emp테이블에서 사원번호가 7902,7788,7566인 사원의 사원번호,
--	이름,업무,급여,입사일자를 출력하세요.
SELECT EMPNO, ENAME, JOB,SAL,HIREDATE
FROM EMP
WHERE EMPNO IN(7902,7788,7566);

--10번 부서가 아닌 사원의 이름,업무,부서번호를 출력하세요
SELECT ENAME,JOB,DEPTNO
FROM EMP
WHERE DEPTNO NOT IN (10);

--emp테이블에서 업무가 SALESMAN 이거나 PRESIDENT인
--	사원의 사원번호,이름,업무,급여를 출력하세요.
SELECT EMPNO,ENAME,JOB,SAL
FROM EMP
WHERE JOB IN('SALESMAN', 'PRESIDENT');
--WHERE JOB ='SALESMAN'OR JOB= 'PRESIDENT');

--	커미션(COMM)이 300이거나 500이거나 1400인 사원정보를 출력하세요
SELECT EMPNO,ENAME,JOB,SAL
FROM EMP
WHERE COMM IN (300,500,1400);

--	커미션이 300,500,1400이 아닌 사원의 정보를 출력하세요

SELECT EMPNO,ENAME,JOB,SAL
FROM EMP
WHERE COMM NOT IN (300,500,1400);

SELECT * FROM EMP 
--WHERE COMM=NULL;[X]
WHERE COMM IS NULL;
--NULL값의 비교는 IS NULL 또는 IS NOT NULL로 비교

--emp에서 이름이 S자로 시작하는 사람 정보를 보여주세요
SELECT * FROM EMP 
WHERE ENAME LIKE 'S%';

--	-이름 중 S자가 들어가는 사람의 정보를 보여주세요.
SELECT * FROM EMP 
WHERE ENAME LIKE '%S%';

--    - 이름의 두번 째에 O자가 들어가는 사람의 정보를 보여주세요.
SELECT * FROM EMP 
WHERE ENAME LIKE '_O%';

-- EMP테이블에서 입사일자가 82년도에 입사한 사원의 사번,이름,업무
--	   입사일자를 출력하세요.
SELECT EMPNO,ENAME,JOB,HIREDATE
FROM EMP
WHERE HIREDATE LIKE '82%';

ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD';
ALTER SESSION SET NLS_DATE_FORMAT='YY/MM/DD';
-- 고객 테이블 가운데 성이 김씨인 사람의 정보를 보여주세요.
SELECT *
FROM MEMBER
WHERE NAME LIKE '김%';
-- 고객 테이블 가운데 '강북'가 포함된 정보를 보여주세요.
SELECT *
FROM MEMBER
WHERE ADDR LIKE '%강북%';
SELECT * FROM MEMBER;
-- 카테고리 테이블 가운데 category_code가 0000로 끝는 상품정보를 보여주세요.
SELECT *
FROM CATEGORY
WHERE category_code LIKE '%0000';

- EMP테이블에서 급여가 1100이상이고 JOB이 MANAGER인 사원의
	사번,이름,업무,급여를 출력하세요.
SELECT EMPNO, ENAME, JOB, SAL
FROM EMP
WHERE SAL>=1100 AND JOB='MANAGER';

- EMP테이블에서 급여가 1100이상이거나 JOB이 MANAGER인 사원의
	사번,이름,업무,급여를 출력하세요.
SELECT EMPNO, ENAME, JOB, SAL
FROM EMP
WHERE SAL>=1100 OR JOB='MANAGER';

- EMP테이블에서 JOB이 MANAGER,CLERK,ANALYST가 아닌
	  사원의 사번,이름,업무,급여를 출력하세요.
SELECT EMPNO, ENAME, JOB, SAL
FROM EMP
WHERE JOB NOT IN('MANAGER','CLERK','ANALYST');

SELECT EMPNO, ENAME, JOB, SAL
FROM EMP
WHERE JOB <>'MANAGER' AND JOB <>'CLERK' AND JOB!='ANALYST';

--- EMP테이블에서 급여가 1000이상 1500이하가 아닌 사원의 정보를 보여주세요
SELECT * FROM emp
WHERE  SAL NOT BETWEEN 1000 AND 1500;
--
--- EMP테이블에서 이름에 'S'자가 들어가지 않은 사람의 이름을 모두
--	  출력하세요.
SELECT * FROM emp
WHERE ENAME NOT LIKE '%S%';
--- 사원테이블에서 업무가 PRESIDENT이고 급여가 1500이상이거나
--	   업무가 SALESMAN인 사원의 사번,이름,업무,급여를 출력하세요.
SELECT * FROM emp 
WHERE JOB='PRESIDENT' AND SAL>=1500 OR JOB='SALESMAN';

ORDER BY절
-오름차순:ASC
-내림차순:DESC
-NULL 값은 오름차순일때 가장 나중에, 내림차순에선 가장먼저옴

WGHO 순서
-WHERE
-GROUP BY
-HAVING
-ORDER BY

사원테이블에서 입사일자 순으로 정렬하여 사번,이름,업무,급여,
	입사일자를 출력하세요.
SELECT EMPNO, ENAME, JOB, SAL, HIREDATE
FROM EMP ORDER BY HIREDATE;

SELECT EMPNO, ENAME, JOB, SAL, HIREDATE
FROM EMP ORDER BY HIREDATE DESC;

SELECT EMPNO,ENAME,SAL, SAL*12 FROM EMP ORDER BY SAL*12 DESC;

SELECT EMPNO,ENAME,SAL, SAL*12 Y FROM EMP ORDER BY Y DESC;
SELECT EMPNO,ENAME,SAL, SAL*12  FROM EMP 
ORDER BY 1 DESC;
--숫자는 컬럼인덱스

-- 사원 테이블에서 부서번호로 정렬한 후 부서번호가 같을 경우
--	급여가 많은 순으로 정렬하여 사번,이름,업무,부서번호,급여를
--	출력하세요.
SELECT EMPNO, ENAME, JOB, DEPTNO,SAL
FROM EMP
ORDER BY DEPTNO ASC, SAL DESC;
--
--	사원 테이블에서 첫번째 정렬은 부서번호로, 두번째 정렬은
--	업무로, 세번째 정렬은 급여가 많은 순으로 정렬하여
--	사번,이름,입사일자,부서번호,업무,급여를 출력하세요.
SELECT EMPNO, ENAME, HIREDATE, DEPTNO,JOB,SAL
FROM EMP
ORDER BY DEPTNO,JOB, SAL DESC;

--1] 상품 테이블에서 판매 가격이 저렴한 순서대로 상품을 정렬해서 
--    보여주세요.
SELECT *
FROM PRODUCTS
ORDER BY OUTPUT_PRICE;

--2] 고객 테이블의 정보를 이름의 가나다 순으로 정렬해서 보여주세요.
--      단, 이름이 같을 경우에는 나이가 많은 순서대로 보여주세요.
SELECT *
FROM MEMBER
ORDER BY NAME, AGE DESC;
--
--3] 상품 테이블에서 배송비의 내림차순으로 정렬하되, 
--	    같은 배송비가 있는 경우에는
--		마일리지의 내림차순으로 정렬하여 보여주세요.
SELECT *
FROM PRODUCTS
ORDER BY TRANS_COST, MILEAGE;
--
--4]사원테이블이서 입사일이 1981 2월20일 ~ 1981 5월1일 사이에
--	    입사한 사원의 이름,업무 입사일을 출력하되, 입사일 순으로 출력하세요.
SELECT ENAME, JOB, HIREDATE
FROM EMP
WHERE HIREDATE >= '81/02/20' AND HIREDATE <='81/05/01' 
ORDER BY HIREDATE ASC;
select ename,job,hiredate
from emp where hiredate between '1981-02-20' and '1981-05-01'
order by hiredate asc;


SELECT * FROM EMP ORDER BY HIREDATE;

--5] 사원테이블에서 부서번호가 10,20인 사원의 이름,부서번호,업무를 출력하되
--	    이름 순으로 정렬하시오.
SELECT ENAME, DEPTNO,JOB
FROM EMP
WHERE DEPTNO = 10 OR DEPTNO =20 ORDER BY ENAME;

--6] 사원테이블에서 보너스가 급여보다 10%가 많은 사원의 이름,급여,보너스
--    를 출력하세요.
SELECT ENAME, SAL, COMM
FROM EMP 
WHERE 1.1*NVL(COMM,0)>SAL;

--7] 사원테이블에서 업무가 CLERK이거나 ANALYST이고
--     급여가 1000,3000,5000이 아닌 모든 사원의 정보를 
--SELECT * FROM EMP
--WHERE JOB IN('CLERK','ANALYST) AND SAL NOT IN(1000,3000,5000);
--8] 사원테이블에서 이름에 L이 두자가 있고 부서가 30이거나
--    또는 관리자가 7782번인 사원의 정보를 출력하세요.
SELECT * FROM EMP
WHERE ENAME LIKE '%LL%' AND DEPTNO=30 OR MGR =7782;






















