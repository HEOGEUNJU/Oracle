2022-080-01)
3. ��¥�ڷ���
  - ��¥ �ð� ������ ����(��,��,��,��,��,��)
  - ��¥ �ڷ�� ������ ������ ������
  - date, timestamp Ÿ�� ����
  1) DATE Ÿ��
   . �⺻ ��¥ �� �ð����� ����
  (�������)
  �÷��� DATE 
  . ������ ������ ������ŭ �ٰ��� ��¥(�̷�)
  . ������ ������ ������ŭ ������ ��¥(����)
  . ��¥ �ڷ� ������ ������ ����(DAYS) ��ȯ
  . ��¥�ڷ�� ��/��/�� �κа� ��/��/�� �κ����� �����Ͽ� ����
  ** �ý����� �����ϴ� ��¥������ SYSDATE�Լ��� ���Ͽ� ������ �� ����
  
   (��뿹) CREATE TABLE TEMP07(
             COL1 DATE,
             COL2 DATE,
             COL3 DATE);
  
            INSERT INTO TEMP07 VALUES(SYSDATE, SYSDATE-10, SYSDATE+10);
            SELECT * FROM TEMP07;
            SELECT TO_CHAR(COL1, 'YYYY-MM-DD'),
                   TO_CHAR(COL2, 'YYYY-MM-DD HH24:MI:SS'),
                   TO_CHAR(COL1, 'YYYY-MM-DD HH12:MI:SS')
                FROM TEMP07;
            
            SELECT CASE MOD(TRUNC(SYSDATE) - TRUNC(TO_DATE(00021111'))-1,7)
                        WHEN 1 THEN '������'
                        WHEN 2 THEN 'ȭ����'
                        WHEN 3 THEN '������'
                        WHEN 4 THEN '�����'
                        WHEN 5 THEN '�ݿ���'
                        WHEN 6 THEN '�����'
                        ELSE '�Ͽ���'
                    END AS ����
                    
            FROM DUAL;
                        
            SELECT 12384981243912834129*1541    FROM DUAL
            
            SELECT SYSDATE-TO_DATE ('20200807') FROM DUAL;
            
            
            
  2) TIMESTAMP Ÿ��
   . �ð��� ����(TIME ZONE)�� ������ �ð�����(10����� 1��)�� �ʿ��� ��� ���
  
  (�������)    
    . �÷��� TIMESTAMP                      : �ð��� �������� ������ �ð����� ����
    . �÷��� TIMESTAMP WITH LOCAL TIME ZONE : �����ͺ��̽��� � ���� ������ �ð��븦 �������� 
                                              ������ �����ϴ� Ŭ���̾�Ʈ���� ������ ���� �ð� �Է�
                                              �ð��� Ŭ���̾�Ʈ ������ �ð����� �ڵ� ��ȯ ��µǱ� ������
                                              �ð��� ������ ������� ����
    . �÷��� TIMESTAMP WITH TIME ZONE       : ������ �ð��� ���� ���� / (�����/���ø�)���� ǥ��ȴ�.
     
    . �ʸ� �ִ� �Ҽ��� 9�ڸ����� ������ �� ������ ǥ���� �Ҽ��� 6�ڸ������� ǥ����
  
  (��뿹)
    CREATE TABLE TEMP08
    (COL1 DATE,
     COL2 TIMESTAMP,
     COL3 TIMESTAMP WITH LOCAL TIME ZONE,
     COL4 TIMESTAMP WITH TIME ZONE);
            
    INSERT INTO TEMP08 VALUES(SYSDATE, SYSDATE, SYSDATE, SYSDATE);       
    SELECT * FROM TEMP08;
    
    
    
    
    
    
    
    
    