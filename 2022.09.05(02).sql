2022-0905-02)���Ǿ� ��ü(SYNONYM)
 - ����Ŭ ��ü�� ��Ī�� �ο��� �� ���
 - �ٸ� �������� ��ü�� �����ϴ� ��� "��Ű����.��ü��" ��������
   �����ؾ��� => �̸� ����ϱ� ���� ����� ������ �ܾ�� ��� �� �� �ִ� ��� ����
   
 (�������)
  CREATE [OR REPLACE] SYNONYM ��Ī
     FOR ���� ��ü��
     
--��뿹--
  HR ������ EMPLOYEES���̺�� DEPARTMENTS ���̺��� EMP �� DEPT�� 
  ��Ī�� �ο��Ͻÿ�.
  
  CREATE OR REPLACE SYNONYM EMP FOR HR.Employees;
  
  SELECT * FROM EMP;

  CREATE OR REPLACE SYNONYM DEPT FOR HR.Departments;
  
  SELECT * FROM DEPT;

  SELECT A.Employee_Id, A.EMP_NAME, B.DEPARTMENT_NAME
    FROM EMP A, DEPT B
   WHERE B.Department_Id IN(20,30,50,60)
     AND A.Department_Id=B.Department_Id;
  
    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    
                                                                                                                    1 
    
    
    
    
    
                
                    
                        
                            
                                    
                                    
                                    
                                            