2022-0817-02
 4) LTRIM(c1 [,c2]), RTRIM(c1 [,c2]) **
   - �־��� ���ڿ� c1�� ���ʺ���(LTRIM) �Ǵ� �����ʺ���(RTRIM) c2 ���ڿ��� ã��
     ã�� ���ڿ��� ������
   - �ݵ�� ù ���ں��� ��ġ�ؾ���
   - c2�� �����Ǹ� ������ ã�� ����
   - c1 ���ڿ� ������ ������ ������ �� ����
   
 ��뿹)
   SELECT LTRIM('APPLEAP PERSIMMON BANANA','APLE'), -- ���ڿ� ������ ������ ������ �� ����.
          LTRIM('APPLEAP PERSIMMON BANANA'),
          LTRIM('APLEAP PERSIMMON BANANA','AP') -->���ڿ� �ȿ� ���� �����̸� �� �����. 
                                                -->�׷��� LEAP�� ��

     FROM DUAL

   SELECT RTRIM('APPLEAPPERSIMMON BANANA','APLEN'),
          RTRIM('APPLEAP PERSIMMON BANANA'),
          RTRIM('APLEAP PERSIMMON BANANA','AN') 

     FROM DUAL

   SELECT 
     FROM MEMBER
     WHERE MEM_NAME=RTRIM('�̻��� '); -->�̸��� ������ ���� ã�� �� ����.
                                      --> RTRIM�� ���� ������ ������ ������� ������ ã�� �� �ִ�.
                                      --> ��Ȯ�� ���Ϸ��� �켱 MEM_NAME�� ���� Ÿ������ ��Ȯ�� Ȯ�� �ؾ��Ѵ�.
                                         
 5) TRIM(c1) *** 
  - �ܾ� ������ ������ �������� ����
  - �־��� ���ڿ� c1�� ���Ե� ��ȿ�� ����(�����ʰ� ����)�� ������
  
 ��뿹) �������̺�(JOBS)���� ������(JOB_TITLE)'Accounting Manager'�� ������ ��ȸ�Ͻÿ�.
   SELECT JOB_ID AS �����ڵ�, 
          LENGTHB(JOB_TITLE) AS "�������� ����", 
          JOB_TITLE AS ������,
          MIN_SALARY AS �����޿�, 
          MAX_SALARY AS �ְ�޿�
     FROM HR.JOBS
    WHERE TRIM(JOB_TITLE)= 'Accounting Manager';
   
 ��뿹) JOBS���̺��� �������� ������ Ÿ���� VARCHAR2(40)���� �����Ͻÿ�
 --���̺��� �������� --> �������� --> �������̷� �����ϸ� �������̿� �ִ�
 --�� ������ �����ͷ� �ν� �Ǳ� ������ ĭ�� �����ϰ� �ȴ�.
  EX) VARCHAR2 => CHAR => VARCHAR2
  
   UPDATE HR.JOBS
      SET JOB_TITLE=TRIM(JOB_TITLE);
      
   COMMIT; 
 
 6) SUBSTR(c1,m[,n] -*****
   - �־��� ���ڿ� c1���� m��°���� n���� ���ڸ� ����
   - m�� ���� ��ġ�� ��Ÿ���� 1���� counting��
   - n�� ������ ������ ���� �����ϸ� m��° ���� ��� ���ڸ� ����
   - m�� �����̸� �����ʺ��� counting��
   
 ��뿹)
    SELECT SUBSTR('ABCDEFGHIJK',3,5),
           SUBSTR('ABCDEFGHIJK',3),
           SUBSTR('ABCDEFGHIJK',-3,5),
           SUBSTR('ABCDEFGHIJK',3,15)
      FROM DUAL;      
-- ('ABCDEFGHIJK',3,15) 3, �ڿ� ������ ���� ���� �Ǿ����ų� ��ü ���ڼ� ���� ũ�� �����ִ� �� 
-- �� �����϶�� �Ҹ�����~

 ��뿹) ȸ�����̺��� �ֹι�ȣ �ʵ�(MEM_REGNO1, MEM_REGNO2)�� �̿��Ͽ� ȸ������
         ���̸� ���ϰ�, ȸ����ȣ, ȸ����, �ֹι�ȣ, ���̸� ����Ͻÿ�.
    SELECT MEM_ID AS ȸ����ȣ, 
           MEM_NAME AS ȸ����, 
           MEM_REGNO1||'_'||MEM_REGNO2 AS �ֹι�ȣ, 
           CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN ('1','2') THEN  --CASE WHEN ���� THEN ELSE END => IF��� ���
                2022-(TO_NUMBER(SUBSTR(MEM_REGNO1,1,2)) + 1900)
           ELSE
                2022-(TO_NUMBER(SUBSTR(MEM_REGNO1,1,2)) + 2000)
           END AS ����
      FROM MEMBER;
      
      
 ��뿹) ������ 2020�� 4�� 1���̶�� �����Ͽ� 'c001'ȸ���� ��ǰ�� ������ ��
         �ʿ��� ��ٱ��� ��ȣ�� �����Ͻÿ�. MAX()�Լ� ���, TO_CHAR()�Լ����
    SELECT '20200401'||TRIM(TO_CHAR(MAX(TO_NUMBER(SUBSTR(CART_NO,9))) +1,'00000'))
      FROM CART
     WHERE SUBSTR(CART_NO,1,8) = '20200401';
     
    SELECT MAX(CART_NO)+1 AS "    ��ٱ��Ϲ�ȣ"
      FROM CART
     WHERE SUBSTR(CART_NO,1,8) = '20200401'; 
     
 ��뿹) �̹��� ������ ȸ������ ��ȸ�Ͻÿ�
         Alias�� ȸ����ȣ, ȸ����, �������, ����
         ��, ������ �ֹε�Ϲ�ȣ�� �̿��� ��
    SELECT MEM_ID AS ȸ����ȣ, 
           MEM_NAME AS ȸ����, 
           MEM_REGNO1 AS �������, 
           SUBSTR(MEM_REGNO1,3,2)||'��'||SUBSTR(MEM_REGNO1,5,2)||'��' AS ����
      FROM MEMBER
     WHERE SUBSTR(MEM_REGNO1,3,2) = '09'; 
     
 7) REPLACE(c1, c2 [,c3]) - **
   - �־��� ���ڿ� c1���� c2���ڿ��� ã�� c3���ڿ��� ġȯ
   - c3�� �����Ǹ� c2�� ������
   - �ܾ� ������ �������� ���� => c2�� ������ �Է��ϸ� �ܾ� ������ ������ ��� �����
   
 ��뿹) --��ȭ��ȣ ������ �� - , . , ���� �� �߱��������� ����ϴ� �� �ϳ��� ���Ͻ�Ű�� ���� ���
   SELECT REPLACE('APPLE  PERSIMMON BANANA','A','����') AS ONE,
          REPLACE('APPLE  PERSIMMON BANANA','A') AS TWO,
          REPLACE(' APPLE  PERSIMMON BANANA ',' ','-') AS THREE,
          REPLACE(' APPLE  PERSIMMON BANANA ',' ') AS FOUR -- �ܾ� ������ ������ �����ϱ� ���� �� ������ ���� ���� ����Ѵ�.
     FROM DUAL;     
   
 
 