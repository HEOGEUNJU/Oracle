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

   SELECT *
     FROM MEMBER
     WHERE MEM_NAME=RTRIM('�̻��� '); -->�̸��� ������ ���� ã�� �� ����.
                                      --> RTRIM�� ���� ������ ������ ������� ������ ã�� �� �ִ�.
                                      --> ��Ȯ�� ���Ϸ��� �켱 MEM_NAME�� ���� Ÿ������ ��Ȯ�� Ȯ�� �ؾ��Ѵ�.
                                         
 5) TRIM(c1) *** 
  - �־��� ���ڿ� ��, �쿡 �����ϴ� ��ȿ�� ������ ���� 
  - �ܾ� ������ ������ �������� ����
  
 
 
 
 
 
 
 
 
 