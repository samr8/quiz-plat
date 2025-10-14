-- =========================================
-- RESET EXISTING TABLES
-- =========================================
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Quizzes;
DROP TABLE IF EXISTS Questions;
DROP TABLE IF EXISTS Options;
DROP TABLE IF EXISTS Results;

-- =========================================
-- CREATE TABLES
-- =========================================
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

-- =========================================
-- INSERT TEST USER
-- =========================================
INSERT INTO Users (username, password) VALUES ('samrat','password123');

-- =========================================
-- QUIZ 1: Python Basics
-- =========================================
INSERT INTO Quizzes (title, description)
VALUES ('Python Basics', 'Test your Python syntax and logic knowledge');

INSERT INTO Questions (quiz_id, text) VALUES
(1, 'What is the output of print(2 ** 3)?'),
(1, 'Which keyword defines a function in Python?'),
(1, 'Which of these is a mutable data type?'),
(1, 'Which operator is used for floor division?'),
(1, 'What is the output of len("Hello")?');

-- Q1 Options
INSERT INTO Options (question_id, text, is_correct) VALUES
(1, '6', 0), (1, '8', 1), (1, '9', 0), (1, '7', 0);
-- Q2
INSERT INTO Options (question_id, text, is_correct) VALUES
(2, 'func', 0), (2, 'define', 0), (2, 'def', 1), (2, 'function', 0);
-- Q3
INSERT INTO Options (question_id, text, is_correct) VALUES
(3, 'tuple', 0), (3, 'list', 1), (3, 'string', 0), (3, 'int', 0);
-- Q4
INSERT INTO Options (question_id, text, is_correct) VALUES
(4, '/', 0), (4, '//', 1), (4, '%', 0), (4, '**', 0);
-- Q5
INSERT INTO Options (question_id, text, is_correct) VALUES
(5, '4', 0), (5, '5', 1), (5, '6', 0), (5, 'Error', 0);

-- =========================================
-- QUIZ 2: Flask Basics
-- =========================================
INSERT INTO Quizzes (title, description)
VALUES ('Flask Basics', 'Test your Flask framework fundamentals');

INSERT INTO Questions (quiz_id, text) VALUES
(2, 'What is the default port for Flask?'),
(2, 'Which command runs a Flask app?'),
(2, 'Flask is written in which language?'),
(2, 'Which method handles form submission in Flask?'),
(2, 'Which file is used for HTML templates in Flask?');

INSERT INTO Options (question_id, text, is_correct) VALUES
(6, '8080', 0), (6, '5000', 1), (6, '3000', 0), (6, '4000', 0);
INSERT INTO Options (question_id, text, is_correct) VALUES
(7, 'flask start', 0), (7, 'flask run', 1), (7, 'python flask.py', 0), (7, 'flask execute', 0);
INSERT INTO Options (question_id, text, is_correct) VALUES
(8, 'C', 0), (8, 'C++', 0), (8, 'Python', 1), (8, 'Java', 0);
INSERT INTO Options (question_id, text, is_correct) VALUES
(9, 'GET', 0), (9, 'POST', 1), (9, 'PUT', 0), (9, 'UPDATE', 0);
INSERT INTO Options (question_id, text, is_correct) VALUES
(10, 'templates.py', 0), (10, 'index.html', 1), (10, 'main.py', 0), (10, 'config.txt', 0);

-- =========================================
-- QUIZ 3: SQL Basics
-- =========================================
INSERT INTO Quizzes (title, description)
VALUES ('SQL Basics', 'Test your SQL knowledge and syntax');

INSERT INTO Questions (quiz_id, text) VALUES
(3, 'Which SQL command is used to extract data?'),
(3, 'Which command removes all rows from a table?'),
(3, 'Which SQL clause is used for filtering results?'),
(3, 'Which SQL statement is used to add a new row?'),
(3, 'Which function returns the number of rows?');

INSERT INTO Options (question_id, text, is_correct) VALUES
(11, 'SELECT', 1), (11, 'GET', 0), (11, 'FETCH', 0), (11, 'TAKE', 0);
INSERT INTO Options (question_id, text, is_correct) VALUES
(12, 'DELETE', 0), (12, 'DROP', 0), (12, 'TRUNCATE', 1), (12, 'REMOVE', 0);
INSERT INTO Options (question_id, text, is_correct) VALUES
(13, 'WHERE', 1), (13, 'GROUP BY', 0), (13, 'ORDER', 0), (13, 'HAVING', 0);
INSERT INTO Options (question_id, text, is_correct) VALUES
(14, 'ADD', 0), (14, 'INSERT INTO', 1), (14, 'UPDATE', 0), (14, 'ALTER', 0);
INSERT INTO Options (question_id, text, is_correct) VALUES
(15, 'COUNT()', 1), (15, 'SUM()', 0), (15, 'AVG()', 0), (15, 'LEN()', 0);

