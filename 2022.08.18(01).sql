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

     
 
 
 
 
 
 
 
 
 
 
 