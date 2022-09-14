2022-0913-01)Ʈ����(trigger) --�ڽ� ���� �� �����
 - Ư�� �̺�Ʈ�� �߻��Ǿ��� ��, �� �̺�Ʈ �����̳� ���� �ڵ������� ����Ǵ�
   ���ν���(��ȯ�Ǵ� ���� ���� ���ν���)�� �ǹ�
  (�������)
   CREATE [OR REPLACE] TRIGGER Ʈ���Ÿ�
    Ʈ����Ÿ�̹� AFTER|BEFORE �̺�Ʈ INSERT | UPDATE | DELETE
    ON ���̺�� -- ���̺� �̺�Ʈ�� �߻��ϱ� ����|�Ŀ�
    [FOR EACH ROW] -- ����� Ʈ���� // FOR EACH ROW�� �Ⱦ��� ������� Ʈ���Ű� ��
    [WHEN ����] -- �ϳ��� Ʈ���Ű� �Ϸ�Ǳ� ���� �ٸ� Ʈ���Ÿ� �ҷ��ͼ� �����ų �� ����.
   [DECLARE 
     �����(����, ���, Ŀ�� ����);
   ]
   BEGIN 
     Ʈ���� ����; --Ʈ���� �������� COMMIT ��� ���� �Ұ�
   END;
   - Ʈ���� Ÿ�̹� : Ʈ���� ������ ����� ����.
     . AFTER : �̺�Ʈ�� �߻��� �� Ʈ���� ���� ����
     . BEFORE : �̺�Ʈ�� �߻��Ǳ� �� Ʈ���� ���� ����
   - Ʈ���� �̺�Ʈ : Ʈ���Ÿ� ���߽�Ű�� DML������� OR �� �����ų �� ����
     INSERT OR DELETE OR UPDATE, INSERT OR UPDATE ��, Ʈ���� �Լ� INSERTING, UPDATING,
     DELETING ���
   - Ʈ���� ����
    . ������� Ʈ���� : 'FOR EACH ROW'�� ������ ���� �̺�Ʈ ���࿡ ���� �ѹ��� Ʈ���� ����
    . ����� Ʈ���� : �̺�Ʈ�� ����� ������ ������ ������ �� �� �ึ�� Ʈ���� ���� ����
                     'FOR EACH ROW' ����ؾ���. Ʈ���� �ǻ緹�ڵ� :OLD, :NEW ��� ���� 
                     
--��뿹--
  �з����̺��� LPROD_ID�� 13���� �ڷḦ �����Ͻÿ�. ���� �� '�ڷᰡ �����Ǿ����ϴ�.'��� �޽�����
  ����ϴ� Ʈ���Ÿ� �ۼ��Ͻÿ�.
  CREATE OR REPLACE TRIGGER tg_delete_lprod;
    AFTER DELETE ON LPORD;
  BEGIN
    Dbms_Output.Put_Line('�ڷᰡ �����Ǿ����ϴ�.');
  END;
  
  ROLLBACK;
  
  DELETE FROM LPROD WHERE LPROD_ID = 13;
  SELECT * FROM LPROD;
  
  DELETE FROM LPROD WHERE LPROD_ID = 13;
  COMMIT;
  
--��뿹--
  2020�� 6�� 12���̶�� ���� �� 
  ��ǰ�ڵ�   ���԰���  ����
  P201000019  210000   5 (2020	P201000019	22	26	14	34	2020/08/01) 
  P202000009   28500   3 (2020	P202000009	9	22	19	12	2020/08/01)
  P202000012   55000   7 (2020	P202000012	33	24	7	50	2020/08/01)
  �� ������ ��� �̸� �������̺�(BUYPROD)�� ������ �� 
  ���������̺��� �����ϴ� Ʈ���Ÿ� �ۼ��Ͻÿ�
  
  CREATE OR REPLACE TRIGGER tg_buyprod_insert 
    AFTER INSERT ON BUYPROD
    FOR EACH ROW 
  DECLARE
    V_PID PROD.PROD_ID%TYPE := (:NEW.BUY_PROD); --���Ի�ǰ�ڵ�
    V_QTY NUMBER := (:NEW.BUY_QTY); --���Լ���   
  BEGIN
    UPDATE REMAIN A
       SET A.REMAIN_I=A.REMAIN_I+V_QTY,
           A.REMAIN_J_99=A.Remain_J_99+V_QTY,
           A.REMAIN_DATE=SYSDATE
     WHERE A.PROD_ID=V_PID;
  END;
  
  (����)
  INSERT INTO BUYPROD VALUES(SYSDATE,'P201000019',5,210000);
  
