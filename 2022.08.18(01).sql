2022-0818-01)
2. 숫자함수
  - 제공되는 숫자함수로는 수학적 함수(ABS, SIGN, SQRT 등), GREATEST, ROUND, MOD, 
    FLOOR, WIDTH_BUCKET 등이 있음
 1) 수학적 함수
   (1) ABS(n), SIGN(n), POWER(e, n), SQRT(n) - *
     - ABS : n의 절대값 반환
     - SIGN : n의 양수이면 1, 음수이면 -1, 0이면 0을 반환 // 값의 크기는 상관X
     - POWER : e의 n승 값(e의 n번 곱한 값)
     - SQRT : n의 평방근
       
  사용예)
   SELECT ABS(10), ABS(-100), ABS(0),
          SIGN(-20000), SIGN(-0.0099), SIGN(0.000005), SIGN(500000), SIGN(0),
          POWER(2,10),
          SQRT(3.3)
     FROM DUAL;
 
 2) GREATEST(n1,n2[,...n]), LEAST(n1,n2[,...n])
  - 주어진 값 n1~n 사이의 값 중 제일 큰 값(GREATEST), 제일 작은 값(LEAST) 반환
  
  사용예)
   SELECT GREATEST('KOREA', 1000, '홍길동'),
          LEAST('대전시','ABC','200')
     FROM DUAL;     
 
 
   SELECT ASCII('홍길동')
     FROM DUAL;
 --MAX는 하나의 컬럼에서 열에서 가장 큰 값을 찾는 것이고 GREATEST는 행에서 가장 큰 값을 찾는 것임
 
  사용예) 회원테이블에서 마일리지가 1000미만인 회원을 찾아 1000으로 변경 출력하시오
        Alias는 회원번호, 회원명, 원본마일리지, 변경된마일리지
   SELECT MEM_ID AS 회원번호, 
          MEM_NAME AS 회원명, 
          MEM_MILEAGE AS 원본마일리지,
          GREATEST(MEM_MILEAGE,1000) AS 변경된마일리지
     FROM MEMBER;
 
 3) ROUND(n [,l]), TRUNC(n [,l]) - ****
   - 주어진 자료 n에서 소숫점 이하 l+1자리에서 반올림하여(ROUND) 또는 자리버림(TRUNC) 
     하여 1자리까지 표현함
   - l이 생략되면 0으로 간주됨
   - l이 음수이면 소숫점 이상의 L자리에서 반올림 또는 자리 버림 수행
   
 사용예)
  SELECT ROUND(12345.678945,3),
         ROUND(12345.678945),
         ROUND(12345.678945,-3) --소숫점 이하는 반올림하면 다 짤린다.
    FROM DUAL;  
    
  SELECT TRUNC(12345.678945,3),
         TRUNC(12345.678945),
         TRUNC(12345.678945,-3)
    FROM DUAL;       
         
 사용예) HR계정의 사원테이블에서 사원들의 근속연수를 구하여 근속연수에 따른 근속 수당을
         계산하시오.
         근속수당 = 기본급(SALALY) * (근속년수/100)
         급여합계 = 기본급 + 근속수당
         세금 = 급여합계의 13%
         지급액 = 급여합계 - 세금이며 소수 둘째자리에서 반올림하시오.
         Alias는 사원번호, 사원명, 입사일, 근속년수, 급여, 근속수당, 세금, 지급액
          
         SELECT EMPLOYEE_ID AS 사원번호, 
                FIRST_NAME || LAST_NAME AS 사원명, 
                HIRE_DATE AS 입사일, 
                TRUNC((SYSDATE-HIRE_DATE)/365) AS 근속년수,
                SALARY AS 기본급여, 
                ROUND(SALARY*(TRUNC((SYSDATE-HIRE_DATE)/365)/100),1) AS 근속수당,
                ROUND(((SALARY + SALARY*(TRUNC((SYSDATE-HIRE_DATE)/365)/100))*0.13),1) AS 세금,
                ROUND(SALARY + SALARY*(TRUNC((SYSDATE-HIRE_DATE)/365)/100) 
                - ((SALARY + SALARY*(TRUNC((SYSDATE-HIRE_DATE)/365)/100))*0.13),1) AS 지급액
           FROM HR.Employees;
           
 4) FLOOR(n) , CEIL(n)  -*
  - 보통 화폐에 관련된 데이터 처리에 사용
  - FLOOR : n과 같거나 (n이 정수인 때) n보다 작은 정수 중 가장 큰 정수
  - CEIL : n과 같거나 (n이 정수인 때) n보다 큰 정수 중 가장 작은 정수
            
 사용예)
  SELECT FLOOR(23.456), FLOOR(23), FLOOR(-23.456),
         CEIL(23.456), CEIL(23), CEIL(-23.456)
    FROM DUAL
 
 5) MOD(n,b), REMAINDER(n,b) - ***
  - 나머지를 반환
  - MOD : 일반적 나머지 반환
  - REMAINDER : 나머지의 크기가 b값의 절반보다 작으면 일반적 나머지를 반환하고,
                b값의 절반보다 크면 다음 몫이 되기 위한 값에서 현재값(n)을 뺀 값 반환
  - MOD와 REMAINDER는 내부 처리가 다름
        
   . MOD (n,b) : n - b * FLOOR(n/b)
   . REMAINDER (n,b) : n - b * ROUND(n/b)
  ex) MOD(23,7), REMAINDER(23,7)
      MOD(23,7) = 23 - 7 * FLOOR(23/7)
                = 23 - 7 * FLOOR(3.286)
                = 23 - 7 * 3
                = 2
      REMAINDER(23,7) = 23 - 7 * ROUND(23/7)
                      = 23 - 7 * ROUND(3.286) 
                      = 23 - 7 * 3
                      = 2      
  ex) MOD(26,7), REMAINDER(26,7)    
      MOD(26,7) = 26 - 7 * FLOOR(26/7)
                = 26 - 7 * FLOOR(3.714)
                = 26 - 7 * 3
                = 5     
               
      REMAINDER(26,7) = 26 - 7 * ROUND(26/7)
                      = 26 - 7 * ROUND(3.714) 
                      = 26 - 7 * 4
                      = -2            
 6) WIDTH_BUCKET(n, min, max, b)
  - 최소값 min에서 최대값 max까지 b개의 구간으로 나누었을 때 n이 어느 구간에
    속하는지를 판단하여 구간의 INDEX 값을 반환
  - n < min 인 경우 0을 반환하고 n >= 인 경우 b+1 값을 반환  
               
 사용예)
  SELECT WIDTH_BUCKET(28,10,39,3),
         WIDTH_BUCKET(8,10,39,3),
         WIDTH_BUCKET(88,10,39,3),
         WIDTH_BUCKET(39,10,39,3),
         WIDTH_BUCKET(10,10,39,3)
    FROM DUAL;
               
 사용예) 회원테이블에서 회원들의 마일리지를 조회하여 1000-9000 사이를 3개의 구간으로 구분하고 
         회원번호, 회원명, 마일리지, 비고를 출력하되 비고에는 
         마일리지가 많은 회원부터 '1등급 회원', '2등급 회원', '3등급 회원', '4등급 회원'을 출력하시오
               
  SELECT MEM_ID AS 회원번호, 
         MEM_NAME AS 회원명, 
         MEM_MILEAGE AS 마일리지, 
         4-WIDTH_BUCKET(MEM_MILEAGE,1000,9000,3)||'등급 회원' AS 비고
         --WIDTH_BUCKET(MEM_MILEAGE,9000,999
         ,3)||'등급 회원' AS 비고
    FROM MEMBER;
   
               
               
               
               
               
 