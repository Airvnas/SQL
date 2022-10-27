1.단일행 함수
2.그룹함수
3.기타함수

#단일행 함수
[1] 문자형 함수
[2] 숫자형 함수
[3] 날짜형 함수
[4] 변환 함수
[5] 일반함수

#[1] 문자형 함수
select lower('HAPPY BIRTHDAY'),UPPER('Happy Birthday') FROM DUAL;

SELECT * FROM DUAL;
1행 1열을 갖는 더미 테이블

#initcap(): 첫 문자만 대문자로 변환
select deptno, dname, initcap(dname),initcap(loc) from dept;

concat(변수1,변수2): 2개 이상의 문자를 결합해준다.
select concat('abc','1234') from dual;

--[문제] 사원 테이블에서 SCOTT의 사번,이름,담당업무(소문자로),부서번호를
--		출력하세요.
select empno, ename, lower(job),deptno
from EMP
where ename = 'SCOTT';

--	 상품 테이블에서 판매가를 화면에 보여줄 때 금액의 단위를 함께 
--	 붙여서 출력하세요.
select products_name, concat(output_price,'원') "판매가"
from products;

--	 고객테이블에서 고객 이름과 나이를 하나의 컬럼으로 만들어 결과값을 화면에
--	       보여주세요.
select concat(name,age) from member;

--#substr(변수,i,len):문자 i인덱스로 시작한 len문자 길이만큼의 변수를 반환함
--I가 양수일 경우 앞에서부터 음수일경우 뒤에서부터
select substr('ABCDEFG',3,4)  FROM DUAL;
--주민번호 뒷자리 잘라내기
select substr('991203-1012369',8)from dual;
select substr('991203-1012369',-7)from dual;

#LENGTH(변수): 문자열 길이 반환
SELECT LENGTH('991203-1012369') FROM DUAL;

--[문제]
--	사원 테이블에서 첫글자가 'K'보다 크고 'Y'보다 작은 사원의
--	  사번,이름,업무,급여를 출력하세요. 단 이름순으로 정렬하세요.
SELECT EMPNO, ENAME, JOB, SAL
FROM EMP
WHERE substr(ENAME,1,1)>'K' and substr(ENAME,1,1)<'Y' ORDER BY ENAME;

--
--	사원테이블에서 부서가 20번인 사원의 사번,이름,이름자릿수,
--	급여,급여의 자릿수를 출력하세요.

SELECT EMPNO,ENAME,LENGTH(ENAME)"이름 자릿수",SAL,LENGTH(SAL) "급여 자릿수"
FROM EMP
WHERE DEPTNO=20;
--	
--	사원테이블의 사원이름 중 6자리 이상을 차지하는 사원의이름과 
--	이름자릿수를 보여주세요.
SELECT ENAME,LENGTH(ENAME)
FROM EMP
WHERE LENGTH(ENAME)>=6;

#LPAD/RPAD
LPAD(컬럼,변수1,변수2):문자 값을 왼쪽부터 채운다
RPAD(컬럼,변수1,변수2):문자 값을 오른쪽부터 채운다

SELECT ENAME, LPAD(ENAME,15,'*'),SAL,LPAD(SAL,10,'*') FROM EMP
WHERE DEPTNO=10;

SELECT RPAD(DNAME,15,'#')FROM DEPT;

--#LTRIM/RTRIM
--LTRIM(변수1,변수2): 변수 1의 값중 변수 2와 같은 단어가 있으면 그 문자를 삭제한 나머지 값을 반환
SELECT LTRIM('TTTHELLO TEST','T'),RTRIM('TTTHELLO TEST','T') FROM DUAL;

#REPLACE(컬럼1,변수1,변수2): 컬럼값중 변수 1에 해당하는 문자를 변수 2로 대체한다.

SELECT REPLACE('ORACLE TEST','TEST','HI') FROM DUAL;


--사원테이블에서 담당업무 중 좌측에 'A'를 삭제하고
--급여중 좌측의 1을 삭제하여 출력하세요.
SELECT LTRIM(JOB,'A'),LTRIM(SAL,1)
FROM EMP;

