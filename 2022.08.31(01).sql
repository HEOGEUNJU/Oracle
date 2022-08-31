2022-0831-01)서브쿼리
 - SQL구문 안에 또 다른 SQL 구문이 존재하는 것을 의미
 - 알려지지 않은 조건에 근거하여 값들을 검색할 때 유용
 - SELECT, DML, CREATE TABLE, VIEW 에 사용
 - 서브쿼리는 '( )'안에 기술(단, INSERT INTO에 사용되는 서브쿼리는 예외)
 - 분류
  . 일반서브쿼리(SELECT절에 나오는 서브쿼리), IN LINE 서브쿼리(FROM절에 나오는 서브쿼리)<=반드시 실행 가능해야 함, 
    중첩서브쿼리(WHERE절에 나오는 서브쿼리)<= 무조건 관계연산자 오른쪽에 써야한다.
  . 연관성 있는 서브쿼리(서브쿼리에서 사용한 테이블과 메인쿼리에서 사용한 테이블이 조인으로 연결되었을 때), 
    연관성 없는 서브쿼리(서브쿼리에서 사용한 테이블과 메인쿼리에서 사용한 테이블이 조인으로 연결되지 않았을 때)
  . 단일행(다중행)/단일열(다중열) 서브쿼리
  . 결과가 하나만 나와야 하는 서브쿼리 : 단일행 서브쿼리 <=>다중행 서브쿼리
   --최종 결과를 출력하고 조회하는 것이 메인쿼리다. 조회하기 필요한 자료를 제공하는 것이 서브쿼리이다.
  ex)평균 급여보다 높은 급여를 뽑아라.

 1) 연관성 없는 서브쿼리
  - 메인쿼리에 사용된 테이블과 서브쿼리에 사용된 테이블 사이에 조인을 사용하지 않는 서브쿼리
--사용예-- 
  사원테이블에서 사원들의 평균 급여보다 많은 급여를 받는 사원을 조회하시오.
  Alias는 사원번호, 사원명, 직책코드, 급여
  (메인쿼리 : 사원테이블에서 사원들의 사원번호, 사원명, 직책코드, 급여조회)
  SELECT 사원번호, 사원명, 직책코드, 급여
    FROM HR.Employees
   WHERE SALARY>(평균급여) 
  (서브쿼리 : 평균급여)
  SELECT AVG(SALARY)
    FROM HR.Employees
  (결합)
  SELECT EMPLOYEE_ID 사원번호,
         EMP_NAME 사원명,
         JOB_ID 직책코드,
         SALARY 급여
    FROM HR.Employees
   WHERE SALARY>(SELECT AVG(SALARY)
                   FROM HR.Employees)     
   ORDER BY 4 DESC;            
  (IN-LINE) <= 서브쿼리 실행횟수 1회
  SELECT A.EMPLOYEE_ID 사원번호,
         A.EMP_NAME 사원명,
         A.JOB_ID 직책코드,
         A.SALARY 급여
    FROM HR.Employees A, (SELECT AVG(SALARY) AS SAL
                            FROM HR.Employees) B  --B로 이름이 붙여진 VIEW
   WHERE A.SALARY>B.SAL
   ORDER BY 4 DESC;
   
--사용예--
  2017년 이후에 입사한 사원이 존재하는 부서를 조회하시오
  Alias는 부서번호, 부서명, 관리사원번호
  (메인쿼리: 부서의 부서번호, 부서명, 관리사원번호)
  SELECT A.DEPARTMENT_ID AS 부서번호, 
         B.DEPARTMENT_NAME AS 부서명, 
         A.MANAGER_ID AS 관리사원번호
    FROM HR.Employees A, HR.Departments B
   WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
     AND B.DEPARTMENT_ID IN(서브쿼리)
     
  (서브쿼리: 2017년 이후에 입사한 사원이 존재하는 부서)  
  SELECT DEPARTMENT_ID
    FROM HR.Employees
   WHERE HIRE_DATE>TO_DATE('20161231') 
  
  (결합)
  SELECT DISTINCT A.DEPARTMENT_ID AS 부서번호, 
         B.DEPARTMENT_NAME AS 부서명 
    FROM HR.Employees A, HR.Departments B
   WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
     AND A.DEPARTMENT_ID IN(SELECT DEPARTMENT_ID
                              FROM HR.Employees
                             WHERE HIRE_DATE>TO_DATE('20161231')) 
   ORDER BY 1;
   
    SELECT DISTINCT A.DEPARTMENT_ID AS 부서번호, 
         B.DEPARTMENT_NAME AS 부서명 
    FROM HR.Employees A, HR.Departments B
   WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
     AND EXISTS (SELECT 1
                   FROM HR.Employees C
                  WHERE HIRE_DATE>TO_DATE('20161231')
                    AND C.EMPLOYEE_ID=A.EMPLOYEE_ID) 
   ORDER BY 1;
   
