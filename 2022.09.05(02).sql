2022-0905-02)동의어 객체(SYNONYM)
 - 오라클 객체에 별칭을 부여할 때 사용
 - 다른 소유자의 객체에 접근하는 경우 "스키마명.객체명" 형식으로
   접근해야함 => 이를 사용하기 쉽고 기억이 용이한 단어로 대신 할 수 있는 방법 제공
   
 (사용형식)
  CREATE [OR REPLACE] SYNONYM 별칭
     FOR 원본 객체명
     
--사용예--
  HR 계정의 EMPLOYEES테이블과 DEPARTMENTS 테이블을 EMP 및 DEPT로 
  별칭을 부여하시오.
  
  CREATE OR REPLACE SYNONYM EMP FOR HR.Employees;
  
  SELECT * FROM EMP;

  CREATE OR REPLACE SYNONYM DEPT FOR HR.Departments;
  
  SELECT * FROM DEPT;

  SELECT A.Employee_Id, A.EMP_NAME, B.DEPARTMENT_NAME
    FROM EMP A, DEPT B
   WHERE B.Department_Id IN(20,30,50,60)
     AND A.Department_Id=B.Department_Id;
  
    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    1 
    
    
    
    
    
                
                    
                        
                            
                                    
                                    
                                    
                                            