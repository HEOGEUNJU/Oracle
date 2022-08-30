2022-0829-01)테이블 조인
 - 관계형 데이터베이스에서 관계(Relationship)를 이용하여 복수개의 테이블로부터 필요한 자료를 
   추출하는 연산 
 - 조인에 참여하는 테이블은 반드시 관계(외래키 관계)를 맺어야함(관계가 없는 테이블간의 조인을
   Cartessian(Cross) join 이라고 함)
 - 조인의 종류
   . 내부조인과 외부조인(Inner join, outer join)
   . 일반조인과 ANSI Join
   . Equi Join, Non-Equi Join, Self Join, Cartessian Product 
 1. 일반 조인
  - 각 DB 벤더에서 자사의 DBMS에 최적화된 문법 구조를 가짐(개발사마다 다름)
  - 사용 DB가 바뀌면 변경된 문법을 새로 습득해야 함
  (사용형식)
  SELECT 컬럼list
    FROM 테이블명1 [별칭1], 테이블명2 [별칭2] [,...]
   WHERE [별칭1.|테이블명1.]컬럼명 연산자 [별칭2.|테이블명2.]컬럼명 
    [AND 조인조건] 
    [AND 일반조건]
                            :
                            
  . n개의 테이블이 사용되면 조인조건은 적어도 n-1개 이상 되어야 함. 
  . 일반조건과 조인조건은 사용 순서가 바뀌어도 상관없음
   
 2. ANSI 내부조인
  SELECT 컬럼list 
    FROM 테이블명1[별칭1]
   INNER|CROSS|NATURAL JOIN 테이블명2 [별칭2] ON(조인조건 [AND 일반조건]) -- 테이블명1과 테이블명3은 직접연결 되지 않았기 때문에 이자리에 올 수 없다.
   INNER|CROSS|NATURAL JOIN 테이블명3 [별칭3] ON(조인조건 [AND 일반조건])
                            :
  [WHERE 일반조건]
            :
            
-- 테이블이 3개 이상 사용될 경우  -- 모든 테이블에 들어갈 조건은 WHERE절에 입력하고 테이블 1과 2, 3에만 적용될 조건은 ON절에 입력한다.   
  . 테이블명1과 테이블명2는 반드시 직접 JOIN 가능해야 함
  . 테이블명3은 테이블명1과 테이블명2의 조인 결과와 조인 수행
  . 'CROSS JOIN'은 일반조인의 Cartessian Product와 동일
  . 'NATURAL JOIN'은 조인연산에 사용된 테이블에 동일 컬럼명이 존재하면 
    자동으로 조인 발생
    
 3. Cartessian Product Join(Cross Join)
  . 조인조건이 기술되지 않았거나 잘못 기술된 경우 발생
  . n행 m열의 테이블과 a행 b열의 테이블이 Cross Join된 경우 최악의 경우(조인 조건이 누락된 경우) 
    결과는 n*a 행 m+b 열이 반환됨
  . 반드시 필요한 경우가 아니면 사용을 자제해야 함
  
 사용예)
  SELECT COUNT(*) AS "PROD 테이블 행의수" FROM PROD; 
  SELECT COUNT(*) AS "CART 테이블 행의수" FROM CART;
  SELECT COUNT(*) AS "BUYPROD 테이블 행의수" FROM BUYPROD;
 
  SELECT COUNT(*) FROM PROD, CART, BUYPROD;
  
  SELECT COUNT(*)
    FROM PROD
   CROSS JOIN CART
   CROSS JOIN BUYPROD;
 
 4. Equi Join(ANSI의 INNER JOIN)
  - 조인조건에 '=' 연산자 사용
  
  (일반조인 사용형식)
  SELECT 컬럼list
    FROM 테이블명1 [별칭1], 테이블명2 [별칭2] [,테이블명3 [별칭3],...]
   WHERE [별칭1.]컬럼명1=[별칭2.]컬럼명2 -- 조인조건
    [AND [별칭1.]컬럼명1=[별칭3.]컬럼명3]-- 조인조건
                    :
    [AND 일반조건]
    
  (ANSI조인 사용형식)
   SELECT 컬럼list
     FROM 테이블명1 [별칭1]
    INNER JOIN 테이블명2 [별칭2] ON([별칭1.]컬럼명1=[별칭2.]컬럼명2 [AND 일반조건1])
    --위의 연산결과(테이블1과 2와 먼저 연산)와 테이블3이 연산되는 조건이다.
   [INNER JOIN 테이블명3 [별칭3] ON([별칭1.]컬럼명1=[별칭2.]컬럼명2 [AND 일반조건2])
                        :
   [WHERE 일반조건]  -- 위의 테이블의 공통적인 조건을 기술해주는 것
   
 사용예) 매입테이블에서 2020년 6월 매입상품정보를 조회하시오
         Alias는 일자, 상품번호, 상품명, 수량, 금액
