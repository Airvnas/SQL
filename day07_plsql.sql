--
--#IN OUT PARAMETER
--���ν����� �а� ���� �۾��� ���ÿ� �� �� �ִ� �Ķ����

 CREATE OR REPLACE PROCEDURE INOUT_TEST 
	  (A1 IN NUMBER,
		 A2 IN VARCHAR2,
		 A3 IN OUT VARCHAR2,
		 A4 OUT VARCHAR2)
	IS
	MSG VARCHAR2(30) := '';

	BEGIN

	 dbms_output.put_line('--------------------------------');
	 dbms_output.put_line('���ν��� ���� ��');
	 dbms_output.put_line('--------------------------------');
	 dbms_output.put_line('ù��° parameter: ' || TO_CHAR(A1, '9,999,999'));
	 dbms_output.put_line('�ι�° parameter: ' || A2);
	 dbms_output.put_line('����° parameter: ' || A3);
	 dbms_output.put_line('�׹�° parameter: ' || A4); 
	 
	 A3 := '���ν��� �ܺο��� �� ���� ���� �� �������?';
	 MSG := '����';
	 A4 := MSG;     

	 dbms_output.put_line('--------------------------------');
	 dbms_output.put_line('���ν��� ���� ��');
	 dbms_output.put_line('--------------------------------');
	  
	 dbms_output.put_line('ù��° parameter: ' || TO_CHAR(A1, '9,999,999'));
	 dbms_output.put_line('�ι�° parameter: ' || A2);
	 dbms_output.put_line('����° parameter: ' || A3);
	 dbms_output.put_line('�׹�° parameter: ' || A4);


	 dbms_output.put_line('--------------------------------');
	 dbms_output.put_line('���ν��� ��');
	 dbms_output.put_line('--------------------------------');

	END INOUT_TEST;
	/
	VARIABLE C VARCHAR2(100) 
	VARIABLE D VARCHAR2(100)

	EXECUTE INOUT_TEST(1000,'�ȳ�',:C,:D);
    PRINT C
	PRINT D
    SET SERVEROUTPUT ON
    
/*    
#���
IF THEN 
ELSIF THEN
..
ELSE
END IF;

����� ���Ķ���ͷ� �����ϸ� ����� �μ���ȣ�� ���� �Ҽӵ� �μ�����
���ڿ��� ����ϴ� ���ν���
10 ȸ��μ�
20 �����μ�
30 �����μ�
40 ��μ�
*/
CREATE OR REPLACE PROCEDURE DEPT_FIND(PNO IN EMP.EMPNO%TYPE)
IS 
VDNO emp.deptno%type;
VENAME emp.ename%type;
VDNAME varchar2(20);
BEGIN
    SELECT ENAME,DEPTNO INTO VENAME,VDNO
    FROM EMP
    WHERE EMPNO=PNO;
    
    IF VDBO:=10 THEN
    VDNAME:='ȸ��μ�';
    ELSIF VDNO=20 THEN
    VDNAME:='�����μ�';
    ELSIF VDNO=30 THEN
    VDNAME:='�����μ�';
    ELSIF VDNO=40 THEN
    VDNAME:='��μ�';
    ELSE VDNAME:='���� �μ����� ������';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE(VENAME||'���� '||VDNO||'�� '||VDNAME||' �μ��� �ֽ��ϴ�');
END;
/
    
--
--������� ���Ķ���ͷ� �����ϸ�
--�ش� ����� ������ ����ؼ� ����ϴ� ���ν����� �ۼ��ϵ�,
--������ COMM�� NULL�� ���� NULL�� �ƴѰ�츦 ������ ����ϼ���
--��¹�
--�����  ���޿�  ���ʽ� ���� 
--����ϼ���

CREATE OR REPLACE PROCEDURE EMP_SAL (PNAME IN EMP.ENAME%TYPE)
IS
VSAL EMP.SAL%TYPE;
VCOMM EMP.COMM%TYPE;
TOTAL NUMBER(10);
BEGIN
    SELECT SAL,COMM INTO VSAL,VCOMM
    FROM EMP
    WHERE ENAME=UPPER(PNAME);
    IF VCOMM IS NULL THEN
        TOTAL := VSAL*12;
    ELSE
        TOTAL := VSAL*12+VCOMM;
    END IF;
    DBMS_OUTPUT.PUT_LINE(PNAME||'--------');
    DBMS_OUTPUT.PUT_LINE('���޿�: '||VSAL);
    DBMS_OUTPUT.PUT_LINE('���ʽ�: '||VCOMM);
    DBMS_OUTPUT.PUT_LINE('��  ��: '||TOTAL);
    
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE(PNAME||' ���� �����ϴ�.');
    WHEN TOO_MANY_ROWS THEN
    DBMS_OUTPUT.PUT_LINE(PNAME||' �� �����Ͱ� 2�� �̻��Դϴ�');
