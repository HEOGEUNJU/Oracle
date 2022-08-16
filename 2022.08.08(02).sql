2022-0808-02)
4. 기타자료형
  - 이진자료를 저장하기 위한 데이터 타입
  - RAW, LONG RAW, BLOB, BFILE 등이 제공됨
  - 이진자료는 오라클이 해석하거나 변환하지 않는다.<= 있는 그대로 이진자료 형태로 저장된다.
  - RAW와 LONG RAW는 크기가 너무 작기 때문에 지금은 잘 사용하지 않는다.
  
  1) RAW
   . 작은 이진자료 저장
   . 최대 2000BYTE까지 저장가능
   . 인덱스 처리가 가능
   . 16진수와 2진수 형태로 저장
  (사용형식)
     컬럼명 RAW(크기)
  (사용예)
     CREATE TABLE TEMP09(
        COL1 RAW(2000));
        
     INSERT INTO TEMP09 VALUES('2A7F');
     INSERT INTO TEMP09 VALUES(HEXTORAW ('2A7F'));
     INSERT INTO TEMP09 VALUES('0010101001111111');
     
     SELECT * FROM TEMP09;


   2) BFILE 
    . 이진자료를 저장
    . 대상이 되는 이진자료를 데이터베이스 외부에 저장하고 데이터베이스에는 경로 정보만 저장
    . 최대 4GB까지 저장 가능
   (사용형식)
    컬럼명 BFILE;
   ** 자료 저장순서**
   1. 자료 준비
       D:\A_TeachingMaterial\02_Oracle\SAMPLE.JPG (절대 경로명)
   2. 테이블 생성
       CREATE TABLE TEMP10(
       COL1 BFILE);
   3. 디렉토리(데이터를 저장할 수 있는 폴더) 객체 생성-경로정보 및 파일명
       디렉토리 객체 생성
       CREATE OR REPLACE DIRECTORY 별칭 AS 경로명;
       CREATE OR REPLACE DIRECTORY TEST_DIR AS 'D:\A_TeachingMaterial\02_Oracle';
   4. 저장
       INSERT INTO TEMP10 VALUES(BFILENAME('TEST_DIR','SAMPLE.JPG'));
     SELECT * FROM TEMP10;
     
     
   3)BLOB(Binaty Large OBjects)
    . 원본 2진 자료를 테이블 내부에 저장
    . 4GB까지 저장 가능
   (사용형식)
    컬럼명 BLOB;
   (사용예) 
      CREATE TABLE TEMP11(
        COL1 BLOB);
   데이터 삽입
    DECLARE
     L_DIR VARCHAR2(20):='TEST_DIR';
     L_FILE VARCHAR2(30):='SAMPLE.JPG';
     L_BFILE BFILE;
     L_BLOB BLOB;
    BEGIN
     INSERT INTO TEMP11 VALUES(EMPTY_BLOB())
       RETURN COL1 INTO L_BLOB;
       
     L_BFILE:=BFILENAME(L_DIR,L_FILE);
     
     DBMS_LOB.FILEOPEN(L_BFILE,DBMS_LOB.FILE_READONLY);
     DBMS_LOB.LOADFROMFILE(L_BLOB,L_BFILE,DBMS_LOB.GETLENGTH(L_BFILE));
     DBMS_LOB.FILECLOSE(L_BFILE);
     
     COMMIT;
     END;
     
     SELECT * FROM TEMP11;
     
     
     
     
     
     
     
     
     
     