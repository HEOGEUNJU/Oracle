2022-0809-01)������
 1. ����(��)������
  - �ڷ��� ��Ұ��踦 ���ϴ� �����ڷ� ����� ��(true)�� ����(false)�� ��ȯ
  - >, <, >=, <=, !=, =, (<>)
  - ǥ����(CASE WHEN ~ THEN, DECODE)�̳� WHERE �������� ���
  
  ��뿹) ȸ�����̺� (MEMBER)���� ��� ȸ������ ȸ����ȣ, ȸ����, ����, ���ϸ����� ��ȸ�ϵ� ���ϸ����� ����
          ȸ������ ��ȸ�Ͻÿ�.
    SELECT MEM_ID AS ȸ����ȣ,
           MEM_NAME AS ȸ����,
           MEM_JOB AS ����,
           MEM_MILEAGE AS ���ϸ���
      FROM MEMBER
      --ORDER BY MEM_MILEAGE DESC;
      ORDER BY 4 DESC;
      
      
      
  ��뿹) ������̺�(Employees)�μ���ȣ�� 50���� ������� ��ȸ�Ͻÿ�.
          Alias�� �����ȣ, �����, �μ���ȣ, �޿��̴�.
    
  SELECT EMPLOYEE_ID AS �����ȣ, 
         EMP_NAME AS �����, 
         DEPARTMENT_ID AS �μ���ȣ, 
         SALARY AS�޿�
    FROM HR.Employees
   WHERE DEPARTMENT_ID=50; 
   
  ��뿹) ȸ�����̺�(MEMBER)���� ������ �ֺ���ȸ������ ��ȸ�Ͻÿ�.
          Alias�� ȸ����ȣ, ȸ����, ����, ���ϸ����̴�.
          
  SELECT MEM_ID AS ȸ����ȣ,
         MEM_NAME AS ȸ����,
         MEM_JOB AS ����,
         MEM_MILEAGE AS ���ϸ���
    FROM MEMBER
   WHERE MEM_JOB='�ֺ�';
   
   
   
 2. ���������
   - '+', '-', '*', '/' => 4Ģ ������    <����Ŭ�� ���������ڰ� ����. �׸��� ������ �����ڴ� REMINEDER��� �Լ��� ����Ѵ�.>
   - ( ) : ������ �켱������ ������ �� ���
  
  ��뿹) ������̺�(HR.EMPLOYEES)���� ���ʽ��� ����ϰ� ���޾��� �����Ͽ� ����Ͻÿ�.
          ���ʽ� = ���� * ���������� 30%
          ���޾� = ���� + ���ʽ�
          Alias�� �����ȣ, �����, ����, ��������, ���ʽ�, ���޾�
          ��� ���� �����κи� ��� 
  
  SELECT EMPLOYEE_ID AS �����ȣ, 
         FIRST_NAME||' '||LAST_NAME AS �����, 
         SALARY AS ����, 
         NVL(COMMISSION_PCT,0) AS ��������, 
         NVL(ROUND(COMMISSION_PCT*SALARY*0.3),0) AS ���ʽ�, 
         SALARY + NVL(ROUND(COMMISSION_PCT*SALARY*0.3),0) AS ���޾�        
    FROM HR.Employees; 
    
     
 3. ��������
   - �ΰ� �̻��� ������� ����(AND, OR)�ϰų� ����(NOT)��� ��ȯ 
   - NOT, AND, OR
   --------------------------
     �Է�           ���
    A    B       OR     AND
   --------------------------
    0    0       0       0              <= 0�� FALSE, 1�� TRUE
    0    1       1       0
    1    0       1       0
    1    1       1       1
  
  
  ��뿹) ��ǰ���̺�(PROD)���� �ǸŰ����� 30���� �̻��̰� ������� 5�� �̻��� 
          ��ǰ�� ��ǰ��ȣ, ��ǰ��, ���԰�, �ǸŰ�, ������� ��ȸ�Ͻÿ�.
   SELECT PROD_ID AS ��ǰ��ȣ, 
          PROD_NAME AS ��ǰ��, 
          PROD_COST AS ���԰�, 
          PROD_PRICE AS �ǸŰ�, 
          PROD_PROPERSTOCK AS �������        
     FROM PROD
    WHERE PROD_PRICE>=300000 
      AND PROD_PROPERSTOCK>=5
    ORDER BY 4;  
   
  ��뿹) �������̺�(BUYPROD)���� �������� 2020�� 1���̰� ���Լ����� 10�� �̻��� ���������� ��ȸ�Ͻÿ�.
          Alias�� ������, ���Ի�ǰ, ���Լ���, ���Աݾ�
   SELECT BUY_DATE AS ������, 
          BUY_PROD AS ���Ի�ǰ, 
          BUY_QTY AS ���Լ���, 
          BUY_COST*BUY_QTY AS ���Աݾ�   
     FROM BUYPROD
    WHERE BUY_DATE>=TO_DATE('20200101') AND BUY_DATE<=TO_DATE('20200131')
  --WHERE BUY_DATE>='20200101'
  --  AND BUY_DATE<='20200131' <= �� ����� ����
      AND BUY_QTY>=10
    ORDER BY 1;
  
  ��뿹) ȸ�����̺��� ���ɴ밡 20���̰ų� ���� ȸ���� ��ȸ�Ͻÿ�.
          Alias�� ȸ����ȣ, ȸ����, �ֹι�ȣ, ���ϸ���
   SELECT MEM_ID AS ȸ����ȣ, 
          MEM_NAME AS ȸ����, 
          MEM_REGNO1||'-'||MEM_REGNO2 AS �ֹι�ȣ, 
          TRUNC(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR),-1) AS ���ɴ�,
          MEM_MILEAGE AS ���ϸ��� 
     FROM MEMBER
    WHERE TRUNC(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR),-1)=20
       OR SUBSTR(MEM_REGNO2,1,1) IN('2','4') 
     --OR (SUBSTR(MEM_REGNO2,1,1)='2' OR SUBSTR(MEM_REGNO2,1,1) = '4')  <= �� ����� ����
     
  ��뿹) ȸ�����̺��� ���ɴ밡 20�� ���� ȸ���̸鼭 ���ϸ����� 2000�̻��� ȸ���� ��ȸ�Ͻÿ�.
          Alias�� ȸ����ȣ, ȸ����, �ֹι�ȣ, ���ϸ���
   SELECT MEM_ID AS ȸ����ȣ, 
          MEM_NAME AS ȸ����, 
          MEM_REGNO1||'-'||MEM_REGNO2 AS �ֹι�ȣ, 
          MEM_MILEAGE AS ���ϸ���
     FROM MEMBER
    WHERE (TRUNC(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR),-1)=20
       OR SUBSTR(MEM_REGNO2,1,1) IN('2','4'))
      AND MEM_MILEAGE>=2000;
   
  ��뿹) Ű����� �⵵�� �Է¹޾� ����� ����� �Ǵ��Ͻÿ�.
        ���� : 4�� ����̸鼭 100�� ����� �ƴϰų� ||�Ǵ� 400�� ����� �Ǵ� �⵵.
   ACCEPT P_YEAR   PROMPT '�⵵�Է� : '
   DECLARE 
     V_YEAR NUMBER:=TO_NUMBER('&P_YEAR');
     V_RES VARCHAR2(100); 
   BEGIN 
     IF (MOD(V_YEAR,4)=0 AND MOD(V_YEAR,100) != 0) OR (MOD(V_YEAR,400)=0) THEN
        V_RES := TO_CHAR(V_YEAR)||'�⵵�� �����Դϴ�.';
     ELSE
        V_RES := TO_CHAR(V_YEAR)||'�⵵�� ����Դϴ�.';
     END IF;
     DBMS_OUTPUT.PUT_LINE(V_RES); 
     --<= �ڹ��� SYSO�� ����.
   END;  
   
   