1. ����� select�� �װ������̺� 

�������� ��¥�� ���� �� �ش� �װ��� ��ȸ
alias �װ���ID/�����/������/�������/��߽ð�/�ܿ��¼�/�װ���/�Ÿ�/�ݾ�

select a.course_id, a.course_dl, a.airport_id, a.course_dd,
a.course_dt, b.seat_remain, a.airline, a.course_distance, a.course_price
from course a, airplane b
where a.airplane_id = b.airplane_id
  and airport_id = ?
  and course_dd = ?

  
  
2. ��� �� �������̺� ȸ����ȣ�� �����ȣ ��������

  select reserv_id
  from resevation a, member b
  where a.mem_id = b.mem_id
  and mem_id = 'A001';


3. delete from course
   where course_dt=1400;
   
   select course_dt, course ,course_dt
   from user_constraints
   where course_dt=1400