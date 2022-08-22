2022-0822-01)형변환 함수
 - 오라클의 데이터 형변환 함수는 TO_CHAR, TO_DATE, TO_NUMBER, CAST 함수가 제공됨
 - 해당 함수가 사용된 곳에서 일시적 변환
 - 허락되어진 경우만 바꿀 수 있다.
 1) CAST(expr AS type)
  . expr로 제공되는 데이터(수식, 함수, 컬럼 등)를 'type' 형태로 변환하여 반환 함
    
 사용예)
   SELECT BUYER_ID AS 거래처코드,
          BUYER_NAME AS 거래처명1,
          CAST(BUYER_NAME AS CHAR(30)) AS 거래처명2,
          BUYER_CHARGER AS 담당자
     FROM BUYER;
     --> VARCHAR2는 가변길이, CHAR는 고정길이(남는 공간은 공백) -> 바꿀 수 있는 것만 바꿀 수 있음
   (바꿀 수 없는 예)
   SELECT CAST(BUY_DATE AS NUMBER)
     FROM BUYPROD
    WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131');
   (꼭 CAST를 써서 바꾸고 싶다면)
   SELECT CAST(TO_CHAR(BUY_DATE,'YYYYMMDD') AS NUMBER) AS 날짜를숫자로
     FROM BUYPROD
    WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131'); 
   
 2) TO_CHAR(d [,fmt]) -*****
   . 변환함수 중 가장 널리 사용
   . 숫자, 날짜, 문자 타입을 문자타입으로 변환
   . 문자타입은 CHAR, CLOB를 VARCHAR2로 변환할 때만 사용 가능
   . VARCHAR2는 VARCHAR2로 변환할 수 없다.
   . 'fmt'는 형식문자열로 크게 날짜형과 숫자형으로 구분됨
---------------------------------------------------------------------------------------------------------------------   
FORMAT 문자        의미                  사용예 
---------------------------------------------------------------------------------------------------------------------
CC                 세기                  SELECT TO_CHAR(SYSDATE, 'CC')||'세기' FROM DUAL;
AD, BC             기원전,기원후          SELECT TO_CHAR(SYSDATE, 'CC BC')||EXTRACT(YEAR FROM SYSDATE) FROM DUAL;
YYYY,YYY,YY,Y      년도                  SELECT TO_CHAR(SYSDATE, 'YYYY')||'년' FROM DUAL;
YEAR               년도를 알파벳으로      SELECT TO_CHAR(SYSDATE, 'YEAR')||'년' FROM DUAL;
Q                  분기                  SELECT TO_CHAR(SYSDATE, 'Q')||'분기' FROM DUAL; 
MM,RM              월                    SELECT TO_CHAR(SYSDATE, 'YYYY-MM')||'월' FROM DUAL; 
MONTH, MON         월                    SELECT TO_CHAR(SYSDATE, 'YYYY-MON') FROM DUAL;
                                         SELECT TO_CHAR(SYSDATE, 'MONTH') FROM DUAL;
WW, W              주                    SELECT TO_CHAR(SYSDATE, 'W')||'주차' FROM DUAL;
                                         SELECT TO_CHAR(SYSDATE, 'WW')||'주차' FROM DUAL;
DDD,DD,D           일                    SELECT TO_CHAR(SYSDATE, 'D') FROM DUAL;
DAY, DY            요일                  SELECT TO_CHAR(SYSDATE, 'DAY') FROM DUAL;
                                         SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DY') FROM DUAL;   
AM, PM, A.M, P.M   오전/오후             SELECT TO_CHAR(SYSDATE, 'AM') FROM DUAL;
HH,HH12,HH24       시각                  SELECT TO_CHAR(SYSDATE, 'HH24') FROM DUAL;
MI                 분                    SELECT TO_CHAR(SYSDATE, 'HH24:MI') FROM DUAL;
SS,SSSSS           초                    SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') FROM DUAL;
---------------------------------------------------------------------------------------------------------------------  