--사원테이블에서 10번 부서의 사원에 대해 담당업무 중 우측에'T'를
--	삭제하고 급여중 우측의 0을 삭제하여 출력하세요.

SELECT RTRIM(JOB,'T'),RTRIM(SAL,0)
FROM EMP
WHERE DEPTNO=10;

--사원테이블 JOB에서 'A'를 '$'로 바꾸어 출력하세요.
SELECT REPLACE(JOB,'A','$')
FROM EMP;

--고객 테이블의 직업에 해당하는 컬럼에서 직업 정보가 학생인 정보를 모두
--	 대학생으로 변경해 출력되게 하세요.
SELECT REPLACE(JOB,'학생','대학생')
FROM MEMBER;
--
-- 고객 테이블 주소에서 서울시를 서울특별시로 수정하세요.
UPDATE MEMBER SET ADDR = REPLACE(ADDR,'서울시','서울특별시');

ROLLBACK;

#[2] 숫자형 함수
#ROUND(값),ROUND(값,자리수):반올림함수
SELECT ROUND(4567.567),ROUND(4567.567,0),ROUND(4567.567,2),
ROUND(4567.567,-1) FROM DUAL;

#TRUNC(): 절삭함
SELECT TRUNC(4567.567),TRUNC(4567.567,0),TRUNC(4567.567,2),
TRUNC(4567.567,-2) FROM DUAL;

#MOD(값1,값2):나머지 값을 반환
--고객 테이블에서 회원이름, 마일리지,나이, 마일리지를 나이로 나눈값을 반올림하여 출력하세요
SELECT NAME,MILEAGE,AGE,ROUND(MILEAGE/AGE)
FROM MEMBER;
--상품 테이블의 상품 정보가운데 백원 단위까지 버린 배송비를 비교하여 출력하세요.
SELECT PRODUCTS_NAME,TRANS_COST,TRUNC(TRANS_COST,-3)
FROM PRODUCTS;
--사원테이블에서 부서번호가 10인 사원의 급여를 	30으로 나눈 나머지를 출력하세요.
SELECT DEPTNO, ENAME, SAL,TRUNC(SAL/30), MOD(SAL,30) FROM EMP
WHERE DEPTNO=10;

#CHR(),ASCII()
SELECT CHR(65),ASCII('A') FROM DUAL;

#ABS(값): 절대값을 구하는 함수
SELECT NAME, AGE, AGE-40,ABS(AGE-40) FROM MEMBER;

#CEIL():올림값
#FLOOR():내림값

SELECT CEIL(123.001),FLOOR(123.001) FROM DUAL;

#POWER()
#SQRT()
#SIGN()
SELECT POWER(2,7),SQRT(64),SQRT(133) FROM DUAL;

#[3] 날짜형 함수

SELECT SYSDATE, SYSTIMESTAMP FROM DUAL;

SELECT SYSDATE+3"3일 뒤",SYSDATE-2"이틀전"FROM DUAL;

두시간뒤
SELECT SYSTIMESTAMP,TO_CHAR(SYSTIMESTAMP+2/24,'YY/MM/DD HH24:MI:SS')"두시간뒤" FROM DUAL;
SELECT HIREDATE,SYSDATE,TRUNC(SYSDATE-HIREDATE),
TRUNC((SYSDATE-HIREDATE)/7) WEEKS,TRUNC(MOD((SYSDATE-HIREDATE),7)) FROM EMP;

select concat(round((sysdate-hiredate)/7),'주'),
concat(floor(mod(sysdate-hiredate,7)),'일') from emp;

#MONTHS_BETWEEN(DATE1,DATE2):날짜1과 날짜2 사이의 월수를 계산한다.
SELECT MONTHS_BETWEEN(SYSDATE,TO_DATE('22-07-01')) FROM EMP;

#ADD_MONTHS(DATE,N):날짜에 N개월을 더함
SELECT ADD_MONTHS(SYSDATE,2) FROM DUAL;

#LAST_DAY(D): 월의 마지막 날짜를 반환함(평년, 윤년 자동계산)
SELECT LAST_DAY('22-02-01'),LAST_DAY('20-02-01'),LAST_DAY(SYSDATE) FROM DUAL;