END;
/   
    EXEC EMP_SAL('SCOTT');
    EXEC EMP_SAL('MARTIN');
    EXEC EMP_SAL('TOM');
INSERT INTO EMP (EMPNO,ENAME,SAL,COMM)
VALUES (8002,'TOM',2000,3000);
COMMIT;


DECLARE 
VSUM NUMBER(4):=0;
BEGIN 
    --1���� 10������ ��
    FOR I IN REVERSE 1..10 LOOP
        DBMS_OUTPUT.PUT_LINE(I);
        VSUM:=VSUM+I;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('������ ��: '||VSUM);
END;
/

--JOB�� ���Ķ���ͷ� �����ϸ� �ش� ������ �����ϴ� ������� ����
--���, �����, �μ���ȣ, �μ���, ������ ����ϼ���
--FOR LOOP�� �̿��ؼ� Ǯ�� ���������� �̿��ϼ���

CREATE OR REPLACE PROCEDURE EMP_JOB (PJOB IN EMP.JOB%TYPE)
IS
VNO EMP.EMPNO%TYPE;
VENAME EMP.ENAME%TYPE;
VDNO EMP.DEPTNO%TYPE;
VDNAME DEPT.DNAME%TYPE;

BEGIN
    FOR E IN (SELECT EMPNO,ENAME,DEPTNO,(SELECT DNAME FROM DEPT WHERE DEPTNO=EMP.DEPTNO) DNAME,JOB
                FROM EMP WHERE JOB=PJOB) LOOP
        DBMS_OUTPUT.PUT_LINE(E.EMPNO||LPAD(E.ENAME,10,' ')||
        LPAD(E.DEPTNO,8,' ')||LPAD(E.JOB,12,' ')||LPAD(E.DNAME,12,' '));
        
    END LOOP;
END;
/

EXEC EMP_JOB('MANAGER');
DECLARE 
BEGIN
    FOR I IN 1..100 LOOP
        CONTINUE WHEN MOD(I,2)=1;
        DBMS_OUTPUT.PUT_LINE(I||' ');
    END LOOP;
END;
/

--# LOOP ��
--LOOP
--	���๮��;
--EXIT [WHEN ���ǹ�]
--END LOOP;

--EMP���̺� ��������� ����ϵ� LOOP�� �̿��ؼ� ����غ��ô�.
--'NONAME1'

DECLARE 
 VCNT NUMBER(3) := 100;
BEGIN
    LOOP
        INSERT INTO EMP(EMPNO,ENAME,HIREDATE)
        VALUES (VCNT+8000,'NONAME'||VCNT,SYSDATE);
    
    VCNT:= VCNT+1;
    EXIT WHEN VCNT>105;
    DBMS_OUTPUT.PUT_LINE(VCNT-100||'���� ������ �Է¿Ϸ�');
    END LOOP;
    
END;
/
SELECT * FROM EMP;

--#WHILE LOOP ��
--WHILE ���� LOOP
--    ���๮
--    EXIT WHEN ����;
--END LOOP;

DECLARE 
VCNT NUMBER(3) := 0;
BEGIN
    WHILE VCNT <10 LOOP
        VCNT:=VCNT+2;
        CONTINUE WHEN VCNT=4;
        DBMS_OUTPUT.PUT_LINE(VCNT);
    END LOOP;
END;
/
    
    
--#CASE ��
--CASE �񱳱���
--    WHEN ��1 THEN ���๮;
--    WHEN ��2 THEN ���๮;
--    ...
--    ELSE 
--    ���๮;
--END CASE;

--��������� ���Ķ���ͷ� �����ϸ�
--������ ����ϴ� ���ν����� �ۼ��ϼ���
--���ν�����: GRADE_AVG
--100~90 : A
--81 => B
--77 => C
--60���� => D
--������ => F


CREATE OR REPLACE PROCEDURE GRADE_AVG (SCORE IN NUMBER)
IS
BEGIN
    CASE FLOOR(SCORE/10)
        WHEN 10 THEN DBMS_OUTPUT.PUT_LINE('A');
        WHEN 9 THEN DBMS_OUTPUT.PUT_LINE('A');
        WHEN 8 THEN DBMS_OUTPUT.PUT_LINE('B');
        WHEN 7 THEN DBMS_OUTPUT.PUT_LINE('C');
        WHEN 6 THEN DBMS_OUTPUT.PUT_LINE('D');
        ELSE 
        DBMS_OUTPUT.PUT_LINE('F');
    END CASE;
END;
/
EXEC GRADE_AVG(100);