-- =========================================
-- QUIZ 4: HTML & CSS
-- =========================================
INSERT INTO Quizzes (title, description)
VALUES ('HTML & CSS', 'Basics of web design and structure');

INSERT INTO Questions (quiz_id, text) VALUES
(4, 'What does HTML stand for?'),
(4, 'Which CSS property changes text color?'),
(4, 'Which tag inserts a line break?'),
(4, 'Which tag creates a hyperlink?'),
(4, 'Which property changes font size?');

INSERT INTO Options (question_id, text, is_correct) VALUES
(16, 'HyperText Markup Language', 1), (16, 'HighText Machine Language', 0), (16, 'Hyper Transfer Markup', 0), (16, 'Home Text Make Language', 0);
INSERT INTO Options (question_id, text, is_correct) VALUES
(17, 'color', 1), (17, 'font-color', 0), (17, 'text-color', 0), (17, 'background', 0);
INSERT INTO Options (question_id, text, is_correct) VALUES
(18, '<lb>', 0), (18, '<break>', 0), (18, '<br>', 1), (18, '<hr>', 0);
INSERT INTO Options (question_id, text, is_correct) VALUES
(19, '<a>', 1), (19, '<link>', 0), (19, '<hlink>', 0), (19, '<hyper>', 0);
INSERT INTO Options (question_id, text, is_correct) VALUES
(20, 'font-size', 1), (20, 'text-size', 0), (20, 'size', 0), (20, 'font-style', 0);

-- =========================================
-- QUIZ 5: JavaScript Basics
-- =========================================
INSERT INTO Quizzes (title, description)
VALUES ('JavaScript Basics', 'Core JS syntax and logic quiz');

INSERT INTO Questions (quiz_id, text) VALUES
(5, 'Which keyword declares a variable?'),
(5, 'How do you write a comment in JS?'),
(5, 'Which method prints output to console?'),
(5, 'What is typeof(42)?'),
(5, 'Which symbol is used for strict equality?');

INSERT INTO Options (question_id, text, is_correct) VALUES
(21, 'var', 1), (21, 'int', 0), (21, 'let', 0), (21, 'define', 0);
INSERT INTO Options (question_id, text, is_correct) VALUES
(22, '#', 0), (22, '//', 1), (22, '/*', 0), (22, '--', 0);
INSERT INTO Options (question_id, text, is_correct) VALUES
(23, 'console.log()', 1), (23, 'print()', 0), (23, 'log()', 0), (23, 'write()', 0);
INSERT INTO Options (question_id, text, is_correct) VALUES
(24, 'number', 1), (24, 'int', 0), (24, 'float', 0), (24, 'string', 0);
INSERT INTO Options (question_id, text, is_correct) VALUES
(25, '==', 0), (25, '=', 0), (25, '===', 1), (25, '=>', 0);

-- =========================================
-- QUIZ 6: C++ Basics
-- =========================================
INSERT INTO Quizzes (title, description)
VALUES ('C++ Basics', 'Core syntax and fundamentals of C++');

INSERT INTO Questions (quiz_id, text) VALUES
(6, 'Which symbol ends a statement in C++?'),
(6, 'Which function prints to console?'),
(6, 'What is the file extension for C++ files?'),
(6, 'Which of these is a loop?'),
(6, 'Which keyword creates an object?');

INSERT INTO Options (question_id, text, is_correct) VALUES
(26, ';', 1), (26, ':', 0), (26, '.', 0), (26, ',', 0);
INSERT INTO Options (question_id, text, is_correct) VALUES
(27, 'cout', 1), (27, 'print', 0), (27, 'display', 0), (27, 'show', 0);
INSERT INTO Options (question_id, text, is_correct) VALUES
(28, '.cpp', 1), (28, '.c', 0), (28, '.cp', 0), (28, '.hpp', 0);
INSERT INTO Options (question_id, text, is_correct) VALUES
(29, 'while', 1), (29, 'goto', 0), (29, 'loop', 0), (29, 'repeat', 0);
INSERT INTO Options (question_id, text, is_correct) VALUES
(30, 'new', 1), (30, 'create', 0), (30, 'make', 0), (30, 'construct', 0);

-- =========================================
-- QUIZ 7: Data Structures
-- =========================================
INSERT INTO Quizzes (title, description)
VALUES ('Data Structures', 'Core concepts of data storage');

INSERT INTO Questions (quiz_id, text) VALUES
(7, 'Which data structure uses FIFO?'),
(7, 'Which uses LIFO?'),
(7, 'Which is used for hierarchical data?'),
(7, 'Which data structure has key-value pairs?'),
(7, 'Which is a linear data structure?');

