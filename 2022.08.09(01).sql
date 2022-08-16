2022-0809-01)연산자
 1. 관계(비교)연산자
  - 자료의 대소관계를 비교하는 연산자로 결과는 참(true)와 거짓(false)로 반환
  - >, <, >=, <=, !=, =, (<>)
  - 표현식(CASE WHEN ~ THEN, DECODE)이나 WHERE 조건절에 사용
  
  사용예) 회원테이블 (MEMBER)에서 모든 회원들의 회원번호, 회원명, 직업, 마일리지을 조회하되 마일리지가 많은
          회원부터 조회하시오.
    SELECT MEM_ID AS 회원번호,
           MEM_NAME AS 회원명,
           MEM_JOB AS 직업,
           MEM_MILEAGE AS 마일리지
      FROM MEMBER
      --ORDER BY MEM_MILEAGE DESC;
      ORDER BY 4 DESC;
      
      
      
  사용예) 사원테이블(Employees)부서번호가 50번인 사원들을 조회하시오.
          Alias는 사원번호, 사원명, 부서번호, 급여이다.
    
  SELECT EMPLOYEE_ID AS 사원번호, 
         EMP_NAME AS 사원명, 
         DEPARTMENT_ID AS 부서번호, 
         SALARY AS급여
    FROM HR.Employees
   WHERE DEPARTMENT_ID=50; 
   
  사용예) 회원테이블(MEMBER)에서 직업이 주부인회원들을 조회하시오.
          Alias는 회원번호, 회원명, 직업, 마일리지이다.
          
  SELECT MEM_ID AS 회원번호,
         MEM_NAME AS 회원명,
         MEM_JOB AS 직업,
         MEM_MILEAGE AS 마일리지
    FROM MEMBER
   WHERE MEM_JOB='주부';
   
   
   
 2. 산술연산자
   - '+', '-', '*', '/' => 4칙 연산자    <오라클은 증감연산자가 없다. 그리고 나머지 연산자는 REMINEDER라는 함수를 사용한다.>
   - ( ) : 연산의 우선순위를 결정할 때 사용
  
  사용예) 사원테이블(HR.EMPLOYEES)에서 보너스를 계산하고 지급액을 결정하여 출력하시오.
          보너스 = 본봉 * 영업실적의 30%
          지급액 = 본봉 + 보너스
          Alias는 사원번호, 사원명, 본봉, 영업실적, 보너스, 지급액
          모든 값은 정수부분만 출력 
  
  SELECT EMPLOYEE_ID AS 사원번호, 
         FIRST_NAME||' '||LAST_NAME AS 사원명, 
         SALARY AS 본봉, 
         NVL(COMMISSION_PCT,0) AS 영업실적, 
         NVL(ROUND(COMMISSION_PCT*SALARY*0.3),0) AS 보너스, 
         SALARY + NVL(ROUND(COMMISSION_PCT*SALARY*0.3),0) AS 지급액        
    FROM HR.Employees; 
    
     
 3. 논리연산자
   - 두개 이상의 관계식을 연결(AND, OR)하거나 반전(NOT)결과 반환 
   - NOT, AND, OR
   --------------------------
     입력           출력
    A    B       OR     AND
   --------------------------
    0    0       0       0              <= 0은 FALSE, 1은 TRUE
    0    1       1       0
    1    0       1       0
    1    1       1       1
  
  
  사용예) 상품테이블(PROD)에서 판매가격이 30만원 이상이고 적정재고가 5개 이상인 
          제품의 제품번호, 제품명, 매입가, 판매가, 적정재고를 조회하시오.
   SELECT PROD_ID AS 제품번호, 
          PROD_NAME AS 제품명, 
          PROD_COST AS 매입가, 
          PROD_PRICE AS 판매가, 
          PROD_PROPERSTOCK AS 적정재고        
     FROM PROD
    WHERE PROD_PRICE>=300000 
      AND PROD_PROPERSTOCK>=5
    ORDER BY 4;  
   
  사용예) 매입테이블(BUYPROD)에서 매입일이 2020년 1월이고 매입수량이 10개 이상인 매입정보를 조회하시오.
          Alias는 매입일, 매입상품, 매입수량, 매입금액
   SELECT BUY_DATE AS 매입일, 
          BUY_PROD AS 매입상품, 
          BUY_QTY AS 매입수량, 
          BUY_COST*BUY_QTY AS 매입금액   
     FROM BUYPROD
    WHERE BUY_DATE>=TO_DATE('20200101') AND BUY_DATE<=TO_DATE('20200131')
  --WHERE BUY_DATE>='20200101'
  --  AND BUY_DATE<='20200131' <= 이 방법도 가능
      AND BUY_QTY>=10
    ORDER BY 1;
  
  사용예) 회원테이블에서 연령대가 20대이거나 여성 회원을 조회하시오.
          Alias는 회원번호, 회원명, 주민번호, 마일리지
   SELECT MEM_ID AS 회원번호, 
          MEM_NAME AS 회원명, 
          MEM_REGNO1||'-'||MEM_REGNO2 AS 주민번호, 
          TRUNC(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR),-1) AS 연령대,
          MEM_MILEAGE AS 마일리지 
     FROM MEMBER
    WHERE TRUNC(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR),-1)=20
       OR SUBSTR(MEM_REGNO2,1,1) IN('2','4') 
     --OR (SUBSTR(MEM_REGNO2,1,1)='2' OR SUBSTR(MEM_REGNO2,1,1) = '4')  <= 이 방법도 가능
     
  사용예) 회원테이블에서 연령대가 20대 여성 회원이면서 마일리지가 2000이상인 회원을 조회하시오.
          Alias는 회원번호, 회원명, 주민번호, 마일리지
   SELECT MEM_ID AS 회원번호, 
          MEM_NAME AS 회원명, 
          MEM_REGNO1||'-'||MEM_REGNO2 AS 주민번호, 
          MEM_MILEAGE AS 마일리지
     FROM MEMBER
    WHERE (TRUNC(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR),-1)=20
       OR SUBSTR(MEM_REGNO2,1,1) IN('2','4'))
      AND MEM_MILEAGE>=2000;
   
  사용예) 키보드로 년도를 입력받아 윤년과 평년을 판단하시오.
        윤년 : 4의 배수이면서 100의 배수가 아니거나 ||또는 400의 배수가 되는 년도.
   ACCEPT P_YEAR   PROMPT '년도입력 : '
   DECLARE 
     V_YEAR NUMBER:=TO_NUMBER('&P_YEAR');
     V_RES VARCHAR2(100); 
   BEGIN 
     IF (MOD(V_YEAR,4)=0 AND MOD(V_YEAR,100) != 0) OR (MOD(V_YEAR,400)=0) THEN
        V_RES := TO_CHAR(V_YEAR)||'년도는 윤년입니다.';
     ELSE
        V_RES := TO_CHAR(V_YEAR)||'년도는 평년입니다.';
     END IF;
     DBMS_OUTPUT.PUT_LINE(V_RES); 
     --<= 자바의 SYSO랑 같다.
   END;  
   
   