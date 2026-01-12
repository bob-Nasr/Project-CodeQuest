CREATE DATABASE IF NOT EXISTS mobprog_codequest;
USE mobprog_codequest;

CREATE TABLE
    user (
        userId INT AUTO_INCREMENT PRIMARY KEY,
        username VARCHAR(50) NOT NULL UNIQUE,
        password VARCHAR(255) NOT NULL,
        name VARCHAR(100) NOT NULL,
        phoneNumber VARCHAR(20)
    );

CREATE TABLE
    course (
        courseId INT AUTO_INCREMENT PRIMARY KEY,
        courseName VARCHAR(100) NOT NULL
    );

CREATE TABLE
    course_details (
        id INT AUTO_INCREMENT PRIMARY KEY,
        courseId INT NOT NULL,
        type ENUM ('objective', 'reading', 'question') NOT NULL,
        text TEXT NOT NULL,
        choices TEXT NULL,
        FOREIGN KEY (courseId) REFERENCES course (courseId) ON DELETE CASCADE
    );

CREATE TABLE
    results (
        id INT AUTO_INCREMENT PRIMARY KEY,
        courseId INT NOT NULL,
        userId INT NOT NULL,
        result INT NOT NULL,
        timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );

-- Insert courses
INSERT INTO
    course (courseName)
VALUES
    ('Python'),
    ('Java'),
    ('C++'),
    ('JavaScript');

-- Insert Python information
INSERT INTO
    course_details (courseId, type, text)
VALUES
    (
        1,
        'objective',
        'Understand Python basics and syntax'
    ),
    (
        1,
        'objective',
        'Write simple Python programs using variables and control flow'
    ),
    (
        1,
        'reading',
        'Python is a high-level, interpreted programming language known for its simplicity and readability.'
    ),
    (
        1,
        'reading',
        'Python uses indentation instead of braces to define code blocks. This enforces clean and readable code.'
    ),
    (
        1,
        'reading',
        'Python supports multiple programming paradigms including procedural, object-oriented, and functional programming.'
    );

INSERT INTO
    course_details (courseId, type, text, choices, answer)
VALUES
    (
        1,
        'quiz',
        'Which symbol is used to start a comment in Python?',
        '["//", "#", "/*", "--"]',
        '#'
    ),
    (
        1,
        'quiz',
        'Which keyword is used to define a function in Python?',
        '["function", "define", "def", "fun"]',
        'def'
    ),
    (
        1,
        'quiz',
        'What is the correct file extension for Python files?',
        '[".pyth", ".pt", ".py", ".p"]',
        '.py'
    ),
    (
        1,
        'quiz',
        'Which data type is used to store text in Python?',
        '["int", "float", "string", "str"]',
        'str'
    ),
    (
        1,
        'quiz',
        'How do you print something in Python?',
        '["echo()", "print()", "printf()", "console.log()"]',
        'print()'
    ),
    (
        1,
        'quiz',
        'Which of the following creates a list in Python?',
        '["{}", "()", "[]", "<>"]',
        '[]'
    );

-- Insert Java information
INSERT INTO
    course_details (courseId, type, text)
VALUES
    (
        2,
        'objective',
        'Understand Java syntax and structure'
    ),
    (
        2,
        'objective',
        'Learn object-oriented programming concepts in Java'
    );

INSERT INTO
    course_details (courseId, type, text)
VALUES
    (
        2,
        'reading',
        'Java is a high-level, class-based, object-oriented programming language.'
    ),
    (
        2,
        'reading',
        'Java programs are compiled into bytecode and run on the Java Virtual Machine (JVM).'
    ),
    (
        2,
        'reading',
        'Java uses classes and objects to model real-world entities.'
    ),
    (
        2,
        'reading',
        'Java supports principles such as inheritance, encapsulation, polymorphism, and abstraction.'
    );

INSERT INTO
    course_details (courseId, type, text, choices, answer)