--고객 테이블이 두 달의 기간을 가진 유료 회원이라는 가정하에 등록일을 기준으로
--	   유료 회원인 고객의 정보를 보여주세요.
SELECT NAME,REG_DATE,ADD_MONTHS(REG_DATE,2) "서비스 만기일" FROM MEMBER;

SELECT SYSDATE FROM DUAL;
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD HH:MI:SS')FROM DUAL;
SELECT TO_CHAR(SYSDATE,'CC YEAR')FROM DUAL;

#[4]변환함수
TO_CHAR()
TO_DATE()
TO_NUMBER()

# TO_CHAR(날짜): 날짜유형을 문자열로 변환
# TO_CHAR(숫자): 숫자유형을 문자열로 변환
  
  TO_CHAR(D,출력형식)
  SELECT TO_CHAR(SYSDATE),TO_CHAR(SYSDATE,'YY-MM-DD HH12:MI:SS') FROM DUAL;
  
--  고객테이블의 등록일자를 0000-00-00 의 형태로 출력하세요.
SELECT * FROM MEMBER WHERE TO_CHAR(REG_DATE,'YYYY')='2013';
--	 고객테이블에 있는 고객 정보 중 등록연도가 2003년인 
--	 고객의 정보를 보여주세요.
SELECT * FROM MEMBER
WHERE REG_DATE=13/%%/%%;
SELECT * FROM MEMBER;
--	 고객테이블에 있는 고객 정보 중 등록일자가 2013년 5월1일보다 
--	 늦은 정보를 출력하세요. 
--	 단, 고객등록 정보는 년, 월만 보이도록 합니다.
SELECT TO_CHAR(REG_DATE,'YYYY-MM')
FROM MEMBER
WHERE TO_CHAR(REG_DATE,'YYYY-MM-DD')>'2013-05-01';
  
TO_CHAR(N,출력형식): 숫자형을 문자열로 변환

SELECT TO_CHAR(100000,'999,999'),TO_CHAR(100000,'$999G999')FROM DUAL;
  
--  상품 테이블에서 상품의 공급 금액을 가격 표시 방법으로 표시하세요.
--	  천자리 마다 , 를 표시합니다.
SELECT PRODUCTS_NAME,INPUT_PRICE, TO_CHAR(INPUT_PRICE,'9999,999,999') FROM PRODUCTS;
--	 74] 상품 테이블에서 상품의 판매가를 출력하되 주화를 표시할 때 사용하는 방법을
--	  사용하여 출력하세요.[예: \10,000]
SELECT PRODUCTS_NAME, OUTPUT_PRICE,TO_CHAR(OUTPUT_PRICE,'L999G999G999')FROM PRODUCTS;

#TO_DATE(STR,출력형식): 문자열을 날짜 유형으로 변환
SELECT TO_DATE('20221128','YYYYMMDD')+2 FROM DUAL;
SELECT *FROM MEMBER
WHERE REG_DATE>TO_DATE('20130601','YYYYMMDD');

#TO_NUMBER(STR,출력형식):문자열을 숫자형식으로 변환한다.
SELECT TO_NUMBER('10,000','99,999')*2 FROM DUAL;

SELECT TO_NUMBER('$8,590','$999G999')+10 FROM DUAL;
SELECT TO_CHAR(-23,'999S'),TO_CHAR(-23,'99D99') FROM DUAL;
SELECT TO_CHAR(-23,'99.9'),TO_CHAR(-23,'99.99EEEE') FROM DUAL;

#그룹함수
-여러행 또는 테이블 전체에 적용하여 하나의 결과를 반환하는 함수

select count(empno) from emp;

select count (comm) from emp;
--null값을 무시하고 센다.

--관리자 수 세보기
select count(distinct mgr) from emp;
select count(*) from emp;

create table test(a number,b number, c number);

desc test;
insert into test values(null,null,null);
commit;
select * from test;
select count(a) from test;
select count(*) from test;
select count(deptno) from dept;


AVG()
MAX()
MIN()
SUM()

