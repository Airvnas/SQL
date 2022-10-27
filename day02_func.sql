1.������ �Լ�
2.�׷��Լ�
3.��Ÿ�Լ�

#������ �Լ�
[1] ������ �Լ�
[2] ������ �Լ�
[3] ��¥�� �Լ�
[4] ��ȯ �Լ�
[5] �Ϲ��Լ�

#[1] ������ �Լ�
select lower('HAPPY BIRTHDAY'),UPPER('Happy Birthday') FROM DUAL;

SELECT * FROM DUAL;
1�� 1���� ���� ���� ���̺�

#initcap(): ù ���ڸ� �빮�ڷ� ��ȯ
select deptno, dname, initcap(dname),initcap(loc) from dept;

concat(����1,����2): 2�� �̻��� ���ڸ� �������ش�.
select concat('abc','1234') from dual;

--[����] ��� ���̺��� SCOTT�� ���,�̸�,������(�ҹ��ڷ�),�μ���ȣ��
--		����ϼ���.
select empno, ename, lower(job),deptno
from EMP
where ename = 'SCOTT';

--	 ��ǰ ���̺��� �ǸŰ��� ȭ�鿡 ������ �� �ݾ��� ������ �Բ� 
--	 �ٿ��� ����ϼ���.
select products_name, concat(output_price,'��') "�ǸŰ�"
from products;

--	 �����̺��� �� �̸��� ���̸� �ϳ��� �÷����� ����� ������� ȭ�鿡
--	       �����ּ���.
select concat(name,age) from member;

--#substr(����,i,len):���� i�ε����� ������ len���� ���̸�ŭ�� ������ ��ȯ��
--I�� ����� ��� �տ������� �����ϰ�� �ڿ�������
select substr('ABCDEFG',3,4)  FROM DUAL;
--�ֹι�ȣ ���ڸ� �߶󳻱�
select substr('991203-1012369',8)from dual;
select substr('991203-1012369',-7)from dual;

#LENGTH(����): ���ڿ� ���� ��ȯ
SELECT LENGTH('991203-1012369') FROM DUAL;

--[����]
--	��� ���̺��� ù���ڰ� 'K'���� ũ�� 'Y'���� ���� �����
--	  ���,�̸�,����,�޿��� ����ϼ���. �� �̸������� �����ϼ���.
SELECT EMPNO, ENAME, JOB, SAL
FROM EMP
WHERE substr(ENAME,1,1)>'K' and substr(ENAME,1,1)<'Y' ORDER BY ENAME;

--
--	������̺��� �μ��� 20���� ����� ���,�̸�,�̸��ڸ���,
--	�޿�,�޿��� �ڸ����� ����ϼ���.

SELECT EMPNO,ENAME,LENGTH(ENAME)"�̸� �ڸ���",SAL,LENGTH(SAL) "�޿� �ڸ���"
FROM EMP
WHERE DEPTNO=20;
--	
--	������̺��� ����̸� �� 6�ڸ� �̻��� �����ϴ� ������̸��� 
--	�̸��ڸ����� �����ּ���.
SELECT ENAME,LENGTH(ENAME)
FROM EMP
WHERE LENGTH(ENAME)>=6;

#LPAD/RPAD
LPAD(�÷�,����1,����2):���� ���� ���ʺ��� ä���
RPAD(�÷�,����1,����2):���� ���� �����ʺ��� ä���

SELECT ENAME, LPAD(ENAME,15,'*'),SAL,LPAD(SAL,10,'*') FROM EMP
WHERE DEPTNO=10;

SELECT RPAD(DNAME,15,'#')FROM DEPT;

--#LTRIM/RTRIM
--LTRIM(����1,����2): ���� 1�� ���� ���� 2�� ���� �ܾ ������ �� ���ڸ� ������ ������ ���� ��ȯ
SELECT LTRIM('TTTHELLO TEST','T'),RTRIM('TTTHELLO TEST','T') FROM DUAL;

#REPLACE(�÷�1,����1,����2): �÷����� ���� 1�� �ش��ϴ� ���ڸ� ���� 2�� ��ü�Ѵ�.

SELECT REPLACE('ORACLE TEST','TEST','HI') FROM DUAL;


--������̺��� ������ �� ������ 'A'�� �����ϰ�
--�޿��� ������ 1�� �����Ͽ� ����ϼ���.
SELECT LTRIM(JOB,'A'),LTRIM(SAL,1)
FROM EMP;

