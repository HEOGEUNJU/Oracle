2022-0822-01)����ȯ �Լ�
 - ����Ŭ�� ������ ����ȯ �Լ��� TO_CHAR, TO_DATE, TO_NUMBER, CAST �Լ��� ������
 - �ش� �Լ��� ���� ������ �Ͻ��� ��ȯ
 - ����Ǿ��� ��츸 �ٲ� �� �ִ�.
 1) CAST(expr AS type)
  . expr�� �����Ǵ� ������(����, �Լ�, �÷� ��)�� 'type' ���·� ��ȯ�Ͽ� ��ȯ ��
    
 ��뿹)
   SELECT BUYER_ID AS �ŷ�ó�ڵ�,
          BUYER_NAME AS �ŷ�ó��1,
          CAST(BUYER_NAME AS CHAR(30)) AS �ŷ�ó��2,
          BUYER_CHARGER AS �����
     FROM BUYER;
     --> VARCHAR2�� ��������, CHAR�� ��������(���� ������ ����) -> �ٲ� �� �ִ� �͸� �ٲ� �� ����
   (�ٲ� �� ���� ��)
   SELECT CAST(BUY_DATE AS NUMBER)
     FROM BUYPROD
    WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131');
   (�� CAST�� �Ἥ �ٲٰ� �ʹٸ�)
   SELECT CAST(TO_CHAR(BUY_DATE,'YYYYMMDD') AS NUMBER) AS ��¥�����ڷ�
     FROM BUYPROD
    WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131'); 
   
 2) TO_CHAR(d [,fmt]) -*****
   . ��ȯ�Լ� �� ���� �θ� ���
   . ����, ��¥, ���� Ÿ���� ����Ÿ������ ��ȯ
   . ����Ÿ���� CHAR, CLOB�� VARCHAR2�� ��ȯ�� ���� ��� ����
   . VARCHAR2�� VARCHAR2�� ��ȯ�� �� ����.
   . 'fmt'�� ���Ĺ��ڿ��� ũ�� ��¥���� ���������� ���е�
---------------------------------------------------------------------------------------------------------------------   
FORMAT ����        �ǹ�                  ��뿹 
---------------------------------------------------------------------------------------------------------------------
CC                 ����                  SELECT TO_CHAR(SYSDATE, 'CC')||'����' FROM DUAL;
AD, BC             �����,�����          SELECT TO_CHAR(SYSDATE, 'CC BC')||EXTRACT(YEAR FROM SYSDATE) FROM DUAL;
YYYY,YYY,YY,Y      �⵵                  SELECT TO_CHAR(SYSDATE, 'YYYY')||'��' FROM DUAL;
YEAR               �⵵�� ���ĺ�����      SELECT TO_CHAR(SYSDATE, 'YEAR')||'��' FROM DUAL;
Q                  �б�                  SELECT TO_CHAR(SYSDATE, 'Q')||'�б�' FROM DUAL; 
MM,RM              ��                    SELECT TO_CHAR(SYSDATE, 'YYYY-MM')||'��' FROM DUAL; 
MONTH, MON         ��                    SELECT TO_CHAR(SYSDATE, 'YYYY-MON') FROM DUAL;
                                         SELECT TO_CHAR(SYSDATE, 'MONTH') FROM DUAL;
WW, W              ��                    SELECT TO_CHAR(SYSDATE, 'W')||'����' FROM DUAL;
                                         SELECT TO_CHAR(SYSDATE, 'WW')||'����' FROM DUAL;
DDD,DD,D           ��                    SELECT TO_CHAR(SYSDATE, 'D') FROM DUAL;
DAY, DY            ����                  SELECT TO_CHAR(SYSDATE, 'DAY') FROM DUAL;
                                         SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DY') FROM DUAL;   
AM, PM, A.M, P.M   ����/����             SELECT TO_CHAR(SYSDATE, 'AM') FROM DUAL;
HH,HH12,HH24       �ð�                  SELECT TO_CHAR(SYSDATE, 'HH24') FROM DUAL;
MI                 ��                    SELECT TO_CHAR(SYSDATE, 'HH24:MI') FROM DUAL;
SS,SSSSS           ��                    SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') FROM DUAL;
---------------------------------------------------------------------------------------------------------------------  

