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

   SELECT *
     FROM MEMBER
     WHERE MEM_NAME=RTRIM('이쁜이 '); -->이름에 공백이 들어가면 찾을 수 없다.
                                      --> RTRIM을 쓰면 오른쪽 공백이 사라지기 때문에 찾을 수 있다.
                                      --> 정확히 비교하려면 우선 MEM_NAME이 무슨 타입인지 정확히 확인 해야한다.
                                         
 5) TRIM(c1) *** 
  - 주어진 문자열 좌, 우에 존재하는 무효의 공백을 제거 
  - 단어 내부의 공백은 제거하지 못함
  
 
 
 
 
 
 
 
 
 