--������̺��� 10�� �μ��� ����� ���� ������ �� ������'T'��
--	�����ϰ� �޿��� ������ 0�� �����Ͽ� ����ϼ���.

SELECT RTRIM(JOB,'T'),RTRIM(SAL,0)
FROM EMP
WHERE DEPTNO=10;

--������̺� JOB���� 'A'�� '$'�� �ٲپ� ����ϼ���.
SELECT REPLACE(JOB,'A','$')
FROM EMP;

--�� ���̺��� ������ �ش��ϴ� �÷����� ���� ������ �л��� ������ ���
--	 ���л����� ������ ��µǰ� �ϼ���.
SELECT REPLACE(JOB,'�л�','���л�')
FROM MEMBER;
--
-- �� ���̺� �ּҿ��� ����ø� ����Ư���÷� �����ϼ���.
UPDATE MEMBER SET ADDR = REPLACE(ADDR,'�����','����Ư����');

ROLLBACK;

#[2] ������ �Լ�
#ROUND(��),ROUND(��,�ڸ���):�ݿø��Լ�
SELECT ROUND(4567.567),ROUND(4567.567,0),ROUND(4567.567,2),
ROUND(4567.567,-1) FROM DUAL;

#TRUNC(): ������
SELECT TRUNC(4567.567),TRUNC(4567.567,0),TRUNC(4567.567,2),
TRUNC(4567.567,-2) FROM DUAL;

#MOD(��1,��2):������ ���� ��ȯ
--�� ���̺��� ȸ���̸�, ���ϸ���,����, ���ϸ����� ���̷� �������� �ݿø��Ͽ� ����ϼ���
SELECT NAME,MILEAGE,AGE,ROUND(MILEAGE/AGE)
FROM MEMBER;
--��ǰ ���̺��� ��ǰ ������� ��� �������� ���� ��ۺ� ���Ͽ� ����ϼ���.
SELECT PRODUCTS_NAME,TRANS_COST,TRUNC(TRANS_COST,-3)
FROM PRODUCTS;
--������̺��� �μ���ȣ�� 10�� ����� �޿��� 	30���� ���� �������� ����ϼ���.
SELECT DEPTNO, ENAME, SAL,TRUNC(SAL/30), MOD(SAL,30) FROM EMP
WHERE DEPTNO=10;

#CHR(),ASCII()
SELECT CHR(65),ASCII('A') FROM DUAL;

#ABS(��): ���밪�� ���ϴ� �Լ�
SELECT NAME, AGE, AGE-40,ABS(AGE-40) FROM MEMBER;

#CEIL():�ø���
#FLOOR():������

SELECT CEIL(123.001),FLOOR(123.001) FROM DUAL;

#POWER()
#SQRT()
#SIGN()
SELECT POWER(2,7),SQRT(64),SQRT(133) FROM DUAL;

#[3] ��¥�� �Լ�

SELECT SYSDATE, SYSTIMESTAMP FROM DUAL;

SELECT SYSDATE+3"3�� ��",SYSDATE-2"��Ʋ��"FROM DUAL;

�νð���
SELECT SYSTIMESTAMP,TO_CHAR(SYSTIMESTAMP+2/24,'YY/MM/DD HH24:MI:SS')"�νð���" FROM DUAL;
SELECT HIREDATE,SYSDATE,TRUNC(SYSDATE-HIREDATE),
TRUNC((SYSDATE-HIREDATE)/7) WEEKS,TRUNC(MOD((SYSDATE-HIREDATE),7)) FROM EMP;

select concat(round((sysdate-hiredate)/7),'��'),
concat(floor(mod(sysdate-hiredate,7)),'��') from emp;

#MONTHS_BETWEEN(DATE1,DATE2):��¥1�� ��¥2 ������ ������ ����Ѵ�.
SELECT MONTHS_BETWEEN(SYSDATE,TO_DATE('22-07-01')) FROM EMP;

#ADD_MONTHS(DATE,N):��¥�� N������ ����
SELECT ADD_MONTHS(SYSDATE,2) FROM DUAL;

#LAST_DAY(D): ���� ������ ��¥�� ��ȯ��(���, ���� �ڵ����)
SELECT LAST_DAY('22-02-01'),LAST_DAY('20-02-01'),LAST_DAY(SYSDATE) FROM DUAL;

