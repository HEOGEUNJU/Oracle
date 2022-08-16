2022-0805-01)데이터 타입
    - 오라클에는 문자열, 숫자, 날짜, 이진수 자료타입이 제공

 1. 문자 데이터타입
    . 오라클의 문자자료는 ' '안에 기술된 자료
    . 대소문자 구별
    . CHAR, VARCHAR(대부분의 DB에서 사용하는 가변길이), VARCHAR2(오라클에서만 사용), NVARCHAR2(다국어지원할 때 사용), 
      LONG(2GB짜리 문자열 저장할 때 사용), CLOB(4GB짜리 문자열 저장할 때 사용), NCLOB 등이 제공됨
      --CHAR을 제외한 나머지는 가변길이
      
      
   1) CHAR(n<= 숫자 정수형[BYTE|CHAR]) []의 내용은 써도 좋고 안써도 좋다. 
     - 고정길이 문자열 저장
     - 최대 2000BYTE까지 저장가능
     - 'n[BYTE|CHAR]' : '[BYTE|CHAR]'이 생략되면 BYTE로 취급
       'CHAR'은  n글자수까지 저장
     - 한글 한 글자는 3BYTE로 저장
     - 기본키나 길이가 고정된 자료(주민번호, 우편번호)의 정당성을 확보하기 위해 사용
       └입력 받은 자릿수를 통해서 자료의 정확성을 좀 더 빨리 확인 가능
     - 컬럼에 저장 할 수 있는 최대 글자수 : 영문자 기준으로 2000자까지 저장되고 한글은 666글자까지만 저장된다.
     
    사용예시)
       CREATE TABLE TEMP01(
        COL1 CHAR(10),
        COL2 CHAR(10 BYTE),
        COL3 CHAR(10CHAR));
       
       INSERT INTO TEMP01 VALUES('대한', '대한민', '대한민국');
     
     SELECT *FROM TEMP01
     
     SELECT LENGTHB(COL1) AS COL1,
            LENGTHB(COL2) AS COL2,
            LENGTHB(COL3) AS COL3
        FROM TEMP01;                    <== COL1,2은 10BYTE로 공간을 잡아서 10이고 COL3은 한글 12BYTE에 남은 글자수 6글자 
                                            를 영문으로 계산해서 총 18BYTE가 나온다
     
    2) VARCHAR2(n[BYTE|CHAR])
      - 가변길이 문자열 자료 저장
      - 최대 4000BYTE까지 저장 가능
      - VARCHAR, NVARCHAR2와 저장형식을 동일
     
    사용예시)
       CREATE TABLE TEMP15(
        COL1 CHAR(20),
        COL2 VARCHAR2(2000 BYTE),
        COL3 VARCHAR2(4000 CHAR));
        
       INSERT INTO TEMP02 VALUES('ILPOSTINO', 'BOYHOOD', '무궁화 꽃이 피었습니다-김진명');
       
     SELECT * FROM TEMP02;     
     
     SELECT LENGTHB(COL1) AS COL1,
            LENGTHB(COL2) AS COL2,  
            LENGTHB(COL3) AS COL3,
            LENGTH(COL1) AS COL1,
            LENGTH(COL2) AS COL2,
            LENGTH(COL3) AS COL3
        FROM TEMP02;    
            
    3) LONG 
      - 가변길이 문자열 자료 저장
      - 최대 2GB까지 저장 가능 <== 500,600페이지의 E-BOOK이 3~400MB
      - 한 테이블에 한 컬럼만 LONG타입 사용 가능 <== 치명적인 단점
      - 현재 기능 개선서비스 종료(오라클 8i) => CLOB로 Upgrade 
         └사용은 가능함(기존에 사용하던 버전들을 위해서)
    
    사용형식)
       컬럼명 LONG
       . LONG 타입으로 저장된 자료를 참조하기 위해 최소 31bit(굉장히 큰거임)가 필요
         =>일부 기능(LENGTHB 등의 함수)이 제한
       . SELECT문의 SELECT절, UPDATE의 SET절, INSERT문의 VALUES절에서 사용 가능
       
    사용예시)
       CREATE TABLE TEMP03 (
        COL1 VARCHAR2(2O00),
        COL2 LONG);     
    
    FROM dual
     
     INSERT INTO TEMP03 VALUES('대전시 중구 계룡로 846','대전시 중구 계룡로 846')
     
     SELECT SUBSTR(COL2),
           -- SUBSTR(COL2,8,3)
       FROM TEMP03;     
     
    SELECT * FROM TEMP03;
     
    4) CLOB(Character Large OBjects)
      - 대용량의 가변길이 문자열 저장
      - 최대 4GB까지 처리 가능
      - 한 테이블에 복수개의 CLOB 타입 정의 가능
      - 일부 기능은 DBMS_LOB API(Application Programming Interface)에서 제공하는 함수 사용
      
    사용형식)  
       컬러명 CLOB 
       
    사용예시)
       CREATE TABLE TEMP04(
          COL1 VARCHAR2(255),
          COL2 CLOB,
          COL3 CLOB);
     
     INSERT INTO TEMP04 VALUES('APPLE BANANA PERSIMMON','APPLE BANANA PERSIMMON','APPLE BANANA PERSIMMON');
     
    
     SELECT * FROM TEMP04;
    
     SELECT SUBSTR(COL1,7,6) AS COL1,
            SUBSTR(COL3,7,6) AS COL3,
            --LENGTHB(COL2) AS COL4,
            DBMS_LOB.GETLENGTH(COL2) AS COL4, -- 글자수 반환
            DBMS_LOB.SUBSTR(COL2,7,6) AS COL2
       FROM TEMP04;
     
     
     
     
     
     
     
     
       
     