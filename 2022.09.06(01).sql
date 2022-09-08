2022-0906-01)PL/SQL
  - 표준 SQL이 가지고 있는 단점(변수, 반복문,분기문 등이 없음)을 보완
  - PROCEDUAL LANGUAGE SQL 
  - BLOCK구조로 구성되어 있음
  - 익명블록(Anonymous Block), Stored Procedure, user defined Function, Trigger,
    Package 등이 제공
  - 모듈화 및 캡슐화 기능 제공 -- 객체언어가 되려면 캡슐화,다형성,상속이 이루어져야한다.
  
  1. 익명블록
  - PL/SQL의 기본 구조 제공
  - 이름이 없어 재 실행(호출)이 불가능
  
  (구성)
    DECLARE
      선언부(변수,상수,커서 선언);
    BEGIN
      실행부:처리할 비지니스 로직을 구현하기 위한 SQL구문, 반복문, 분기문 등으로 구성
      [EXCEPTION
        예외처리 문
       ]
    END;
  - 실행영역에서 사용하는 SELECT문은 
    SELECT 컬럼list
      INTO 변수명[,변수명,...]
      FROM 테이블명
    [WHERE 조건]
    . 컬럼의 개수와 데이터 타입은 INTO절의 변수의 갯수 및 데이터 타입과 동일
  
  1) 변수
     . 개발언어의 변수와 같은 개념
     . SCLAR변수, REFERENCE 변수, COMPOSITE 변수, BINDING 변수 등이 제공

     (사용형식)
     ** SCLAR 변수
     변수명[CONSTANT] 데이터타입 [(크기)] [:=초기값];
      . 데이터타입 : SQL에서 제공하는 데이터 타입, PLS_INTEGER, BINARY_INTEGER, BOOLEAN 등이 제공됨
      . 'CONSTANT' : 상수 선언(반드시 초기값이 설정되어야 함)
      -- PLS_INTEGER, BINARY_INTEGER는 4BYTE로 표현되어지는 정수 <= 처리 속도는 빠르지만 값이 작아서 잘 사용하지 않음
      -- 변수는 = 왼쪽에 올 수 있지만 상수는 = 왼쪽에 올 수 없음.
      -- BOOLEAN은 오라클에서는 TRUE, FALSE, NULL 값을 리턴 받을 수 있다. 변수를 초기화를 시키지 않으면 NULL값이 나옴
     **REFERENCE 변수
        열참조 : 변수명 테이블명.컬럼명%TYPE
        행참조 : 변수명 테이블명%ROWTYPE
        
--사용예--
  키보드로 부서를 입력 받아 해당 부서에 가장 먼저 입사한 사원의 사원번호, 사원명, 직책코드, 입사일을 출력하는 블록을 작성하시오
  ACCEPT P_DID PROMPT '부서번호 입력: '
  DECLARE
    V_DID HR.Departments.DERARTMENT_ID%TYPE;
    V_EID HR.Employees.EMPLOYEE_ID%TYPE; --사원번호
    V_NAME VARCHAR2(100);--사원명
    V_JID HR.JOBS.JOB_ID%TYPE;--직책코드
    V_HDATE DATE;--입사일
  BEGIN
    V_DID := TO_NUMBER('&P_DID');
    SELECT EMPLOYEE_ID,EMP_NAME,JOB_ID,HIRE_DATE
      INTO V_EID, V_NAME, V_JID, V_HDATE
      FROM (SELECT HR.Employees, EMP_NAME, JOB_ID, HIRE_DATE
              FROM HR.Employees 
             WHERE  DEPARTMENT_ID = V_DID
             ORDER BY 4)A
     WHERE ROWNUM=1;
     
     DBMS_OUTPUT.PUT._LINE('사원번호 : '||V_EID);
     DBMS_OUTPUT.PUT._LINE('사원명 : '||V_NAME);
     DBMS_OUTPUT.PUT._LINE('직책코드 : '||V_JID);
     DBMS_OUTPUT.PUT._LINE('입사일 : '||V_DATE);
     DBMS_OUTPUT.PUT._LINE('------------------------------');
  END; 
  