--�� ���̺��� �� ���� �Ⱓ�� ���� ���� ȸ���̶�� �����Ͽ� ������� ��������
--	   ���� ȸ���� ���� ������ �����ּ���.
SELECT NAME,REG_DATE,ADD_MONTHS(REG_DATE,2) "���� ������" FROM MEMBER;

SELECT SYSDATE FROM DUAL;
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD HH:MI:SS')FROM DUAL;
SELECT TO_CHAR(SYSDATE,'CC YEAR')FROM DUAL;

#[4]��ȯ�Լ�
TO_CHAR()
TO_DATE()
TO_NUMBER()

# TO_CHAR(��¥): ��¥������ ���ڿ��� ��ȯ
# TO_CHAR(����): ���������� ���ڿ��� ��ȯ
  
  TO_CHAR(D,�������)
  SELECT TO_CHAR(SYSDATE),TO_CHAR(SYSDATE,'YY-MM-DD HH12:MI:SS') FROM DUAL;
  
--  �����̺��� ������ڸ� 0000-00-00 �� ���·� ����ϼ���.
SELECT * FROM MEMBER WHERE TO_CHAR(REG_DATE,'YYYY')='2013';
--	 �����̺� �ִ� �� ���� �� ��Ͽ����� 2003���� 
--	 ���� ������ �����ּ���.
SELECT * FROM MEMBER
WHERE REG_DATE=13/%%/%%;
SELECT * FROM MEMBER;
--	 �����̺� �ִ� �� ���� �� ������ڰ� 2013�� 5��1�Ϻ��� 
--	 ���� ������ ����ϼ���. 
--	 ��, ����� ������ ��, ���� ���̵��� �մϴ�.
SELECT TO_CHAR(REG_DATE,'YYYY-MM')
FROM MEMBER
WHERE TO_CHAR(REG_DATE,'YYYY-MM-DD')>'2013-05-01';
  
TO_CHAR(N,�������): �������� ���ڿ��� ��ȯ

SELECT TO_CHAR(100000,'999,999'),TO_CHAR(100000,'$999G999')FROM DUAL;
  
--  ��ǰ ���̺��� ��ǰ�� ���� �ݾ��� ���� ǥ�� ������� ǥ���ϼ���.
--	  õ�ڸ� ���� , �� ǥ���մϴ�.
SELECT PRODUCTS_NAME,INPUT_PRICE, TO_CHAR(INPUT_PRICE,'9999,999,999') FROM PRODUCTS;
--	 74] ��ǰ ���̺��� ��ǰ�� �ǸŰ��� ����ϵ� ��ȭ�� ǥ���� �� ����ϴ� �����
--	  ����Ͽ� ����ϼ���.[��: \10,000]
SELECT PRODUCTS_NAME, OUTPUT_PRICE,TO_CHAR(OUTPUT_PRICE,'L999G999G999')FROM PRODUCTS;

#TO_DATE(STR,�������): ���ڿ��� ��¥ �������� ��ȯ
SELECT TO_DATE('20221128','YYYYMMDD')+2 FROM DUAL;
SELECT *FROM MEMBER
WHERE REG_DATE>TO_DATE('20130601','YYYYMMDD');

#TO_NUMBER(STR,�������):���ڿ��� ������������ ��ȯ�Ѵ�.
SELECT TO_NUMBER('10,000','99,999')*2 FROM DUAL;

SELECT TO_NUMBER('$8,590','$999G999')+10 FROM DUAL;
SELECT TO_CHAR(-23,'999S'),TO_CHAR(-23,'99D99') FROM DUAL;
SELECT TO_CHAR(-23,'99.9'),TO_CHAR(-23,'99.99EEEE') FROM DUAL;

#�׷��Լ�
-������ �Ǵ� ���̺� ��ü�� �����Ͽ� �ϳ��� ����� ��ȯ�ϴ� �Լ�

select count(empno) from emp;

select count (comm) from emp;
--null���� �����ϰ� ����.

--������ �� ������
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

