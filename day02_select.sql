--day02_select.sql

select * from tab;
select * from emp;
select * from dept;
select * from salgrade;

select EMPNO, ENAME, SAL, SAL+500 ,SAL*12+NVL(COMM,0) "YEAR SAL" FROM EMP;

--NVL()
--NVL2(EXPR,��1,��2)" EXPR�� NULL�� �ƴҰ�� ��1, NULL�ϰ�� ��2
SELECT EMPNO,ENAME,MGR, NVL2(MGR,'����������','�����ھ���') "������ ����" FROM EMP;

SELECT ENAME||' IS A '||JOB AS "EMPLOYEE INFO" FROM EMP;

SELECT ENAME||':1 YEAR SALARY = '||SAL*12 AS "SAL INFO" FROM EMP;

--DISTINCT: �ߺ��� ����
SELECT JOB FROM EMP;
SELECT DISTINCT JOB FROM EMP;

SELECT DISTINCT DEPTNO, JOB FROM EMP ORDER BY DEPTNO;

-- [����]
--	 1] EMP���̺��� �ߺ����� �ʴ� �μ���ȣ�� ����ϼ���.
SELECT DISTINCT DEPTNO FROM EMP;

--	 2] MEMBER���̺��� ȸ���� �̸��� ���� ������ �����ּ���.
SELECT NAME, AGE, JOB FROM MEMBER;

--	 3] CATEGORY ���̺� ����� ��� ������ �����ּ���.
SELECT * FROM CATEGORY;

--	 4] MEMBER���̺��� ȸ���� �̸��� ������ ���ϸ����� �����ֵ�,
--	      ���ϸ����� 13�� ���� ����� "MILE_UP"�̶�� ��Ī����
--	      �Բ� �����ּ���.
SELECT NAME, MILEAGE*13 AS "MILE_UP" FROM MEMBER;

--#Ư�� �� �˻� - WHERE�� �̿��ؼ� ���Ǻο�

SELECT EMPNO, ENAME, JOB, SAL FROM EMP WHERE SAL>=3000;

--EMP���̺��� �������� MANAGER�� �����
--������ �����ȣ,�̸�,����,�޿�,�μ���ȣ�� ����ϼ���.
SELECT EMPNO,ENAME, JOB, SAL, DEPTNO 
FROM EMP 
WHERE JOB='MANAGER';
--SQL���� ��ҹ��� ��������������, ��(���ͷ�)�� ��ҹ��� ����

--EMP���̺��� 1982�� 1��1�� ���Ŀ� �Ի��� ����� 
--�����ȣ,����,����,�޿�,�Ի����ڸ� ����ϼ���
SELECT EMPNO, ENAME, JOB, SAL, HIREDATE 
FROM EMP 
WHERE HIREDATE >'82/01/01' ;

--emp���̺��� �޿��� 1300���� 1500������ ����� �̸�,����,�޿�,
--	�μ���ȣ�� ����ϼ���.
SELECT ENAME, JOB, SAL
FROM EMP
WHERE SAL BETWEEN 1300 AND 1500;

--emp���̺��� �����ȣ�� 7902,7788,7566�� ����� �����ȣ,
--	�̸�,����,�޿�,�Ի����ڸ� ����ϼ���.
SELECT EMPNO, ENAME, JOB,SAL,HIREDATE
FROM EMP
WHERE EMPNO IN(7902,7788,7566);

--10�� �μ��� �ƴ� ����� �̸�,����,�μ���ȣ�� ����ϼ���
SELECT ENAME,JOB,DEPTNO
FROM EMP
WHERE DEPTNO NOT IN (10);

--emp���̺��� ������ SALESMAN �̰ų� PRESIDENT��
--	����� �����ȣ,�̸�,����,�޿��� ����ϼ���.
SELECT EMPNO,ENAME,JOB,SAL
FROM EMP
WHERE JOB IN('SALESMAN', 'PRESIDENT');
--WHERE JOB ='SALESMAN'OR JOB= 'PRESIDENT');

--	Ŀ�̼�(COMM)�� 300�̰ų� 500�̰ų� 1400�� ��������� ����ϼ���
SELECT EMPNO,ENAME,JOB,SAL
FROM EMP
WHERE COMM IN (300,500,1400);

