2022-0902-01) 
 4) MINUS 
  - 차집합의 결과를 반환
  - A MINUS B : A의 결과에서 B의 결과를 제거한 값 반환
    B MINUS A : B의 결과에서 A의 결과를 제거한 값 반환

--사용예--
  2020년 매출테이블(CART)에서 5월과 6월 매출 중 5월에만 판매된 상품을 조회하시오.
  SELECT DISTINCT A.CART_PROD AS CID, 
         B.PROD_NAME AS CNAME
    FROM CART A, PROD B
   WHERE A.CART_PROD = B.PROD_ID 
     AND SUBSTR(A.CART_NO,1,6) = '202005'
  MINUS  
  SELECT DISTINCT A.CART_PROD, 
         B.PROD_NAME
    FROM CART A, PROD B
   WHERE A.CART_PROD = B.PROD_ID 
     AND SUBSTR(A.CART_NO,1,6) = '202006'  
     
  (WITH절 사용)
 WITH T1 AS(  
  SELECT DISTINCT CART_PROD AS CID
    FROM CART 
   WHERE SUBSTR(CART_NO,1,6) = '202005'
  MINUS  
  SELECT DISTINCT CART_PROD
    FROM CART 
   WHERE SUBSTR(CART_NO,1,6) = '202006'
 ) 
 SELECT A.CID AS 상품코드,
        B.PROD_NAME AS 상품명
   FROM T1 A, PROD B  
  WHERE A.CID=B.PROD_ID;   
     
     
     
     
     
     
     