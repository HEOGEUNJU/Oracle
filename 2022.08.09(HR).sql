

**EMPLOYEES테이블에 새로운 컬럼(EMP_NAME), 데이터 타입은 VARCHAR2(80)인 컬럼을 추가
  ALTER TABLE 테이블명 ADD (컬러명 데이터타입[(크기)][DEFAULT 값])
  ALTER TABLE EMPLOYEES ADD(EMP_NAME VARCHAR2(80));
  
**UPDATE 문 => 저장된 자료를 수정할 때 사용
  UPDATE 테이블명 
    SET 컬럼명=값[,]
        컬럼명=값[,]
            : 
        컬럼명=값
  [WHERE 조건]      <== WHERE절을 안쓰면 모든 행을 다 같은 값으로 변경한다.
                        EX) 총원을 다 변경하려면 안써도 되고 일부만 변경할 거라면 써야한다.
                        
  UPDATE HR.Employees                             <= 전부 다 바꿔줄 거라서 WHERE절 생략 가능
     SET EMP_NAME=First_Name||' '||LAST_NAME;     
    
  SELECT Employee_Id,
         EMP_NAME
    FROM EMPLOYEES;
  
  사용예) 사원테이블(Employees)부서번호가 50번인 사원들을 조회하시오.
          Alias는 사원번호, 사원명, 부서번호, 급여이다.
    
  SELECT 사원번호, 사원명, 부서번호, 급여
    FROM Employees
    
    COMMIT;