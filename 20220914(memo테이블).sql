INSERT INTO memo (
    no,
    title,
    content,
    writer
) VALUES (
    seq_memo.NEXTVAL,
    'ù��° �޸�',
    '�ȳ��ϼ���',
    'hgj'
);
--�μ�Ʈ
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
--������Ʈ
UPDATE memo
    SET
        title = '����° �޸�',
        content = '����° �� �����',
        writer = 'chopper'
WHERE
    no = 3;