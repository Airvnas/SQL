--day03_join.sql

�μ� ���̺�� ��� ���̺��� ����

select dept.deptno, dept.dname,emp.deptno, emp.ename,job,sal
from dept, emp
where dept.deptno = emp.deptno order by 1;

����� �������� �̿��� ����=> ǥ��

select d.*,e.*
from dept d join emp e
on d.deptno= e.deptno order by d.deptno;

--SALESMAN�� �����ȣ,�̸�,�޿�,�μ���,�ٹ����� ����Ͽ���.

select e.empno, e.ename, e.sal, d.dname, d.loc
from emp e join dept d
on e.deptno = d.deptno
where e.job = 'SALESMAN';

--���� ������ �ִ� ī�װ� ���̺�� ��ǰ ���̺��� �̿��Ͽ� �� ��ǰ���� ī�װ�
--	      �̸��� ��ǰ �̸��� �Բ� �����ּ���.

SELECT C.category_name,P.PRODUCTS_NAME
FROM CATEGORY C JOIN PRODUCTS P
ON c.category_code = P.CATEGORY_FK ORDER BY 1;


--ī�װ� ���̺�� ��ǰ ���̺��� �����Ͽ� ȭ�鿡 ����ϵ� ��ǰ�� ���� ��
--	      ������ü�� �Ｚ�� ��ǰ�� ������ �����Ͽ� ī�װ� �̸��� ��ǰ�̸�, ��ǰ����
--	      ������ ���� ������ ȭ�鿡 �����ּ���.
SELECT  C.category_name,P.PRODUCTS_NAME,OUTPUT_PRICE,COMPANY
FROM CATEGORY C JOIN PRODUCTS P
ON c.category_code = P.CATEGORY_FK AND P.COMPANY='�Ｚ';
--�� ��ǰ���� ī�װ� �� ��ǰ��, ������ ����ϼ���. �� ī�װ��� 'TV'�� ���� 
--	      �����ϰ� ������ ������ ��ǰ�� ������ ������ ������ �����ϼ���
select category_name, products_name, output_price
from category c join products p
on c.category_name != 'TV' and c.category_code = p.category_fk order by 3;

SELECT D.DNAME,E.ENAME
FROM DEPT D JOIN EMP E
USING(DEPTNO);

#NON-EQUIJOIN
���� ������ =�� �ƴ� �ٸ� �����ȣ�� ��������� ���

SELECT EMPNO, ENAME, SAL, GRADE, LOSAL,HISAL
FROM EMP E JOIN SALGRADE S
ON E.SAL BETWEEN S.LOSAL AND S.HISAL;

--97] ���޾�ü ���̺�� ��ǰ ���̺��� �����Ͽ� ���޾�ü �̸�, ��ǰ��,
--		���ް��� ǥ���ϵ� ��ǰ�� ���ް��� 100000�� �̻��� ��ǰ ����
--		�� ǥ���ϼ���. ��, ���⼭�� ���޾�üA�� ���޾�üB�� ��� ǥ��
--		�ǵ��� �ؾ� �մϴ�.
SELECT S.EP_NAME,p.products_name,p.input_price
FROM PRODUCTS P JOIN SUPPLY_COMP S
ON (S.EP_NAME='���޾�üA' OR S.EP_NAME='���޾�üB') AND P.INPUT_PRICE >=100000;

#CARTESIAN PRODUCT : ������ ���
SELECT D.*,E.*
FROM DEPT D,EMP E;

#OUTER JOIN
EQUAL ���ǿ� �������� �ʴ� �����Ͱ� �ִ��� NULL�� �����Ͽ� �������

SELECT D.DEPTNO,DNAME,ENAME,JOB
FROM DEPT D, EMP E
WHERE D.DEPTNO= E.DEPTNO(+) ORDER BY 1;

����� �������� ���
[1] LEFT OUTER JOIN : ���� ���̺� �������� ���
[2] RIGHT OUTER JOIN: ������ ���̺� �������� ���
[3] FULL OUTER JOIN : ���� �� �ƿ��� ������ �Ŵ� ���

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

--����98] ��ǰ���̺��� ��� ��ǰ�� ���޾�ü, ���޾�ü�ڵ�, ��ǰ�̸�, 
--          ��ǰ���ް�, ��ǰ �ǸŰ� ������ ����ϵ� ���޾�ü�� ����
--          ��ǰ�� ����ϼ���(��ǰ�� ��������).
SELECT s.ep_name,S.EP_CODE,P.PRODUCTS_NAME,p.input_price,p.output_price
FROM PRODUCTS P LEFT OUTER JOIN SUPPLY_COMP S
ON S.EP_CODE = p.ep_code_fk;

--	����99] ��ǰ���̺��� ��� ��ǰ�� ���޾�ü, ī�װ���, ��ǰ��, ��ǰ�ǸŰ�
--		������ ����ϼ���. ��, ���޾�ü�� ��ǰ ī�װ��� ���� ��ǰ��
--		����մϴ�.
SELECT S.EP_NAME,C.CATEGORY_NAME ,P.PRODUCTS_NAME, P.OUTPUT_PRICE 
FROM PRODUCTS P LEFT OUTER JOIN SUPPLY_COMP S
ON S.EP_CODE = p.ep_code_fk
LEFT OUTER JOIN CATEGORY C
ON p.category_fk=c.category_code;

#SELF JOIN
�� ����� ������ ����ϵ� ������� ������ �̸��� �Բ� �����ּ���
SELECT E.EMPNO, E.ENAME,M.EMPNO , M.ENAME "MANAGER"
FROM EMP E JOIN EMP M
ON E.MGR = M.EMPNO;

--[����] emp���̺��� "������ �����ڴ� �����̴�"�� ������ ����ϼ���.
SELECT E.ENAME||'�� �����ڴ� '||M.ENAME||'�̴�.'
FROM EMP E JOIN EMP M
ON E.MGR = M.EMPNO;

#UNION: ������
SELECT DEPTNO FROM DEPT UNION
SELECT DEPTNO FROM EMP;

#UNION ALL
SELECT DEPTNO FROM DEPT UNION ALL
SELECT DEPTNO FROM EMP;

#INTERSECT: ������
SELECT DEPTNO FROM DEPT 
INTERSECT SELECT DEPTNO FROM EMP;

#MINUS: ������
SELECT DEPTNO FROM DEPT MINUS
SELECT DEPTNO FROM EMP;

1. emp���̺��� ��� ����� ���� �̸�,�μ���ȣ,�μ����� ����ϴ� 
   ������ �ۼ��ϼ���.
SELECT E.ENAME,E.DEPTNO,D.DNAME
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;

2. emp���̺��� NEW YORK���� �ٹ��ϰ� �ִ� ����� ���Ͽ� �̸�,����,�޿�,
    �μ����� ����ϴ� SELECT���� �ۼ��ϼ���.
SELECT E.ENAME,E.JOB,E.SAL,D.DNAME,D.LOC
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO AND D.LOC='NEW YORK';

3. EMP���̺��� ���ʽ��� �޴� ����� ���Ͽ� �̸�,�μ���,��ġ�� ����ϴ�
    SELECT���� �ۼ��ϼ���.
SELECT E.ENAME,E.JOB,E.SAL,D.DNAME,D.LOC
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO AND E.COMM IS NOT NULL;


5. �Ʒ��� ����� ����ϴ� ������ �ۼ��Ͽ���(�����ڰ� ���� King�� �����Ͽ�
	��� ����� ���)

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



