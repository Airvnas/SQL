--day03_subquery.sql

#subquery
- ������̺��� scott�� �޿����� ���� ����� �����ȣ,�̸�,����
    �޿��� ����ϼ���.
select sal from emp where ename = 'SCOTT';

select empno,ename,job,sal from emp 
where sal>3000;

select empno,ename,job,sal from emp 
where sal>(select sal from emp where ename = 'SCOTT');

#�������� ��ȯ�ϴ� ��������
-����2]������̺��� �޿��� ��պ��� ���� ����� ���,�̸�
	����,�޿�,�μ���ȣ�� ����ϼ���.

select empno,ename,job,sal,deptno from emp 
where sal<(select AVG(sal) from emp );

--������̺��� ����� �޿��� 20�� �μ��� �ּұ޿�
--		���� ���� �μ��� ����ϼ���.
select deptno,min(sal)
from emp
group by deptno
having min(sal)>(select min(sal) from emp where deptno=20);

#������ ��������: 1���̻��� ���� ��ȯ�ϴ� ���
=> ������ �������� �����ڸ� ����ؾ��Ѵ�.
    in ������
    any
    all
    exists
    -- �������� �ִ� �޿��� �޴� ����� 
	-- �����ȣ�� �̸��� ����ϼ���.
select job,empno,ename, sal
from emp
where (job,sal) in (select job,max(sal)
from emp group by job) order by 1;

#any ����
select deptno, ename, sal from emp
where deptno <> 20 and sal>any(select sal from emp where job='SALESMAN');
==> SALESMAN ����� �ּұ޿����� �����鼭 2-�� �μ��� �ƴ� ��������� ���

#ALL ����
select deptno, ename, sal from emp
where deptno <> 20 and sal>ALL(select sal from emp where job='SALESMAN');
==> SALESMAN ����� �ִ�޿����� �����鼭 2-�� �μ��� �ƴ� ��������� ���

#EXISTS: �������� ������ ���� ���θ� ���� �����ϴ� ���鸸 ����� ��ȯ�Ѵ�.
--������ ����
SELECT EMPNO,ENAME,SAL FROM EMP E
WHERE EXISTS (SELECT EMPNO FROM EMP WHERE E.EMPNO=MGR);

#���߿� ��������
�μ����� �ּұ޿��� �޴� ����� ���, �̸� ,�޿�, �μ���ȣ�� ����ϼ���
SELECT EMPNO,ENAME, SAL,DEPTNO FROM EMP 
WHERE (DEPTNO,SAL) IN
(SELECT DEPTNO,MIN(SAL)
FROM EMP
GROUP BY DEPTNO);

--84] �� ���̺� �ִ� �� ���� �� ���ϸ����� 
--	���� ���� �ݾ��� �� ������ �����ּ���.
SELECT *
FROM MEMBER
WHERE MILEAGE=(
SELECT MAX(MILEAGE)FROM MEMBER);

--	85] ��ǰ ���̺� �ִ� ��ü ��ǰ ���� �� ��ǰ�� �ǸŰ����� 
--	    �ǸŰ����� ��պ��� ū  ��ǰ�� ����� �����ּ���. 
--	    ��, ����� ���� ���� ����� ������ ���� �Ǹ� ������
--	    50������ �Ѿ�� ��ǰ�� ���ܽ�Ű����.
SELECT * FROM PRODUCTS
WHERE OUTPUT_PRICE>
(SELECT AVG(OUTPUT_PRICE) FROM PRODUCTS WHERE OUTPUT_PRICE<=500000)
AND OUTPUT_PRICE<=500000;

--	86] ��ǰ ���̺� �ִ� �ǸŰ��ݿ��� ��հ��� �̻��� ��ǰ ����� ���ϵ� �����
--	    ���� �� �ǸŰ����� �ִ��� ��ǰ�� �����ϰ� ����� ���ϼ���.
SELECT * FROM PRODUCTS
WHERE OUTPUT_PRICE>=
(SELECT AVG(OUTPUT_PRICE) FROM PRODUCTS 
WHERE OUTPUT_PRICE<>(SELECT MAX(OUTPUT_PRICE) FROM PRODUCTS));

--  87] ��ǰ ī�װ� ���̺��� ī�װ� �̸��� ��ǻ�Ͷ�� �ܾ ���Ե� ī�װ���
--	    ���ϴ� ��ǰ ����� �����ּ���.
SELECT * FROM PRODUCTS
WHERE CATEGORY_FK IN(
SELECT CATEGORY_CODE FROM CATEGORY
WHERE CATEGORY_NAME LIKE('%��ǻ��%'));
--
--	88] �� ���̺� �ִ� ������ �� ������ �������� ���� ���̰� ���� ����� ������
--	    ȭ�鿡 �����ּ���.
SELECT * FROM MEMBER
WHERE (JOB,AGE) IN(
SELECT JOB,MAX(AGE)FROM MEMBER
GROUP BY JOB);

