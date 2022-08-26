2022-0826-01)
4. NULLIF(c1, c2)
 - 'c1'과 'c2'를 비교하여 같은 값이면 NULL을 반환하고 다른 값이면 'c1'을 반환함
***상품테이블에서 분류코드가 'P301'인 상품의 판매가를 매입가와 같도록 변경하시오. 
 ROLLBACK;
  
 UPDATE PROD -- 해당테이블
    SET PROD_PRICE = PROD_COST  -- 변경(업데이트)시킬 컬럼명
  WHERE PROD_LGU = 'P301' -- 분류기준 
 
 사용예) 상품테이블에서 매입가격과 매출가격이 같은 제품을 찾아 보고란에 
         '판매중단예정상품'을 출력하고, 두 가격이 같지 않은 상품은 매출이익을
         비고란에 출력하시오.
         Alias는 상품번호, 상품명, 매입가, 매출가, 비고
  SELECT PROD_ID AS 상품번호, 
         PROD_NAME AS 상품명, 
         PROD_COST AS 매입가, 
         PROD_PRICE AS 매출가, 
         NVL2(TO_CHAR(NULLIF(PROD_PRICE, PROD_COST)),TO_CHAR((PROD_PRICE-PROD_COST),'9,999,999'),'판매중단상품') AS 비고       
    FROM PROD
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 