2022-0830-02)외부조인(OUTER JOIN)
 - 내부조인은 조인조건을 만족하는 결과만 반환하지만, 외부조인은 자료가 부족한
   테이블에 NULL행을 추가하여 조인을 수행
 - 조인조건 기술 시 자료가 부족한 테이블의 컬럼 뒤에 외부조인 연산자 '(+)'를 
   추가 기술함
 - 외부조인 조건이 복수 개일 때 모든 외부조인 조건에 모두 '(+)' 연산자를 기술
   해야함
--  한번에 한 테이블에만 외부조인을 할 수 있음.
--  즉, A,B,C 테이블을 외부조인 할 경우 A를 기준으로 B와 외부조인하고 동시에 C를
--  기준으로 B를 외부조인할 수 없다(A=B(+) AND C=B(+)는 허용되지 않음)
 - 일반 외부조인에서 일반조건이 부여되면 정확한 결과가 반환되지 않은=> 서부쿼리를
   사용한 외부조인 또는 ANSI외부 조인으로 해결해야함
 - IN연산자 또는 OR연산자는 외부조인 연산자('(+)')는 같이 사용할 수 없다
  (일반 외부조인 형식)
  SELECT 컬럼list
    FROM 테이블명1 [별칭1], 테이블명2 [별칭2],...
   WHERE 별칭1.컬럼명(+)=별칭2.컬럼명2 =>테이블명1이 자료가 부족한 테이블인 경우
   
  (ANSI 외부조인 사용형식)--안시 외부조인 사용 지향 하지만 외부조인 사용 지양 
  SELECT 컬럼list
    FROM 테이블명1 [별칭1]
  RIGHT|LEFT|FULL OUTER JOIN 테이블명2 [별칭2] ON(조인조건1 [AND 일반조건1])
             :
  [WHERE 일반조건]
  
  - 'RIGHT|LEFT|FULL' : FROM절에 기술된 테이블(테이블1)의 자료가 
    OUTER JOIN 테이블명2 보다 많으면 'LEFT', 적으면 'RIGHT',
    양쪽 모두 적으면 'FULL'사용 
  
** 1) SELECT에 사용하는 컬럼 중 양쪽 테이블에 모두 존재하는 컬럼은 많은 쪽 테이블 것을
     사용해야함
   2) 외부조인의 SELECT절에 COUNT함수를 사용하는 경우
     '*'는 NULL 값을 갖는 행도 하나의 행으로 인식하여 부정확한 값을 반환함. 
     따라서 '*'대신 해당 테이블의 기본키를 사용
   
--사용예--
  모든 분류에 속한 상품의 수를 출력하시오
  (일반외부조인)
  SELECT B.LPROD_GU AS 분류코드, 
         B.LPROD_NM AS 분류명, 
         COUNT(A.PROD_ID) AS "상품의 수" 
    FROM PROD A, LPROD B
   WHERE A.PROD_LGU(+) = B.LPROD_GU 
   GROUP BY B.LPROD_GU, B.LPROD_NM
   ORDER BY 1;
  (ANSI외부조인)
  SELECT B.LPROD_GU AS 분류코드, 
         B.LPROD_NM AS 분류명, 
         COUNT(A.PROD_ID) AS "상품의 수" 
    FROM PROD A
   RIGHT OUTER JOIN LPROD B ON(A.PROD_LGU = B.LPROD_GU) 
   GROUP BY B.LPROD_GU, B.LPROD_NM
   ORDER BY 1;
  
  
  
  
