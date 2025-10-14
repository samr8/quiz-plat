import sqlite3
import os

# Make sure the instance folder exists
os.makedirs("instance", exist_ok=True)

db_path = "instance/quiz.db"

# If old database exists, delete it
if os.path.exists(db_path):
    os.remove(db_path)
    print("Old quiz.db deleted.")

# Connect and create new database
conn = sqlite3.connect(db_path)
c = conn.cursor()

schema = """
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
    taken_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(id),
    FOREIGN KEY (quiz_id) REFERENCES Quizzes(id)
);

INSERT INTO Users (username, password) VALUES ('samrat','password123');

INSERT INTO Quizzes (title, description)
VALUES ('Python Basics','A simple quiz to test your Python basics');

INSERT INTO Quizzes (title, description)
VALUES ('Flask Basics', 'Test your knowledge of Flask framework');

INSERT INTO Questions (quiz_id,text) VALUES (1, 'What is the output of print(2**3)?');
INSERT INTO Questions (quiz_id,text) VALUES (1, 'Which keyword is used to define a function in Python?');

INSERT INTO Options (question_id,text,is_correct) VALUES (1,'5',0);
INSERT INTO Options (question_id,text,is_correct) VALUES (1,'6',0);
INSERT INTO Options (question_id,text,is_correct) VALUES (1,'8',1);
INSERT INTO Options (question_id,text,is_correct) VALUES (1,'9',0);

INSERT INTO Options (question_id,text,is_correct) VALUES (2,'func',0);
INSERT INTO Options (question_id,text,is_correct) VALUES (2,'def',1);
INSERT INTO Options (question_id,text,is_correct) VALUES (2,'function',0);
INSERT INTO Options (question_id,text,is_correct) VALUES (2,'lambda',0);

INSERT INTO Questions (quiz_id, text) VALUES (2, 'What is the default port for Flask?');
INSERT INTO Questions (quiz_id, text) VALUES (2, 'Which command runs a Flask app?');

INSERT INTO Options (question_id, text, is_correct) VALUES (3, '8080', 0);
INSERT INTO Options (question_id, text, is_correct) VALUES (3, '5000', 1);
INSERT INTO Options (question_id, text, is_correct) VALUES (3, '3000', 0);
INSERT INTO Options (question_id, text, is_correct) VALUES (3, '4000', 0);

INSERT INTO Options (question_id, text, is_correct) VALUES (4, 'flask start', 0);
INSERT INTO Options (question_id, text, is_correct) VALUES (4, 'flask run', 1);
INSERT INTO Options (question_id, text, is_correct) VALUES (4, 'python run.py', 0);
INSERT INTO Options (question_id, text, is_correct) VALUES (4, 'start flask', 0);
"""

c.executescript(schema)
conn.commit()
conn.close()

print("New quiz.db created with sample data in 'instance/' folder.")