--emp���̺��� ��� SALESMAN�� ���Ͽ� �޿��� ���,
--		 �ְ��,������,�հ踦 ���Ͽ� ����ϼ���.
select AVG(SAL),MAX(SAL),MIN(SAL),SUM(SAL)
from emp
where job='SALESMAN';
--EMP���̺� ��ϵǾ� �ִ� �ο���, ���ʽ��� NULL�� �ƴ� �ο���,
--		���ʽ��� ���,��ϵǾ� �ִ� �μ��� ���� ���Ͽ� ����ϼ���.
select count(empno),count(distinct COMM),AVG(COMM),count(deptno)
from emp;

#�׷��Լ��� GROUP BY ���� �Բ� ���ȴ�
EMP���� ������ �ο����� �����ּ���

SELECT JOB, COUNT (EMPNO)FROM EMP
GROUP BY JOB;

GROUP BY���� �̿��� ���� GROUP BY ������ ������� �÷��� �׷��Լ��� SELECT �Ҽ� �ִ�.

--SELECT ENAME, JOB, COUNT (EMPNO)FROM EMP
--GROUP BY JOB;[X]

--  17] �� ���̺��� ������ ����, �� ������ ���� �ִ� ���ϸ��� ������ �����ּ���.
select job,Max(mileage)
from member
group by job;
--
--	18] ��ǰ ���̺��� �� ��ǰī�װ����� �� �� ���� ��ǰ�� �ִ��� �����ּ���.
--
--		���� �ִ� �ǸŰ��� �ּ� �ǸŰ��� �Բ� �����ּ���.
select CATEGORY_FK,COUNT(PNUM),MAX(OUTPUT_PRICE),MIN(OUTPUT_PRICE)
FROM PRODUCTS
GROUP BY CATEGORY_FK ORDER BY 1;

--	19] ��ǰ ���̺��� �� ���޾�ü �ڵ庰�� ������ ��ǰ�� ����԰��� �����ּ���.
SELECT EP_CODE_FK,AVG(INPUT_PRICE)
FROM PRODUCTS
GROUP BY EP_CODE_FK;


--  ����1] ��� ���̺��� �Ի��� �⵵���� ��� ���� �����ּ���.
SELECT HIREDATE, COUNT(EMPNO)
FROM EMP GROUP BY HIREDATE;

select to_char(hiredate,'YY'),count(empno) from emp group by to_char(hiredate,'YY')
ORDER BY 1;

--	����2] ��� ���̺��� �ش�⵵ �� ������ �Ի��� ������� �����ּ���.
select to_char(hiredate,'YY/MM'),count(empno) from emp group by to_char(hiredate,'YY/MM')
ORDER BY 1;
--	����3] ��� ���̺��� ������ �ִ� ����, �ּ� ������ ����ϼ���.
SELECT JOB, MAX(SAL),MIN(SAL) FROM EMP
GROUP BY JOB;

#HAVING ��
-GROUP BY �� ����� ������ �־� ������ �� ���

20] �� ���̺��� ������ ������ �� ������ ���� ����� ���� 
	     2�� �̻��� �������� ������ �����ֽÿ�.
SELECT JOB,COUNT(NUM) FROM MEMBER
GROUP BY JOB HAVING COUNT(NUM)>=2;

--21] �� ���̺��� ������ ������ �� ������ ���� �ִ� ���ϸ��� ������ �����ּ���.
--	      ��, �������� �ִ� ���ϸ����� 0�� ���� ���ܽ�ŵ�ô�.
SELECT JOB, MAX(MILEAGE) FROM MEMBER
GROUP BY JOB HAVING MAX(MILEAGE)>0;
--
--	����1] ��ǰ ���̺��� �� ī�װ����� ��ǰ�� ���� ���, �ش� ī�װ��� ��ǰ�� 2���� 
--	      ��ǰ���� ������ �����ּ���.
SELECT CATEGORY_FK,COUNT(PNUM) FROM PRODUCTS
GROUP BY CATEGORY_FK HAVING COUNT(PNUM)=2;
--
--	����2] ��ǰ ���̺��� �� ���޾�ü �ڵ庰�� ��ǰ �ǸŰ��� ��հ� �� ������ 100������ ����
--	      ���� �׸��� ������ �����ּ���.
SELECT EP_CODE_FK,AVG(OUTPUT_PRICE)
FROM PRODUCTS
GROUP BY EP_CODE_FK HAVING MOD(AVG(OUTPUT_PRICE),100)=0
ORDER BY AVG(OUTPUT_PRICE) ASC;


