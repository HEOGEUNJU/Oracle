

**EMPLOYEES���̺� ���ο� �÷�(EMP_NAME), ������ Ÿ���� VARCHAR2(80)�� �÷��� �߰�
  ALTER TABLE ���̺�� ADD (�÷��� ������Ÿ��[(ũ��)][DEFAULT ��])
  ALTER TABLE EMPLOYEES ADD(EMP_NAME VARCHAR2(80));
  
**UPDATE �� => ����� �ڷḦ ������ �� ���
  UPDATE ���̺�� 
    SET �÷���=��[,]
        �÷���=��[,]
            : 
        �÷���=��
  [WHERE ����]      <== WHERE���� �Ⱦ��� ��� ���� �� ���� ������ �����Ѵ�.
                        EX) �ѿ��� �� �����Ϸ��� �Ƚᵵ �ǰ� �Ϻθ� ������ �Ŷ�� ����Ѵ�.
                        
  UPDATE HR.Employees                             <= ���� �� �ٲ��� �Ŷ� WHERE�� ���� ����
     SET EMP_NAME=First_Name||' '||LAST_NAME;     
    
  SELECT Employee_Id,
         EMP_NAME
    FROM EMPLOYEES;
  
  ��뿹) ������̺�(Employees)�μ���ȣ�� 50���� ������� ��ȸ�Ͻÿ�.
          Alias�� �����ȣ, �����, �μ���ȣ, �޿��̴�.
    
  SELECT �����ȣ, �����, �μ���ȣ, �޿�
    FROM Employees
    
    COMMIT;