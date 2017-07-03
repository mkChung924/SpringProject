--message.sql

create table tbl_user(
userid varchar2(50) primary key,
upw varchar2(50) not null,
uname varchar2(100) not null,
upoint number default 0
);

create table tbl_message(
mid number primary key,
targetid varchar2(50) references tbl_user(userid),
sender varchar2(50) references tbl_user(userid),
message varchar2(500) not null,
opendate date,
senddate date default sysdate
);

create sequence tbl_message_seq
start with 1
increment by 1
nocycle
nocache;

insert into tbl_user(userid, upw, uname) values('user00', 'user00', 'Iron man');
insert into tbl_user(userid, upw, uname) values('user01', 'user01', 'Captain');
insert into tbl_user(userid, upw, uname) values('user02', 'user02', 'Hulk');
insert into tbl_user(userid, upw, uname) values('user03', 'user03', 'Thor');
insert into tbl_user(userid, upw, uname) values('user10', 'user10', 'Quick Silver');