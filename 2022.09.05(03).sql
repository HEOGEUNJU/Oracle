2022-0905-03) 인덱스(INDEX) 객체
 - 자료검색을 효율적으로 수행하기 위한 객체
 - DBMS의 성능개선에 도움
 - B-TREE(Binary Tree) 개념이 적용되어 동일 시간 안에 모든 자료 검색을 담보함
 - 데이터 검색, 삽입, 변경시 필요자료 선택의 효율성 증대
 - 정렬과 그룹화의 성능 개선에 도움
 - 인덱스 구성에 자원이 많이 소요됨
 - 지속적인 데이터 변경이 발생되면 인덱스파일 갱신에 많은 시간 소요
 - 인덱스의 갯수는 적당히 만들어야 한다.
 - 인덱스의 종류
 . Unique(기본키가 아니므로 null값이 올 수 있음) / Non Unique Index
 . Single(한 컬럼으로 만들어지는 것) / Composite Index(여러가지 컬럼을 조합해서 인덱스가 만들어지는 것)
 . Normal(보통 만드는 인덱스 B-TREE개념 사용) / Bitmap(bit를 mapping해서 만든 인덱스-2진수의 자료를 이용해서 만듬) 
   / Function-Based Normal Index
  
 -In Order 운행
  . left - root - right 형식
  
  (사용형식)
  CREATE [UNIQUE|BITMAP] INDEX 인덱스명
    ON 테이블명(컬럼명[,컬럼명,...])[ASC|DESC]
    
--사용예--
  회원테이블에서 이름컬럼으로 인덱스를 구성하시오
  CREATE INDEX IDX_NAME
    ON MEMBER(MEM_NAME);
    
  SELECT *
    FROM MEMBER
   WHERE MEM_NAME = '배인정'; 
   
  --인덱스 삭제 
    DROP INDEX IDX_NAME;
    
  CREATE INDEX IDX_REGNO
    ON MEMBER(SUBSTR(MEM_REGNO2,2,4));
  (함수가 적용된 인덱스기 때문에 인덱스 타입은 FUNCTION-BASED NORMAL이다)
  
  SELECT *
    FROM MEMBER
   WHERE SUBSTR(MEM_REGNO2,2,4) = '4558' 
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  