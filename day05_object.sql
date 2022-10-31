/*
# ������
����
CREATE SEQUENCE ��������
[INCREMENT BY n] --����ġ
[START WITH n]   --���۰�
[{MAXVALUE n | NOMAXVALE}]--�ִ밪
[{MINVALUE n | NOMINVALUE}]--�ּҰ�
[{CYCLE | NOCYCLE}]-- �ִ� �ּҿ� ������ �� ��� ���� �������� ���θ� ����nocycle�� �⺻
[{CACHE n| NOCACHE}]--�޸� ĳ�� ����Ʈ ������ 20
*/

create sequence dept2_seq
start with 50
increment by 5
maxvalue 95
cache 20
nocycle;

select * from user_sequences;

������ ���
-nextval: ������ ������
-currval: ������ ���簪
[����] nextval�� ȣ����� ���� ���¿��� currval�� ���Ǹ� ����������.

select dept2_seq.currval from dual; ==> ����

select dept2_seq.nextval from dual;

insert into dept2(deptno,dname,loc)
values(dept2_seq.nextval,'SALES','SEOUL');

SELECT * FROM DEPT2;

CREATE SEQUENCE TEMP_SEQ
START WITH 100
INCREMENT BY -5
MAXVALUE 100
MINVALUE 0
CYCLE 
NOCACHE;

SELECT * FROM USER_SEQUENCES WHERE SEQUENCE_NAME='DEPT2_SEQ';

SELECT TEMP_SEQ.NEXTVAL FROM DUAL;

#������ ����
[���ǻ���] ���۰��� ������ �� ����. ���۰��� �����Ϸ��� DROP�� �ٽû���

ALTER SEQUENCE ��������
INCREMENT BY N
MAXVALUE N
MINVALUE N
...;

ALTER SEQUENCE DEPT2_SEQ
INCREMENT BY 1
MAXVALUE 1000;
SELECT * FROM USER_SEQUENCES WHERE SEQUENCE_NAME='DEPT2_SEQ';

INSERT INTO DEPT2 VALUES(DEPT2_SEQ.NEXTVAL,'TEST','TEST');
SELECT * FROM DEPT2;
#������ ����
DROP SEQUENCE ��������;

DROP SEQUENCE TEMP_SEQ;

#VIEW
[���ǻ��� ] VIEW�� �����Ϸ��� CREATE VIEW ������ �������Ѵ�.

--CREATE VIEW ���̸�
--	AS
--	SELECT �÷���1, �÷���2...
--	FROM �信 ����� ���̺��
--	WHERE ����

--EMP���̺��� 20�� �μ��� ��� �÷��� �����ϴ� EMP20_VIEW�� �����϶�.
CREATE VIEW EMP20_VIEW
AS SELECT * FROM EMP WHERE DEPTNO= 20;

--system
--Abcd1234
--grant create view to scott;

select * from emp20_view;
select * from user_views;

desc emp20_view;
drop view emp20_view;

#VIEW ����
CREATE OR REPLACE ���̸� 
AS SELECT��;

--[����] 
--	�����̺��� �� ���� �� ���̰� 19�� �̻���
--	���� ������
--	Ȯ���ϴ� �並 ��������.
--	�� ���� �̸��� MEMBER_19�� �ϼ���.

CREATE OR REPLACE VIEW MEMBER_19
AS SELECT * FROM MEMBER WHERE AGE>=19;

SELECT * FROM MEMBER_19;

CREATE OR REPLACE VIEW MEMBER_19
AS SELECT * FROM MEMBER WHERE AGE>=30;

EMP���̺��� 30�� �μ��� EMPNO�� EMP_NO�� ENAME�� NAME����
	SAL�� SALARY�� �ٲپ� EMP30_VIEW�� �����Ͽ���.
CREATE OR REPLACE VIEW EMP30_VIEW
AS SELECT EMPNO EMP_NO,ENAME NAME,SAL SALARY FROM EMP
WHERE DEPTNO=30;

SELECT * FROM EMP30_VIEW;

CREATE OR REPLACE VIEW EMP30_VIEW(ENO,NAME,SALARY,DNO)
AS SELECT EMPNO, ENAME, SAL, DEPTNO FROM EMP
WHERE DEPTNO=30;

UPDATE EMP SET DEPTNO= 20 WHERE EMPNO=7499;
SELECT * FROM EMP;

SELECT * FROM EMP30_VIEW;--VIEW�� �����͸� ������ ���̺��� ����Ǹ� ���泻���� VIEW���̺��� ���ϰԵ�

SELECT * FROM EMP_DEPT_VIEW ORDER BY 1;

CREATE OR REPLACE VIEW EMP_DEPT_VIEW
AS  
SELECT D.DEPTNO,DNAME,ENAME,JOB
FROM DEPT D JOIN EMP E
ON D.DEPTNO= E.DEPTNO;

UPDATE EMP30_VIEW SET DNO=10 WHERE ENO=7521;
SELECT * FROM EMP30_VIEW;

SELECT *FROM EMP;
ROLLBACK;
--�並 �����ϸ� �����̺� ������
--�����̺��� �����ϸ� ���õ� �䵵 ������

