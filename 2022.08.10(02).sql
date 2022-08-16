2022-0810-02)
 4. LIKE ������
  - ������ �����Ͽ� ���Ϻ񱳸� ����
  - ���ڿ� ��(���� �񱳴� ����, ��¥ Ÿ�Կ��� ��� ����)
  (�������)
   expr LIKE ���Ϲ��ڿ�
   . ���ϱ������� '%'�� '_'�� ���ϵ�ī��(���Ϲ���)�� ���
   . '%' : '%'�� ���� ��ġ ������ ��� ���ڿ��� ������(���鵵 ������) 
     ex) '��%' : '��'���� �����ϴ� ��� ���ڿ��� ��(true)�� ��ȯ
         '%��' : '��'���� ������ ��� ���ڿ��� ��(true)�� ��ȯ
         '%��%': ���ڿ� ���ο� '��'�� �����ϸ� ��(true)�� ��ȯ
   
   . '_' : '_'�� ���� ��ġ���� �ϳ��� ���ڿ� ������
     ex) '��_' : �� ���ڷ� �����ǰ� ù ���ڰ� '��'�̸� ��(true)�� ��ȯ
         '_��' : �� ���ڷ� �����ǰ� '��'���� ������ ��(true)�� ��ȯ
         '_��_': �� ���ڷ� �����ǰ� �߰����ڰ� '��'�̸� ��(true)�� ��ȯ
   
   . ���� ����� ��ȯ�ϱ� ������ (���̵Ǵ� ��찡 ���� �߻�) ����� �ڷḦ �����ϰ� �ִ� ��� 
     ���� ���� ������ �˻�ȿ���� ������
  (��뿹) ȸ�����̺��� �������� '����'�� ȸ������ ��ȸ�Ͻÿ�
           Alias�� ȸ����ȣ, ȸ����, �ּ�
    SELECT MEM_ID AS ȸ����ȣ, 
           MEM_NAME AS ȸ����, 
           MEM_ADD1||' '||MEM_ADD2 AS�ּ�
      FROM MEMBER
     WHERE MEM_ADD1 LIKE '����%';
           
  (��뿹) ��ٱ������̺��� 2020�� 6���� �Ǹŵ� ��ǰ�� ��ȸ�Ͻÿ�
           Alias�� ��ǰ��ȣ     
    SELECT DISTINCT CART_PROD AS ��ǰ��ȣ  
      FROM CART
     WHERE CART_NO LIKE '202006%'
     ORDER BY 1;
     
  (��뿹) �������̺��� 2020�� 6���� ���Ե� ��ǰ�� ��ȸ�Ͻÿ�
           Alias�� ��ǰ��ȣ             
    SELECT DISTINCT BUY_PROD AS ��ǰ��ȣ  
      FROM BUYPROD
     WHERE BUY_DATE >= TO_DATE('20200601') AND BUY_DATE <= TO_DATE('20200630');
        -- TO_CHAR(BUY_DATE,'YYYYMMDD') LIKE '202006%'
        -- BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630'); <= ��¥ ���������� LIKE���� BETWEEN ����ϱ�
        
 5) BETWEEN ������
  - ������ ���� �ڷḦ ��
  (�������)
   expr BETWEEN ��1 AND ��2
   . expr�� ���� '��1'���� '��2' ���̿� �����ϴ� ���̸� ���� ��ȯ
   . BETWEEN�����ڴ� AND�����ڷ� �ٲپ� ����� �� ����
   . ��� ������ Ÿ�Կ� ��� ����
   . ��¥�� ���ڷ� ������ �������� �� ���� ����ϴ� ��������
  (��뿹) ��ǰ���̺��� �ǸŰ����� 10����~20���� ������ ��ǰ�� ��ȸ�Ͻÿ�.
           Alias�� ��ǰ��ȣ, ��ǰ��, �ǸŰ���
   (AND ������)
    SELECT PROD_ID AS ��ǰ��ȣ, 
           PROD_NAME AS ��ǰ��, 
           PROD_PRICE AS �ǸŰ���
      FROM PROD
     WHERE PROD_PRICE>=100000 AND PROD_PRICE<=200000
     ORDER BY 3;
   
   (BETWEEN ������)
    SELECT PROD_ID AS ��ǰ��ȣ, 
           PROD_NAME AS ��ǰ��, 
           PROD_PRICE AS �ǸŰ���
      FROM PROD
     WHERE PROD_PRICE BETWEEN 100000 AND 200000
     ORDER BY 3;
     
     
  (��뿹) ������̺��� �Ի����� 2005��~2007�� ���̿� �Ի��� ������� ��ȸ�Ͻÿ�.         
           Alias�� �����ȣ, �����, �μ��ڵ�, �����ڵ�, �Ի���
    SELECT EMPLOYEE_ID AS �����ȣ, 
           EMP_NAME AS �����, 
           DEPARTMENT_ID AS �μ��ڵ�, 
           JOB_ID AS �����ڵ�, 
           HIRE_DATE AS �Ի���
      FROM HR.Employees
     WHERE HIRE_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20071231')
     ORDER BY 5;
     
  (��뿹) ��ǰ���̺��� ��ǰ�� �з��ڵ尡 'P100'����� 'P300'������ ��ǰ���� ��ȸ�Ͻÿ�.
           Alias�� ��ǰ��ȣ, ��ǰ��, �з��ڵ�, �ǸŰ���
    SELECT PROD_ID AS ��ǰ��ȣ, 
           PROD_NAME AS ��ǰ��, 
           PROD_LGU AS  �з��ڵ�, 
           PROD_PRICE AS �ǸŰ���
      FROM PROD
     WHERE PROD_LGU BETWEEN 'P100' AND 'P199'
       OR  PROD_LGU BETWEEN 'P300' AND 'P399'
     ORDER BY 3;        
           