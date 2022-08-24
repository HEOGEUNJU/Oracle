2022-0824-01) �����Լ�
 ��뿹) ��ٱ������̺��� 2020�� 5�� ��ǰ�� �Ǹ����踦 ��ȸ�Ͻÿ�
         Alias�� ��ǰ�ڵ�, �ǸŰǼ�, �Ǹż���, �ݾ� 
  SELECT A.CART_PROD AS ��ǰ�ڵ�, 
         COUNT(*) AS �ǸŰǼ�, 
         SUM(A.CART_QTY) AS �Ǹż���, 
         SUM(A.CART_QTY*B.PROD_PRICE) AS �ݾ�
    FROM CART A, PROD B 
   WHERE CSUBSTR(ART_NO,1,6) LIKE'202005%'
     AND A.CART_PROD=B;
    GROUP BY A.CART_PROD;
    ORDER BY 1;
   
 ��뿹) ��ٱ������̺��� 2020�� 5�� ȸ���� �Ǹ����踦 ��ȸ�Ͻÿ�
         Alias�� ȸ����ȣ, ���ż���, ���űݾ�
  SELECT  A.CART_MEMBER AS ȸ����ȣ, 
          SUM(A.CART_QTY) AS ���ż���, 
          SUM(B.PROD_SALE*A.CART_QTY) AS ���űݾ�
    FROM  CART A, PROD B
   WHERE  A.CART_NO LIKE '202005%'
     AND  A.CART_PROD = B.PROD_ID
   GROUP BY A.CART_MEMBER
   ORDER BY A.CART_MEMBER; 
   
 ��뿹) ��ٱ������̺��� 2020�� ����, ȸ���� �Ǹ����踦 ��ȸ�Ͻÿ� --> ��׷� ����, �ұ׷� ȸ������ ������
         Alias�� ��, ȸ����ȣ, ���ż���, ���űݾ�         
  SELECT SUBSTR(A.CART_NO,5,2) AS ��, 
         A.CART_MEMBER AS ȸ����ȣ, 
         SUM(A.CART_QTY) AS ���ż���, 
         SUM(B.PROD_PRICE*A.CART_QTY) AS ���űݾ�
    FROM CART A, PROD B
   WHERE A.CART_NO LIKE '2020%'
     AND A.CART_PROD = B.PROD_ID 
   GROUP BY SUBSTR(A.CART_NO,5,2), A.CART_MEMBER
   ORDER BY 1;
   
    
 ��뿹) ��ٱ������̺��� 2020�� 5�� ��ǰ�� �Ǹ����踦 ��ȸ�ϵ� �Ǹűݾ��� 
         100���� �̻��� �ڷḸ ��ȸ�Ͻÿ�
         Alias�� ��ǰ�ڵ�, �Ǹż���, �ݾ�         
  SELECT A.CART_PROD AS ��ǰ�ڵ�, 
         SUM(A.CART_QTY)�Ǹż���, 
         SUM(A.CART_QTY*B.PROD_PRICE) AS �ݾ�       
    FROM CART A, PROD B        
   WHERE A.CART_NO LIKE '202005%'        
     AND A.CART_PROD = B.PROD_ID    
   GROUP BY A.CART_PROD
   HAVING SUM(A.CART_QTY*B.PROD_PRICE)>=1000000 -- �׷��Լ� ��ü�� ������ �־��� ��
   ORDER BY 1;
        
        
         
 ��뿹) 2020�� ��ݱ�(1-6��) ���Ծ� ���� ���� ���� ���Ե� ��ǰ 5���� ��ȸ�Ͻÿ�
         Alias�� ��ǰ�ڵ�, ���Լ���, ���Աݾ�
    1) 2020�� ��ݱ�(1-6��) ��ǰ�� ���Ծ��� ����ϰ� ���Ծ��� ���� ������ ���     
  SELECT BUY_PROD AS ��ǰ�ڵ�, 
         SUM(BUY_QTY) AS ���Լ����հ�,
         SUM(BUY_QTY*BUY_COST) AS ���Աݾ��հ�
    FROM BUYPROD 
   WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200630')
   GROUP BY BUY_PROD
   ORDER BY 3 DESC;
         
  -- ���â���� ������ ������ PSEUDO(�ǻ�,����) COLUMM�̶�� �ϸ� ���� �ϳ��ϳ��� ROWNUM�̶�� �Ѵ�.        
         
 ����) ������̺��� �μ��� ��ձ޿��� ��ȸ�Ͻÿ�
SELECT DEPARTMENT_ID AS �μ�,
       ROUND(AVG(SALARY)) AS ��ձ޿�
  FROM HR.Employees
 GROUP BY DEPARTMENT_ID
 ORDER BY 1; 
 
 ����) ������̺��� �μ��� �Ի����� ���� ���� �Ի��� ����� �����ȣ, �����, �μ���ȣ,
       �Ի����� ����Ͻÿ�
SELECT EMPLOYEE_ID AS �����ȣ, 
       EMP_NAME AS �����, 
       DEPARTMENT_ID AS �μ���ȣ, 
       TO_CHAR(HIRE_DATE,'YYYYMMDD') AS �Ի���
  FROM (SELECT DEPARTMENT_ID,
               MIN(HIRE_DATE) AS HDATE
          FROM HR.Employees
         GROUP BY DEPARTMENT_ID) A, 
        HR.Employees B
 WHERE F       
 GROUP BY DEPARTMENT_ID;
------------------------------------------------
SELECT EMPLOYEE_ID AS ��DNJS��ȣ,
       EMP_NAME AS �����,
       DEPARTMENT_ID AS �μ���ȣ,
       MIN(HIRE_DATE) AS �Ի���
  FROM HR.EMPLOYEES
 GROUP BY EMPLOYEE_ID, EMP_NAME, DEPARTMENT_ID 


 ����) ������� ��ձ޿����� �� ���� �޴� ����� �����ȣ, �����, �μ���ȣ, �޿��� ����Ͻÿ�
           
  
-----------------------------------------------
SELECT ROUND(AVG(SALARY),2)  AS ��ձ޿�
  FROM HR.Employees
 
 
 ����) ȸ�����̺��� ����ȸ���� ���ϸ��� �հ�� ��� ���ϸ����� ��ȸ�Ͻÿ�.
       Alias�� ����, ���ϸ����հ�, ��ո��ϸ���
SELECT CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN ('1','3') THEN 
       '����ȸ��'
       ELSE '����ȸ��'
       END AS ����,
       ROUND(AVG(MEM_MILEAGE),2) AS ���ϸ������,
       SUM(MEM_MILEAGE) AS ���ϸ����հ�,
       COUNT(*) AS ȸ����
  FROM MEMBER
 GROUP BY CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN ('1','3') THEN 
       '����ȸ��'
       ELSE '����ȸ��'
       END;        
         
         
         