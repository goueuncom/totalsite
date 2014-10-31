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
	CONSTRAINT pk_num	PRIMARY KEY(num)
);

CREATE SEQUENCE seq_num;

INSERT INTO tblboard VALUES(seq_num.nextVal, 'aaa', 'aaa', 'aaa', 'aaa', 'aaa', 'aaa', 0, 'aaa', sysdate, 0, 0);
INSERT INTO tblboard VALUES(seq_num.nextVal, 'bbb', 'bbb', 'bbb', 'bbb', 'bbb', 'bbb', 0, 'bbb', sysdate, 0, 0);

select * from tblboard;