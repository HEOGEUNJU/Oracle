2022-0818-01)
2. �����Լ�
  - �����Ǵ� �����Լ��δ� ������ �Լ�(ABS, SIGN, SQRT ��), GREATEST, ROUND, MOD, 
    FLOOR, WIDTH_BUCKET ���� ����
 1) ������ �Լ�
   (1) ABS(n), SIGN(n), POWER(e, n), SQRT(n) - *
     - ABS : n�� ���밪 ��ȯ
     - SIGN : n�� ����̸� 1, �����̸� -1, 0�̸� 0�� ��ȯ // ���� ũ��� ���X
     - POWER : e�� n�� ��(e�� n�� ���� ��)
     - SQRT : n�� ����
       
  ��뿹)
   SELECT ABS(10), ABS(-100), ABS(0),
          SIGN(-20000), SIGN(-0.0099), SIGN(0.000005), SIGN(500000), SIGN(0),
          POWER(2,10),
          SQRT(3.3)
     FROM DUAL;
 
 2) GREATEST(n1,n2[,...n]), LEAST(n1,n2[,...n])
  - �־��� �� n1~n ������ �� �� ���� ū ��(GREATEST), ���� ���� ��(LEAST) ��ȯ
  
  ��뿹)
   SELECT GREATEST('KOREA', 1000, 'ȫ�浿'),
          LEAST('������','ABC','200')
     FROM DUAL;     
 
 
   SELECT ASCII('ȫ�浿')
     FROM DUAL;
 --MAX�� �ϳ��� �÷����� ������ ���� ū ���� ã�� ���̰� GREATEST�� �࿡�� ���� ū ���� ã�� ����
 
  ��뿹) ȸ�����̺��� ���ϸ����� 1000�̸��� ȸ���� ã�� 1000���� ���� ����Ͻÿ�
        Alias�� ȸ����ȣ, ȸ����, �������ϸ���, ����ȸ��ϸ���
   SELECT MEM_ID AS ȸ����ȣ, 
          MEM_NAME AS ȸ����, 
          MEM_MILEAGE AS �������ϸ���,
          GREATEST(MEM_MILEAGE,1000) AS ����ȸ��ϸ���
     FROM MEMBER;
 
 3) ROUND(n [,l]), TRUNC(n [,l]) - ****
   - �־��� �ڷ� n���� �Ҽ��� ���� l+1�ڸ����� �ݿø��Ͽ�(ROUND) �Ǵ� �ڸ�����(TRUNC) 
     �Ͽ� 1�ڸ����� ǥ����
   - l�� �����Ǹ� 0���� ���ֵ�
   - l�� �����̸� �Ҽ��� �̻��� L�ڸ����� �ݿø� �Ǵ� �ڸ� ���� ����
   
 ��뿹)
  SELECT ROUND(12345.678945,3),
         ROUND(12345.678945),
         ROUND(12345.678945,-3) --�Ҽ��� ���ϴ� �ݿø��ϸ� �� ©����.
    FROM DUAL;  
    
  SELECT TRUNC(12345.678945,3),
         TRUNC(12345.678945),
         TRUNC(12345.678945,-3)
    FROM DUAL;       
         
 ��뿹) HR������ ������̺��� ������� �ټӿ����� ���Ͽ� �ټӿ����� ���� �ټ� ������
         ����Ͻÿ�.
         �ټӼ��� = �⺻��(SALALY) * (�ټӳ��/100)
         �޿��հ� = �⺻�� + �ټӼ���
         ���� = �޿��հ��� 13%
         ���޾� = �޿��հ� - �����̸� �Ҽ� ��°�ڸ����� �ݿø��Ͻÿ�.
         Alias�� �����ȣ, �����, �Ի���, �ټӳ��, �޿�, �ټӼ���, ����, ���޾�
          
         SELECT EMPLOYEE_ID AS �����ȣ, 
                FIRST_NAME || LAST_NAME AS �����, 
                HIRE_DATE AS �Ի���, 
                TRUNC((SYSDATE-HIRE_DATE)/365) AS �ټӳ��,
                SALARY AS �⺻�޿�, 
                ROUND(SALARY*(TRUNC((SYSDATE-HIRE_DATE)/365)/100),1) AS �ټӼ���,
                ROUND(((SALARY + SALARY*(TRUNC((SYSDATE-HIRE_DATE)/365)/100))*0.13),1) AS ����,
                ROUND(SALARY + SALARY*(TRUNC((SYSDATE-HIRE_DATE)/365)/100) 
                - ((SALARY + SALARY*(TRUNC((SYSDATE-HIRE_DATE)/365)/100))*0.13),1) AS ���޾�
           FROM HR.Employees;
           
 4) FLOOR(n) , CEIL(n)  -*
  - ���� ȭ�� ���õ� ������ ó���� ���
  - FLOOR : n�� ���ų� (n�� ������ ��) n���� ���� ���� �� ���� ū ����
  - CEIL : n�� ���ų� (n�� ������ ��) n���� ū ���� �� ���� ���� ����
            
 ��뿹)
  SELECT FLOOR(23.456), FLOOR(23), FLOOR(-23.456),
         CEIL(23.456), CEIL(23), CEIL(-23.456)
    FROM DUAL
 
 5) MOD(n,b), REMAINDER(n,b) - ***
  - �������� ��ȯ
  - MOD : �Ϲ��� ������ ��ȯ
  - REMAINDER : �������� ũ�Ⱑ b���� ���ݺ��� ������ �Ϲ��� �������� ��ȯ�ϰ�,
                b���� ���ݺ��� ũ�� ���� ���� �Ǳ� ���� ������ ���簪(n)�� �� �� ��ȯ
  - MOD�� REMAINDER�� ���� ó���� �ٸ�
        
   . MOD (n,b) : n - b * FLOOR(n/b)
   . REMAINDER (n,b) : n - b * ROUND(n/b)
  ex) MOD(23,7), REMAINDER(23,7)
      MOD(23,7) = 23 - 7 * FLOOR(23/7)
                = 23 - 7 * FLOOR(3.286)
                = 23 - 7 * 3
                = 2
      REMAINDER(23,7) = 23 - 7 * ROUND(23/7)
                      = 23 - 7 * ROUND(3.286) 
                      = 23 - 7 * 3
                      = 2      
  ex) MOD(26,7), REMAINDER(26,7)    
      MOD(26,7) = 26 - 7 * FLOOR(26/7)
                = 26 - 7 * FLOOR(3.714)
                = 26 - 7 * 3
                = 5     
               
      REMAINDER(26,7) = 26 - 7 * ROUND(26/7)
                      = 26 - 7 * ROUND(3.714) 
                      = 26 - 7 * 4
                      = -2            
 6) WIDTH_BUCKET(n, min, max, b)
  - �ּҰ� min���� �ִ밪 max���� b���� �������� �������� �� n�� ��� ������
    ���ϴ����� �Ǵ��Ͽ� ������ INDEX ���� ��ȯ
  - n < min �� ��� 0�� ��ȯ�ϰ� n >= �� ��� b+1 ���� ��ȯ  
               
 ��뿹)
  SELECT WIDTH_BUCKET(28,10,39,3),
         WIDTH_BUCKET(8,10,39,3),
         WIDTH_BUCKET(88,10,39,3),
         WIDTH_BUCKET(39,10,39,3),
         WIDTH_BUCKET(10,10,39,3)
    FROM DUAL;
               
 ��뿹) ȸ�����̺��� ȸ������ ���ϸ����� ��ȸ�Ͽ� 1000-9000 ���̸� 3���� �������� �����ϰ� 
         ȸ����ȣ, ȸ����, ���ϸ���, ��� ����ϵ� ����� 
         ���ϸ����� ���� ȸ������ '1��� ȸ��', '2��� ȸ��', '3��� ȸ��', '4��� ȸ��'�� ����Ͻÿ�
               
  SELECT MEM_ID AS ȸ����ȣ, 
         MEM_NAME AS ȸ����, 
         MEM_MILEAGE AS ���ϸ���, 
         4-WIDTH_BUCKET(MEM_MILEAGE,1000,9000,3)||'��� ȸ��' AS ���
         --WIDTH_BUCKET(MEM_MILEAGE,9000,999
         ,3)||'��� ȸ��' AS ���
    FROM MEMBER;
   
               
               
               
               
               
 