--day03_join.sql

부서 테이블과 사원 테이블을 조인

select dept.deptno, dept.dname,emp.deptno, emp.ename,job,sal
from dept, emp
where dept.deptno = emp.deptno order by 1;

명시적 조인절을 이용한 조인=> 표준

select d.*,e.*
from dept d join emp e
on d.deptno= e.deptno order by d.deptno;

--SALESMAN의 사원번호,이름,급여,부서명,근무지를 출력하여라.

select e.empno, e.ename, e.sal, d.dname, d.loc
from emp e join dept d
on e.deptno = d.deptno
where e.job = 'SALESMAN';

--서로 연관이 있는 카테고리 테이블과 상품 테이블을 이용하여 각 상품별로 카테고리
--	      이름과 상품 이름을 함께 보여주세요.

SELECT C.category_name,P.PRODUCTS_NAME
FROM CATEGORY C JOIN PRODUCTS P
ON c.category_code = P.CATEGORY_FK ORDER BY 1;


--카테고리 테이블과 상품 테이블을 조인하여 화면에 출력하되 상품의 정보 중
--	      제조업체가 삼성인 상품의 정보만 추출하여 카테고리 이름과 상품이름, 상품가격
--	      제조사 등의 정보를 화면에 보여주세요.
SELECT  C.category_name,P.PRODUCTS_NAME,OUTPUT_PRICE,COMPANY
FROM CATEGORY C JOIN PRODUCTS P
ON c.category_code = P.CATEGORY_FK AND P.COMPANY='삼성';
--각 상품별로 카테고리 및 상품명, 가격을 출력하세요. 단 카테고리가 'TV'인 것은 
--	      제외하고 나머지 정보는 상품의 가격이 저렴한 순으로 정렬하세요
select category_name, products_name, output_price
from category c join products p
on c.category_name != 'TV' and c.category_code = p.category_fk order by 3;

SELECT D.DNAME,E.ENAME
FROM DEPT D JOIN EMP E
USING(DEPTNO);

#NON-EQUIJOIN
조인 조건이 =이 아닌 다른 연산기호로 만들어지는 경우

SELECT EMPNO, ENAME, SAL, GRADE, LOSAL,HISAL
FROM EMP E JOIN SALGRADE S
ON E.SAL BETWEEN S.LOSAL AND S.HISAL;

--97] 공급업체 테이블과 상품 테이블을 조인하여 공급업체 이름, 상품명,
--		공급가를 표시하되 상품의 공급가가 100000원 이상의 상품 정보
--		만 표시하세요. 단, 여기서는 공급업체A와 공급업체B가 모두 표시
--		되도록 해야 합니다.
SELECT S.EP_NAME,p.products_name,p.input_price
FROM PRODUCTS P JOIN SUPPLY_COMP S
ON (S.EP_NAME='공급업체A' OR S.EP_NAME='공급업체B') AND P.INPUT_PRICE >=100000;

#CARTESIAN PRODUCT : 모든것을 출력
SELECT D.*,E.*
FROM DEPT D,EMP E;

#OUTER JOIN
EQUAL 조건에 만족하지 않는 데이터가 있더라도 NULL로 설정하여 출력해줌

SELECT D.DEPTNO,DNAME,ENAME,JOB
FROM DEPT D, EMP E
WHERE D.DEPTNO= E.DEPTNO(+) ORDER BY 1;

명시적 조인절일 경우
[1] LEFT OUTER JOIN : 왼쪽 테이블 기준으로 출력
[2] RIGHT OUTER JOIN: 오른쪽 테이블 기준으로 출력
[3] FULL OUTER JOIN : 양쪽 다 아우터 조인을 거는 경우

[1]LEFT OUTER JOIN
SELECT DISTINCT(E.DEPTNO),D.DEPTNO
FROM DEPT D LEFT OUTER JOIN EMP E
ON D.DEPTNO = E.DEPTNO ORDER BY 2;

[2]RIGHT OUTER JOIN
SELECT DISTINCT(E.DEPTNO),D.DEPTNO
FROM DEPT D RIGHT OUTER JOIN EMP E
ON D.DEPTNO = E.DEPTNO ORDER BY 2;

