2022-0829-01)���̺� ����
 - ������ �����ͺ��̽����� ����(Relationship)�� �̿��Ͽ� �������� ���̺�κ��� �ʿ��� �ڷḦ 
   �����ϴ� ���� 
 - ���ο� �����ϴ� ���̺��� �ݵ�� ����(�ܷ�Ű ����)�� �ξ����(���谡 ���� ���̺��� ������
   Cartessian(Cross) join �̶�� ��)
 - ������ ����
   . �������ΰ� �ܺ�����(Inner join, outer join)
   . �Ϲ����ΰ� ANSI Join
   . Equi Join, Non-Equi Join, Self Join, Cartessian Product 
 1. �Ϲ� ����
  - �� DB �������� �ڻ��� DBMS�� ����ȭ�� ���� ������ ����(���߻縶�� �ٸ�)
  - ��� DB�� �ٲ�� ����� ������ ���� �����ؾ� ��
  (�������)
  SELECT �÷�list
    FROM ���̺��1 [��Ī1], ���̺��2 [��Ī2] [,...]
   WHERE [��Ī1.|���̺��1.]�÷��� ������ [��Ī2.|���̺��2.]�÷��� 
    [AND ��������] 
    [AND �Ϲ�����]
                            :
                            
  . n���� ���̺��� ���Ǹ� ���������� ��� n-1�� �̻� �Ǿ�� ��. 
  . �Ϲ����ǰ� ���������� ��� ������ �ٲ� �������
   
 2. ANSI ��������
  SELECT �÷�list 
    FROM ���̺��1[��Ī1]
   INNER|CROSS|NATURAL JOIN ���̺��2 [��Ī2] ON(�������� [AND �Ϲ�����]) -- ���̺��1�� ���̺��3�� �������� ���� �ʾұ� ������ ���ڸ��� �� �� ����.
   INNER|CROSS|NATURAL JOIN ���̺��3 [��Ī3] ON(�������� [AND �Ϲ�����])
                            :
  [WHERE �Ϲ�����]
            :
            
-- ���̺��� 3�� �̻� ���� ���  -- ��� ���̺� �� ������ WHERE���� �Է��ϰ� ���̺� 1�� 2, 3���� ����� ������ ON���� �Է��Ѵ�.   
  . ���̺��1�� ���̺��2�� �ݵ�� ���� JOIN �����ؾ� ��
  . ���̺��3�� ���̺��1�� ���̺��2�� ���� ����� ���� ����
  . 'CROSS JOIN'�� �Ϲ������� Cartessian Product�� ����
  . 'NATURAL JOIN'�� ���ο��꿡 ���� ���̺� ���� �÷����� �����ϸ� 
    �ڵ����� ���� �߻�
    
 3. Cartessian Product Join(Cross Join)
  . ���������� ������� �ʾҰų� �߸� ����� ��� �߻�
  . n�� m���� ���̺�� a�� b���� ���̺��� Cross Join�� ��� �־��� ���(���� ������ ������ ���) 
    ����� n*a �� m+b ���� ��ȯ��
  . �ݵ�� �ʿ��� ��찡 �ƴϸ� ����� �����ؾ� ��
  
 ��뿹)
  SELECT COUNT(*) AS "PROD ���̺� ���Ǽ�" FROM PROD; 
  SELECT COUNT(*) AS "CART ���̺� ���Ǽ�" FROM CART;
  SELECT COUNT(*) AS "BUYPROD ���̺� ���Ǽ�" FROM BUYPROD;
 
  SELECT COUNT(*) FROM PROD, CART, BUYPROD;
  
  SELECT COUNT(*)
    FROM PROD
   CROSS JOIN CART
   CROSS JOIN BUYPROD;
 
 4. Equi Join(ANSI�� INNER JOIN)
  - �������ǿ� '=' ������ ���
  
  (�Ϲ����� �������)
  SELECT �÷�list
    FROM ���̺��1 [��Ī1], ���̺��2 [��Ī2] [,���̺��3 [��Ī3],...]
   WHERE [��Ī1.]�÷���1=[��Ī2.]�÷���2 -- ��������
    [AND [��Ī1.]�÷���1=[��Ī3.]�÷���3]-- ��������
                    :
    [AND �Ϲ�����]
    
  (ANSI���� �������)
   SELECT �÷�list
     FROM ���̺��1 [��Ī1]
    INNER JOIN ���̺��2 [��Ī2] ON([��Ī1.]�÷���1=[��Ī2.]�÷���2 [AND �Ϲ�����1])
    --���� ������(���̺�1�� 2�� ���� ����)�� ���̺�3�� ����Ǵ� �����̴�.
   [INNER JOIN ���̺��3 [��Ī3] ON([��Ī1.]�÷���1=[��Ī2.]�÷���2 [AND �Ϲ�����2])
                        :
   [WHERE �Ϲ�����]  -- ���� ���̺��� �������� ������ ������ִ� ��
   
 ��뿹) �������̺��� 2020�� 6�� ���Ի�ǰ������ ��ȸ�Ͻÿ�
         Alias�� ����, ��ǰ��ȣ, ��ǰ��, ����, �ݾ�
--(�Ϲ�����)--        
  SELECT A.BUY_DATE AS ����, 
         A.BUY_PROD AS ��ǰ��ȣ, 
         B.PROD_NAME AS ��ǰ��, 
         A.BUY_QTY AS ����, 
         A.BUY_QTY*B.PROD_COST AS �ݾ�       
    FROM BUYPROD A, PROD B     
   WHERE A.BUY_PROD=B.PROD_ID -- ��������
     AND A.BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630')--�Ϲ�����
   ORDER BY 1;     
--(ANSI����)--        
  SELECT A.BUY_DATE AS ����, 
         A.BUY_PROD AS ��ǰ��ȣ, 
         B.PROD_NAME AS ��ǰ��, 
         A.BUY_QTY AS ����, 
         A.BUY_QTY*B.PROD_COST AS �ݾ�
    FROM BUYPROD A
-- INNER JOIN PROD B ON(A.BUY_PROD=B.PROD_ID 
--   AND (A.BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630'))) 
   INNER JOIN PROD B ON(A.BUY_PROD=B.PROD_ID) 
   WHERE A.BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630') --3�����ʹ� �޶����ϱ� �����ؾ��Կ�
   ORDER BY 1;       
         
 ��뿹) ��ǰ���̺��� 'P10202' �ŷ�ó���� ��ǰ�ϴ� ��ǰ������ ��ȸ�Ͻÿ�
         Alias�� ��ǰ�ڵ�, ��ǰ��, �ŷ�ó��, ���Դܰ�
--(�Ϲ�����)--            
  SELECT A.PROD_ID AS ��ǰ�ڵ�, 
         A.PROD_NAME AS ��ǰ��, 
         B.BUYER_NAME AS �ŷ�ó��, 
         A.PROD_COST AS ���Դܰ�       
    FROM PROD A, BUYER B   
   WHERE A.PROD_BUYER =B.BUYER_ID
     AND SUBSTR(B.BUYER_ID,1,6) = 'P10202'; 
--(ANSI����)--     
  SELECT A.PROD_ID AS ��ǰ�ڵ�, 
         A.PROD_NAME AS ��ǰ��, 
         B.BUYER_NAME AS �ŷ�ó��, 
         A.PROD_COST AS ���Դܰ�
    FROM PROD A
   INNER JOIN BUYER B ON(A.PROD_BUYER=B.BUYER_ID)
   WHERE A.PROD_BUYER = 'P10202'
         
 ��뿹) ��ǰ���̺��� ���� ������ ��ȸ�Ͻÿ�
         Alias�� ��ǰ�ڵ�, ��ǰ��, �з���, �ǸŴܰ�
--(�Ϲ�����)--           
  SELECT A.PROD_ID AS ��ǰ�ڵ�, 
         A.PROD_NAME AS ��ǰ��, 
         B.LPROD_NM AS �з���, 
         A.PROD_PRICE �ǸŴܰ�      
    FROM PROD A, LPROD B
   WHERE B.LPROD_GU=A.PROD_LGU
   ORDER BY 1;
--(ANSI����)--
  SELECT A.PROD_ID AS ��ǰ�ڵ�, 
         A.PROD_NAME AS ��ǰ��, 
         B.LPROD_NM AS �з���, 
         A.PROD_PRICE �ǸŴܰ�   
    FROM LPROD B 
   INNER JOIN PROD A ON(B.LPROD_GU=A.PROD_LGU)
      
  
  
--��뿹-- 
 ������̺��� �����ȣ, �����, �μ���, �Ի����� ����Ͻÿ�         
  (�Ϲ�����)  
  SELECT A.EMPLOYEE_ID AS �����ȣ, 
         A.EMP_NAME AS �����, 
         B.DEPARTMENT_NAME AS �μ���, 
         A.HIRE_DATE AS �Ի���         
    FROM HR.Employees A, HR.Departments B
   WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID 
  (ANSI����) 
  SELECT EMPLOYEE_ID AS �����ȣ, 
         EMP_NAME AS �����, 
         DEPARTMENT_NAME AS �μ���, 
         HIRE_DATE AS �Ի���         
    FROM HR.Employees A      
   INNER JOIN HR.Departments B ON(A.DEPARTMENT_ID = B.DEPARTMENT_ID)      
         