--사용예--
  상품테이블에서 상품의 평균판매가보다 판매가가 더 높은 상품의 
  상품번호, 상품명, 분류명, 판매가를 조회하시오
  SELECT A.PROD_ID 상품번호, 
         A.PROD_NAME 상품명, 
         B.LPROD_GU 분류명, 
         A.PROD_PRICE 판매가
    FROM PROD A, LPROD B
   WHERE A.PROD_LGU=B.LPROD_GU
     AND A.PROD_PRICE IN(SELECT PROD_PRICE
                           FROM PROD
                          WHERE PROD_PRICE>AVG(PROD_PRICE))
                          
                        
      SELECT A.PROD_ID 상품번호, 
             A.PROD_NAME 상품명, 
             B.LPROD_GU 분류명, 
             A.PROD_PRICE 판매가
        FROM PROD A, LPROD B, (SELECT AVG(PROD_PRICE) AS PAVG
                                 FROM PROD) PG
       WHERE A.PROD_LGU=B.LPROD_GU
         AND A.PROD_PRICE>PG.PAVG                     
   
--사용예--
  회원테이블에서 2000년 이전 출생한 어떤 회원의 마일리지보다 더 많은
  마일리지를 보유한 회원의 회원번호, 회원명, 주민번호, 마일리지를 조회
  
  SELECT A.MEM_ID AS 회원번호, 
         A.MEM_NAME AS 회원명, 
         A.MEM_REGNO1||MEM_REGNO2 AS 주민번호, 
         A.MEM_MILEAGE AS 마일리지
    FROM MEMBER A, (SELECT MAX(MEM_MILEAGE) AS AA
                      FROM MEMBER
                     WHERE MEM_BIR <TO_DATE('20000101')) BB
   WHERE A.MEM_MILEAGE >ALL(BB.AA)
 ---------------------------------------------------------------- 
  SELECT A.MEM_ID AS 회원번호, 
         A.MEM_NAME AS 회원명, 
         A.MEM_REGNO1||MEM_REGNO2 AS 주민번호, 
         A.MEM_MILEAGE AS 마일리지
    FROM MEMBER A 
   WHERE A.MEM_MILEAGE >ALL(SELECT MEM_MILEAGE 
                              FROM MEMBER
                             WHERE MEM_BIR <TO_DATE('20000101'))
  
  
  
--사용예--
  장바구니테이블에서 2020년 5월 회원별 최고 구매금액을 기록한 회원을 조회하시오.
  Alias는 회원번호, 회원명, 구매금액합계 
  (서브쿼리: 2020년 5월 회원별 구매금액 합계를 내림차순으로 정렬)
   SELECT A.CART_MEMBER AS CID, --회원번호
          SUM(A.CART_QTY * B.PROD_PRICE) AS CSUM --구매금액합계
     FROM CART A, PROD B
    WHERE A.CART_PROD=B.PROD_ID
      AND A.CART_NO LIKE '202005%'
    GROUP BY A.CART_MEMBER
    ORDER BY 2 DESC;
  (메인쿼리: 서브쿼리의 결과 중 가장 위 줄에 해당하는 자료 출력)
   SELECT TA.CID AS 회원번호, 
          M.MEM_NAME AS 회원명, 
          TA.CSUM AS 구매금액합계
     FROM MEMBER M,(SELECT A.CART_MEMBER AS CID, --회원번호
                           SUM(A.CART_QTY * B.PROD_PRICE) AS CSUM --구매금액합계
                      FROM CART A, PROD B
                     WHERE A.CART_PROD=B.PROD_ID
                       AND A.CART_NO LIKE '202005%'
                     GROUP BY A.CART_MEMBER
                     ORDER BY 2 DESC)TA 
     WHERE M.MEM_ID= TA.CID
       AND ROWNUM=1
  
  (WITH 절 사용)
  WITH A1 AS (SELECT A.CART_MEMBER AS CID, --회원번호
                     SUM(A.CART_QTY * B.PROD_PRICE) AS CSUM --구매금액합계
                FROM CART A, PROD B
               WHERE A.CART_PROD=B.PROD_ID
                 AND A.CART_NO LIKE '202005%'
               GROUP BY A.CART_MEMBER
               ORDER BY 2 DESC)
  SELECT B.MEM_ID,B.MEM_NAME,A1.CSUM
    FROM MEMBER B, A1
   WHERE B.MEM_ID=A1.CID 
     AND ROWNUM=1
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  