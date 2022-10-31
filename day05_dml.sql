create table emp_10
as
select * from emp where 1=2;
select * from emp_10;

insert into emp_10 (empno,job,ename,hiredate,mgr,sal,comm,deptno)
values (1000,'MANAGER','TOM',SYSDATE,NULL,2000,NULL,10);
commit;
desc emp_10;

alter table emp_10 add constraint EMP_10_ENAME_NN NOT NULL (ENAME);--[x]
--���̺� ���ؿ��� ���� �Ұ�

alter table emp_10 modify ename varchar2(20) not null;

insert into emp_10 (EMPNO,ENAME,job, mgr, sal) values (1001,'JAMES','SALESMAN',1000,3000);

select * from emp_10;

insert into emp_10 
select * from emp where deptno=10;


--   insert ���� ���� ������ ���������� ���� ������ �������� ���� 1��1��
--	 �����ϸ� �ڷ����� ���̰� ���ƾ� �Ѵ�.

--UPDATE ���̺�� SET �÷��̸�1='�ڷ�1', �÷��̸�2='�ڷ�2' ....
--  WHERE ����(�÷�)='���ǰ�'



select * from emp2;

--EMP���̺��� ī���Ͽ� EMP2���̺��� ����� �����Ϳ� ������ ��� �����ϼ���
create table emp2 
as 
select * from emp;
--EMP2���� ����� 7788�� ����� �μ���ȣ�� 10�� �μ��� �����ϼ���.
update emp2 set deptno=10 where empno=7788;
--EMP2���� ����� 7369�� ����� �μ��� 30�� �μ��� �޿��� 3500���� �����ϼ���
update emp2 set deptno=30,sal=3500 where empno=7369;

select * from emp2;
create table member2 
as 
select *from member;
select *from member;
select * from member2;
--   2] ��ϵ� �� ���� �� ���� ���̸� ���� ���̿��� ��� 5�� ���� ������ 
--	      �����ϼ���.
    update member2 set age=age+5;
--	 2_1] �� �� 13/09/01���� ����� ������ ���ϸ����� 350���� �÷��ּ���.
    update member2 set mileage=mileage+350 where reg_date>'13/09/01';
--3] ��ϵǾ� �ִ� �� ���� �� �̸��� '��'�ڰ� ����ִ� ��� �̸��� '��' ���
--	     '��'�� �����ϼ���.
    update member2 set name=REPLACE (NAME,'��','��') WHERE NAME LIKE '��%';

UPDATE�� ���Ἲ ���� ���� �Ű�����


CREATE TABLE DEPT2
AS SELECT * FROM DEPT;

--DEPT2���̺��� DEPTNO�� ���� PRIMARY KEY ���������� �߰��ϼ���

ALTER TABLE DEPT2 ADD CONSTRAINT DEPT2_DEPTNO_PK PRIMARY KEY (DEPTNO);

--EMP2 ���̺��� DEPTNO�� ���� FOREIGN KEY ���������� �߰��ϵ� DEPT2�� DEPTNO�� �ܷ�Ű�� �����ϵ��� �ϼ���

ALTER TABLE EMP2 ADD CONSTRAINT EMP2_FK FOREIGN KEY (DEPTNO)
REFERENCE DEPT2(DEPTNO);

#DELETE FROM ���̺��  WHERE ����(�÷�)='���ǰ�'


-- EMP2���̺��� �����ȣ�� 7499�� ����� ������ �����϶�.
    DELETE FROM EMP2 WHERE EMPNO=7499;
--- EMP2���̺��� �ڷ� �� �μ����� 'SALES'�� ����� ������ �����϶�.
    DELETE FROM EMP2 WHERE DEPTNO= (SELECT DEPTNO FROM DEPT2 WHERE DNAME = 'SALES');
    SELECT * FROM EMP2;
    ROLLBACK;
---- PRODUCTS2 �� ���� �׽�Ʈ�ϱ�
CREATE TABLE PRODUCTS2 AS SELECT * FROM PRODUCTS;
--1] ��ǰ ���̺� �ִ� ��ǰ �� ��ǰ�� �Ǹ� ������ 10000�� ������ ��ǰ�� ��� 
--	      �����ϼ���.
    SELECT *FROM PRODUCTS2;
    DELETE FROM PRODUCTS2 WHERE OUTPUT_PRICE<=10000;
--
--	2] ��ǰ ���̺� �ִ� ��ǰ �� ��ǰ�� ��з��� ������ ��ǰ�� �����ϼ���.
    DELETE FROM PRODUCTS2 WHERE CATEGORY_FK = 
    (SELECT CATEGORY_CODE FROM CATEGORY WHERE CATEGORY_NAME LIKE '%����%'
    AND MOD(CATEGORY_CODE,100)=0);
    DELETE FROM PRODUCTS2;
    COMMIT;

    TCL: TRANSACTION CONTROL LANGUAGE
    -COMMIT
    -ROLLBACK
    -SAVEPOINT(ǥ�� X, ����Ŭ�̤ĸ� ����)

UPDATE EMP2 SET ENAME ='CHARSE' WHERE EMPNO=7788;

SELECT * FROM EMP2;

UPDATE EMP2 SET DEPTNO=30 WHERE EMPNO=7788;
--SAVEPOINT ����Ʈ��;
SAVEPOINT POINT1;--������ ����

UPDATE EMP2 SET JOB='MANAGER';

ROLLBACK TO SAVEPOINT POINT1;

SELECT * FROM EMP2;
COMMIT;

select * from emp;
//�˻��� ����� �̸��� �Է¹޾Ƽ� �ش� ��� ������ ���
		//���, �����,�μ���,�Ի���,�ٹ��� ���
select empno,ename,e.deptno,hiredate, d.loc 
from emp e join dept d
on d.deptno=e.deptno
where ename='JONES';