**숫자형 형식문자 => *숫자로서의 역할은 사라지고 문자열로 바뀜*
--------------------------------------------------------------------------------------------------------------------- 
FORMAT 문자        의미                  사용예 
--------------------------------------------------------------------------------------------------------------------- 
9,0                숫자자료출력           SELECT TO_CHAR(12345.56,'9,999,999.99'),                
                                                 TO_CHAR(12345.56,'0,000,000.00')    FROM DUAL;
--  9=> 유효숫자와 대응 => 숫자출력 / 0=> 유효숫자와 대응 => 숫자출력
--      무효숫자와 대응 => 공백출력 /     무효숫자와 대응 => '0'을출력
-- 소숫점이하 자릿수가 부족할 경우 반올림하여 결과값 출력
, (COMMA)         3자리마다 자리점(,)
. (DOT)            소숫점
&, L               화폐기호               SELECT TO_CHAR(PROD_PRICE, 'L9,999,999')
                                            FROM PROD;
                                          SELECT TO_CHAR(SALARY,'$999,999') AS 급여1 --> ,가 있기 때문에 절대로 숫자가 될 수 없다.
                                                 TO_CHAR(SALARY) AS 급여2
                                            FROM HR.EMPLOYEES;    
PR             음수자료를 '<>'안에 출력    SELECT TO_CHAR(-2500, '99,999PR') FROM DUAL;  --> 형식지정 문자열 가장 오른쪽 끝에 PR을 써야함.
MI       음수자료 출력시 오른쪽에 '-'출력   SELECT TO_CHAR(-2500, '99,999MI') FROM DUAL;

" " 사용자가 직접 정의하는 문자열           SELECT TO_CHAR(SYSDATE, 'YYYY"년" MM"월" DD"일"') --> ""는 컬럼의 별칭을 작성할 때와
                                             FROM DUAL;                                     --> 형식지정 문자열을 기술할 때 사용    
--------------------------------------------------------------------------------------------------------------------- 
   
 3) TO_DATE(c [,fmt]) - *** --> fmt는 기본날짜 타입으로 변경할 수 없는 문자열이 있는 경우 // 문자열만 날짜로 바꿀 수 있음.
  . 주어진 문자열 자료 c를 날짜타입의 자료로 형변환 시킴
  . c에 포함된 문자열 중 날짜자료로 변환될 수 없는 문자열이 포함된 경우
    'fmt'를 사용하여 기본형식으로 변환할 수 있음
  . 'fmt'는 TO_CHAR함수의 '날짜형 형식문자'와 동일
  . 숫자 자료는 절대로 날짜 자료로 바꿀 수 없다.(문자열 자료만 바꿀 수 있음)
 
 사용예)
   SELECT TO_DATE('20200504'),
          TO_DATE('20200504', 'YYYY-MM-DD'),--> -와 /는 날짜 데이터의 기본 타입이기 때문에 써줘도 되고 안써줘도 된다.
          TO_DATE('2020년 08월 22일','yyyy"년" mm"월" dd"일"')
     FROM DUAL;     

 4) TO_NUMBER(c [,fmt]) - *** //문자열만 숫자로 바꿀 수 있음
  . 주어진 문자열 자료 c를 숫자타입의 자료로 형변환 시킴
  . c에 포함된 문자열 중 숫자자료로 변환될 수 없는 문자열이 포함된 경우
    'fmt'를 사용하여 기본 숫자 형식으로 변환할 수 있음
  . 'fmt'는 TO_CHAR함수의 '숫자형 형식문자'와 동일
  
 사용예) 
   SELECT TO_NUMBER('2345') / 7,
          TO_NUMBER('2345.56'),
          TO_NUMBER('2,345', '99,999'), --> 둘 다 ,가 있거나 둘 다 없어야 변환이 가능하다.
          TO_NUMBER('$2345', '$9999'), --> 원본데이터의 형태와 같으면 가능
          TO_NUMBER('002,345', '000,000') AS 무효,
          TO_NUMBER('<2,345>', '9,999PR')
     FROM DUAL;     
 
 
 
 