--사용예--
  2020년 6월 모든 거래처별 매입집계를 조회하시오
  Alias는 거래처코드, 거래처명, 매입금액합계
  SELECT A.BUYER_ID AS 거래처코드, 
         A.BUYER_NAME AS 거래처명, 
         SUM(B.BUY_QTY*C.PROD_COST) AS 매입금액합계
    FROM BUYER A, BUYPROD B, PROD C
   WHERE B.BUY_PROD(+)=C.PROD_ID
     AND A.BUYER_ID=C.PROD_BUYER(+)
     AND BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630') 
   GROUP BY A.BUYER_ID,A.BUYER_NAME
   
 (ANSI)
  SELECT A.BUYER_ID AS 거래처코드, 
         A.BUYER_NAME AS 거래처명, 
         NVL(SUM(B.BUY_QTY*C.PROD_COST),0) AS 매입금액합계
    FROM BUYER A
    LEFT OUTER JOIN PROD C ON(A.BUYER_ID=C.PROD_BUYER)
    LEFT OUTER JOIN BUYPROD B ON(B.BUY_PROD=C.PROD_ID
    AND BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630'))
   GROUP BY A.BUYER_ID,A.BUYER_NAME
   ORDER BY 1
 
 (SUBQUERY)
  SELECT A.BUYER_ID AS 거래처코드, 
         A.BUYER_NAME AS 거래처명, 
         NVL(TBL.BSUM,0) AS 매입금액합계
    FROM BUYER A, 
         (--2020년 6월 거래처별 매입금액합계
         SELECT C.PROD_BUYER AS CID,
                SUM(B.BUY_QTY*C.PROD_COST) AS BSUM
           FROM BUYPROD B, PROD C
          WHERE B.BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630')
            AND B.BUY_PROD=C.PROD_ID
          GROUP BY C.PROD_BUYER) TBL    
   WHERE A.BUYER_ID = TBL.CID(+)
   ORDER BY 1;
   
 
  
--사용예--
  2020년 상반기(4-6월) 모든 제품별 매입수량집계를 조회하시오 --제고관리를 하고자 할 때 사용/전년도에서부터 넘어온 각제품별 재고수량 : 기초재고
  (일반외부조인)--외부조인의 제한사항, 외부조인을 사용했지만 내부조인으로 결괏값이 도출됨
  SELECT B.PROD_ID AS 제품코드,    
         B.PROD_NAME AS 제품명, 
         SUM(A.BUY_QTY)매입수량합계
    FROM BUYPROD A, PROD B
   WHERE A.BUY_PROD(+)=B.PROD_ID
     AND A.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')
   GROUP BY B.PROD_ID, B.PROD_NAME
   ORDER BY 1
  (ANSI FORMAT)  --반드시 ON절에 WHERE절을 써야함
  SELECT B.PROD_ID AS 제품코드,    
         B.PROD_NAME AS 제품명, 
         SUM(A.BUY_QTY)매입수량합계
    FROM BUYPROD A 
   RIGHT OUTER JOIN PROD B ON(A.BUY_PROD = B.PROD_ID AND
         A.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131'))
--   RIGHT OUTER JOIN PROD B ON(A.BUY_PROD = B.PROD_ID)
--   WHERE A.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')
   GROUP BY B.PROD_ID, B.PROD_NAME
   ORDER BY 1;
  
  
  (SUBQUERY)
  SELECT B.PROD_ID AS 제품코드,    
         B.PROD_NAME AS 제품명, 
         매입수량합계
    FROM PROD B,
         (2020년 1월 제품별 매입수량 집계--내부조인)A
   WHERE B.PROD_ID=A.BUY_PROD(+)
   ORDER BY 1;
                
  (서브쿼리:2020년 1월 제품별 매입수량 집계--내부조인)
  SELECT BUY_PROD,
         SUM(BUY_QTY) AS BSUM
    FROM BUYPROD     
   WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')
   GROUP BY BUY_PROD
                   
                   
  (결합) 
  SELECT B.PROD_ID AS 제품코드,    
         B.PROD_NAME AS 제품명, 
         A.BSUM매입수량합계
    FROM PROD B,                                            
         (SELECT BUY_PROD,
                SUM(BUY_QTY) AS BSUM
         FROM BUYPROD      
        WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')
        GROUP BY BUY_PROD) A
   WHERE B.PROD_ID=A.BUY_PROD(+)
   ORDER BY 1;
    
    
    
--사용예--
  2020년 4월 모든 제품별 매출수량집계를 조회하시오
  Alias는 제품코드, 제품명, 매출수량합계
  (ANSI FORMAT)
  SELECT A.PROD_ID AS 제품코드, 
         A.PROD_NAME AS 제품명, 
         SUM(CART_QTY) AS 매출수량합계
    FROM PROD A
    LEFT OUTER JOIN CART B ON(B.CART_PROD=A.PROD_ID AND B.CART_NO LIKE '202004%')
   GROUP BY A.PROD_ID, A.PROD_NAME  
   ORDER BY 1; 
   
--사용예--
  2020년 6월 모든 제품별 매입/매출수량집계를 조회하시오
  SELECT A.PROD_ID AS 제품코드, 
         A.PROD_NAME AS 제품명, 
         SUM(B.BUY_QTY) AS 매입수량, 
         SUM(C.CART_QTY) AS 매출수량
    FROM PROD A
    LEFT OUTER JOIN BUYPROD B ON(A.PROD_ID=B.BUY_PROD 
     AND B.BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630')
    LEFT OUTER JOIN CART C ON(C.CART_PROD=A.PROD_ID AND C.CART_NO LIKE '202006%')
    GROUP BY A.PROD_ID, A.PROD_NAME
    ORDER BY 1
    
   
   
   