**������ ���Ĺ��� => *���ڷμ��� ������ ������� ���ڿ��� �ٲ�*
--------------------------------------------------------------------------------------------------------------------- 
FORMAT ����        �ǹ�                  ��뿹 
--------------------------------------------------------------------------------------------------------------------- 
9,0                �����ڷ����           SELECT TO_CHAR(12345.56,'9,999,999.99'),                
                                                 TO_CHAR(12345.56,'0,000,000.00')    FROM DUAL;
--  9=> ��ȿ���ڿ� ���� => ������� / 0=> ��ȿ���ڿ� ���� => �������
--      ��ȿ���ڿ� ���� => ������� /     ��ȿ���ڿ� ���� => '0'�����
-- �Ҽ������� �ڸ����� ������ ��� �ݿø��Ͽ� ����� ���
, (COMMA)         3�ڸ����� �ڸ���(,)
. (DOT)            �Ҽ���
&, L               ȭ���ȣ               SELECT TO_CHAR(PROD_PRICE, 'L9,999,999')
                                            FROM PROD;
                                          SELECT TO_CHAR(SALARY,'$999,999') AS �޿�1 --> ,�� �ֱ� ������ ����� ���ڰ� �� �� ����.
                                                 TO_CHAR(SALARY) AS �޿�2
                                            FROM HR.EMPLOYEES;    
PR             �����ڷḦ '<>'�ȿ� ���    SELECT TO_CHAR(-2500, '99,999PR') FROM DUAL;  --> �������� ���ڿ� ���� ������ ���� PR�� �����.
MI       �����ڷ� ��½� �����ʿ� '-'���   SELECT TO_CHAR(-2500, '99,999MI') FROM DUAL;

" " ����ڰ� ���� �����ϴ� ���ڿ�           SELECT TO_CHAR(SYSDATE, 'YYYY"��" MM"��" DD"��"') --> ""�� �÷��� ��Ī�� �ۼ��� ����
                                             FROM DUAL;                                     --> �������� ���ڿ��� ����� �� ���    
--------------------------------------------------------------------------------------------------------------------- 
   
 3) TO_DATE(c [,fmt]) - *** --> fmt�� �⺻��¥ Ÿ������ ������ �� ���� ���ڿ��� �ִ� ��� // ���ڿ��� ��¥�� �ٲ� �� ����.
  . �־��� ���ڿ� �ڷ� c�� ��¥Ÿ���� �ڷ�� ����ȯ ��Ŵ
  . c�� ���Ե� ���ڿ� �� ��¥�ڷ�� ��ȯ�� �� ���� ���ڿ��� ���Ե� ���
    'fmt'�� ����Ͽ� �⺻�������� ��ȯ�� �� ����
  . 'fmt'�� TO_CHAR�Լ��� '��¥�� ���Ĺ���'�� ����
  . ���� �ڷ�� ����� ��¥ �ڷ�� �ٲ� �� ����.(���ڿ� �ڷḸ �ٲ� �� ����)
 
 ��뿹)
   SELECT TO_DATE('20200504'),
          TO_DATE('20200504', 'YYYY-MM-DD'),--> -�� /�� ��¥ �������� �⺻ Ÿ���̱� ������ ���൵ �ǰ� �Ƚ��൵ �ȴ�.
          TO_DATE('2020�� 08�� 22��','yyyy"��" mm"��" dd"��"')
     FROM DUAL;     

 4) TO_NUMBER(c [,fmt]) - *** //���ڿ��� ���ڷ� �ٲ� �� ����
  . �־��� ���ڿ� �ڷ� c�� ����Ÿ���� �ڷ�� ����ȯ ��Ŵ
  . c�� ���Ե� ���ڿ� �� �����ڷ�� ��ȯ�� �� ���� ���ڿ��� ���Ե� ���
    'fmt'�� ����Ͽ� �⺻ ���� �������� ��ȯ�� �� ����
  . 'fmt'�� TO_CHAR�Լ��� '������ ���Ĺ���'�� ����
  
 ��뿹) 
   SELECT TO_NUMBER('2345') / 7,
          TO_NUMBER('2345.56'),
          TO_NUMBER('2,345', '99,999'), --> �� �� ,�� �ְų� �� �� ����� ��ȯ�� �����ϴ�.
          TO_NUMBER('$2345', '$9999'), --> ������������ ���¿� ������ ����
          TO_NUMBER('002,345', '000,000') AS ��ȿ,
          TO_NUMBER('<2,345>', '9,999PR')
     FROM DUAL;     
 
 
 
 