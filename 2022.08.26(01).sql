2022-0826-01)
4. NULLIF(c1, c2)
 - 'c1'�� 'c2'�� ���Ͽ� ���� ���̸� NULL�� ��ȯ�ϰ� �ٸ� ���̸� 'c1'�� ��ȯ��
***��ǰ���̺��� �з��ڵ尡 'P301'�� ��ǰ�� �ǸŰ��� ���԰��� ������ �����Ͻÿ�. 
 ROLLBACK;
  
 UPDATE PROD -- �ش����̺�
    SET PROD_PRICE = PROD_COST  -- ����(������Ʈ)��ų �÷���
  WHERE PROD_LGU = 'P301' -- �з����� 
 
 ��뿹) ��ǰ���̺��� ���԰��ݰ� ���Ⱑ���� ���� ��ǰ�� ã�� ������� 
         '�Ǹ��ߴܿ�����ǰ'�� ����ϰ�, �� ������ ���� ���� ��ǰ�� ����������
         ������ ����Ͻÿ�.
         Alias�� ��ǰ��ȣ, ��ǰ��, ���԰�, ���Ⱑ, ���
  SELECT PROD_ID AS ��ǰ��ȣ, 
         PROD_NAME AS ��ǰ��, 
         PROD_COST AS ���԰�, 
         PROD_PRICE AS ���Ⱑ, 
         NVL2(TO_CHAR(NULLIF(PROD_PRICE, PROD_COST)),TO_CHAR((PROD_PRICE-PROD_COST),'9,999,999'),'�Ǹ��ߴܻ�ǰ') AS ���       
    FROM PROD
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 