1. 예약시 select로 항공편테이블 

도착지와 날짜를 선택 후 해당 항공편 조회
alias 항공편ID/출발지/도착지/출발일자/출발시간/잔여좌석/항공사/거리/금액

select a.course_id, a.course_dl, a.airport_id, a.course_dd,
a.course_dt, b.seat_remain, a.airline, a.course_distance, a.course_price
from course a, airplane b
where a.airplane_id = b.airplane_id
  and airport_id = ?
  and course_dd = ?

  
  
2. 취소 시 예약테이블 회원번호로 예약번호 가져오기

  select reserv_id
  from resevation a, member b
  where a.mem_id = b.mem_id
  and mem_id = 'A001';


3. delete from course
   where course_dt=1400;
   
   select course_dt, course ,course_dt
   from user_constraints
   where course_dt=1400