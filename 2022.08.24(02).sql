2022-0824-02) ROLLUP과 CUBE
 - 다양한 집계결과를 얻기 위해 사용
 - 반드시 GROUP BY절에 사용되어야 함
 1) ROLLUP
  . LEVEL별 집계 결과를 반환
  (사용형식)
  GROUP BY [컬럼,]ROLLUP(컬럼명1 [,컬럼명2,...,컬럼명n])[,컬럼]
   - 컬럼명1부터 컬럼명n을 기준컬럼으로 집계 출력 후 오른쪽부터 컬럼을 하나씩
     제거한 기준으로 집계를 반환
   - 제일 마지막은 전체집계(모든 컬럼명을 제거한 집계결과)반환  
   - ROLLUP 앞 또는 뒤에 컬럼이 올 수 있음 => 부분ROLLUP이라함
  
  사용예) 2020년 4-7월 월별, 회원별, 상품별 구매수량 합계를 조회하시오.
--(ROLLUP 사용 전)--
  SELECT SUBSTR(CART_NO,5,2) AS 월,
         CART_MEMBER AS 회원번호,
         CART_PROD AS 상품코드,
         SUM(CART_QTY) AS 구매수량합계
    FROM CART
   WHERE SUBSTR(CART_NO,1,6) BETWEEN '202004' AND '202007'
   GROUP BY SUBSTR(CART_NO,5,2), CART_MEMBER, CART_PROD
   ORDER BY SUBSTR(CART_NO,5,2);
  
--(ROLLUP 사용 후)--ROLLUP 다음에 기술된 컬럼이 갯수가 n개이면 집계되는 컬럼의 종류는 n+1이다.
   SELECT SUBSTR(CART_NO,5,2) AS 월,
         CART_MEMBER AS 회원번호,
         CART_PROD AS 상품코드,
         SUM(CART_QTY) AS 구매수량합계
    FROM CART
   WHERE SUBSTR(CART_NO,1,6) BETWEEN '202004' AND '202007'
   GROUP BY ROLLUP(SUBSTR(CART_NO,5,2), CART_MEMBER, CART_PROD)
   ORDER BY SUBSTR(CART_NO,5,2);
   
  사용예) 상품테이블에서 상품의 분류별, 거래처별 상품의 수(COUNT)를 조회하시오.  <== ~별 하면 그게 일반컬럼, 구해야하는게 집계함수 
  --(ROLLUP을 사용하지 않고 GROUP BY절만 사용)--
  SELECT PROD_LGU AS "상품의 분류", 
         PROD_BUYER AS "거래처 코드", 
         COUNT(*) AS "상품의 수"     
    FROM PROD
   GROUP BY PROD_LGU, PROD_BUYER 
   ORDER BY PROD_LGU
  --(ROLLUP을 사용)-- 
  SELECT PROD_LGU AS "상품의 분류", 
         PROD_BUYER AS "거래처 코드", 
         COUNT(*) AS "상품의 수"     
    FROM PROD
   GROUP BY ROLLUP(PROD_LGU, PROD_BUYER) 
   ORDER BY PROD_LGU  
  --(부분 ROLLUP을 사용)-- 전체집계 빼고 다 나옴
  SELECT PROD_LGU AS "상품의 분류", 
         PROD_BUYER AS "거래처 코드", 
         COUNT(*) AS "상품의 수"     
    FROM PROD
   GROUP BY PROD_LGU, ROLLUP(PROD_BUYER)
   ORDER BY PROD_LGU   
   
 2) CUBE
  . GROUP BY절 안에 사용되어 CUBE 내부에 기술된 컬럼의 조합 가능한 모든 집계를 반환
  . CUBE 내부에 기술된 컬럼의 개수가 n개일 때 2의 n승 가지만큼의 집계 종류를 반환

  사용예) 2020년 4-7월 월별, 회원별, 상품별 구매수량 합계를 조회하시오.  
  --(CUBE 사용)--
  SELECT SUBSTR(CART_NO,5,2) AS 월,
         CART_MEMBER AS 회원번호,
         CART_PROD AS 상품코드,
         SUM(CART_QTY) AS 구매수량합계
    FROM CART
   WHERE SUBSTR(CART_NO,1,6) BETWEEN '202004' AND '202007'
   GROUP BY CUBE(SUBSTR(CART_NO,5,2), CART_MEMBER, CART_PROD)
   ORDER BY SUBSTR(CART_NO,5,2);
   
  --(부분CUBE 사용)--    
  SELECT SUBSTR(CART_NO,5,2) AS 월,
         CART_MEMBER AS 회원번호,
         CART_PROD AS 상품코드,
         SUM(CART_QTY) AS 구매수량합계
    FROM CART
   WHERE SUBSTR(CART_NO,1,6) BETWEEN '202004' AND '202007'
   GROUP BY SUBSTR(CART_NO,5,2), CUBE(CART_MEMBER, CART_PROD)
   ORDER BY SUBSTR(CART_NO,5,2);
  
  
  
  
  
  