--사용예--
  회원테이블에서 직업이 '주부'인 회원들의 2020년 5월 구매현황을 조회시오
  Alias는 회원번호, 회원명,직업, 구매금액 합계 
    
  SELECT A.MEM_ID AS 회원번호, 
         A.MEM_NAME AS 회원명, 
         A.MEM_JOB AS 직업, 
         D.BSUM AS 구매금액합계
    FROM (SELECT MEM_ID, MEM_NAME, MEM_JOB
            FROM MEMBER
           WHERE MEM_JOB='주부')A,
         (SELECT B.CART_MEMBER AS BMID,
                 SUM(B.CART_QTY*C.PROD_PRICE) AS BSUM
            FROM CART B, PROD C
           WHERE B.CART_PROD=C.PROD_ID
             AND B.CART_NO LIKE '202005%'
           GROUP BY B.CART_MEMBER) D
   WHERE A.MEM_ID = D.BMID        
   
  (익명블록)
  DECLARE
    V_MID MEMBER.MEM_ID%TYPE;
    V_NAME VARCHAR2(100);
    V_JOB MEMBER.MEM_JOB%TYPE;
    V_SUM NUMBER := 0; --27자리까지는 알아서 잡아줌
    CURSOR CUR_MEM IS
     SELECT MEM_ID, MEM_NAME, MEM_JOB
            FROM MEMBER
           WHERE MEM_JOB='주부';
  BEGIN
    OPEN CUR_MEM;
    LOOP 
      FETCH CUR_MEM INTO V_MID, V_NAME, V_JOB;
      EXIT WHEN CUR_MEM%NOTFOUND;
      SELECT SUM(A.CART_QTY*B.PROD_PRICE) INTO V_SUM
        FROM CART A, PROD B
       WHERE A.CART_PROD = B.PROD_ID
         AND A.CART_NO LIKE '202005%'
         AND A.CART_MEMBER = V_MID;
     DBMS_OUTPUT.PUT_LINE('회원번호 : '||V_MID);
     DBMS_OUTPUT.PUT_LINE('회원명 : '||V_NAME);
     DBMS_OUTPUT.PUT_LINE('직업 : '||V_JOB);
     DBMS_OUTPUT.PUT_LINE('구매금액 : '||V_SUM);
     DBMS_OUTPUT.PUT_LINE('-----------------------');
    END LOOP;  
    CLOSE CUR_MEM;
  END;

--사용예--
  년도를 입력 받아 윤년인지 평년인지 구별하는 블록을 작성하시오
  ACCEPT P_YEAR PROMPT '년도입력 : '
  DECLARE 
   V_YEAR NUMBER := TO_NUMBER('&P_YEAR');
   V_RES VARCHAR2(200);
  BEGIN
   IF(MOD(V_YEAR,4) = 0 AND MOD(V_YEAR,100) != 0) OR (MOD(V_YEAR,400) = 0) THEN
      V_RES := V_YEAR ||'년은 윤년입니다.';
   ELSE   
      V_RES := V_YEAR ||'년은 평년입니다.';
   END IF;
   
   DBMS_OUTPUT.PUT_LINE(V_RES);
  END;
  
--사용예--
  반지름을 입력받아 원의 넓이와 원둘레를 구하시오.
  원의 넓이 : 반지름 * 반지름 * 원주율(3.1415926)
  원둘레 : 지름 * 3.1415926
  
  ACCEPT P_RADIUS PROMPT ' 반지름 입력 : '
  DECLARE 
   V_RADIUS NUMBER := 15;
   V_PIE CONSTANT NUMBER := 3.1415926;
   V_AREA NUMBER := 0;
   V_CIRCUM NUMBER := 0;
  BEGIN
    V_AREA := V_RADIUS * V_RADIUS * V_PIE;
    V_CIRCUM := 2* V_RADIUS *V_PIE;
    
    DBMS_OUTPUT.PUT_LINE('원의 너비 ='||V_AREA);
    DBMS_OUTPUT.PUT_LINE('원의 둘레 ='||V_CIRCUM);
END;