--	Ŀ�̼��� 300,500,1400�� �ƴ� ����� ������ ����ϼ���

SELECT EMPNO,ENAME,JOB,SAL
FROM EMP
WHERE COMM NOT IN (300,500,1400);

SELECT * FROM EMP 
--WHERE COMM=NULL;[X]
WHERE COMM IS NULL;
--NULL���� �񱳴� IS NULL �Ǵ� IS NOT NULL�� ��

--emp���� �̸��� S�ڷ� �����ϴ� ��� ������ �����ּ���
SELECT * FROM EMP 
WHERE ENAME LIKE 'S%';

--	-�̸� �� S�ڰ� ���� ����� ������ �����ּ���.
SELECT * FROM EMP 
WHERE ENAME LIKE '%S%';

--    - �̸��� �ι� °�� O�ڰ� ���� ����� ������ �����ּ���.
SELECT * FROM EMP 
WHERE ENAME LIKE '_O%';

-- EMP���̺��� �Ի����ڰ� 82�⵵�� �Ի��� ����� ���,�̸�,����
--	   �Ի����ڸ� ����ϼ���.
SELECT EMPNO,ENAME,JOB,HIREDATE
FROM EMP
WHERE HIREDATE LIKE '82%';

ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD';
ALTER SESSION SET NLS_DATE_FORMAT='YY/MM/DD';
-- �� ���̺� ��� ���� �达�� ����� ������ �����ּ���.
SELECT *
FROM MEMBER
WHERE NAME LIKE '��%';
-- �� ���̺� ��� '����'�� ���Ե� ������ �����ּ���.
SELECT *
FROM MEMBER
WHERE ADDR LIKE '%����%';
SELECT * FROM MEMBER;
-- ī�װ� ���̺� ��� category_code�� 0000�� ���� ��ǰ������ �����ּ���.
SELECT *
FROM CATEGORY
WHERE category_code LIKE '%0000';

- EMP���̺��� �޿��� 1100�̻��̰� JOB�� MANAGER�� �����
	���,�̸�,����,�޿��� ����ϼ���.
SELECT EMPNO, ENAME, JOB, SAL
FROM EMP
WHERE SAL>=1100 AND JOB='MANAGER';

- EMP���̺��� �޿��� 1100�̻��̰ų� JOB�� MANAGER�� �����
	���,�̸�,����,�޿��� ����ϼ���.
SELECT EMPNO, ENAME, JOB, SAL
FROM EMP
WHERE SAL>=1100 OR JOB='MANAGER';

- EMP���̺��� JOB�� MANAGER,CLERK,ANALYST�� �ƴ�
	  ����� ���,�̸�,����,�޿��� ����ϼ���.
SELECT EMPNO, ENAME, JOB, SAL
FROM EMP
WHERE JOB NOT IN('MANAGER','CLERK','ANALYST');

SELECT EMPNO, ENAME, JOB, SAL
FROM EMP
WHERE JOB <>'MANAGER' AND JOB <>'CLERK' AND JOB!='ANALYST';

--- EMP���̺��� �޿��� 1000�̻� 1500���ϰ� �ƴ� ����� ������ �����ּ���
SELECT * FROM emp
WHERE  SAL NOT BETWEEN 1000 AND 1500;
--
--- EMP���̺��� �̸��� 'S'�ڰ� ���� ���� ����� �̸��� ���
--	  ����ϼ���.
SELECT * FROM emp
WHERE ENAME NOT LIKE '%S%';
--- ������̺��� ������ PRESIDENT�̰� �޿��� 1500�̻��̰ų�
--	   ������ SALESMAN�� ����� ���,�̸�,����,�޿��� ����ϼ���.
SELECT * FROM emp 
WHERE JOB='PRESIDENT' AND SAL>=1500 OR JOB='SALESMAN';

ORDER BY��
-��������:ASC
-��������:DESC
-NULL ���� ���������϶� ���� ���߿�, ������������ ���������

WGHO ����
-WHERE
-GROUP BY
-HAVING
-ORDER BY

������̺��� �Ի����� ������ �����Ͽ� ���,�̸�,����,�޿�,
	�Ի����ڸ� ����ϼ���.