#�Ͻ��� Ŀ��
CREATE OR REPLACE PROCEDURE IMPLICIT_CURSOR
(PNO IN EMP.EMPNO%TYPE)
IS
VSAL EMP.SAL%TYPE;
UPDATE_ROW NUMBER;
BEGIN
    SELECT SAL INTO VSAL
    FROM EMP WHERE EMPNO=PNO;
    --�˻��� �����Ͱ� �ִٸ�
    IF SQL%FOUND THEN
       DBMS_OUTPUT.PUT_LINE(PNO||'�� ����� ���޿��� '||VSAL||'�Դϴ�. 10%�λ� �����Դϴ�.'); 
    END IF;
    
    UPDATE EMP SET SAL=SAL*1.1 WHERE EMPNO= PNO;
    UPDATE_ROW :=SQL%ROWCOUNT;
    DBMS_OUTPUT.PUT_LINE(UPDATE_ROW||'���� ����� �޿��� �λ�Ǿ����');
    SELECT SAL INTO VSAL
    FROM EMP WHERE EMPNO=PNO;
    IF SQL%FOUND THEN
       DBMS_OUTPUT.PUT_LINE(PNO||'�� ����� �λ�� ���޿��� '||VSAL||'�Դϴ�.'); 
    END IF;
END;
/
    
EXEC IMPLICIT_CURSOR(7788);    
ROLLBACK;
/*
# ����� Ŀ�� 
Ŀ�� ���� 
Ŀ�� OPEN
�ݺ��� ���鼭
Ŀ������ FETCH��
Ŀ�� CLOSE
*/


CREATE OR REPLACE PROCEDURE EMP_ALL
IS
VNO EMP.EMPNO%TYPE;
VNAME EMP.ENAME%TYPE;
VDATE EMP.HIREDATE%TYPE;
--Ŀ�� ����
CURSOR EMP_CR IS 
    SELECT EMPNO,ENAME,HIREDATE
    FROM EMP ORDER BY 1 ASC;

BEGIN
--Ŀ�� ����
OPEN EMP_CR;
    LOOP 
        FETCH EMP_CR INTO
        VNO,VNAME,VDATE;
    
    EXIT WHEN EMP_CR%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(VNO||LPAD(VNAME,12,' ')||LPAD(VDATE,12,' '));
    END LOOP;
    
--Ŀ�� �ݱ�
CLOSE EMP_CR;
END;
/

EXEC EMP_ALL;

--[�ǽ�] �μ��� �����, ��ձ޿�, �ִ�޿�, �ּұ޿��� ������ ����ϴ�
--      ���ν����� �ۼ��ϼ���.

CREATE OR REPLACE PROCEDURE DEPT_STAT
IS
VDNO NUMBER;
VCNT NUMBER;
VAVGSAL NUMBER;
VMAXSAL NUMBER;
VMINSAL NUMBER;
CURSOR CR IS
    SELECT DEPTNO,COUNT(EMPNO),AVG(SAL),MAX(SAL),MIN(SAL) 
    FROM EMP
    GROUP BY DEPTNO HAVING DEPTNO IS NOT NULL ORDER BY 1 ASC;
BEGIN
OPEN CR;
LOOP
    FETCH CR INTO
    VDNO,VCNT,VAVGSAL,VMAXSAL,VMINSAL;
    EXIT WHEN CR%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(VDNO||'  '||VCNT||'  '||VAVGSAL||'  '||VMAXSAL||'  '||VMINSAL);
END LOOP;
CLOSE CR;
END;
/
    
    EXEC DEPT_STAT;
    
--# SUBQUERY
--�μ����̺��� ��� ������ ������ ����ϴ� ���ν����� �ۼ��ϵ�
--FOR LOOP�̿��ϱ�

CREATE OR REPLACE PROCEDURE DEPT_INFO
IS
BEGIN
    FOR K IN (SELECT * FROM DEPT ORDER BY DEPTNO) LOOP
        DBMS_OUTPUT.PUT_LINE(K.DEPTNO||LPAD(K.DEPTNO,10,' ')||LPAD(K.DNAME,12,' ')||LPAD(K.LOC,10,' '));
    END LOOP;  
END;
/

EXEC DEPT_INFO;


--# EXCEPTION
--Exception
--WHEN ����1 [or ����2] THEN
--	statement1
--	statement2...
--WHEN ����3 THEN
--	statement3
--WHEN OTHERS THEN
--	statement4

--MEMBER ���̺��� USERID �÷��� UNIQUE ���������� �߰��ϵ� �������� �̸� �־� �߰��ϼ���
ALTER TABLE MEMBER ADD CONSTRAINT MEMBER_USERID_UK UNIQUE (USERID);

SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME='MEMBER';

CREATE SEQUENCE MEMBER_SEQ 
START WITH 11
INCREMENT BY 1
NOCACHE;

