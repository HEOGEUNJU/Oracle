COMMIT

rollback
--������, ���¼�, �����¼�, �װ���
insert into airplane(AIRPLANE_ID, SEATTOTAL, SEATREMAIN, AIRLINE)
values ('', 20, 20 , '');
--���׾��̵�, �����̸�, ����, �ּ�
INSERT INTO AIRPORT(AIRPORT_ID, AIRPORT_NAME, NATION, ADDRESS)
VALUES('','','','');
--�װ��� �ڵ�, �����, ������, �����, ��߽ð�, ������, ����� �ڵ�, ����, �Ÿ�
INSERT INTO COURSE (COURSE_ID, COURSE_DL, AIRPORT_ID, COURSE_DD, COURSE_DT, AIRPLANE_ID, COURSE_PRICE, COURSE_DISTANCE) 
VALUES ('P2022001', 'ICN', 'PEK', to_date('20220904'), SYSDATE, 'a100', 'KE', 350000, 914);
--ȸ��ID, �̸�, �������, ���¹�ȣ, ����, ���ϸ���
INSERT INTO MEMBER (MEM_ID, MEM_NAME, MEM_REG, MEM_ACCOUNT, MEM_BANK, MEM_MILEAGE)
VALUES ('', '', , , '', );
--�����ڵ�, ȸ��ID, �¼���ȣ, �װ����ڵ�, ž���� �̸�, ž���� ��ȭ��ȣ, ž���� �������
INSERT INTO reservation (RESERV_ID, MEM_ID, SEAT_NO, COURSE_ID, PASS_NAME, PASS_PHONE, PASS_REG) 
VALUES ('1', 'B001', '������', '980222', 'P2022001', 'F10', '01012345678');









Drop Table COURSE;