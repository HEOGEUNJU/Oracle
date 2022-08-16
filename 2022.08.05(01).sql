2022-0805-01)������ Ÿ��
    - ����Ŭ���� ���ڿ�, ����, ��¥, ������ �ڷ�Ÿ���� ����

 1. ���� ������Ÿ��
    . ����Ŭ�� �����ڷ�� ' '�ȿ� ����� �ڷ�
    . ��ҹ��� ����
    . CHAR, VARCHAR(��κ��� DB���� ����ϴ� ��������), VARCHAR2(����Ŭ������ ���), NVARCHAR2(�ٱ��������� �� ���), 
      LONG(2GB¥�� ���ڿ� ������ �� ���), CLOB(4GB¥�� ���ڿ� ������ �� ���), NCLOB ���� ������
      --CHAR�� ������ �������� ��������
      
      
   1) CHAR(n<= ���� ������[BYTE|CHAR]) []�� ������ �ᵵ ���� �Ƚᵵ ����. 
     - �������� ���ڿ� ����
     - �ִ� 2000BYTE���� ���尡��
     - 'n[BYTE|CHAR]' : '[BYTE|CHAR]'�� �����Ǹ� BYTE�� ���
       'CHAR'��  n���ڼ����� ����
     - �ѱ� �� ���ڴ� 3BYTE�� ����
     - �⺻Ű�� ���̰� ������ �ڷ�(�ֹι�ȣ, �����ȣ)�� ���缺�� Ȯ���ϱ� ���� ���
       ���Է� ���� �ڸ����� ���ؼ� �ڷ��� ��Ȯ���� �� �� ���� Ȯ�� ����
     - �÷��� ���� �� �� �ִ� �ִ� ���ڼ� : ������ �������� 2000�ڱ��� ����ǰ� �ѱ��� 666���ڱ����� ����ȴ�.
     
    ��뿹��)
       CREATE TABLE TEMP01(
        COL1 CHAR(10),
        COL2 CHAR(10 BYTE),
        COL3 CHAR(10CHAR));
       
       INSERT INTO TEMP01 VALUES('����', '���ѹ�', '���ѹα�');
     
     SELECT *FROM TEMP01
     
     SELECT LENGTHB(COL1) AS COL1,
            LENGTHB(COL2) AS COL2,
            LENGTHB(COL3) AS COL3
        FROM TEMP01;                    <== COL1,2�� 10BYTE�� ������ ��Ƽ� 10�̰� COL3�� �ѱ� 12BYTE�� ���� ���ڼ� 6���� 
                                            �� �������� ����ؼ� �� 18BYTE�� ���´�
     
    2) VARCHAR2(n[BYTE|CHAR])
      - �������� ���ڿ� �ڷ� ����
      - �ִ� 4000BYTE���� ���� ����
      - VARCHAR, NVARCHAR2�� ���������� ����
     
    ��뿹��)
       CREATE TABLE TEMP15(
        COL1 CHAR(20),
        COL2 VARCHAR2(2000 BYTE),
        COL3 VARCHAR2(4000 CHAR));
        
       INSERT INTO TEMP02 VALUES('ILPOSTINO', 'BOYHOOD', '����ȭ ���� �Ǿ����ϴ�-������');
       
     SELECT * FROM TEMP02;     
     
     SELECT LENGTHB(COL1) AS COL1,
            LENGTHB(COL2) AS COL2,  
            LENGTHB(COL3) AS COL3,
            LENGTH(COL1) AS COL1,
            LENGTH(COL2) AS COL2,
            LENGTH(COL3) AS COL3
        FROM TEMP02;    
            
    3) LONG 
      - �������� ���ڿ� �ڷ� ����
      - �ִ� 2GB���� ���� ���� <== 500,600�������� E-BOOK�� 3~400MB
      - �� ���̺� �� �÷��� LONGŸ�� ��� ���� <== ġ������ ����
      - ���� ��� �������� ����(����Ŭ 8i) => CLOB�� Upgrade 
         ������� ������(������ ����ϴ� �������� ���ؼ�)
    
    �������)
       �÷��� LONG
       . LONG Ÿ������ ����� �ڷḦ �����ϱ� ���� �ּ� 31bit(������ ū����)�� �ʿ�
         =>�Ϻ� ���(LENGTHB ���� �Լ�)�� ����
       . SELECT���� SELECT��, UPDATE�� SET��, INSERT���� VALUES������ ��� ����
       
    ��뿹��)
       CREATE TABLE TEMP03 (
        COL1 VARCHAR2(2O00),
        COL2 LONG);     
    
    FROM dual
     
     INSERT INTO TEMP03 VALUES('������ �߱� ���� 846','������ �߱� ���� 846')
     
     SELECT SUBSTR(COL2),
           -- SUBSTR(COL2,8,3)
       FROM TEMP03;     
     
    SELECT * FROM TEMP03;
     
    4) CLOB(Character Large OBjects)
      - ��뷮�� �������� ���ڿ� ����
      - �ִ� 4GB���� ó�� ����
      - �� ���̺� �������� CLOB Ÿ�� ���� ����
      - �Ϻ� ����� DBMS_LOB API(Application Programming Interface)���� �����ϴ� �Լ� ���
      
    �������)  
       �÷��� CLOB 
       
    ��뿹��)
       CREATE TABLE TEMP04(
          COL1 VARCHAR2(255),
          COL2 CLOB,
          COL3 CLOB);
     
     INSERT INTO TEMP04 VALUES('APPLE BANANA PERSIMMON','APPLE BANANA PERSIMMON','APPLE BANANA PERSIMMON');
     
    
     SELECT * FROM TEMP04;
    
     SELECT SUBSTR(COL1,7,6) AS COL1,
            SUBSTR(COL3,7,6) AS COL3,
            --LENGTHB(COL2) AS COL4,
            DBMS_LOB.GETLENGTH(COL2) AS COL4, -- ���ڼ� ��ȯ
            DBMS_LOB.SUBSTR(COL2,7,6) AS COL2
       FROM TEMP04;
     
     
     
     
     
     
     
     
       
     