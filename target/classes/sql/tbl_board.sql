drop table tbl_board;
create table tbl_board(
bno number primary key,
title varchar2(200) not null,
content varchar2(500),
writer varchar2(50) not null,
regdate date default sysdate,
viewcnt number default 0
);

drop sequence tbl_board_seq;
create sequence tbl_board_seq
start with 1
increment by 1
nocycle
nocache;