
-P282
집계함수

  SELECT PROD_LGU
       , PROD_COST 
  FROM   PROD
  ORDER BY 1;
  
--DISTINCT : 중복제거
  SELECT AVG(DISTINCT PROD_COST) --> AS "중복된 값은 제외",
       , AVG(All PROD_COST) --> AS "DEFALT로써 모든 값을 포함",
       , AVG(PROD_COST) --> AS "매입가 평균" , 3번째가 제일 중요하니까 꼭 외우기
    FROM PROD;
    
-- 그룹별 평균 구하는 법   
-- BY : ~별 , GROUP : 묶음, ASCENDING : 오름차순(생략가능) / DESCENDING : 내림차순
  SELECT PROD_LGU
       , ROUND(AVG(PROD_COST),2) PROD_COST
  FROM   PROD
  GROUP BY PROD_LGU
  ORDER BY PROD_LGU; 
  
--상품분류 별 구매가격 평균
SELECT PROD_LGU 상품분류
     , ROUND(AVG(PROD_SALE),2) 구매가격평균
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
--상품테이블(PROD)의
--총 판매가격(PROD_SALE) 
--평균 값을 구하시오 ?
--(Alias는 상품총판매가평균)
--ALIAS 허용 BYTES? 30BYTES
SELECT SUM(PROD_SALE) AS 판매가격
     , ROUND(AVG(PROD_SALE),2) AS 평균
  FROM PROD     
  
--P.282
--상품테이블의 상품분류(PROD_LGU)별 
--판매가격(PROD_SALE) 평균 값을 구하시오 ?
--(Alias는 상품분류(PROD_LGU), 상품분류별판매가격평균)  
SELECT PROD_LGU AS 상품분류
     , ROUND(AVG(PROD_SALE),2) AS 판매가격평균
  FROM PROD
 GROUP BY PROD_LGU
 ORDER BY PROD_LGU;
 
 --P.283
--거래처테이블(BUYER)의 
--담당자(BUYER_CHARGER)를 컬럼으로 하여 
--COUNT집계 하시오 ? 
--( Alias는 자료수(DISTINCT), 
--  자료수, 자료수(*) )
SELECT COUNT(DISTINCT(BUYER_CHARGER)) "자료수(DISTINCT)"
     , COUNT(*) "자료수(*)"
  FROM BUYER;
  
--P.283
--회원테이블(MEMBER)의 취미(MEM_LIKE)별
--COUNT집계 하시오
--회원의 취미 별 인구수를 구해보자
--(Alias는 취미, 자료수, 자료수(*) )
 
 SELECT MEM_LIKE AS 취미, 
 
        COUNT(MEM_ID) AS 자료수,       --기본키로 세는게 가장 좋다. 기본키는 NULL이 없고 중복이 없기 때문에
        COUNT(*) AS "자료수(*)" 
   FROM MEMBER
  GROUP BY MEM_LIKE
  ORDER BY MEM_LIKE ; 
  
--P.284
--장바구니테이블의 회원별 최대구매수량
--을 검색하시오?
--ALIAS : 회원ID, 최대수량, 최소수량  
 SELECT CART_MEMBER AS 회원ID,
        MAX(CART_QTY) AS 최대수량,
        MIN(CART_QTY) AS 최소수량        
   FROM CART
  GROUP BY CART_MEMBER
  ORDER BY CART_MEMBER;

--오늘이 2020년도7월11일이라 가정하고 
--장바구니테이블(CART)에 발생될 
--추가주문번호(CART_NO)를 검색 하시오 ? 
--( Alias는 최고치주문번호MAX(CART_NO), 
--추가주문번호MAX(CART_NO)+1 )
--LIKE와 함께 쓰인 %,_를 와일드카드라고부른다
--% : 여러 글자 / _ : 한 글자
SELECT MAX(CART_NO)+1 추가주문번호,
       MAX(CART_NO) 최고치주문번호 
  FROM CART
 WHERE SUBSTR(CART_NO,1,8) = '20200711'
   AND CART_NO LIKE '20200711%'; --> SUBSTR 또는 CART_NO 둘 중 하나 써도됨
   
--P.285
--상품테이블에서 상품분류, 거래처별로 
--최고판매가, 최소판매가, 자료수를 검색하시오?

SELECT 최고판매가, 
       최소판매가, 
       자료수
  FROM PROD
 GROUB BY PROD_LGU,  









  
  
  
  