SELECT EMPNO, ENAME, JOB, SAL, HIREDATE
FROM EMP ORDER BY HIREDATE;

SELECT EMPNO, ENAME, JOB, SAL, HIREDATE
FROM EMP ORDER BY HIREDATE DESC;

SELECT EMPNO,ENAME,SAL, SAL*12 FROM EMP ORDER BY SAL*12 DESC;

SELECT EMPNO,ENAME,SAL, SAL*12 Y FROM EMP ORDER BY Y DESC;
SELECT EMPNO,ENAME,SAL, SAL*12  FROM EMP 
ORDER BY 1 DESC;
--���ڴ� �÷��ε���

-- ��� ���̺��� �μ���ȣ�� ������ �� �μ���ȣ�� ���� ���
--	�޿��� ���� ������ �����Ͽ� ���,�̸�,����,�μ���ȣ,�޿���
--	����ϼ���.
SELECT EMPNO, ENAME, JOB, DEPTNO,SAL
FROM EMP
ORDER BY DEPTNO ASC, SAL DESC;
--
--	��� ���̺��� ù��° ������ �μ���ȣ��, �ι�° ������
--	������, ����° ������ �޿��� ���� ������ �����Ͽ�
--	���,�̸�,�Ի�����,�μ���ȣ,����,�޿��� ����ϼ���.
SELECT EMPNO, ENAME, HIREDATE, DEPTNO,JOB,SAL
FROM EMP
ORDER BY DEPTNO,JOB, SAL DESC;

--1] ��ǰ ���̺��� �Ǹ� ������ ������ ������� ��ǰ�� �����ؼ� 
--    �����ּ���.
SELECT *
FROM PRODUCTS
ORDER BY OUTPUT_PRICE;

--2] �� ���̺��� ������ �̸��� ������ ������ �����ؼ� �����ּ���.
--      ��, �̸��� ���� ��쿡�� ���̰� ���� ������� �����ּ���.
SELECT *
FROM MEMBER
ORDER BY NAME, AGE DESC;
--
--3] ��ǰ ���̺��� ��ۺ��� ������������ �����ϵ�, 
--	    ���� ��ۺ� �ִ� ��쿡��
--		���ϸ����� ������������ �����Ͽ� �����ּ���.
SELECT *
FROM PRODUCTS
ORDER BY TRANS_COST, MILEAGE;
--
--4]������̺��̼� �Ի����� 1981 2��20�� ~ 1981 5��1�� ���̿�
--	    �Ի��� ����� �̸�,���� �Ի����� ����ϵ�, �Ի��� ������ ����ϼ���.
SELECT ENAME, JOB, HIREDATE
FROM EMP
WHERE HIREDATE >= '81/02/20' AND HIREDATE <='81/05/01' 
ORDER BY HIREDATE ASC;
select ename,job,hiredate
from emp where hiredate between '1981-02-20' and '1981-05-01'
order by hiredate asc;


SELECT * FROM EMP ORDER BY HIREDATE;

--5] ������̺��� �μ���ȣ�� 10,20�� ����� �̸�,�μ���ȣ,������ ����ϵ�
--	    �̸� ������ �����Ͻÿ�.
SELECT ENAME, DEPTNO,JOB
FROM EMP
WHERE DEPTNO = 10 OR DEPTNO =20 ORDER BY ENAME;

--6] ������̺��� ���ʽ��� �޿����� 10%�� ���� ����� �̸�,�޿�,���ʽ�
--    �� ����ϼ���.
SELECT ENAME, SAL, COMM
FROM EMP 
WHERE 1.1*NVL(COMM,0)>SAL;

--7] ������̺��� ������ CLERK�̰ų� ANALYST�̰�
--     �޿��� 1000,3000,5000�� �ƴ� ��� ����� ������ 
--SELECT * FROM EMP
--WHERE JOB IN('CLERK','ANALYST) AND SAL NOT IN(1000,3000,5000);
--8] ������̺��� �̸��� L�� ���ڰ� �ְ� �μ��� 30�̰ų�
--    �Ǵ� �����ڰ� 7782���� ����� ������ ����ϼ���.
SELECT * FROM EMP
WHERE ENAME LIKE '%LL%' AND DEPTNO=30 OR MGR =7782;






















