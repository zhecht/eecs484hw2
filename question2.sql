DROP TABLE Member;
DROP TABLE Enrolled;
DROP TABLE Student;
DROP TABLE Project;
DROP TABLE Course;



CREATE TABLE Student (
   sid integer PRIMARY KEY, 
   name VARCHAR(20),
   major VARCHAR(20)
);

CREATE TABLE Project ( 
   pid integer  PRIMARY KEY, 
   ptitle VARCHAR(50) 
);

CREATE TABLE Course ( 
   cid integer PRIMARY KEY,
   title VARCHAR(30)
);

CREATE TABLE Member (
  pid integer,
  sid integer,
  PRIMARY KEY (pid, sid),
  FOREIGN KEY (pid) REFERENCES Project(pid),
  FOREIGN KEY (sid) REFERENCES Student(sid)
);

CREATE TABLE Enrolled (
  sid integer,
	cid integer,
	PRIMARY KEY (sid, cid),
  FOREIGN KEY (sid) REFERENCES Student(sid),
  FOREIGN KEY (cid) REFERENCES Course(cid) 
);

INSERT INTO Student (sid, name, major) VALUES (0, 'a', 'a');
INSERT INTO Student (sid, name, major) VALUES (1, 'b', 'b');
INSERT INTO Student (sid, name, major) VALUES (2, 'c', 'c');
INSERT INTO Student (sid, name, major) VALUES (3, 'd', 'd');

INSERT INTO Project (pid, ptitle) VALUES (0, 'project');

INSERT INTO Course (cid, title) VALUES (0, 'EECS484');
INSERT INTO Course (cid, title) VALUES (1, 'EECS482');

INSERT INTO Member (pid, sid) VALUES (0, 0);
INSERT INTO Member (pid, sid) VALUES (0, 1);

INSERT INTO Enrolled (sid, cid) VALUES (0, 0);
INSERT INTO Enrolled (sid, cid) VALUES (0, 1);
INSERT INTO Enrolled (sid, cid) VALUES (1, 0);
INSERT INTO Enrolled (sid, cid) VALUES (1, 1);


