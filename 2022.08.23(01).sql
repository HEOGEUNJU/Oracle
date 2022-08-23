
-P282
�����Լ�

  SELECT PROD_LGU
       , PROD_COST 
  FROM   PROD
  ORDER BY 1;
  
--DISTINCT : �ߺ�����
  SELECT AVG(DISTINCT PROD_COST) --> AS "�ߺ��� ���� ����",
       , AVG(All PROD_COST) --> AS "DEFALT�ν� ��� ���� ����",
       , AVG(PROD_COST) --> AS "���԰� ���" , 3��°�� ���� �߿��ϴϱ� �� �ܿ��
    FROM PROD;
    
-- �׷캰 ��� ���ϴ� ��   
-- BY : ~�� , GROUP : ����, ASCENDING : ��������(��������) / DESCENDING : ��������
  SELECT PROD_LGU
       , ROUND(AVG(PROD_COST),2) PROD_COST
  FROM   PROD
  GROUP BY PROD_LGU
  ORDER BY PROD_LGU; 
  
--��ǰ�з� �� ���Ű��� ���
SELECT PROD_LGU ��ǰ�з�
     , ROUND(AVG(PROD_SALE),2) ���Ű������
  FROM PROD   
 GROUP BY PROD_LGU 
 ORDER BY PROD_LGU;
 
SELECT PROD_LGU
     , PROD_BUYER
     , ROUND(AVG(PROD_COST),2) PROD_COST
     , SUM(PROD_COST)
     , MAX(PROD_COST)
     , MIN(PROD_COST)
     , COUNT(PROD_COST)
  FROM PROD
 GROUP BY PROD_LGU, PROD_BUYER
 ORDER BY 1,2;
 
--P.282
--��ǰ���̺�(PROD)��
--�� �ǸŰ���(PROD_SALE) 
--��� ���� ���Ͻÿ� ?
--(Alias�� ��ǰ���ǸŰ����)
--ALIAS ��� BYTES? 30BYTES
SELECT SUM(PROD_SALE) AS �ǸŰ���
     , ROUND(AVG(PROD_SALE),2) AS ���
  FROM PROD     
  
--P.282
--��ǰ���̺��� ��ǰ�з�(PROD_LGU)�� 
--�ǸŰ���(PROD_SALE) ��� ���� ���Ͻÿ� ?
--(Alias�� ��ǰ�з�(PROD_LGU), ��ǰ�з����ǸŰ������)  
SELECT PROD_LGU AS ��ǰ�з�
     , ROUND(AVG(PROD_SALE),2) AS �ǸŰ������
  FROM PROD
 GROUP BY PROD_LGU
 ORDER BY PROD_LGU;
 
 --P.283
--�ŷ�ó���̺�(BUYER)�� 
--�����(BUYER_CHARGER)�� �÷����� �Ͽ� 
--COUNT���� �Ͻÿ� ? 
--( Alias�� �ڷ��(DISTINCT), 
--  �ڷ��, �ڷ��(*) )
SELECT COUNT(DISTINCT(BUYER_CHARGER)) "�ڷ��(DISTINCT)"
     , COUNT(*) "�ڷ��(*)"
  FROM BUYER;
  
--P.283
--ȸ�����̺�(MEMBER)�� ���(MEM_LIKE)��
--COUNT���� �Ͻÿ�
--ȸ���� ��� �� �α����� ���غ���
--(Alias�� ���, �ڷ��, �ڷ��(*) )
 
 SELECT MEM_LIKE AS ���, 
 
        COUNT(MEM_ID) AS �ڷ��,       --�⺻Ű�� ���°� ���� ����. �⺻Ű�� NULL�� ���� �ߺ��� ���� ������
        COUNT(*) AS "�ڷ��(*)" 
   FROM MEMBER
  GROUP BY MEM_LIKE
  ORDER BY MEM_LIKE ; 
  
--P.284
--��ٱ������̺��� ȸ���� �ִ뱸�ż���
--�� �˻��Ͻÿ�?
--ALIAS : ȸ��ID, �ִ����, �ּҼ���  
 SELECT CART_MEMBER AS ȸ��ID,
        MAX(CART_QTY) AS �ִ����,
        MIN(CART_QTY) AS �ּҼ���        
   FROM CART
  GROUP BY CART_MEMBER
  ORDER BY CART_MEMBER;

--������ 2020�⵵7��11���̶� �����ϰ� 
--��ٱ������̺�(CART)�� �߻��� 
--�߰��ֹ���ȣ(CART_NO)�� �˻� �Ͻÿ� ? 
--( Alias�� �ְ�ġ�ֹ���ȣMAX(CART_NO), 
--�߰��ֹ���ȣMAX(CART_NO)+1 )
--LIKE�� �Բ� ���� %,_�� ���ϵ�ī����θ���
--% : ���� ���� / _ : �� ����
SELECT MAX(CART_NO)+1 �߰��ֹ���ȣ,
       MAX(CART_NO) �ְ�ġ�ֹ���ȣ 
  FROM CART
 WHERE SUBSTR(CART_NO,1,8) = '20200711'
   AND CART_NO LIKE '20200711%'; --> SUBSTR �Ǵ� CART_NO �� �� �ϳ� �ᵵ��
   
--P.285
--��ǰ���̺��� ��ǰ�з�, �ŷ�ó���� 
--�ְ��ǸŰ�, �ּ��ǸŰ�, �ڷ���� �˻��Ͻÿ�?

SELECT �ְ��ǸŰ�, 
       �ּ��ǸŰ�, 
       �ڷ��
  FROM PROD
 GROUB BY PROD_LGU,  









  
  
  
  