#WITH READ ONLY �ɼ��� �ָ� �信 DML������ ������ �� ����.
CREATE OR REPLACE VIEW EMP10_VIEW
AS SELECT EMPNO,ENAME,JOB,DEPTNO
FROM EMP WHERE DEPTNO=10
WITH READ ONLY;

SELECT * FROM EMP10_VIEW;

UPDATE EMP10_VIEW SET JOB='SALESMAN' WHERE EMPNO = 7782;
--"cannot perform a DML operation on a read-only view"

#WITH CHECK OPTION

CREATE OR REPLACE VIEW EMP_SALES_VIEW
AS SELECT * FROM EMP WHERE JOB='SALESMAN'
WITH CHECK OPTION;
==>WHERE���� �����ϰ� üũ��
    WHERE���� ����Ǵ� ���� INSERT�ǰų� UPDATE�Ǵ°��� ���´�
    
SELECT * FROM EMP_SALES_VIEW;
UPDATE EMP_SALES_VIEW SET DEPTNO = 10 WHERE EMPNO= 7499;
==>����������

UPDATE EMP_SALES_VIEW SET JOB ='MANAGER' WHERE ENAME ='WARD';
==>view WITH CHECK OPTION where-clause violation

#INLINE VIEW
FROM������ ���� ���������� �ζ��κ��� �Ѵ�.
EMP���� ���ټ��� 3�� �̾Ƽ� �ؿܿ���. 3����
DROP VIEW EMP_OLD;

CREATE VIEW EMP_OLD_VIEW
AS SELECT * FROM EMP ORDER BY HIREDATE ASC;

SELECT * FROM EMP_OLD_VIEW;

SELECT ROWNUM ,EMPNO,ENAME,HIREDATE FROM EMP_OLD_VIEW WHERE ROWNUM<4;

SELECT * FROM{
SELECT ROWNUM RN ,A.* FROM
(SELECT * FROM EMP ORDER BY HIREDATE ASC) A
}
WHERE RN<4;

#INDEX
-�ڵ������Ǵ� ��� : PRIMARY, UNIQUE ���������� �ָ� �ڵ����� ����
-��������� �����ϴ� ��� : ����ڰ� Ư�� �÷��� �����ؼ� UNIQUE INDEX �Ǵ� NON-UNIQUE    
                        �ε����� ������ �� �ִ�.

CREATE INDEX �ε����� ON ���̺��(�÷���[,�÷���2,...])
[����] �ε����� NOT NULL �� �÷����� ������ϴ�.

CREATE INDEX EMP_ENAME_INDX ON EMP (ENAME);

SELECT * FROM EMP WHERE ENAME='SCOTT';
�ε����� �����ϸ� ���������� �ش��÷��� �о �������� ������ �Ѵ�
ROWID�� ENAME�� �����ϱ� ���� ��������� �״��� �� ���� �����Ѵ�.

�����ͻ������� ��ȸ
SELECT * FROM USER_OBJECTS WHERE OBJECT_TYPE='INDEX';
SELECT * FROM USER_OBJECTS WHERE OBJECT_TYPE='VIEW';
SELECT* FROM USER_INDEXES;

SELECT * FROM USER_IND_COLUMNS
WHERE INDEX_NAME= 'EMP_ENAME_INDX';

SELECT * FROM USER_IND_COLUMNS
WHERE TABLE_NAME= 'DEPT2';

CREATE INDEX PRODUCTS_CATEGORY_FK_INDX ON PRODUCTS(CATEGORY_FK);
CREATE INDEX PRODUCTS_EP_CODE_FK_INDX ON PRODUCTS(EP_CODE_FK);

SELECT * FROM USER_INDEXES WHERE TABLE_NAME='PRODUCTS';

ī�װ�, ��ǰ, ���޾�ü JOIN�Ͽ� ���
CREATE OR REPLACE VIEW PRODUCTS_INFO_VIEW
AS
SELECT C.CATEGORY_CODE,CATEGORY_NAME,PNUM,PRODUCTS_NAME,OUTPUT_PRICE,
EP_CODE_FK,EP_NAME
FROM CATEGORY C RIGHT OUTER JOIN PRODUCTS P
ON C.CATEGORY_CODE= P.CATEGORY_FK
LEFT OUTER JOIN SUPPLY_COMP S
ON P.EP_CODE_FK=S.EP_CODE;

SELECT * FROM PRODUCTS_INFO_VIEW
ORDER BY OUTPUT_PRICE ASC;

#DROP INDEX �ε�����
EMP_ENAME_INDX �ε��� ����

DROP INDEX EMP_ENAME_INDX;
SELECT * FROM USER_INDEXES WHERE TABLE_NAME='EMP';


#�ε��� ����
==>DROP �ϰ� �ٽ� ����


#synonym :���Ǿ�
create [public] synonym for ��ü
-public�� DBA�� �� �� �ִ�.
-���Ǿ� ���� ���ѵ� �ο��޾ƾ� �� �� �ִ�.
SYSTEM�������� �����ؼ�
GRANT CREATE SYNONYM TO SCOTT
������ �������� ��ȸ
SELECT * FROM USER_OBJECTS
WHERE OBJECT_TYPE='SYNONYM';

���Ǿ� ����
DROP SYNONYM NOTE;
SELECT * FROM NOTE;
SELECT * FROM MYSTAR.MYSTARSTABLENOTE;