VALUES
    (
        2,
        'question',
        'Which keyword is used to define a class in Java?',
        '["class", "define", "struct", "object"]',
        0
    ),
    (
        2,
        'question',
        'Which method is the entry point of a Java program?',
        '["start()", "run()", "main()", "init()"]',
        2
    ),
    (
        2,
        'question',
        'Which keyword is used to inherit a class in Java?',
        '["this", "extends", "implements", "super"]',
        1
    ),
    (
        2,
        'question',
        'Which data type stores whole numbers in Java?',
        '["float", "double", "int", "char"]',
        2
    ),
    (
        2,
        'question',
        'Which symbol is used to end a statement in Java?',
        '[".", ":", ";", ","]',
        2
    ),
    (
        2,
        'question',
        'Which access modifier makes a variable accessible only within the same class?',
        '["public", "private", "protected", "default"]',
        1
    ),
    (
        2,
        'question',
        'Which of the following is not a Java feature?',
        '["Platform Independent", "Object-Oriented", "Pointer Arithmetic", "Secure"]',
        2
    );

-- Insert C++ information
INSERT INTO
    course_details (courseId, type, text)
VALUES
    (
        3,
        'objective',
        'Understand basic C++ syntax and structure'
    ),
    (
        3,
        'objective',
        'Learn memory management and object-oriented concepts in C++'
    );

INSERT INTO
    course_details (courseId, type, text)
VALUES
    (
        3,
        'reading',
        'C++ is an extension of the C programming language with object-oriented features.'
    ),
    (
        3,
        'reading',
        'C++ allows both procedural and object-oriented programming styles.'
    ),
    (
        3,
        'reading',
        'Memory management in C++ is done using pointers, new, and delete.'
    ),
    (
        3,
        'reading',
        'C++ supports classes, inheritance, and polymorphism.'
    );

INSERT INTO
    course_details (courseId, type, text, choices, answer)
VALUES
    (
        3,
        'question',
        'Which symbol is used to include a library in C++?',
        '["#", "$", "@", "%"]',
        0
    ),
    (
        3,
        'question',
        'Which function is the entry point of a C++ program?',
        '["start()", "main()", "run()", "begin()"]',
        1
    ),
    (
        3,
        'question',
        'Which operator is used to access members of a class through an object?',
        '[".", "->", "::", "*"]',
        0
    ),
    (
        3,
        'question',
        'Which keyword is used to create an object dynamically?',
        '["malloc", "alloc", "new", "create"]',
        2
    ),
    (
        3,
        'question',
        'Which of the following supports function overloading?',
        '["C", "Python", "C++", "Assembly"]',
        2
    ),
    (
        3,
        'question',
        'Which symbol ends a statement in C++?',
        '[".", ":", ";", ","]',
        2
    ),
    (
        3,
        'question',
        'Which concept allows multiple functions with the same name?',
        '["Inheritance", "Encapsulation", "Overloading", "Abstraction"]',
        2
    );

-- Insert JavaScript information
INSERT INTO
    course_details (courseId, type, text)
VALUES
    (
        4,
        'objective',
        'Understand JavaScript syntax and variables'
    ),
    (
        4,
        'objective',
        'Learn how JavaScript interacts with web pages'
    );

INSERT INTO
    course_details (courseId, type, text)
VALUES
    (
        4,
        'reading',
        'JavaScript is a scripting language mainly used for web development.'
    ),
    (
        4,
        'reading',
        'JavaScript runs in the browser and allows dynamic web content.'
    ),
    (
        4,
        'reading',
        'Variables in JavaScript can be declared using var, let, or const.'
    ),
    (
        4,
        'reading',
        'JavaScript can manipulate HTML elements using the DOM.'
    );

INSERT INTO
    course_details (courseId, type, text, choices, answer)
VALUES
    (
        4,
        'question',
        'Which keyword is used to declare a variable in JavaScript?',
        '["var", "int", "define", "let"]',
        0
    ),
    (
        4,
        'question',
        'Which symbol is used for single-line comments in JavaScript?',
        '["#", "//", "/*", "<!--"]',
        1
    ),
    (
        4,
        'question',
        'Which function prints output to the browser console?',
        '["print()", "log()", "console.log()", "echo()"]',
        2
    ),
    (
        4,
        'question',
        'Which data type is used for true or false values?',
        '["number", "string", "boolean", "object"]',
        2
    ),
    (
        4,
        'question',
        'Which keyword prevents a variable from being reassigned?',
        '["let", "var", "static", "const"]',
        3
    ),
    (
        4,
        'question',
        'Which operator compares both value and type?',
        '["==", "=", "===", "!="]',
        2
    ),
    (
        4,
        'question',
        'Which object is used to access HTML elements?',
        '["HTML", "document", "window", "screen"]',
        1
    );