--emp테이블에서 모든 SALESMAN에 대하여 급여의 평균,
--		 최고액,최저액,합계를 구하여 출력하세요.
select AVG(SAL),MAX(SAL),MIN(SAL),SUM(SAL)
from emp
where job='SALESMAN';
--EMP테이블에 등록되어 있는 인원수, 보너스에 NULL이 아닌 인원수,
--		보너스의 평균,등록되어 있는 부서의 수를 구하여 출력하세요.
select count(empno),count(distinct COMM),AVG(COMM),count(deptno)
from emp;

#그룹함수는 GROUP BY 절과 함께 사용된다
EMP에서 업무별 인원수를 보여주세요

SELECT JOB, COUNT (EMPNO)FROM EMP
GROUP BY JOB;

GROUP BY절을 이용할 때는 GROUP BY 절에서 ㅎ사용한 컬럼과 그룹함수만 SELECT 할수 있다.

--SELECT ENAME, JOB, COUNT (EMPNO)FROM EMP
--GROUP BY JOB;[X]

--  17] 고객 테이블에서 직업의 종류, 각 직업에 속한 최대 마일리지 정보를 보여주세요.
select job,Max(mileage)
from member
group by job;
--
--	18] 상품 테이블에서 각 상품카테고리별로 총 몇 개의 상품이 있는지 보여주세요.
--
--		또한 최대 판매가와 최소 판매가를 함께 보여주세요.
select CATEGORY_FK,COUNT(PNUM),MAX(OUTPUT_PRICE),MIN(OUTPUT_PRICE)
FROM PRODUCTS
GROUP BY CATEGORY_FK ORDER BY 1;

--	19] 상품 테이블에서 각 공급업체 코드별로 공급한 상품의 평균입고가를 보여주세요.
SELECT EP_CODE_FK,AVG(INPUT_PRICE)
FROM PRODUCTS
GROUP BY EP_CODE_FK;


--  문제1] 사원 테이블에서 입사한 년도별로 사원 수를 보여주세요.
SELECT HIREDATE, COUNT(EMPNO)
FROM EMP GROUP BY HIREDATE;

select to_char(hiredate,'YY'),count(empno) from emp group by to_char(hiredate,'YY')
ORDER BY 1;

--	문제2] 사원 테이블에서 해당년도 각 월별로 입사한 사원수를 보여주세요.
select to_char(hiredate,'YY/MM'),count(empno) from emp group by to_char(hiredate,'YY/MM')
ORDER BY 1;
--	문제3] 사원 테이블에서 업무별 최대 연봉, 최소 연봉을 출력하세요.
SELECT JOB, MAX(SAL),MIN(SAL) FROM EMP
GROUP BY JOB;

#HAVING 절
-GROUP BY 의 결과에 조건을 주어 제한할 때 사용

20] 고객 테이블에서 직업의 종류와 각 직업에 속한 사람의 수가 
	     2명 이상인 직업군의 정보를 보여주시오.
SELECT JOB,COUNT(NUM) FROM MEMBER
GROUP BY JOB HAVING COUNT(NUM)>=2;

--21] 고객 테이블에서 직업의 종류와 각 직업에 속한 최대 마일리지 정보를 보여주세요.
--	      단, 직업군의 최대 마일리지가 0인 경우는 제외시킵시다.
SELECT JOB, MAX(MILEAGE) FROM MEMBER
GROUP BY JOB HAVING MAX(MILEAGE)>0;
--
--	문제1] 상품 테이블에서 각 카테고리별로 상품을 묶은 경우, 해당 카테고리의 상품이 2개인 
--	      상품군의 정보를 보여주세요.
SELECT CATEGORY_FK,COUNT(PNUM) FROM PRODUCTS
GROUP BY CATEGORY_FK HAVING COUNT(PNUM)=2;
--
--	문제2] 상품 테이블에서 각 공급업체 코드별로 상품 판매가의 평균값 중 단위가 100단위로 떨어
--	      지는 항목의 정보를 보여주세요.
SELECT EP_CODE_FK,AVG(OUTPUT_PRICE)
FROM PRODUCTS
GROUP BY EP_CODE_FK HAVING MOD(AVG(OUTPUT_PRICE),100)=0
ORDER BY AVG(OUTPUT_PRICE) ASC;