--MEMBER���̺� ���ο� ���ڵ带 �߰��ϴ� ���ν����� �ۼ��ϵ�
--���Ķ���ͷ� ȸ����, ���̵�, ��й�ȣ, ����, ����, �ּ�
--�� �ְ� �ش� �����͸� INSERT�ϴ� ���ν����� �ۼ��ϼ���


CREATE OR REPLACE PROCEDURE INSERT_MEMBER(
PNAME IN MEMBER.NAME%TYPE,PID IN MEMBER.USERID%TYPE,
PWD IN MEMBER.PASSWD%TYPE,PAGE IN MEMBER.AGE%TYPE,
PJOB IN MEMBER.JOB%TYPE, PADDR IN MEMBER.ADDR%TYPE)
IS 
VNAME MEMBER.NAME%TYPE;
VUID MEMBER.USERID%TYPE;
BEGIN
    INSERT INTO MEMBER(NUM, USERID,NAME,PASSWD,AGE,JOB,ADDR,REG_DATE)
    VALUES(MEMBER_SEQ.NEXTVAL,PID,PNAME,PWD,PAGE,PJOB,PADDR,SYSTDATE);
    IF SQL%ROWCOUNT>0 THEN
        DBMS_OUTPUT.PUT_LINE('ȸ������ �Ϸ�');
    END IF;
    SELECT NAME,USERID INTO VNAME, VUID
    FROM MEMBER WHERE NAME=PNAME;
    DBMS_OUTPUT.PUT_LINE(PNAME||'��'||VUID||'�� ��� �Ǿ����ϴ�.');
    EXCEPTION 
    WHEN DUP_VAL_ON_INDEX THEN 
    DBMS_OUTPUT.PUT_LINE('����Ϸ��� ���̵�� �̹� ��ϵǾ� �־��.');
    WHEN TOO_MANY_ROWS THEN
    DBMS_OUTPUT.PUT_LINE(PNAME||'�� �����ʹ� 2�� �̻� �ֽ��ϴ�.');
    WHEN OTHERS THEN 
    DBMS_OUTPUT.PUT_LINE('��Ÿ ����ġ ���� ���� �߻�');
END;
/


SELECT * FROM MEMBER;
INSERT INTO MEMBER(NUM,USERID,NAME,PASSWD,AGE,JOB,ADDR,REG_DATE) 
    VALUES(MEMBER_SEQ.NEXTVAL,'KIM','��ȸ��1','123',22,'�л�','���� ������',SYSTDATE);

# ����� ���� ���� ����� �߻���Ű��
select count(*) from emp group by deptno;

--�μ� �ο��� 5�� �̸��̸� ��������� ���ܸ� ����� �߻���Ű��
CREATE OR REPLACE PROCEDURE USER_EXCEPT
(PDNO IN DEPT.DEPTNO%TYPE)
IS
--1. ���� ����
MY_DEFINE_ERROR EXCEPTION;
VCNT NUMBER;
BEGIN
    SELECT COUNT (EMPNO)INTO VCNT
    FROM EMP WHERE DEPTNO=PDNO;
    --2.���� �߻� ��Ű��=> RAISE���� �̿�
    IF VCNT<5 THEN
        RAISE MY_DEFINE_ERROR;
    END IF;
    
    --3. ���� ó��
    EXCEPTION 
    WHEN MY_DEFINE_ERROR THEN
        RAISE_APPLICATION_ERROR(-20001,'�μ� �ο��� 5�� �̸��� �μ��� �ȵſ�');
END;
/

EXEC USER_EXCEPT(30);


--# FUNCTION
--���� ȯ�濡�� �ݵ�� �ϳ��� ���� return�ؾ��Ѵ�.,
--������� �Է��ϸ� �ش� ����� �Ҽӵ� �μ����� ��ȯ�ϴ� �Լ��� �ۼ��ϼ���
CREATE OR REPLACE FUNCTION GET_DNAME(
PNAME IN EMP.ENAME%TYPE)
--��ȯ���� ������ ������ ����
RETURN VARCHAR2
IS
VDNO EMP.DEPTNO%TYPE;
VDNAME DEPT.DNAME%TYPE;
BEGIN
    SELECT DEPTNO INTO VDNO FROM EMP
    WHERE ENAME= PNAME;
    
    SELECT DNAME INTO VDNAME FROM DEPT
    WHERE DEPTNO= VDNO;
    
    RETURN VDNAME;--���� ��ȯ.
    
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE(PNAME||'����� �����ϴ�');
    RETURN SQLERRM;
    WHEN TOO_MANY_ROWS THEN
    DBMS_OUTPUT.PUT_LINE(PNAME||'��� �����Ͱ� 2���̻� �Դϴ�.');
    RETURN SQLERRM;
END;
/

VAR GNAME VARCHAR2;

EXEC :GNAME :=GET_DNAME('TOM')
PRINT GNAME







    
    