
drop table tbl_reply;
create table tbl_reply(
rno number primary key,
bno number not null references tbl_board(bno),
replytext varchar2(1000) not null,
replyer varchar2(50) not null,
regdate date default sysdate,
updatedate date default sysdate
);

drop sequence tbl_reply_seq;
create sequence tbl_reply_seq
start with 1
increment by 1
nocycle
nocache;


insert  into tbl_reply(rno, bno, replytext, replyer) values(tbl_reply_seq.nextval, 6, '안녕하세요!', '김주원');