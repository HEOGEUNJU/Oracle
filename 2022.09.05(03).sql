2022-0905-03) �ε���(INDEX) ��ü
 - �ڷ�˻��� ȿ�������� �����ϱ� ���� ��ü
 - DBMS�� ���ɰ����� ����
 - B-TREE(Binary Tree) ������ ����Ǿ� ���� �ð� �ȿ� ��� �ڷ� �˻��� �㺸��
 - ������ �˻�, ����, ����� �ʿ��ڷ� ������ ȿ���� ����
 - ���İ� �׷�ȭ�� ���� ������ ����
 - �ε��� ������ �ڿ��� ���� �ҿ��
 - �������� ������ ������ �߻��Ǹ� �ε������� ���ſ� ���� �ð� �ҿ�
 - �ε����� ������ ������ ������ �Ѵ�.
 - �ε����� ����
 . Unique(�⺻Ű�� �ƴϹǷ� null���� �� �� ����) / Non Unique Index
 . Single(�� �÷����� ��������� ��) / Composite Index(�������� �÷��� �����ؼ� �ε����� ��������� ��)
 . Normal(���� ����� �ε��� B-TREE���� ���) / Bitmap(bit�� mapping�ؼ� ���� �ε���-2������ �ڷḦ �̿��ؼ� ����) 
   / Function-Based Normal Index
  
 -In Order ����
  . left - root - right ����
  
  (�������)
  CREATE [UNIQUE|BITMAP] INDEX �ε�����
    ON ���̺��(�÷���[,�÷���,...])[ASC|DESC]
    
--��뿹--
  ȸ�����̺��� �̸��÷����� �ε����� �����Ͻÿ�
  CREATE INDEX IDX_NAME
    ON MEMBER(MEM_NAME);
    
  SELECT *
    FROM MEMBER
   WHERE MEM_NAME = '������'; 
   
  --�ε��� ���� 
    DROP INDEX IDX_NAME;
    
  CREATE INDEX IDX_REGNO
    ON MEMBER(SUBSTR(MEM_REGNO2,2,4));
  (�Լ��� ����� �ε����� ������ �ε��� Ÿ���� FUNCTION-BASED NORMAL�̴�)
  
  SELECT *
    FROM MEMBER
   WHERE SUBSTR(MEM_REGNO2,2,4) = '4558' 
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  