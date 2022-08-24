2022-0824-01) 집계함수
 사용예) 장바구니테이블에서 2020년 5월 제품별 판매집계를 조회하시오
         Alias는 제품코드, 판매건수, 판매수량, 금액 
  SELECT A.CART_PROD AS 제품코드, 
         COUNT(*) AS 판매건수, 
         SUM(A.CART_QTY) AS 판매수량, 
         SUM(A.CART_QTY*B.PROD_PRICE) AS 금액
    FROM CART A, PROD B 
   WHERE CSUBSTR(ART_NO,1,6) LIKE'202005%'
     AND A.CART_PROD=B;
    GROUP BY A.CART_PROD;
    ORDER BY 1;
   
 사용예) 장바구니테이블에서 2020년 5월 회원별 판매집계를 조회하시오
         Alias는 회원번호, 구매수량, 구매금액
  SELECT  A.CART_MEMBER AS 회원번호, 
          SUM(A.CART_QTY) AS 구매수량, 
          SUM(B.PROD_SALE*A.CART_QTY) AS 구매금액
    FROM  CART A, PROD B
   WHERE  A.CART_NO LIKE '202005%'
     AND  A.CART_PROD = B.PROD_ID
   GROUP BY A.CART_MEMBER
   ORDER BY A.CART_MEMBER; 
   
 사용예) 장바구니테이블에서 2020년 월별, 회원별 판매집계를 조회하시오 --> 대그룹 월별, 소그룹 회원별로 모으기
         Alias는 월, 회원번호, 구매수량, 구매금액         
  SELECT SUBSTR(A.CART_NO,5,2) AS 월, 
         A.CART_MEMBER AS 회원번호, 
         SUM(A.CART_QTY) AS 구매수량, 
         SUM(B.PROD_PRICE*A.CART_QTY) AS 구매금액
    FROM CART A, PROD B
   WHERE A.CART_NO LIKE '2020%'
     AND A.CART_PROD = B.PROD_ID 
   GROUP BY SUBSTR(A.CART_NO,5,2), A.CART_MEMBER
   ORDER BY 1;
   
    
 사용예) 장바구니테이블에서 2020년 5월 제품별 판매집계를 조회하되 판매금액이 
         100만원 이상인 자료만 조회하시오
         Alias는 제품코드, 판매수량, 금액         
  SELECT A.CART_PROD AS 제품코드, 
         SUM(A.CART_QTY)판매수량, 
         SUM(A.CART_QTY*B.PROD_PRICE) AS 금액       
    FROM CART A, PROD B        
   WHERE A.CART_NO LIKE '202005%'        
     AND A.CART_PROD = B.PROD_ID    
   GROUP BY A.CART_PROD
   HAVING SUM(A.CART_QTY*B.PROD_PRICE)>=1000000 -- 그룹함수 자체에 조건이 주어질 때
   ORDER BY 1;
        
        
         
 사용예) 2020년 상반기(1-6월) 매입액 기준 가장 많이 매입된 상품 5개를 조회하시오
         Alias는 상품코드, 매입수량, 매입금액
    1) 2020년 상반기(1-6월) 제품별 매입액을 계산하고 매입액이 많은 순으로 출력     
  SELECT BUY_PROD AS 상품코드, 
         SUM(BUY_QTY) AS 매입수량합계,
         SUM(BUY_QTY*BUY_COST) AS 매입금액합계
    FROM BUYPROD 
   WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200630')
   GROUP BY BUY_PROD
   ORDER BY 3 DESC;
         
  -- 출력창에서 나오는 순번을 PSEUDO(의사,가상) COLUMM이라고 하며 순번 하나하나를 ROWNUM이라고 한다.        
         
 문제) 사원테이블에서 부서별 평균급여를 조회하시오
SELECT DEPARTMENT_ID AS 부서,
       ROUND(AVG(SALARY)) AS 평균급여
  FROM HR.Employees
 GROUP BY DEPARTMENT_ID
 ORDER BY 1; 
 
 문제) 사원테이블에서 부서별 입사일이 가장 먼저 입사한 사원의 사원번호, 사원명, 부서번호,
       입사일을 출력하시오
SELECT EMPLOYEE_ID AS 사원번호, 
       EMP_NAME AS 사원명, 
       DEPARTMENT_ID AS 부서번호, 
       TO_CHAR(HIRE_DATE,'YYYYMMDD') AS 입사일
  FROM (SELECT DEPARTMENT_ID,
               MIN(HIRE_DATE) AS HDATE
          FROM HR.Employees
         GROUP BY DEPARTMENT_ID) A, 
        HR.Employees B
 WHERE F       
 GROUP BY DEPARTMENT_ID;
------------------------------------------------
SELECT EMPLOYEE_ID AS 사DNJS번호,
       EMP_NAME AS 사원명,
       DEPARTMENT_ID AS 부서번호,
       MIN(HIRE_DATE) AS 입사일
  FROM HR.EMPLOYEES
 GROUP BY EMPLOYEE_ID, EMP_NAME, DEPARTMENT_ID 


 문제) 사원들의 평균급여보다 더 많이 받는 사원의 사원번호, 사원명, 부서번호, 급여를 출력하시오
           
  
-----------------------------------------------
SELECT ROUND(AVG(SALARY),2)  AS 평균급여
  FROM HR.Employees
 
 
 문제) 회원테이블에서 남녀회원별 마일리지 합계와 평균 마일리지를 조회하시오.
       Alias는 구분, 마일리지합계, 평균마일리지
SELECT CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN ('1','3') THEN 
       '남성회원'
       ELSE '여성회원'
       END AS 구분,
       ROUND(AVG(MEM_MILEAGE),2) AS 마일리지평균,
       SUM(MEM_MILEAGE) AS 마일리지합계,
       COUNT(*) AS 회원수
  FROM MEMBER
 GROUP BY CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN ('1','3') THEN 
       '남성회원'
       ELSE '여성회원'
       END;        
         
         
         