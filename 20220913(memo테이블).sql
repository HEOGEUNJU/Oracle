CREATE TABLE memo(
  no NUMBER,
  title varchar2(100),
  content varchar2(1000),
  writer varchar2(50),
  register_date date default sysdate,
  modify_date date,
  Constraint pk_memo Primary Key (no)
);  

SELECT
    no,
    title,
    content,
    writer,
    register_date,
    modify_date
FROM
    memo;