--��뿹-- 
 2020�� 4�� ȸ����, ��ǰ�� �Ǹ����踦 ��ȸ�Ͻÿ�        
 Alias�� ȸ����ȣ, ȸ����, ��ǰ��, ���ż����հ�, ���űݾ��հ�   
  (�Ϲ�����) 
  SELECT A.CART_MEMBER AS ȸ����ȣ, 
         B.MEM_NAME AS ȸ����, 
         C.PROD_NAME AS ��ǰ��, 
         SUM(A.CART_QTY) AS ���ż����հ�, 
         SUM(A.CART_QTY*C.PROD_PRICE) AS ���űݾ��հ�         
    FROM CART A, MEMBER B, PROD C
   WHERE A.CART_MEMBER = B.MEM_ID --��������(ȸ����)
     AND A.CART_PROD = C.PROD_ID  --��������(��ǰ��, ��ǰ�ܰ�)
     AND SUBSTR(A.CART_NO,1,6) = '202004'
   GROUP BY A.CART_MEMBER, B.MEM_NAME, C.PROD_NAME
   ORDER BY 1;
  (ANSI����)  
  SELECT A.CART_MEMBER AS ȸ����ȣ, 
         B.MEM_NAME AS ȸ����, 
         C.PROD_NAME AS ��ǰ��, 
         SUM(A.CART_QTY) AS ���ż����հ�, 
         SUM(A.CART_QTY*C.PROD_PRICE) AS ���űݾ��հ�         
    FROM CART A  
   INNER JOIN  MEMBER B ON(A.CART_MEMBER = B.MEM_ID)
   INNER JOIN  PROD C ON(A.CART_PROD = C.PROD_ID
     AND SUBSTR(A.CART_NO,1,6) = '202004')     --�������ο����� WHERE ���� �ᵵ ū ������ �߻����� ������
                                               --�ܺ������� ���� ������ ����         
   GROUP BY A.CART_MEMBER, B.MEM_NAME, C.PROD_NAME
   ORDER BY 1;      
         
--(��뿹)--
 2020�� 5�� �ŷ�ó�� �������踦 ��ȸ�Ͻÿ�
 Alias�� �ŷ�ó�ڵ�, �ŷ�ó��, ����ݾ��հ�
  (ANSI����)    
  SELECT B.BUYER_ID AS �ŷ�ó�ڵ�, 
         B.BUYER_NAME AS �ŷ�ó��, 
         SUM(C.CART_QTY*A.PROD_PRICE) AS ����ݾ��հ�
    FROM PROD A
   INNER JOIN BUYER B ON(A.PROD_BUYER = B.BUYER_ID)
   INNER JOIN CART C ON(A.PROD_ID = C.CART_PROD
     AND SUBSTR(C.CART_NO,1,6) = '202005')
   GROUP BY B.BUYER_ID, B.BUYER_NAME
   ORDER BY 1; 
  (�Ϲ�����)
  SELECT B.BUYER_ID AS �ŷ�ó�ڵ�, 
         B.BUYER_NAME AS �ŷ�ó��, 
         SUM(C.CART_QTY*A.PROD_PRICE) AS ����ݾ��հ�
    FROM PROD A, BUYER B, CART C
--   WHERE A.PROD_LGU = B.BUYER_LGU
    WHERE A.PROD_BUYER = B.BUYER_ID
     AND A.PROD_ID = C.CART_PROD
     AND SUBSTR(C.CART_NO,1,6) = '202005'
   GROUP BY B.BUYER_ID, B.BUYER_NAME
   ORDER BY 1;
   
--��뿹-- 
 HR�������� �̱� �̿��� ������ ��ġ�� �μ������� ��ȸ�Ͻÿ�
 Alias�� �μ���ȣ, �μ���, �ּ�, ����
  (ANSI����)
  SELECT B.DEPARTMENT_ID AS �μ���ȣ, 
         B.DEPARTMENT_NAME AS �μ���, 
         A.COUNTRY_ID||' '||A.CITY||' '||A.STREET_ADDRESS AS �ּ�, 
         C.COUNTRY_NAME AS ����      
    FROM HR.Locations A 
   INNER JOIN HR.Countries C ON(A.COUNTRY_ID = C.COUNTRY_ID)
   INNER JOIN HR.Departments B ON(A.LOCATION_ID = B.LOCATION_ID)
   WHERE C.COUNTRY_ID != 'US'
   
  (�Ϲ�����)
  SELECT B.DEPARTMENT_ID AS �μ���ȣ, 
         B.DEPARTMENT_NAME AS �μ���, 
         A.COUNTRY_ID||' '||A.CITY||' '||A.STREET_ADDRESS AS �ּ�, 
         C.COUNTRY_NAME AS ����      
    FROM HR.Locations A, HR.Departments B, HR.Countries C
   WHERE A.LOCATION_ID = B.LOCATION_ID
     AND A.COUNTRY_ID = C.COUNTRY_ID
     AND C.COUNTRY_ID != 'US'
         
         
         