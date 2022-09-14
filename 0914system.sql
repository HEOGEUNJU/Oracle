CREATE OR REPLACE DIRECTORY TEST_DUMP AS 'E:\export';
GRANT READ, WRITE ON DIRECTORY TEST_DUMP TO xeuser;


create user ks95 identified by java;

grant connect, resource, dba to ks95;

INSERT INTO ks95 (
    no,
    title,
    content,
    writer
) VALUES (
    seq_memo.NEXTVAL,
    '첫번째 메모',
    '안녕하세요',
    'hgj'
);