--��뿹--
  �����ȣ 190-194������ 5���� ����ó���Ͻÿ�.
  ������ ������ ������̺��� �����Ǳ� ���� �ʿ� ������ ������ ���̺� �����Ͻÿ�.
  
  CREATE OR REPLACE TRIGGER tg_delete_emp
    BEFORE DELETE ON EMPLOYEES
    FOR EACH ROW
  BEGIN 
    INSERT INTO RETIRE(EMPLOYEE_ID, EMP_NAME, JOB_ID, HIRE_DATE, RETIRE_DATE, DEPARTMENT_ID)
                VALUES(:OLD.EMPLOYEE_ID, :OLD.EMP_NAME, :OLD.JOB_ID, :OLD.HIRE_DATE, SYSDATE,
                       :OLD.DEPARTMENT_ID);
  END;  
  
  DELETE FROM EMPLOYEES
   WHERE EMPLOYEE_ID BETWEEN 190 AND 194;
  
--��뿹--
  ���� �����ڷᰡ �߻��� ���� �۾��� Ʈ���ŷ� �ۼ��Ͻÿ�
  ����ȸ�� : ��ö��('k001', 5000 ����Ʈ)
  ���� ��ǰ�ڵ� : 'P202000010' (2020	P202000010	38	36	25	49	2020/08/01)
  ���ż��� : 2
  CREATE OR REPLACE TRIGGER tg_change_cart
    AFTER INSERT OR UPDATE OR DELETE ON CART
    FOR EACH ROW
  DECLARE
    V_QTY NUMBER:=0;
    V_PID PROD.PROD_ID%TYPE;
    V_DATE DATE;
    V_MID MEMBER.MEM_ID%TYPE;
    V_MILE NUMBER:=0;
  BEGIN
    IF INSERTING THEN
      V_QTY:=(:NEW.CART_QTY);
      V_PID:=(:NEW.CART_PROD);
      V_DATE:=TO_DATE(SUBSTR(:NEW.CART_NO,1,8));
      V_MID:=(:NEW.CART_MEMBER);
    ELSIF UPDATING THEN  
      V_QTY:=(:NEW.CART_QTY) - (:OLD.CART_QTY);
      V_PID:=(:NEW.CART_PROD);
      V_DATE:=TO_DATE(SUBSTR(:NEW.CART_NO,1,8));
      V_MID:=(:NEW.CART_MEMBER);
    ELSIF DELETING THEN
      V_QTY:=-(:OLD.CART_QTY);
      V_PID:=(:OLD.CART_PROD);
      V_DATE:=TO_DATE(SUBSTR(:OLD.CART_NO,1,8));
      V_MID:=(:OLD.CART_MEMBER);
    END IF;
    
    UPDATE REMAIN 
       SET REMAIN_O=REMAIN_O+V_QTY,
           REMAIN_J_99=REMAIN_J_99 - V_QTY,
           REMAIN_DATE=V_DATE
     WHERE PROD_ID=V_PID;
     
    SELECT V_QTY*PROD_MILEAGE INTO V_MILE
      FROM PROD
     WHERE PROD_ID=V_PID;
     
    UPDATE MEMBER
       SET MEM_MILEAGE=MEM_MILEAGE+V_MILE
     WHERE MEM_ID=V_MID;  
  END;
  
  INSERT INTO CART VALUES('k001',FN_CREATE_CARTNO(SYSDATE), 'P202000010',5); 
  2020	P202000010	38	36	30	44	2022/09/13
  
  (3�� ��ǰ)
  UPDATE CART
     SET CART_QTY=2
   WHERE CART_NO='2020091300002'
     AND CART_PROD='P202000010'
     
  (���� ��� : DELETE)
  DELETE FROM CART  
  WHERE CART_NO='2020091300002'
    AND CART_PROD='P202000010'
   
  