--(일반조인)--        
  SELECT A.BUY_DATE AS 일자, 
         A.BUY_PROD AS 상품번호, 
         B.PROD_NAME AS 상품명, 
         A.BUY_QTY AS 수량, 
         A.BUY_QTY*B.PROD_COST AS 금액       
    FROM BUYPROD A, PROD B     
   WHERE A.BUY_PROD=B.PROD_ID -- 조인조건
     AND A.BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630')--일반조건
   ORDER BY 1;     
--(ANSI조인)--        
  SELECT A.BUY_DATE AS 일자, 
         A.BUY_PROD AS 상품번호, 
         B.PROD_NAME AS 상품명, 
         A.BUY_QTY AS 수량, 
         A.BUY_QTY*B.PROD_COST AS 금액
    FROM BUYPROD A
-- INNER JOIN PROD B ON(A.BUY_PROD=B.PROD_ID 
--   AND (A.BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630'))) 
   INNER JOIN PROD B ON(A.BUY_PROD=B.PROD_ID) 
   WHERE A.BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630') --3개부터는 달라지니까 조심해야함요
   ORDER BY 1;       
         
 사용예) 상품테이블에서 'P10202' 거래처에서 납품하는 상품정보를 조회하시오
         Alias는 상품코드, 상품명, 거래처명, 매입단가
--(일반조인)--            
  SELECT A.PROD_ID AS 상품코드, 
         A.PROD_NAME AS 상품명, 
         B.BUYER_NAME AS 거래처명, 
         A.PROD_COST AS 매입단가       
    FROM PROD A, BUYER B   
   WHERE A.PROD_BUYER =B.BUYER_ID
     AND SUBSTR(B.BUYER_ID,1,6) = 'P10202'; 
--(ANSI조인)--     
  SELECT A.PROD_ID AS 상품코드, 
         A.PROD_NAME AS 상품명, 
         B.BUYER_NAME AS 거래처명, 
         A.PROD_COST AS 매입단가
    FROM PROD A
   INNER JOIN BUYER B ON(A.PROD_BUYER=B.BUYER_ID)
   WHERE A.PROD_BUYER = 'P10202'
         
 사용예) 상품테이블에서 다음 정보를 조회하시오
         Alias는 상품코드, 상품명, 분류명, 판매단가
--(일반조인)--           
  SELECT A.PROD_ID AS 상품코드, 
         A.PROD_NAME AS 상품명, 
         B.LPROD_NM AS 분류명, 
         A.PROD_PRICE 판매단가      
    FROM PROD A, LPROD B
   WHERE B.LPROD_GU=A.PROD_LGU
   ORDER BY 1;
--(ANSI조인)--
  SELECT A.PROD_ID AS 상품코드, 
         A.PROD_NAME AS 상품명, 
         B.LPROD_NM AS 분류명, 
         A.PROD_PRICE 판매단가   
    FROM LPROD B 
   INNER JOIN PROD A ON(B.LPROD_GU=A.PROD_LGU)
      
  
  
--사용예-- 
 사원테이블에서 사원번호, 사원명, 부서명, 입사일을 출력하시오         
  (일반조인)  
  SELECT A.EMPLOYEE_ID AS 사원번호, 
         A.EMP_NAME AS 사원명, 
         B.DEPARTMENT_NAME AS 부서명, 
         A.HIRE_DATE AS 입사일         
    FROM HR.Employees A, HR.Departments B
   WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID 
  (ANSI조인) 
  SELECT EMPLOYEE_ID AS 사원번호, 
         EMP_NAME AS 사원명, 
         DEPARTMENT_NAME AS 부서명, 
         HIRE_DATE AS 입사일         
    FROM HR.Employees A      
   INNER JOIN HR.Departments B ON(A.DEPARTMENT_ID = B.DEPARTMENT_ID)      
         
