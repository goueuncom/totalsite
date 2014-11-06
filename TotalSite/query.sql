CREATE TABLE tblBoard(
	num			number,
	name			varchar2(20),
	email			varchar2(50),
	homepage	varchar2(50),
	subject		varchar2(50),
	content		varchar2(4000),
	pass			varchar2(10),
	count			number,
	ip				varchar2(30),
	regdate		date,
	pos			number,
	depth			number,
	filename		varchar2(50),
	CONSTRAINT pk_num	PRIMARY KEY(num)
);

CREATE SEQUENCE seq_num;

INSERT INTO tblboard VALUES(seq_num.nextVal, 'aaa', 'aaa', 'aaa', 'aaa', 'aaa', 'aaa', 0, 'aaa', sysdate, 0, 0);
INSERT INTO tblboard VALUES(seq_num.nextVal, 'bbb', 'bbb', 'bbb', 'bbb', 'bbb', 'bbb', 0, 'bbb', sysdate, 0, 0);

select * from tblboard;

delete from tblboard;
drop table tblBoard cascade constraint purge;

CREATE TABLE tblReply(
	num			number,
	subject		varchar2(10),
	pos			number,
	depth			number
);

-- 새 글 입력 :  pos + 1 에 조건은 필요 없다. 기존의 글들은 모두 해당이니까.
update tblReply set pos = pos + 1;
INSERT INTO tblReply VALUES(1, 'aaa', 0, 0);
update tblReply set pos = pos + 1;
insert into tblreply values(2, 'bbb', 0, 0);
update tblReply set pos = pos + 1;
insert into tblreply values(3, 'ccc', 0, 0);
-- 2번 글에 대한 답변
update tblReply set pos = pos + 1 where pos > 1;
insert into tblReply values(4, 'bbb의 답변', 2, 1);

select * from tblReply order by pos;

drop table tblReply cascade constraint purge;

CREATE TABLE tblReply(
	num			number,
	subject		varchar2(20),
	g_num		number,
	seq			number,
	lev				number
);

insert into tblReply values(1, 'aaa', 1, 1, 0);
insert into tblReply values(2, 'bbb', 2, 1, 0);
insert into tblReply values(3, 'cccc', 3, 1, 0);
-- 2번 글에 대한 답변
update tblReply set seq=seq+1 where g_num=2 and seq>1;
insert into tblReply values(4, 'bbb의 답변', 2, 2, 1);
-- 2번 글에 대한 답변 2
update tblReply set seq=seq+1 where g_num=2 and seq>1;
insert into tblReply values(5, 'bbb의 답변2', 2, 2, 1);

select * from tblReply order by g_num desc, seq;

drop table tblReply cascade constraint purge;