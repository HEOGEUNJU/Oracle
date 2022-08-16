2022-0810-02)
 4. LIKE 연산자
  - 패턴을 정의하여 패턴비교를 수행
  - 문자열 비교(숫자 비교는 못함, 날짜 타입에도 사용 못함)
  (사용형식)
   expr LIKE 패턴문자열
   . 패턴구성에는 '%'와 '_'의 와일드카드(패턴문자)가 사용
   . '%' : '%'가 사용된 위치 이후의 모든 문자열과 대응됨(공백도 대응됨) 
     ex) '김%' : '김'으로 시작하는 모든 문자열은 참(true)을 반환
         '%김' : '김'으로 끝나는 모든 문자열은 참(true)을 반환
         '%김%': 문자열 내부에 '김'이 존재하면 참(true)을 반환
   
   . '_' : '_'이 사용된 위치에서 하나의 문자와 대응됨
     ex) '김_' : 두 글자로 구성되고 첫 글자가 '김'이면 참(true)을 반환
         '_김' : 두 글자로 구성되고 '김'으로 끝나면 참(true)을 반환
         '_김_': 세 글자로 구성되고 중간글자가 '김'이면 참(true)을 반환
   
   . 많은 결과를 반환하기 때문에 (참이되는 경우가 많이 발생) 방대한 자료를 저장하고 있는 경우 
     사용빈도 수가 많으면 검색효율이 떨어짐
  (사용예) 회원테이블에서 거주지가 '대전'인 회원들을 조회하시오
           Alias는 회원번호, 회원명, 주소
    SELECT MEM_ID AS 회원번호, 
           MEM_NAME AS 회원명, 
           MEM_ADD1||' '||MEM_ADD2 AS주소
      FROM MEMBER
     WHERE MEM_ADD1 LIKE '대전%';
           
  (사용예) 장바구니테이블에서 2020년 6월에 판매된 상품을 조회하시오
           Alias는 상품번호     
    SELECT DISTINCT CART_PROD AS 상품번호  
      FROM CART
     WHERE CART_NO LIKE '202006%'
     ORDER BY 1;
     
  (사용예) 매입테이블에서 2020년 6월에 매입된 상품을 조회하시오
           Alias는 상품번호             
    SELECT DISTINCT BUY_PROD AS 상품번호  
      FROM BUYPROD
     WHERE BUY_DATE >= TO_DATE('20200601') AND BUY_DATE <= TO_DATE('20200630');
        -- TO_CHAR(BUY_DATE,'YYYYMMDD') LIKE '202006%'
        -- BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630'); <= 날짜 단위에서는 LIKE말고 BETWEEN 사용하기
        
 5) BETWEEN 연산자
  - 범위를 정한 자료를 비교
  (사용형식)
   expr BETWEEN 값1 AND 값2
   . expr의 값이 '값1'에서 '값2' 사이에 존재하는 값이면 참을 반환
   . BETWEEN연산자는 AND연산자로 바꾸어 사용할 수 있음
   . 모든 데이터 타입에 사용 가능
   . 날짜나 숫자로 범위가 정해졌을 때 많이 사용하는 연산자임
  (사용예) 상품테이블에서 판매가격이 10만원~20만원 사이의 상품을 조회하시오.
           Alias는 상품번호, 상품명, 판매가격
   (AND 연산자)
    SELECT PROD_ID AS 상품번호, 
           PROD_NAME AS 상품명, 
           PROD_PRICE AS 판매가격
      FROM PROD
     WHERE PROD_PRICE>=100000 AND PROD_PRICE<=200000
     ORDER BY 3;
   
   (BETWEEN 연산자)
    SELECT PROD_ID AS 상품번호, 
           PROD_NAME AS 상품명, 
           PROD_PRICE AS 판매가격
      FROM PROD
     WHERE PROD_PRICE BETWEEN 100000 AND 200000
     ORDER BY 3;
     
     
  (사용예) 사원테이블에서 입사일이 2005년~2007년 사이에 입사한 사원들을 조회하시오.         
           Alias는 사원번호, 사원명, 부서코드, 직무코드, 입사일
    SELECT EMPLOYEE_ID AS 사원번호, 
           EMP_NAME AS 사원명, 
           DEPARTMENT_ID AS 부서코드, 
           JOB_ID AS 직무코드, 
           HIRE_DATE AS 입사일
      FROM HR.Employees
     WHERE HIRE_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20071231')
     ORDER BY 5;
     
  (사용예) 상품테이블에서 상품의 분류코드가 'P100'번대와 'P300'번대의 상품들을 조회하시오.
           Alias는 상품번호, 상품명, 분류코드, 판매가격
    SELECT PROD_ID AS 상품번호, 
           PROD_NAME AS 상품명, 
           PROD_LGU AS  분류코드, 
           PROD_PRICE AS 판매가격
      FROM PROD
     WHERE PROD_LGU BETWEEN 'P100' AND 'P199'
       OR  PROD_LGU BETWEEN 'P300' AND 'P399'
     ORDER BY 3;        
           