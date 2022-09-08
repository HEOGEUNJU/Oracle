2022-0906-01)PL/SQL
  - ǥ�� SQL�� ������ �ִ� ����(����, �ݺ���,�б⹮ ���� ����)�� ����
  - PROCEDUAL LANGUAGE SQL 
  - BLOCK������ �����Ǿ� ����
  - �͸���(Anonymous Block), Stored Procedure, user defined Function, Trigger,
    Package ���� ����
  - ���ȭ �� ĸ��ȭ ��� ���� -- ��ü�� �Ƿ��� ĸ��ȭ,������,����� �̷�������Ѵ�.
  
  1. �͸���
  - PL/SQL�� �⺻ ���� ����
  - �̸��� ���� �� ����(ȣ��)�� �Ұ���
  
  (����)
    DECLARE
      �����(����,���,Ŀ�� ����);
    BEGIN
      �����:ó���� �����Ͻ� ������ �����ϱ� ���� SQL����, �ݺ���, �б⹮ ������ ����
      [EXCEPTION
        ����ó�� ��
       ]
    END;
  - ���࿵������ ����ϴ� SELECT���� 
    SELECT �÷�list
      INTO ������[,������,...]
      FROM ���̺��
    [WHERE ����]
    . �÷��� ������ ������ Ÿ���� INTO���� ������ ���� �� ������ Ÿ�԰� ����
  
  1) ����
     . ���߾���� ������ ���� ����
     . SCLAR����, REFERENCE ����, COMPOSITE ����, BINDING ���� ���� ����

     (�������)
     ** SCLAR ����
     ������[CONSTANT] ������Ÿ�� [(ũ��)] [:=�ʱⰪ];
      . ������Ÿ�� : SQL���� �����ϴ� ������ Ÿ��, PLS_INTEGER, BINARY_INTEGER, BOOLEAN ���� ������
      . 'CONSTANT' : ��� ����(�ݵ�� �ʱⰪ�� �����Ǿ�� ��)
      -- PLS_INTEGER, BINARY_INTEGER�� 4BYTE�� ǥ���Ǿ����� ���� <= ó�� �ӵ��� �������� ���� �۾Ƽ� �� ������� ����
      -- ������ = ���ʿ� �� �� ������ ����� = ���ʿ� �� �� ����.
      -- BOOLEAN�� ����Ŭ������ TRUE, FALSE, NULL ���� ���� ���� �� �ִ�. ������ �ʱ�ȭ�� ��Ű�� ������ NULL���� ����
     **REFERENCE ����
        ������ : ������ ���̺��.�÷���%TYPE
        ������ : ������ ���̺��%ROWTYPE
        
--��뿹--
  Ű����� �μ��� �Է� �޾� �ش� �μ��� ���� ���� �Ի��� ����� �����ȣ, �����, ��å�ڵ�, �Ի����� ����ϴ� ����� �ۼ��Ͻÿ�
  ACCEPT P_DID PROMPT '�μ���ȣ �Է�: '
  DECLARE
    V_DID HR.Departments.DERARTMENT_ID%TYPE;
    V_EID HR.Employees.EMPLOYEE_ID%TYPE; --�����ȣ
    V_NAME VARCHAR2(100);--�����
    V_JID HR.JOBS.JOB_ID%TYPE;--��å�ڵ�
    V_HDATE DATE;--�Ի���
  BEGIN
    V_DID := TO_NUMBER('&P_DID');
    SELECT EMPLOYEE_ID,EMP_NAME,JOB_ID,HIRE_DATE
      INTO V_EID, V_NAME, V_JID, V_HDATE
      FROM (SELECT HR.Employees, EMP_NAME, JOB_ID, HIRE_DATE
              FROM HR.Employees 
             WHERE  DEPARTMENT_ID = V_DID
             ORDER BY 4)A
     WHERE ROWNUM=1;
     
     DBMS_OUTPUT.PUT._LINE('�����ȣ : '||V_EID);
     DBMS_OUTPUT.PUT._LINE('����� : '||V_NAME);
     DBMS_OUTPUT.PUT._LINE('��å�ڵ� : '||V_JID);
     DBMS_OUTPUT.PUT._LINE('�Ի��� : '||V_DATE);
     DBMS_OUTPUT.PUT._LINE('------------------------------');
  END; 
  
