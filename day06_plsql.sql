/*
���ν��� �͸��
-�����
-�����
-����ó����
*/
DECLARE
 --����ο����� ��������
 I_MSG VARCHAR2(100);
BEGIN
 --����ο��� SQL�Ǵ� PL/SQL���� �ü� �ִ�.
 I_MSG:='HELLO ORACLE';
 DBMS_OUTPUT.PUT_LINE(I_MSG);
END;
/

SET SERVEROUTPUT ON

--[2] �̸��� ���� ���ν���
CREATE OR REPLACE PROCEDURE PRINT_TIME
IS 
--�����
    VTIME1 TIMESTAMP;
    VTIME2 TIMESTAMP;
    
BEGIN
--����� ��¥+����: �ϼ��� ���� -> ��¥+����/24 : �ð��� ����
    SELECT SYSTIMESTAMP -1/24 INTO VTIME1 FROM DUAL;
    SELECT SYSTIMESTAMP +2/24 INTO VTIME2 FROM DUAL;
    DBMS_OUTPUT.PUT_LINE('�� �ð� ��:'||VTIME1);
    DBMS_OUTPUT.PUT_LINE('�� �ð� ��:'||VTIME2);
END;
/
--���ν��� ������
EXECUTE PRINT_TIME;

--����� ���Ķ���ͷ� �����ϸ� �ش�����
--���,�̸�,�μ���,�������� ������
--����ϴ� ���ν��� �ۼ�

CREATE OR REPLACE PROCEDURE EMP_INFO(PNO IN NUMBER)
IS
    VNO NUMBER(4); --��Į��Ÿ��
    VNAME EMP.ENAME%TYPE; --EMP ���̺��� ENAME�÷��� ���� �ڷ��������� �ϰڴٴ� �ǹ�
    VDNAME DEPT.DNAME%TYPE;
    VJOB EMP.JOB%TYPE;
    VDNO EMP.DEPTNO%TYPE;
BEGIN
--SELECT INTO �� ������ ������ ������ �Ҵ��ϱ�
    SELECT ENAME,JOB,DEPTNO INTO VNAME,VJOB,VDNO 
    FROM EMP WHERE EMPNO=PNO;
    SELECT DNAME INTO VDNAME FROM DEPT
    WHERE DEPTNO=VDNO;
--DBMS�� ����ϱ�
DBMS_OUTPUT.PUT_LINE('---'||PNO||'�� �������---');
DBMS_OUTPUT.PUT_LINE('�����: '||VNAME);
DBMS_OUTPUT.PUT_LINE('������: '||VJOB);
DBMS_OUTPUT.PUT_LINE('�� �� ��: '||VDNAME);

EXCEPTION 
    WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE(PNO||'�� ����� �������� �ʾƿ�');

END;
/

EXECUTE EMP_INFO(8499);


--�μ���ȣ�� ���Ķ���ͷ� �ָ�
--�ش� �μ��� �μ���� �ٹ����� ����ϴ� ���ν����� �ۼ��սô�

CREATE OR REPLACE PROCEDURE RTYPE(PDNO IN DEPT.DEPTNO%TYPE)
IS
    VDEPT DEPT%ROWTYPE;
BEGIN
    SELECT DNAME,LOC INTO VDEPT.DNAME,VDEPT.LOC 
    FROM DEPT WHERE DEPTNO = PDNO;
    DBMS_OUTPUT.PUT_LINE('�μ���ȣ: '||PDNO);
    DBMS_OUTPUT.PUT_LINE('�� �� ��: '||VDEPT.DNAME);
    DBMS_OUTPUT.PUT_LINE('�μ���ġ: '||VDEPT.LOC);
    
    EXCEPTION 
    WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('�ش� �μ��� �����');
END;
/


EXECUTE RTYPE(50);


--#TABLE TYPE: COMPOSITE TYPE(���յ����� Ÿ��)=> �迭�� �����
--TABLE Ÿ�Կ� �����ϱ� ���� �ε����� �ִµ� BINARY_INTEGER ������ ���� �ε�����
--�̿��� �� �ִ�.

CREATE OR REPLACE PROCEDURE TABLE_TYPE(PDNO IN EMP.DEPTNO%TYPE)
IS
--���̺�Ÿ���� ���� ����
    TYPE ENAME_TABLE IS TABLE OF EMP.ENAME%TYPE
    INDEX BY BINARY_INTEGER;
    TYPE JOB_TABLE IS TABLE OF EMP.JOB%TYPE
    INDEX BY BINARY_INTEGER;
    
--���̺� Ÿ���� ���� ����
    ENAME_TAB ENAME_TABLE;
    JOB_TAB JOB_TABLE;
    I BINARY_INTEGER:=0;
BEGIN
    FOR K IN (SELECT ENAME,JOB FROM EMP WHERE DEPTNO= PDNO) LOOP
    I:=I+1;
    --���̺����� ������ ������ ����
        ENAME_TAB(I):=K.ENAME;
        JOB_TAB(I):=K.JOB;
    END LOOP;
    
    --���̺� Ÿ�Կ� ����� ���� ���
    FOR J IN 1..I LOOP
    DBMS_OUTPUT.PUT_LINE(ENAME_TAB(J)||': '||JOB_TAB(J));
    END LOOP;
END;
/

EXECUTE TABLE_TYPE(30);

# RECORD TYPE
��ǰ��ȣ�� �Է��ϸ� �ش��ǰ�� ��ǰ��, �ǸŰ�, �����縦 ����ϴ� ���ν����� �ۼ��ϼ���

ACCEPT PNUM PROMPT '��ȸ�� ��ǰ��ȣ�� �Է��ϼ���'
DECLARE  
    TYPE PROD_RECORD_TYPE IS RECORD(
        VPNAME PRODUCTS.PRODUCTS_NAME%TYPE,
        VPRICE PRODUCTS.OUTPUT_PRICE%TYPE,
        VCOMP PRODUCTS.COMPANY%TYPE
    );
    --���ڵ� Ÿ���� ��������
    PROD_REC PROD_RECORD_TYPE;
BEGIN
    SELECT PRODUCTS_NAME,OUTPUT_PRICE,COMPANY
    INTO PROD_REC
    FROM PRODUCTS
    WHERE PNUM='&PNUM';

    DBMS_OUTPUT.PUT_LINE(&PNUM||'�� ��ǰ ����------');
    DBMS_OUTPUT.PUT_LINE('��ǰ��: '||PROD_REC.VPNAME);
    DBMS_OUTPUT.PUT_LINE('������: '||PROD_REC.VCOMP);
    DBMS_OUTPUT.PUT_LINE('��  ��: '||LTRIM(TO_CHAR(PROD_REC.VPRICE,'999,999,999'))||'��');
END;
/

���ε� ����- NON-PL/SQL ����
VARIABLE MYVAR NUMBER

--���ν��� ���ο��� ���ε� ������ �����Ϸ���
--���ε� ���� �տ� �ݷ�(:)�� ���� ���ξ�� ����Ѵ�.

DECLARE 
BEGIN
:MYVAR:=700;
END;
/

PRINT MYVAR

--#���ν��� �Ķ���� ����
--[1] IN �Ķ����
--[2] OUT �Ķ����
--[3] IN OUT �Ķ����
--
--MEMO ���̺� ���ο� ���ڵ带 INSERT �ϴ� ���ν��� �ۼ�
--�ۼ��ڿ� �޸𳻿��� IN �Ķ���ͷ� ����
���ν�����: MEMO_ADD

CREATE OR REPLACE PROCEDURE MEMO_ADD (
PNAME IN VARCHAR2 DEFAULT '�ƹ���',
PMSG IN MEMO.MSG%TYPE)
IS
    
BEGIN
    INSERT INTO MEMO(IDX,NAME,MSG,WDATE)
    VALUES(MEMO_SEQ.NEXTVAL,PNAME,PMSG,SYSDATE);
END;
/

EXEC MEMO_ADD('ȫ�浿','���ν����� ���� ���ϴ�.');
EXEC MEMO_ADD(PMSG=>'�ȳ�');
SELECT * FROM MEMO ORDER BY IDX DESC;

--#OUT �Ķ����: ���ν����� ����ڿ��� �Ѱ��ִ� ��
--    [����] ����Ʈ ���� ���� �� ����.

--����� �� �Ķ���ͷ� �����ϸ� �ش� ����� �̸��� �ƿ� �Ķ���ͷ�
--�������� ���ν����� �ۼ��ϼ���
--==>OUT�Ķ���� �������� ���ε庯���� �ʿ���

CREATE OR REPLACE PROCEDURE EMP_FIND(
PNO IN EMP.EMPNO%TYPE,
ONAME OUT EMP.ENAME%TYPE)
IS
BEGIN
    SELECT ENAME INTO ONAME
    FROM EMP
    WHERE EMPNO= PNO;
END;
/
������
���ε庯�� ����
���ν����� ������ �� ���ε庯���� �ƿ��Ķ������ �Ű������� ����
���ε� �������� ���

VAR GNAME VARCHAR(20);
EXEC EMP_FIND(7788, :GNAME);
PRINT GNAME;


--�μ���ȣ�� ���Ķ���ͷ� �ް�, �޿� �λ���� ���Ķ���ͷ� �޾Ƽ�
--EMP���̺��� Ư�� �μ� �������� �޿��� �λ����ְ�
--�׷��� �ش� �μ��� ��ձ޿��� �ƿ��Ķ���ͷ� �����ϴ� ���ν�����
--�ۼ��� ��
--�ش� �μ��� ��ձ޿��� ����ϼ���

CREATE OR REPLACE PROCEDURE SAL_AVG(
DNO IN EMP.DEPTNO%TYPE,
SALRATE IN NUMBER,
AVGSAL OUT EMP.SAL%TYPE )
IS 
BEGIN
    UPDATE EMP SET SAL=SAL+SAL*SALRATE/100 
    WHERE DEPTNO=DNO;
    SELECT AVG(SAL) INTO AVGSAL FROM EMP WHERE DEPTNO=DNO;
    COMMIT;
END;
/

VAR TOTAL NUMBER(10);

EXEC SAL_AVG(10,10,:TOTAL);

PRINT TOTAL;


--MEMO_EDIT ���ν����� �ۼ��ϼ���
--���Ķ���� 3�� �޾Ƽ�(�۹�ȣ, �ۼ���, �޽���)
--UPDATE���� �����ϴ� ���ν���


CREATE OR REPLACE PROCEDURE MEMO_EDIT(
PIDX IN MEMO.IDX%TYPE,
PNAME IN MEMO.NAME%TYPE,
PMSG IN MEMO.MSG%TYPE)
IS
BEGIN
    UPDATE MEMO SET NAME=PNAME,MSG=PMSG WHERE PIDX=MEMO.IDX;
END;
/
EXEC MEMO_EDIT(3,'JIN','�ȳ�!~~!@@');
SELECT * FROM MEMO;

update memo set name='�۱泲' where idx=26;