--사용예-- 
 2020년 4월 회원별, 상품별 판매집계를 조회하시오        
 Alias는 회원번호, 회원명, 상품명, 구매수량합계, 구매금액합계   
  (일반조인) 
  SELECT A.CART_MEMBER AS 회원번호, 
         B.MEM_NAME AS 회원명, 
         C.PROD_NAME AS 상품명, 
         SUM(A.CART_QTY) AS 구매수량합계, 
         SUM(A.CART_QTY*C.PROD_PRICE) AS 구매금액합계         
    FROM CART A, MEMBER B, PROD C
   WHERE A.CART_MEMBER = B.MEM_ID --조인조건(회원명)
     AND A.CART_PROD = C.PROD_ID  --조인조건(상품명, 상품단가)
     AND SUBSTR(A.CART_NO,1,6) = '202004'
   GROUP BY A.CART_MEMBER, B.MEM_NAME, C.PROD_NAME
   ORDER BY 1;
  (ANSI조인)  
  SELECT A.CART_MEMBER AS 회원번호, 
         B.MEM_NAME AS 회원명, 
         C.PROD_NAME AS 상품명, 
         SUM(A.CART_QTY) AS 구매수량합계, 
         SUM(A.CART_QTY*C.PROD_PRICE) AS 구매금액합계         
    FROM CART A  
   INNER JOIN  MEMBER B ON(A.CART_MEMBER = B.MEM_ID)
   INNER JOIN  PROD C ON(A.CART_PROD = C.PROD_ID
     AND SUBSTR(A.CART_NO,1,6) = '202004')     --내부조인에서는 WHERE 절을 써도 큰 문제가 발생하지 않지만
                                               --외부조인할 때는 문제가 생김         
   GROUP BY A.CART_MEMBER, B.MEM_NAME, C.PROD_NAME
   ORDER BY 1;      
         
--(사용예)--
 2020년 5월 거래처별 매출집계를 조회하시오
 Alias는 거래처코드, 거래처명, 매출금액합계
  (ANSI조인)    
  SELECT B.BUYER_ID AS 거래처코드, 
         B.BUYER_NAME AS 거래처명, 
         SUM(C.CART_QTY*A.PROD_PRICE) AS 매출금액합계
    FROM PROD A
   INNER JOIN BUYER B ON(A.PROD_BUYER = B.BUYER_ID)
   INNER JOIN CART C ON(A.PROD_ID = C.CART_PROD
     AND SUBSTR(C.CART_NO,1,6) = '202005')
   GROUP BY B.BUYER_ID, B.BUYER_NAME
   ORDER BY 1; 
  (일반조인)
  SELECT B.BUYER_ID AS 거래처코드, 
         B.BUYER_NAME AS 거래처명, 
         SUM(C.CART_QTY*A.PROD_PRICE) AS 매출금액합계
    FROM PROD A, BUYER B, CART C
--   WHERE A.PROD_LGU = B.BUYER_LGU
    WHERE A.PROD_BUYER = B.BUYER_ID
     AND A.PROD_ID = C.CART_PROD
     AND SUBSTR(C.CART_NO,1,6) = '202005'
   GROUP BY B.BUYER_ID, B.BUYER_NAME
   ORDER BY 1;
   
--사용예-- 
 HR계정에서 미국 이외의 국가에 위치한 부서정보를 조회하시오
 Alias는 부서번호, 부서명, 주소, 국가
  (ANSI조인)
  SELECT B.DEPARTMENT_ID AS 부서번호, 
         B.DEPARTMENT_NAME AS 부서명, 
         A.COUNTRY_ID||' '||A.CITY||' '||A.STREET_ADDRESS AS 주소, 
         C.COUNTRY_NAME AS 국가      
    FROM HR.Locations A 
   INNER JOIN HR.Countries C ON(A.COUNTRY_ID = C.COUNTRY_ID)
   INNER JOIN HR.Departments B ON(A.LOCATION_ID = B.LOCATION_ID)
   WHERE C.COUNTRY_ID != 'US'
   
  (일반조인)
  SELECT B.DEPARTMENT_ID AS 부서번호, 
         B.DEPARTMENT_NAME AS 부서명, 
         A.COUNTRY_ID||' '||A.CITY||' '||A.STREET_ADDRESS AS 주소, 
         C.COUNTRY_NAME AS 국가      
    FROM HR.Locations A, HR.Departments B, HR.Countries C
   WHERE A.LOCATION_ID = B.LOCATION_ID
     AND A.COUNTRY_ID = C.COUNTRY_ID
     AND C.COUNTRY_ID != 'US'
         
         
         