--��뿹--
  ȸ�����̺��� ������ '�ֺ�'�� ȸ������ 2020�� 5�� ������Ȳ�� ��ȸ�ÿ�
  Alias�� ȸ����ȣ, ȸ����,����, ���űݾ� �հ� 
    
  SELECT A.MEM_ID AS ȸ����ȣ, 
         A.MEM_NAME AS ȸ����, 
         A.MEM_JOB AS ����, 
         D.BSUM AS ���űݾ��հ�
    FROM (SELECT MEM_ID, MEM_NAME, MEM_JOB
            FROM MEMBER
           WHERE MEM_JOB='�ֺ�')A,
         (SELECT B.CART_MEMBER AS BMID,
                 SUM(B.CART_QTY*C.PROD_PRICE) AS BSUM
            FROM CART B, PROD C
           WHERE B.CART_PROD=C.PROD_ID
             AND B.CART_NO LIKE '202005%'
           GROUP BY B.CART_MEMBER) D
   WHERE A.MEM_ID = D.BMID        
   
  (�͸���)
  DECLARE
    V_MID MEMBER.MEM_ID%TYPE;
    V_NAME VARCHAR2(100);
    V_JOB MEMBER.MEM_JOB%TYPE;
    V_SUM NUMBER := 0; --27�ڸ������� �˾Ƽ� �����
    CURSOR CUR_MEM IS
     SELECT MEM_ID, MEM_NAME, MEM_JOB
            FROM MEMBER
           WHERE MEM_JOB='�ֺ�';
  BEGIN
    OPEN CUR_MEM;
    LOOP 
      FETCH CUR_MEM INTO V_MID, V_NAME, V_JOB;
      EXIT WHEN CUR_MEM%NOTFOUND;
      SELECT SUM(A.CART_QTY*B.PROD_PRICE) INTO V_SUM
        FROM CART A, PROD B
       WHERE A.CART_PROD = B.PROD_ID
         AND A.CART_NO LIKE '202005%'
         AND A.CART_MEMBER = V_MID;
     DBMS_OUTPUT.PUT_LINE('ȸ����ȣ : '||V_MID);
     DBMS_OUTPUT.PUT_LINE('ȸ���� : '||V_NAME);
     DBMS_OUTPUT.PUT_LINE('���� : '||V_JOB);
     DBMS_OUTPUT.PUT_LINE('���űݾ� : '||V_SUM);
     DBMS_OUTPUT.PUT_LINE('-----------------------');
    END LOOP;  
    CLOSE CUR_MEM;
  END;

--��뿹--
  �⵵�� �Է� �޾� �������� ������� �����ϴ� ����� �ۼ��Ͻÿ�
  ACCEPT P_YEAR PROMPT '�⵵�Է� : '
  DECLARE 
   V_YEAR NUMBER := TO_NUMBER('&P_YEAR');
   V_RES VARCHAR2(200);
  BEGIN
   IF(MOD(V_YEAR,4) = 0 AND MOD(V_YEAR,100) != 0) OR (MOD(V_YEAR,400) = 0) THEN
      V_RES := V_YEAR ||'���� �����Դϴ�.';
   ELSE   
      V_RES := V_YEAR ||'���� ����Դϴ�.';
   END IF;
   
   DBMS_OUTPUT.PUT_LINE(V_RES);
  END;
  
--��뿹--
  �������� �Է¹޾� ���� ���̿� ���ѷ��� ���Ͻÿ�.
  ���� ���� : ������ * ������ * ������(3.1415926)
  ���ѷ� : ���� * 3.1415926
  
  ACCEPT P_RADIUS PROMPT ' ������ �Է� : '
  DECLARE 
   V_RADIUS NUMBER := 15;
   V_PIE CONSTANT NUMBER := 3.1415926;
   V_AREA NUMBER := 0;
   V_CIRCUM NUMBER := 0;
  BEGIN
    V_AREA := V_RADIUS * V_RADIUS * V_PIE;
    V_CIRCUM := 2* V_RADIUS *V_PIE;
    
    DBMS_OUTPUT.PUT_LINE('���� �ʺ� ='||V_AREA);
    DBMS_OUTPUT.PUT_LINE('���� �ѷ� ='||V_CIRCUM);
END;































