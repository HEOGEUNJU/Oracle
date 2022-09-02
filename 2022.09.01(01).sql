2022-0901-01)
  ** 재고수불테이블 생성
  1) 테이블명 : REMAIN
  2) 컬럼명
  ----------------------------------------------------------------------------
   컬럼명             데이터타입              NULLLABLE            PK, FK
  ----------------------------------------------------------------------------
  REMAIN_YEAR          CHAR(4)                                      PK    --년도
  PROD_ID            VARCHAR2(10)                                   PK&FK --상품코드
  REMAIN_J_OO          NUMBER(5)            DEFAULT 0       --기초재고
  REMAIN_I             NUMBER(5)                            --입고수량
  REMAIN_O             NUMBER(5)                            --출고수량
  REMAIN_J_99          NUMBER(5)            DEFAULT 0       --기말(현)재고
  REMAIN_DATE          DATE                 DEFAULT SYSDATE --수정일자
  ----------------------------------------------------------------------------
  
  CREATE TABLE REMAIN(
  REMAIN_YEAR          CHAR(4),
  PROD_ID            VARCHAR2(10),
  REMAIN_J_OO          NUMBER(5) DEFAULT 0,
  REMAIN_I             NUMBER(5),
  REMAIN_O             NUMBER(5),
  REMAIN_J_99          NUMBER(5) DEFAULT 0,
  REMAIN_DATE          DATE DEFAULT SYSDATE,
  
  CONSTRAINT PK_REMAIN PRIMARY KEY(REMAIN_YEAR, PROD_ID),
  CONSTRAINT FK_REMAIN_PROD FOREIGN KEY(PROD_ID) REFERENCES PROD(PROD_ID));
  
  ** 재고수블테이블(REMAIN)에 다음 자료를 입력하세요
  년도 : 2020년
  상품코드 : PROD 테이블의 모든 상품코드
  기초재고 : PROD 테이블의 적정재고량(PROD_PROPERSTOCK)
  입고/출고수량 : 0
  기말재고 : PROD 테이블의 적정재고량(PROD_PROPERSTOCK)
  갱신일자 : 2020년 1월 1일
  
  1) INSERT문과 SUBQUERY
   .  '( )' 사용하지 않음
   . VALUES 절을 생략하고 서브쿼리를 기술
   
   INSERT INTO REMAIN(REMAIN_YEAR,PROD_ID,REMAIN_J_00,REMAIN_I,REMAIN_O,REMAIN_J_99,REMAIN_DATE)
     SELECT '2020',PROD_ID,PROD_PROPERSTOCK,0,0,PROD_PROPERSTOCK,TO_DATE('20200101')
       FROM PROD;
 
 
  ALTER TABLE REMAIN 
  RENAME COLUMN REMAIN_J_OO TO REMAIN_J_00;
  
  2) 서브쿼리를 이용한 UPDATE문
  (사용형식)
    UPDATE 테이블명
       SET (컬럼명1[,컬럼명2,...])=(서브쿼리)
    [WHERE 조건]
     . SET 절에서 변경시킬 컬럼이 하나 이상이 있는 경우 보통 ( ) 안에 컬럼명을 기술하며 
       서브쿼리의 SELECT 절의 컬럼들이 기술된 순서대로 1대1 대응되어 할당됨
     . SET 절에서 ()를 사용하지 않으면 변경시킬 컬럼마다 서브쿼리를 기술해야함
  
