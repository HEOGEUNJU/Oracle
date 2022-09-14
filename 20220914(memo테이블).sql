INSERT INTO memo (
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
--인서트
INSERT INTO memo (
    no,
    title,
    content,
    writer
) VALUES (
    seq_memo.NEXTVAL,
    '',
    '',
    ''
)
commit;
--업데이트
UPDATE memo
    SET
        title = '세번째 메모',
        content = '세번째 글 등록함',
        writer = 'chopper'
WHERE
    no = 3;