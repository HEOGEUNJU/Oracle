2022-0822-02)집계함수
 - 대상 데이터를 특정 컬럼을 기준으로 그룹으로 분할하여 각 그룹에 대하여 합계(SUM), 평균(AVG), 자료 수(COUNT), 
   최대값(MAX), 최소값(MIN)을 반환하는 함수 <-- 다중행 함수(결과값이 만들어진 그룹의 갯수만큼 나옴)
 기술형식)
   SELECT [컬럼명1 [,] --> SELECT절만 주의깊게 보면 집계함수 쓰는 걸 틀릴 수가 없다.
             :    
          [컬럼명n]
          SUM|AVG|COUNT|MAX|MIN
     FROM 테이블명
   [WHERE 조건]
   [GROUB BY 컬럼명1,...,컬럼명n] --> 일반컬럼이 사용된 경우에는 필수적으로 써야한다. 아니면 안써도 상관 엑
  [HAVING 조건]
  
 - SELECT 절에서 집계함수만 사용된 경우에는 GROUP BY절의 사용이 필요없음
 - SELECT 절에 집계함수 이외의 컬럼이 기술된 경우 (일반함수 포함) 반드시 GROUP BY절이 기술되어야하고 GROUP BY
   다음에 모든 일반컬럼을 ','로 구분하여 기술해야함
 - SELECT 절에 사용되지 않은 컬럼도 해당 테이블에만 있다면 GROUP BY 절에 사용 가능  
 - 집계함수에 조건이 부여될 때에는 반드시 HAVING절로 조건처리를 수행해야함  
 
 1) SUM(column | expr) 
  . 기술된 컬럼의 값이나 수식의 결과를 모두 합한 결과 반환
  
  SELECT PROD_COST
  FROM   PROD
  ORDER BY 1;

  SELECT AVG(DISTINCT PROD_COST) --AS "중복된 값은 제외",
       , AVG(All PROD_COST) --AS "DEFALT로써 모든 값을 포함",
       , AVG(PROD_COST) -- AS "매입가 평균"
    FROM PROD;   
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  