2022-0831-01)��������
 - SQL���� �ȿ� �� �ٸ� SQL ������ �����ϴ� ���� �ǹ�
 - �˷����� ���� ���ǿ� �ٰ��Ͽ� ������ �˻��� �� ����
 - SELECT, DML, CREATE TABLE, VIEW �� ���
 - ���������� '( )'�ȿ� ���(��, INSERT INTO�� ���Ǵ� ���������� ����)
 - �з�
  . �Ϲݼ�������(SELECT���� ������ ��������), IN LINE ��������(FROM���� ������ ��������)<=�ݵ�� ���� �����ؾ� ��, 
    ��ø��������(WHERE���� ������ ��������)<= ������ ���迬���� �����ʿ� ����Ѵ�.
  . ������ �ִ� ��������(������������ ����� ���̺�� ������������ ����� ���̺��� �������� ����Ǿ��� ��), 
    ������ ���� ��������(������������ ����� ���̺�� ������������ ����� ���̺��� �������� ������� �ʾ��� ��)
  . ������(������)/���Ͽ�(���߿�) ��������
  . ����� �ϳ��� ���;� �ϴ� �������� : ������ �������� <=>������ ��������
   --���� ����� ����ϰ� ��ȸ�ϴ� ���� ����������. ��ȸ�ϱ� �ʿ��� �ڷḦ �����ϴ� ���� ���������̴�.
  ex)��� �޿����� ���� �޿��� �̾ƶ�.

 1) ������ ���� ��������
  - ���������� ���� ���̺�� ���������� ���� ���̺� ���̿� ������ ������� �ʴ� ��������
--��뿹-- 
  ������̺��� ������� ��� �޿����� ���� �޿��� �޴� ����� ��ȸ�Ͻÿ�.
  Alias�� �����ȣ, �����, ��å�ڵ�, �޿�
  (�������� : ������̺��� ������� �����ȣ, �����, ��å�ڵ�, �޿���ȸ)
  SELECT �����ȣ, �����, ��å�ڵ�, �޿�
    FROM HR.Employees
   WHERE SALARY>(��ձ޿�) 
  (�������� : ��ձ޿�)
  SELECT AVG(SALARY)
    FROM HR.Employees
  (����)
  SELECT EMPLOYEE_ID �����ȣ,
         EMP_NAME �����,
         JOB_ID ��å�ڵ�,
         SALARY �޿�
    FROM HR.Employees
   WHERE SALARY>(SELECT AVG(SALARY)
                   FROM HR.Employees)     
   ORDER BY 4 DESC;            
  (IN-LINE) <= �������� ����Ƚ�� 1ȸ
  SELECT A.EMPLOYEE_ID �����ȣ,
         A.EMP_NAME �����,
         A.JOB_ID ��å�ڵ�,
         A.SALARY �޿�
    FROM HR.Employees A, (SELECT AVG(SALARY) AS SAL
                            FROM HR.Employees) B  --B�� �̸��� �ٿ��� VIEW
   WHERE A.SALARY>B.SAL
   ORDER BY 4 DESC;
   
--��뿹--
  2017�� ���Ŀ� �Ի��� ����� �����ϴ� �μ��� ��ȸ�Ͻÿ�
  Alias�� �μ���ȣ, �μ���, ���������ȣ
  (��������: �μ��� �μ���ȣ, �μ���, ���������ȣ)
  SELECT A.DEPARTMENT_ID AS �μ���ȣ, 
         B.DEPARTMENT_NAME AS �μ���, 
         A.MANAGER_ID AS ���������ȣ
    FROM HR.Employees A, HR.Departments B
   WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
     AND B.DEPARTMENT_ID IN(��������)
     
  (��������: 2017�� ���Ŀ� �Ի��� ����� �����ϴ� �μ�)  
  SELECT DEPARTMENT_ID
    FROM HR.Employees
   WHERE HIRE_DATE>TO_DATE('20161231') 
  
  (����)
  SELECT DISTINCT A.DEPARTMENT_ID AS �μ���ȣ, 
         B.DEPARTMENT_NAME AS �μ��� 
    FROM HR.Employees A, HR.Departments B
   WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
     AND A.DEPARTMENT_ID IN(SELECT DEPARTMENT_ID
                              FROM HR.Employees
                             WHERE HIRE_DATE>TO_DATE('20161231')) 
   ORDER BY 1;
   
    SELECT DISTINCT A.DEPARTMENT_ID AS �μ���ȣ, 
         B.DEPARTMENT_NAME AS �μ��� 
    FROM HR.Employees A, HR.Departments B
   WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
     AND EXISTS (SELECT 1
                   FROM HR.Employees C
                  WHERE HIRE_DATE>TO_DATE('20161231')
                    AND C.EMPLOYEE_ID=A.EMPLOYEE_ID) 
   ORDER BY 1;
   