[3]FULL OUTER JOIN
SELECT DISTINCT(E.DEPTNO), D.DEPTNO
FROM DEPT D FULL OUTER JOIN EMP E
ON D.DEPTNO= E.DEPTNO ORDER BY 2;

--문제98] 상품테이블의 모든 상품을 공급업체, 공급업체코드, 상품이름, 
--          상품공급가, 상품 판매가 순서로 출력하되 공급업체가 없는
--          상품도 출력하세요(상품을 기준으로).
SELECT s.ep_name,S.EP_CODE,P.PRODUCTS_NAME,p.input_price,p.output_price
FROM PRODUCTS P LEFT OUTER JOIN SUPPLY_COMP S
ON S.EP_CODE = p.ep_code_fk;

--	문제99] 상품테이블의 모든 상품을 공급업체, 카테고리명, 상품명, 상품판매가
--		순서로 출력하세요. 단, 공급업체나 상품 카테고리가 없는 상품도
--		출력합니다.
SELECT S.EP_NAME,C.CATEGORY_NAME ,P.PRODUCTS_NAME, P.OUTPUT_PRICE 
FROM PRODUCTS P LEFT OUTER JOIN SUPPLY_COMP S
ON S.EP_CODE = p.ep_code_fk
LEFT OUTER JOIN CATEGORY C
ON p.category_fk=c.category_code;

#SELF JOIN
각 사원의 정보를 출력하되 사원들의 관리자 이름도 함께 보여주세요
SELECT E.EMPNO, E.ENAME,M.EMPNO , M.ENAME "MANAGER"
FROM EMP E JOIN EMP M
ON E.MGR = M.EMPNO;

--[문제] emp테이블에서 "누구의 관리자는 누구이다"는 내용을 출력하세요.
SELECT E.ENAME||'의 관리자는 '||M.ENAME||'이다.'
FROM EMP E JOIN EMP M
ON E.MGR = M.EMPNO;

#UNION: 합집합
SELECT DEPTNO FROM DEPT UNION
SELECT DEPTNO FROM EMP;

#UNION ALL
SELECT DEPTNO FROM DEPT UNION ALL
SELECT DEPTNO FROM EMP;

#INTERSECT: 교집합
SELECT DEPTNO FROM DEPT 
INTERSECT SELECT DEPTNO FROM EMP;

#MINUS: 차집합
SELECT DEPTNO FROM DEPT MINUS
SELECT DEPTNO FROM EMP;

1. emp테이블에서 모든 사원에 대한 이름,부서번호,부서명을 출력하는 
   문장을 작성하세요.
SELECT E.ENAME,E.DEPTNO,D.DNAME
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;

2. emp테이블에서 NEW YORK에서 근무하고 있는 사원에 대하여 이름,업무,급여,
    부서명을 출력하는 SELECT문을 작성하세요.
SELECT E.ENAME,E.JOB,E.SAL,D.DNAME,D.LOC
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO AND D.LOC='NEW YORK';

3. EMP테이블에서 보너스를 받는 사원에 대하여 이름,부서명,위치를 출력하는
    SELECT문을 작성하세요.
SELECT E.ENAME,E.JOB,E.SAL,D.DNAME,D.LOC
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO AND E.COMM IS NOT NULL;


5. 아래의 결과를 출력하는 문장을 작성하에요(관리자가 없는 King을 포함하여
	모든 사원을 출력)

	---------------------------------------------
	Emplyee		Emp#		Manager	Mgr#
	---------------------------------------------
	KING		7839
	BLAKE		7698		KING		7839
	CKARK		7782		KING		7839
	.....
	---------------------------------------------
SELECT E.ENAME Employee, E.EMPNO "Emp#", M.ENAME Manager, m.empno "Mgr#"
FROM EMP E LEFT OUTER JOIN EMP M
ON E.MGR=M.EMPNO ORDER BY 3 DESC;

SELECT  E.ENAME Employee, E.EMPNO "Emp#", M.ENAME Manager, m.empno "Mgr#"
FROM EMP E, EMP M
WHERE E.MGR = M.EMPNO(+) ORDER BY 3 DESC;



