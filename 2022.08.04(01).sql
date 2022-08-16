2022-0804-01) 
    ������ ���Ǿ�(DDL:Data Definition Language)
    - ������ ������ �����ϱ� ���� ���̺� ����, ����, ���� ���
    - CREATE, DROP, ALTER
1. ���̺� �������
  (�������)
  CREATE TABLE ���̺�� (
    �÷��� ������ Ÿ��[(ũ��)] [NOT NULL] [DEFAULT ��] [,]
                        :
    �÷��� ������ Ÿ��[(ũ��)] [NOT NULL] [DEFAULT ��] [,] 
    [CONSTRAINT �⺻Ű������ PRIMARY KEY(�÷���[,�÷���,...])[,]]  
    [CONSTRAINT �ܷ�Ű������1 FOREIGN KEY(�÷���) REFERENCES ���̺��(�÷���) 
      DELETE ON CASCADE[,]]        
                                        :
    [CONSTRAINT �ܷ�Ű������1 FOREIGN KEY(�÷���) REFERENCES ���̺��(�÷���)
      DELETE ON CASCADE]); 
     
    - �⺻Ű������ : �⺻Ű������ �ο��� �̸����� �� ���̺� �ߺ������ �� ����.
    - �ܷ�Ű������1 : �ܷ�Ű������ �ο��� �̸����� �ߺ������ �� ����.
    - REFERENCES ���̺�� : �θ����̺�� 
    - REFERENCES ���̺�� (Į����) :  �θ����̺��� ����� �÷���
    - DELETE ON CASCADE : �θ����̺��� Ư����(ROW) ������ �ڽ����̺��� �ڷ���� �����ϰ� �θ� �ڷ� ���� ���
    
    
    SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') FROM DUAL; <==����ð� Ȯ���ϴ¹�
    
    ��뿹) �ѱ��Ǽ� �䱸���׿� �´� �����ͺ��̽� �������� ���̺�� �����Ͻÿ�.
    
    (������̺�)
    CREATE TABLE EMP(
       EMP_ID CHAR(4),
       EMP_NAME VARCHAR2(30),
       DEPT_NAME VARCHAR2(50),
       CONSTRAINT PK_EMP PRIMARY KEY(EMP_ID));
       
    (��������̺�)
    CREATE TABLE TBL_SITE(
        SITE_ID NUMBER(3) NOT NULL,
        SITE_NAME VARCHAR2(50),
        SITE_ADDR VARCHAR2(255));,
        CONSTRAINT pk_site PRIMARY KEY(SITE_ID));
    
    (���������)
    CREATE TABLE TBL_MAT(
        MAT_ID CHAR(3),
        MAT_NAME VARCHAR2(50),
        SITE_ID NUMBER(3),
        CONSTRAINT pk_tbl_mat PRIMARY KEY(MAT_ID),
        CONSTRAINT fk_tbl_mat_site FOREIGN KEY(SITE_ID)
            REFERENCES SITE(SITE_ID));
            
    (�ٹ�)
    CREATE TABLE TBL_WORK(
        EMP_ID CHAR(4),
        SITE_ID NUMBER(3),
        INS_DATE DATE,
        CONSTRAINT pk_tbl_work PRIMARY KEY(EMP_ID,SITE_ID),
        CONSTRAINT FK_TBL_WORK_EMP FOREIGN KEY(EMP_ID)
            REFERENCES EMP (EMP_ID),
        CONSTRAINT FK_DBL_WORK_SITE FOREIGN KEY(SITE_ID)
            REFERENCES SITE(SITE_ID));
            
2. DROP TABLE
   - ���̺� ���� ���
   - ���谡 ������ �θ����̺��� ���Ƿ� ������ �� ����
     => ���谡 ������ �� �Ǵ� �ڽ� ���̺��� ������ �� ���� ����
   (�������)
   DROP TABLE ���̺��;

   COMMIT;

   ��뿹��) ����� ���̺��� �����Ͻÿ�.
   --�ڽ����̺� ���� ����
    DROP TABLE TBL_MAT;
    DROP TABLE TBL_WORK;
    DROP TABLE TBL_SITE;
   --�������� ���� �� ���̺� ����
    ALTER TABLE ���̺�� DROP CONSTRAINT �⺻Ű������|�ܷ�Ű������;
    
    ALTER TABLE TBL_MAT DROP CONSTRAINT FK_TBL_MAT_SITE;
    ALTER TABLE TBL_WORK DROP CONSTRAINT FK_TBL_WORK_SITE; 
    
    ROLLBACK;
    
COMMIT;

3. ALTER ���
   - ���̺� �̸�����, �÷��̸� ����, �÷�Ÿ�Ժ���
   - �÷�����, �������� �߰�����
   - �÷�����, �������ǻ��� ���� ����� ����

   1) ���̺� �̸� ����
    ALTER TABLE �������̺�� RENAME TO ���������̺��;
    ��뿹��) ��������̺�(TBL_SITE)�� �����ϰ� SITE�� ���̺���� �����Ͻÿ�.
    ALTER TABLE TBL_SITE RENAME TO SITE;      
 
   2) �÷� �̸� ����
    ALTER TABLE ���̺�� RENAME COLUMN �����÷��� TO �������÷���;
    ��뿹��) SITE���̺� ������ּ�(SITE_ADDR) �÷����� SITE_ADDRESS�� �����Ͻÿ�.
    ALTER TABLE SITE RENAME COLUMN SITE_ADDR TO SITE_ADDRESS;

   3) �÷�DML ������ Ÿ�� �Ǵ� ũ�� ����
    ���� �÷��� ũ�⺸�� ���� ũ��� ������ ������ ����.
    ALTER TABLE ���̺�� MODIFY �÷��� Ÿ��[(ũ��)]
    ��뿹��) SITE���̺��� SITE_ADDRESS�÷� VARCHAR2(255))�� �������� ���ڿ� 100BYTE��(CHAR(100)) �����Ͻÿ�.
    ALTER TABLE SITE MODIFY SITE_ADDRESS CHAR(255);
    ALTER TABLE SITE MODIFY SITE_ADDRESS VARCHAR2(255);
    
    INSERT INTO SITE VALUES(101,'�����ʱ����������','������ �߱� ���� 846 3��');
    
    4) �÷� �Ǵ� �������� �߰�
    ALTER TABLE ���̺�� ADD(�÷��� ������Ÿ��[(ũ��)]) �Ǵ� 
    ALTER TABLE ���̺�� ADD(CONSTRAINT �⺻Ű������ PRIMARY KEY(�÷���[,...]))
    ALTER TABLE ���̺�� ADD(CONSTRAINT �ܺ�Ű������ FOREIGN KEY(�÷���)
     REFERENCES ���̺��(�÷���))
    ��뿹��) SITE���̺��� �⺻Ű(SITE_ID)�� �����Ͻÿ�.
    ALTER TABLE SITE ADD(CONSTRAINT PK_SITE PRIMARY KEY(SITE_ID));
    
    5) �÷� �Ǵ� �������� ����
    ALTER TABLE ���̺�� DROP COLUMN �÷���|DROP CONSTRAINT �����̸�;
   
     
    
    