INSERT INTO Options (question_id, text, is_correct) VALUES
(31, 'Queue', 1), (31, 'Stack', 0), (31, 'Tree', 0), (31, 'Graph', 0);
INSERT INTO Options (question_id, text, is_correct) VALUES
(32, 'Stack', 1), (32, 'Queue', 0), (32, 'Array', 0), (32, 'Set', 0);
INSERT INTO Options (question_id, text, is_correct) VALUES
(33, 'Tree', 1), (33, 'List', 0), (33, 'Stack', 0), (33, 'Array', 0);
INSERT INTO Options (question_id, text, is_correct) VALUES
(34, 'Map', 1), (34, 'Array', 0), (34, 'Stack', 0), (34, 'Queue', 0);
INSERT INTO Options (question_id, text, is_correct) VALUES
(35, 'Array', 1), (35, 'Tree', 0), (35, 'Graph', 0), (35, 'Heap', 0);

-- =========================================
-- QUIZ 8: Operating Systems
-- =========================================
INSERT INTO Quizzes (title, description)
VALUES ('Operating Systems', 'Fundamentals of OS concepts');

INSERT INTO Questions (quiz_id, text) VALUES
(8, 'Which of these is not an OS?'),
(8, 'Which OS is open-source?'),
(8, 'Which manages processes?'),
(8, 'Which handles memory?'),
(8, 'What is kernel?');

INSERT INTO Options (question_id, text, is_correct) VALUES
(36, 'Linux', 0), (36, 'Windows', 0), (36, 'Oracle', 1), (36, 'macOS', 0);
INSERT INTO Options (question_id, text, is_correct) VALUES
(37, 'Windows', 0), (37, 'macOS', 0), (37, 'Linux', 1), (37, 'iOS', 0);
INSERT INTO Options (question_id, text, is_correct) VALUES
(38, 'Scheduler', 1), (38, 'Loader', 0), (38, 'Driver', 0), (38, 'Terminal', 0);
INSERT INTO Options (question_id, text, is_correct) VALUES
(39, 'Memory Manager', 1), (39, 'File System', 0), (39, 'User', 0), (39, 'Cache', 0);
INSERT INTO Options (question_id, text, is_correct) VALUES
(40, 'Core part of OS', 1), (40, 'File Manager', 0), (40, 'User Interface', 0), (40, 'Driver', 0);

-- =========================================
-- QUIZ 9: Networking
-- =========================================
INSERT INTO Quizzes (title, description)
VALUES ('Networking', 'Basic computer network fundamentals');

INSERT INTO Questions (quiz_id, text) VALUES
(9, 'What does HTTP stand for?'),
(9, 'Which device connects networks?'),
(9, 'What layer does TCP belong to?'),
(9, 'Which protocol sends emails?'),
(9, 'Which device regenerates signals?');

INSERT INTO Options (question_id, text, is_correct) VALUES
(41, 'HyperText Transfer Protocol', 1), (41, 'HighText Protocol', 0), (41, 'Hyper Transfer', 0), (41, 'Host Transfer', 0);
INSERT INTO Options (question_id, text, is_correct) VALUES
(42, 'Router', 1), (42, 'Hub', 0), (42, 'Bridge', 0), (42, 'Repeater', 0);
INSERT INTO Options (question_id, text, is_correct) VALUES
(43, 'Transport', 1), (43, 'Network', 0), (43, 'Data Link', 0), (43, 'Physical', 0);
INSERT INTO Options (question_id, text, is_correct) VALUES
(44, 'SMTP', 1), (44, 'FTP', 0), (44, 'HTTP', 0), (44, 'DNS', 0);
INSERT INTO Options (question_id, text, is_correct) VALUES
(45, 'Repeater', 1), (45, 'Switch', 0), (45, 'Router', 0), (45, 'Bridge', 0);

-- =========================================
-- QUIZ 10: Git & Version Control
-- =========================================
INSERT INTO Quizzes (title, description)
VALUES ('Git & Version Control', 'Test your Git commands and workflow');

INSERT INTO Questions (quiz_id, text) VALUES
(10, 'Which command initializes a repo?'),
(10, 'Which shows commit history?'),
(10, 'Which adds files to staging?'),
(10, 'Which undoes changes?'),
(10, 'Which creates a new branch?');

INSERT INTO Options (question_id, text, is_correct) VALUES
(46, 'git init', 1), (46, 'git start', 0), (46, 'git repo', 0), (46, 'git new', 0);
INSERT INTO Options (question_id, text, is_correct) VALUES
(47, 'git log', 1), (47, 'git show', 0), (47, 'git commits', 0), (47, 'git history', 0);
INSERT INTO Options (question_id, text, is_correct) VALUES
(48, 'git add', 1), (48, 'git push', 0), (48, 'git merge', 0), (48, 'git save', 0);
INSERT INTO Options (question_id, text, is_correct) VALUES
(49, 'git revert', 1), (49, 'git undo', 0), (49, 'git reset', 0), (49, 'git back', 0);
INSERT INTO Options (question_id, text, is_correct) VALUES
(50, 'git branch', 1), (50, 'git fork', 0), (50, 'git split', 0), (50, 'git clone', 0);
