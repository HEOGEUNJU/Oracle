2022-0902-02)����Ŭ ��ü
 1. VIEW ��ü
  - TABLE�� ������ ��ü
  - ������ ���̺��̳� VIEW�� ������� ���ο� SELECT ���� ����� VIEW�� ��
  - SELECT���� ���� ��ü�� �ƴ϶� ���� ��ü��
  - ������� 
  . �ʿ��� ������ �л�Ǿ� �Ź� ������ �ʿ�� �ϴ� ���
  . Ư���ڷ��� ������ �����ϰ��� �ϴ� ���(���Ȼ�)
 (�������)
  CREATE [OR REPLACE] VIEW ���̸� [(�÷�list)]
  AS
    SELECT ��
    [WITH READ ONLY]
    [WITH CHECK OPTION];
    
    'OR REPLACE' : �̹� �����ϴ� ���� ��� ������ �並 ��ġ�ϰ� �������� �ʴ� ��� ���� 
                   ���� 
    '(�÷�list)' : �信�� ����� �÷���.
                   (�����ϸ� 
                    1) �並 �����ϴ� SELECT ���� SELECT���� �÷���Ī�� ���Ǿ����� 
                       �÷���Ī�� ���� �÷����� ��
                    2) �並 �����ϴ� SELECT ���� SELECT���� �÷���Ī�� ������ �ʾ�����
                       SELECT���� �÷����� ���� �÷����� ��
    'WITH READ ONLY' : �б������(�信�� ����) -- �並 �ǵ帮�� �������̺� ����Ǳ� ������ �並 �� �ǵ帮���� �ϱ� ����
                       �������̺��� ����Ǹ� �䵵 �ڵ����� ����Ǵµ� ���ϴ°� ���� �� �ִ� ����� ����. 
    'WITH CHECK OPTION' : ������ �並 ������� �並 �����ϴ� SELECT ���� �������� �����ϵ���
                          �ϴ� DML����� ����� �� ����(�信�� ����)
****'WITH READ ONLY'�� 'WITH CHECK OPTION'�� ���� ����� �� ����                          
    
--��뿹--
  ȸ�����̺��� ���ϸ����� 3000�̻��� ȸ���� ȸ����ȣ, ȸ����, ����, ���ϸ����� �並 �����Ͻÿ�
  
  CREATE OR REPLACE VIEW V_MEM01(MID,MNAME,MJOB,MILE)
  AS 
  SELECT MEM_ID AS ȸ����ȣ, 
         MEM_NAME AS ȸ����, 
         MEM_JOB AS ����, 
         MEM_MILEAGE AS ���ϸ���
    FROM MEMBER
   WHERE MEM_MILEAGE>=3000; 
    
    
  SELECT * FROM V_MEM01; 
    
  **V_MEM01���� ��ö��ȸ��(k001)�� ���ϸ����� 2000���� ����
  
  UPDATE V_MEM01
     SET MEM_MILEAGE=2000
   WHERE MEM_ID = 'k001';  
    
  **MEMEBER���̺��� ��ö��ȸ��(K001)�� ���ϸ����� 5000���� ����
  UPDATE MEMBER
     SET MEM_MILEAGE = 5000
   WHERE MEM_ID = 'k001';  
    
  **MEMEBER���̺��� ��� ȸ������ ���ϸ����� 1000�� �߰� �����Ͻÿ�
  UPDATE MEMBER
     SET MEM_MILEAGE = MEM_MILEAGE + 1000
    
  (�б�����)
  CREATE OR REPLACE VIEW V_MEM01(MID,MNAME,MJOB,MILE)
  AS 
  SELECT MEM_ID AS ȸ����ȣ, 
         MEM_NAME AS ȸ����, 
         MEM_JOB AS ����, 
         MEM_MILEAGE AS ���ϸ���
    FROM MEMBER
   WHERE MEM_MILEAGE>=3000 
    WITH READ ONLY;
    
  SELECT * FROM V_MEM01; 
  
  **MEMBER���̺��� ��� ȸ���� ���ϸ����� 1000�� ���ҽ�Ű�ÿ�
  UPDATE MEMBER
     SET MEM_MILEAGE = MEM_MILEAGE - 1000
     
  COMMIT;      
     
  **VIEW V_MEM01�� �ڷῡ�� ��ö�� ȸ���� ���ϸ���('k001')�� 3700���� ����
  UPDATE V_MEM01
     SET MILE = 3700
   WHERE MID = 'k001'  
     
  (���Ǻ�)
  CREATE OR REPLACE VIEW V_MEM01(MID,MNAME,MJOB,MILE)
  AS 
  SELECT MEM_ID AS ȸ����ȣ, 
         MEM_NAME AS ȸ����, 
         MEM_JOB AS ����, 
         MEM_MILEAGE AS ���ϸ���
    FROM MEMBER
   WHERE MEM_MILEAGE>=3000 
    WITH CHECK OPTION;
    
  SELECT * FROM V_MEM01;    
     
  **�� V_MEM01���� �ſ�ȯȸ��('c001')�� ���ϸ����� 5500���� �����Ͻÿ�
  --WHERE ������ �������� ������ ���氡��--
  UPDATE V_MEM01
     SET MILE = 5500
   WHERE MID = 'c001'
   -->���� ���̺��� �����͵� ����� 
     
  **�� V_MEM01���� �ſ�ȯȸ��('c001')�� ���ϸ����� 1500���� �����Ͻÿ�   
  UPDATE V_MEM01
     SET MILE = 1500
   WHERE MID = 'c001'   
  -->WHERE  ������ �����ؼ� �ȵ�   
     
  UPDATE MEMBER
     SET MEM_MILEAGE = 1500
   WHERE MEM_ID = 'c001'   
     
  ROLLBACK ;  
     
     