--* UPDATE������ ���
--UPDATE ���̺�� SET �÷���=��,... WHERE ����
	89] �� ���̺� �ִ� �� ���� �� ���ϸ����� ���� ���� �ݾ���
	     ������ ������ ���ʽ� ���ϸ��� 5000���� �� �ִ� SQL�� �ۼ��ϼ���.
	UPDATE MEMBER
    SET MILEAGE=MILEAGE+5000
    WHERE MILEAGE=(SELECT MAX(MILEAGE) FROM MEMBER);
    ROLLBACK;
	90] �� ���̺��� ���ϸ����� ���� ���� ������ڸ� �� ���̺��� 
	      ������� �� ���� �ڿ� ����� ��¥�� ���ϴ� ������ �����ϼ���.
    UPDATE MEMBER SET REG_DATE= (SELECT MAX(REG_DATE) FROM MEMBER)
    WHERE MILEAGE = 0;
    
    * DELETE������ ���
    DELETE FROM ���̺�� WHERE ������;
	91] ��ǰ ���̺� �ִ� ��ǰ ���� �� ���ް��� ���� ū ��ǰ�� ���� ��Ű�� 
	      SQL���� �ۼ��ϼ���.
    DELETE FROM PRODUCTS WHERE INPUT_PRICE=(SELECT MAX(INPUT_PRICE) FROM PRODUCTS);
    ROLLBACK;
	92] ��ǰ ���̺��� ��ǰ ����� ���� ��ü���� ������ ��,
	     �� ���޾�ü���� �ּ� �Ǹ� ������ ���� ��ǰ�� �����ϼ���.
     DELETE FROM PRODUCTS WHERE (EP_CODE_FK,OUTPUT_PRICE) IN(
     SELECT EP_CODE_FK,MIN(OUTPUT_PRICE) FROM PRODUCTS
     GROUP BY EP_CODE_FK);
    
# INSERT���� SUBQUERY ���        
CATEGORY���̺��� ī���ؼ� CATEGORY_COPY�� ����� �����ʹ� ���� ������ �����ϼ���
�׷��� CATEGORY ���̺��� ������ǰ���� �����ͼ� CATEGORY_COPY�� INSERT�ϼ���

CREATE TABLE CATEGORY_COPY
AS
SELECT * FROM CATEGORY WHERE 1=2;
SELECT * FROM CATEGORY_COPY;
DROP TABLE CATEGORY_COPY;
    
insert into category_copy
select * from category
where category_code like '0001%';

EMP���� EMP_COPY ���̺�� ������ �����ϱ�         
�޿������ 3��޿� ���ϴ� ��������鸸 EMP_COPY�� INSERT�ϼ���

CREATE TABLE EMP_COPY
AS 
SELECT * FROM EMP WHERE 1=2;

INSERT INTO EMP_COPY
SELECT E.* FROM EMP E JOIN SALGRADE S
ON E.SAL BETWEEN S.LOSAL AND S.HISAL AND S.GRADE =3;
SELECT * FROM SALGRADE;

COMMIT;

#FROM �������� �������� ==> INLINE VIEW
EMP�� DEPT ���̺��� ������ MANAGER�� ����� �̸�, ����,�μ���,
	�ٹ����� ����ϼ���.
    SELECT ENAME, JOB,DNAME,LOC
    FROM EMP E JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO
    WHERE JOB='MANAGER';

���������� ������ ����
SELECT A.ENAME,JOB,DNAME,LOC FROM(
(SELECT * FROM EMP WHERE JOB='MANAGER') A JOIN DEPT D
ON A.DEPTNO =D.DEPTNO);

#RANK() OVER()�Լ�: ��ŷ�� �Ű��ִ� �Լ�

SELECT ENAME, SAL FROM EMP
ORDER BY SAL DESC;

SELECT* FROM(
SELECT RANK() OVER(ORDER BY SAL DESC) RNK,EMP.* FROM EMP
) WHERE RNK<=5;

#ROW_NUMBER() OVER() : ���ȣ�� �Ű��ִ� �Լ�
SELECT * FROM(
SELECT ROWNUM RN,A.* FROM
(SELECT * FROM EMP ORDER BY HIREDATE DESC)A
)
WHERE RN<=5; 

SELECT * FROM(
SELECT ROW_NUMBER() OVER(ORDER BY HIREDATE DESC)RN,EMP.*
FROM EMP) WHERE RN<=5;