--사용예--
  2020년 1월 상품들의 매입집계를 이용하여 재고수불테이블을 갱신하시오
  작업일자는 2020년 1월 31일이다
  (메인쿼리 : 재고수블테이블을 갱신)
   UPDATE REMAIN A
      SET (REMAIN_I, REMAIN_J__,REMAIN_DATE)=
          (서브쿼리 : 2020년 1월 제품별 매입수량집계)
    WHERE A.PROD_ID IN( SELECT BUY_PROD 
                          FROM BUYPROD
                         WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')   
  (서브쿼리 : 2020년 1월 제품별 매입수량집계)
   SELECT BUY_PROD,
          SUM(BUY_QTY)
     FROM BUYPROD
    WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')
    GROUP BY BUY_PROD 
  (결합)
   UPDATE REMAIN A
      SET (A.REMAIN_I,A.REMAIN_J_99,A.REMAIN_DATE)=
          (SELECT A.REMAIN_I+B.BSUM, 
                  A.REMAIN_J_99 + B.BSUM, 
                  TO_DATE('20200131')
             FROM (SELECT BUY_PROD, SUM(BUY_QTY) AS BSUM
                     FROM BUYPROD
                    WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')
                    GROUP BY BUY_PROD
                    ORDER BY 1)B
            WHERE A.PROD_ID = B.BUY_PROD
         )        
    WHERE A.PROD_ID IN(SELECT BUY_PROD
                         FROM BUYPROD
                        WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131'))
  
  
  
  
  
  
  COMMIT;
  ROLLBACK;
  
--사용예--
  2020년 2-3월 상품들의 매입집계를 이용하여 재고수불테이블을 갱신하시오
  작업일자는 2020년 3월 31일이다  
  
   UPDATE REMAIN A
      SET (A.REMAIN_I,A.REMAIN_J_99,A.REMAIN_DATE)=
          (SELECT A.REMAIN_I+B.BSUM, 
                  A.REMAIN_J_99 + B.BSUM, 
                  TO_DATE('20200331')
             FROM (SELECT BUY_PROD, SUM(BUY_QTY) AS BSUM
                     FROM BUYPROD
                    WHERE BUY_DATE BETWEEN TO_DATE('20200201') AND TO_DATE('20200331')
                    GROUP BY BUY_PROD
                    ORDER BY 1)B
            WHERE A.PROD_ID = B.BUY_PROD
         )        
   WHERE A.PROD_ID IN(SELECT BUY_PROD
                        FROM BUYPROD
                       WHERE BUY_DATE BETWEEN TO_DATE('20200201') AND TO_DATE('20200331'))  

--사용예--
  2020년 4-7월 매입매출집계를 이용하여 재고수불테이블을 갱신하시오
  작업일자는 2020년 8월 1일이다  
  
  (메인쿼리 : 재고수블테이블을 갱신)
   UPDATE REMAIN A
      SET (REMAIN_I, REMAIN_J__99,REMAIN_DATE)=
          (서브쿼리 : 2020년 4월 제품별 매입매출집계)
    WHERE A.PROD_ID IN( SELECT BUY_PROD 
                          FROM BUYPROD
                         WHERE BUY_DATE BETWEEN TO_DATE('20200401') AND TO_DATE('2020430')  
  (서브쿼리 : 2020년 4~7월 제품별 매입매출집계)
   SELECT C.PROD_ID, 
          SUM(A.BUY_QTY) AS BSUM,
          SUM(B.CART_QTY) AS CSUM
     FROM BUYPROD A, CART B, PROD C
    WHERE B.CART_PROD = C.PROD_ID
      AND A.BUY_PROD = C.PROD_ID
      AND BUY_DATE BETWEEN TO_DATE('20200401') AND TO_DATE('20200730')
    GROUP BY PROD_ID
    ORDER BY 1;
    
    
  (결합)  
  
  
  
 ------------------- 
  (매입)
  UPDATE REMAIN A
     SET (A.REMAIN_I,A.REMAIN_J_99,A.REMAIN_DATE)=
         (SELECT A.REMAIN_I+B.BSUM,
               A.REMAIN_J_99+B.BSUM,
               TO_DATE('20200801')
           FROM (SELECT BUY_PROD, SUM(BUY_QTY) AS BSUM
                  FROM BUYPROD
                 WHERE BUY_DATE BETWEEN TO_DATE('20200401') AND TO_DATE('20200731') 
                 GROUP BY BUY_PROD)B
         WHERE A.PROD_ID=B.BUY_PROD)
    WHERE A.PROD_ID IN(SELECT BUY_PROD
                         FROM BUYPROD
                        WHERE BUY_DATE BETWEEN TO_DATE('20200401') AND TO_DATE('20200731'));
                       
   (매출)        
   UPDATE REMAIN A --테이블 별칭을 쓸 수 있다
           SET (A.REMAIN_O,A.REMAIN_J_99,A.REMAIN_DATE)=
                (SELECT A.REMAIN_O+CSUM,
                        A.REMAIN_J_99-CSUM,
                        TO_DATE('20200801')
                   FROM (SELECT CART_PROD, 
                               SUM(CART_QTY) AS CSUM
                         FROM CART 
                        WHERE SUBSTR(CART_NO,1,6) BETWEEN '202004' AND '202007'   
                     GROUP BY CART_PROD) C
             WHERE  A.PROD_ID=C.CART_PROD)
        WHERE  A.PROD_ID IN(SELECT CART_PROD
                              FROM CART
                             WHERE SUBSTR(CART_NO,1,6) BETWEEN '202004' AND '202007');                                  
         
         (4-7사이의 매입집계)B
         SELECT BUYPROD, SUM(BUY_QTY) AS BSUM
           FROM BUYPROD
          WHERE BUY_DATE BETWEEN TO_DATE('20200401') AND TO_DATE('2020731') 
          GROUP BY BUY_PROD
          
         (4-7사이의 매출집계)C
          SELECT CART_PROD, SUM(CART_QTY) AS CSUM
           FROM CART
          WHERE SUBSTR(CART_NO,1,6) BETWEEN '202004' AND '202007'
          GROUP BY CART_PROD
          
 3) 서브쿼리를 이용한 DELETE문
 (사용형식)
 DELETE FROM 테이블명
  WHERE 조건
  
  -'조건'에 IN이나 EXISTS 연산자를 사용하여 서브쿼리를 적용
  
--사용예--  
  장바구니테이블에서 2020년 4월 'm001'회원의 구매자료 중 'P202000005'제품의 구매내역을 삭제하시오
  DELETE FROM CART A
   WHERE EXISTS (SELECT 1
                   FROM MEMBER B
                  WHERE B.MEM_ID = 'm001'
                    AND B.MEM_ID = A.CART_MEMBER)
     AND A.CART_NO LIKE '202004%'
     AND A.CART_PROD='P202000005'
          
          
         
         
         
         
  
  
  