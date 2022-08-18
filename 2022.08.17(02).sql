2022-0817-02
 4) LTRIM(c1 [,c2]), RTRIM(c1 [,c2]) **
   - 주어진 문자열 c1의 왼쪽부터(LTRIM) 또는 오른쪽부터(RTRIM) c2 문자열을 찾아
     찾은 문자열을 삭제함
   - 반드시 첫 글자부터 일치해야함
   - c2가 생략되면 공백을 찾아 삭제
   - c1 문자열 내부의 공백은 제거할 수 없음
   
 사용예)
   SELECT LTRIM('APPLEAP PERSIMMON BANANA','APLE'), -- 문자열 내부의 공백은 제거할 수 없다.
          LTRIM('APPLEAP PERSIMMON BANANA'),
          LTRIM('APLEAP PERSIMMON BANANA','AP') -->문자열 안에 같은 문자이면 다 지운다. 
                                                -->그래서 LEAP가 됨

     FROM DUAL

   SELECT RTRIM('APPLEAPPERSIMMON BANANA','APLEN'),
          RTRIM('APPLEAP PERSIMMON BANANA'),
          RTRIM('APLEAP PERSIMMON BANANA','AN') 

     FROM DUAL

   SELECT 
     FROM MEMBER
     WHERE MEM_NAME=RTRIM('이쁜이 '); -->이름에 공백이 들어가면 찾을 수 없다.
                                      --> RTRIM을 쓰면 오른쪽 공백이 사라지기 때문에 찾을 수 있다.
                                      --> 정확히 비교하려면 우선 MEM_NAME이 무슨 타입인지 정확히 확인 해야한다.
                                         
 5) TRIM(c1) *** 
  - 단어 내부의 공백은 제거하지 못함
  - 주어진 문자열 c1에 포함된 무효의 공백(오른쪽과 왼쪽)을 제거함
  
 사용예) 직무테이블(JOBS)에서 직무명(JOB_TITLE)'Accounting Manager'인 직무를 조회하시오.
   SELECT JOB_ID AS 직무코드, 
          LENGTHB(JOB_TITLE) AS "직무명의 길이", 
          JOB_TITLE AS 직무명,
          MIN_SALARY AS 최저급여, 
          MAX_SALARY AS 최고급여
     FROM HR.JOBS
    WHERE TRIM(JOB_TITLE)= 'Accounting Manager';
   
 사용예) JOBS테이블의 직무명의 데이터 타입을 VARCHAR2(40)으로 변경하시오
 --테이블을 가변길이 --> 고정길이 --> 가변길이로 변경하면 고정길이에 있던
 --빈 공간도 데이터로 인식 되기 때문에 칸을 차지하게 된다.
  EX) VARCHAR2 => CHAR => VARCHAR2
  
   UPDATE HR.JOBS
      SET JOB_TITLE=TRIM(JOB_TITLE);
      
   COMMIT; 
 
 6) SUBSTR(c1,m[,n] -*****
   - 주어진 문자열 c1에서 m번째에서 n개의 문자를 추출
   - m은 시작 위치를 나타내며 1부터 counting함
   - n은 추출할 문자의 수로 생략하면 m번째 이후 모든 문자를 추출
   - m이 음수이면 오른쪽부터 counting함
   
 사용예)
    SELECT SUBSTR('ABCDEFGHIJK',3,5),
           SUBSTR('ABCDEFGHIJK',3),
           SUBSTR('ABCDEFGHIJK',-3,5),
           SUBSTR('ABCDEFGHIJK',3,15)
      FROM DUAL;      
-- ('ABCDEFGHIJK',3,15) 3, 뒤에 나오는 수가 생략 되어지거나 전체 글자수 보다 크면 남아있는 거 
-- 다 추출하라는 소리에용~

 사용예) 회원테이블의 주민번호 필드(MEM_REGNO1, MEM_REGNO2)를 이용하여 회원들의
         나이를 구하고, 회원번호, 회원명, 주민번호, 나이를 출력하시오.
    SELECT MEM_ID AS 회원번호, 
           MEM_NAME AS 회원명, 
           MEM_REGNO1||'_'||MEM_REGNO2 AS 주민번호, 
           CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN ('1','2') THEN  --CASE WHEN 조건 THEN ELSE END => IF대신 사용
                2022-(TO_NUMBER(SUBSTR(MEM_REGNO1,1,2)) + 1900)
           ELSE
                2022-(TO_NUMBER(SUBSTR(MEM_REGNO1,1,2)) + 2000)
           END AS 나이
      FROM MEMBER;
      
      
 사용예) 오늘이 2020년 4월 1일이라고 가정하여 'c001'회원이 상품을 구매할 때
         필요한 장바구니 번호를 생성하시오. MAX()함수 사용, TO_CHAR()함수사용
    SELECT '20200401'||TRIM(TO_CHAR(MAX(TO_NUMBER(SUBSTR(CART_NO,9))) +1,'00000'))
      FROM CART
     WHERE SUBSTR(CART_NO,1,8) = '20200401';
     
    SELECT MAX(CART_NO)+1 AS "    장바구니번호"
      FROM CART
     WHERE SUBSTR(CART_NO,1,8) = '20200401'; 
     
 사용예) 이번달 생일인 회원들을 조회하시오
         Alias는 회원번호, 회원명, 생년월일, 생일
         단, 생일은 주민등록번호를 이용할 것
    SELECT MEM_ID AS 회원번호, 
           MEM_NAME AS 회원명, 
           MEM_REGNO1 AS 생년월일, 
           SUBSTR(MEM_REGNO1,3,2)||'월'||SUBSTR(MEM_REGNO1,5,2)||'일' AS 생일
      FROM MEMBER
     WHERE SUBSTR(MEM_REGNO1,3,2) = '09'; 
     
 7) REPLACE(c1, c2 [,c3]) - **
   - 주어진 문자열 c1에서 c2문자열을 찾아 c3문자열로 치환
   - c3가 생략되면 c2를 삭제함
   - 단어 내부의 공백제거 가능 => c2에 공백을 입력하면 단어 내부의 공백을 모두 지운다
   
 사용예) --전화번호 작정할 때 - , . , 띄어쓰기 등 중구난방으로 사용하는 걸 하나로 통일시키기 위해 사용
   SELECT REPLACE('APPLE  PERSIMMON BANANA','A','에이') AS ONE,
          REPLACE('APPLE  PERSIMMON BANANA','A') AS TWO,
          REPLACE(' APPLE  PERSIMMON BANANA ',' ','-') AS THREE,
          REPLACE(' APPLE  PERSIMMON BANANA ',' ') AS FOUR -- 단어 내부의 공백을 제거하기 위해 이 유형을 가장 많이 사용한다.
     FROM DUAL;     
   
 
 