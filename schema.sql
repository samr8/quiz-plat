drop table if EXISTS Users;
DROP TABLE IF EXISTS Quizzes;
DROP TABLE IF EXISTS Questions;
DROP TABLE IF EXISTS Options;
DROP TABLE IF EXISTS Results;
DROp TABLE IF EXISTS Quizzers;

CREATE TABLE Users(
id INTEGER PRIMARY KEY AUTOINCREMENT,
username TEXT UNIQUE NOT NULL,
password TEXT NOT NULL
);

CREATE TABLE Quizzes(
id INTEGER PRIMARY KEY AUTOINCREMENT,
title TEXT NOT NULL,
description TEXT
);

CREATE TABLE Questions(
id INTEGER PRIMARY KEY AUTOINCREMENT,
quiz_id INTEGER NOT NULL,
text TEXT NOT NULL,
FOREIGN KEY (quiz_id) REFERENCES Quizzes(id)
);

CREATE TABLE Options(
id INTEGER PRIMARY KEY AUTOINCREMENT,
question_id INTEGER NOT NULL,
text TEXT NOT NULL,
is_correct BOOLEAN NOT NULL DEFAULT 0,
FOREIGN KEY (question_id) REFERENCES Questions(id)
);

CREATE TABLE Results(
id INTEGER PRIMARY KEY AUTOINCREMENT,
user_id INTEGER NOT NULL,
quiz_id INTEGER NOT NULL,
score INTEGER NOT NULL,
FOREIGN KEY (user_id) REFERENCES Users(id),
FOREIGN KEY (quiz_id) REFERENCES Quizzes(id)
);

-- inserting user
insert into Users (username, password) values('samrat','password123');

-- sample quiz
insert into Quizzes (title, description)
values('python basic','A simple quiz to test you python basic');

-- Question for quiz id 1
insert into questions(quiz_id,text) values(1, 'what is the output of print(2**3)?');
INSERT INTO Questions (quiz_id, text) VALUES (1, 'Which keyword is used to define a function in Python?');

INSERT INTO Options (question_id,text,is_correct) values(1,'5',0);
INSERT INTO Options (question_id, text, is_correct) VALUES (1, '6', 0);
INSERT INTO Options (question_id, text, is_correct) VALUES (1, '8', 1);
INSERT INTO Options (question_id, text, is_correct) VALUES (1, '9', 0);

INSERT INTO Options (question_id, text, is_correct) VALUES (2, 'func', 0);
INSERT INTO Options (question_id, text, is_correct) VALUES (2, 'def', 1);
INSERT INTO Options (question_id, text, is_correct) VALUES (2, 'function', 0);
INSERT INTO Options (question_id, text, is_correct) VALUES (2, 'lambda', 0);