--��뿹--
  ��ǰ���̺��� ��ǰ�� ����ǸŰ����� �ǸŰ��� �� ���� ��ǰ�� 
  ��ǰ��ȣ, ��ǰ��, �з���, �ǸŰ��� ��ȸ�Ͻÿ�
  SELECT A.PROD_ID ��ǰ��ȣ, 
         A.PROD_NAME ��ǰ��, 
         B.LPROD_GU �з���, 
         A.PROD_PRICE �ǸŰ�
    FROM PROD A, LPROD B
   WHERE A.PROD_LGU=B.LPROD_GU
     AND A.PROD_PRICE IN(SELECT PROD_PRICE
                           FROM PROD
                          WHERE PROD_PRICE>AVG(PROD_PRICE))
                          
                        
      SELECT A.PROD_ID ��ǰ��ȣ, 
             A.PROD_NAME ��ǰ��, 
             B.LPROD_GU �з���, 
             A.PROD_PRICE �ǸŰ�
        FROM PROD A, LPROD B, (SELECT AVG(PROD_PRICE) AS PAVG
                                 FROM PROD) PG
       WHERE A.PROD_LGU=B.LPROD_GU
         AND A.PROD_PRICE>PG.PAVG                     
   
--��뿹--
  ȸ�����̺��� 2000�� ���� ����� � ȸ���� ���ϸ������� �� ����
  ���ϸ����� ������ ȸ���� ȸ����ȣ, ȸ����, �ֹι�ȣ, ���ϸ����� ��ȸ
  
  SELECT A.MEM_ID AS ȸ����ȣ, 
         A.MEM_NAME AS ȸ����, 
         A.MEM_REGNO1||MEM_REGNO2 AS �ֹι�ȣ, 
         A.MEM_MILEAGE AS ���ϸ���
    FROM MEMBER A, (SELECT MAX(MEM_MILEAGE) AS AA
                      FROM MEMBER
                     WHERE MEM_BIR <TO_DATE('20000101')) BB
   WHERE A.MEM_MILEAGE >ALL(BB.AA)
 ---------------------------------------------------------------- 
  SELECT A.MEM_ID AS ȸ����ȣ, 
         A.MEM_NAME AS ȸ����, 
         A.MEM_REGNO1||MEM_REGNO2 AS �ֹι�ȣ, 
         A.MEM_MILEAGE AS ���ϸ���
    FROM MEMBER A 
   WHERE A.MEM_MILEAGE >ALL(SELECT MEM_MILEAGE 
                              FROM MEMBER
                             WHERE MEM_BIR <TO_DATE('20000101'))
  
  
  
--��뿹--
  ��ٱ������̺��� 2020�� 5�� ȸ���� �ְ� ���űݾ��� ����� ȸ���� ��ȸ�Ͻÿ�.
  Alias�� ȸ����ȣ, ȸ����, ���űݾ��հ� 
  (��������: 2020�� 5�� ȸ���� ���űݾ� �հ踦 ������������ ����)
   SELECT A.CART_MEMBER AS CID, --ȸ����ȣ
          SUM(A.CART_QTY * B.PROD_PRICE) AS CSUM --���űݾ��հ�
     FROM CART A, PROD B
    WHERE A.CART_PROD=B.PROD_ID
      AND A.CART_NO LIKE '202005%'
    GROUP BY A.CART_MEMBER
    ORDER BY 2 DESC;
  (��������: ���������� ��� �� ���� �� �ٿ� �ش��ϴ� �ڷ� ���)
   SELECT TA.CID AS ȸ����ȣ, 
          M.MEM_NAME AS ȸ����, 
          TA.CSUM AS ���űݾ��հ�
     FROM MEMBER M,(SELECT A.CART_MEMBER AS CID, --ȸ����ȣ
                           SUM(A.CART_QTY * B.PROD_PRICE) AS CSUM --���űݾ��հ�
                      FROM CART A, PROD B
                     WHERE A.CART_PROD=B.PROD_ID
                       AND A.CART_NO LIKE '202005%'
                     GROUP BY A.CART_MEMBER
                     ORDER BY 2 DESC)TA 
     WHERE M.MEM_ID= TA.CID
       AND ROWNUM=1
  
  (WITH �� ���)
  WITH A1 AS (SELECT A.CART_MEMBER AS CID, --ȸ����ȣ
                     SUM(A.CART_QTY * B.PROD_PRICE) AS CSUM --���űݾ��հ�
                FROM CART A, PROD B
               WHERE A.CART_PROD=B.PROD_ID
                 AND A.CART_NO LIKE '202005%'
               GROUP BY A.CART_MEMBER
               ORDER BY 2 DESC)
  SELECT B.MEM_ID,B.MEM_NAME,A1.CSUM
    FROM MEMBER B, A1
   WHERE B.MEM_ID=A1.CID 
     AND ROWNUM=1
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  