CREATE SCHEMA IF NOT EXISTS school;

CREATE TABLE IF NOT EXISTS school.Group
(
    group_id VARCHAR(15) NOT NULL PRIMARY KEY,
    class    INTEGER     NOT NULL
);

CREATE TABLE IF NOT EXISTS school.Student
(
    student_id             INTEGER      NOT NULL PRIMARY KEY,
    name                   VARCHAR(255) NOT NULL,
    surname                VARCHAR(255) NOT NULL,
    group_id               VARCHAR(15),
    phone_number           VARCHAR(20)  NOT NULL,
    telegram_id            VARCHAR(100),
    vk_id                  VARCHAR(100),
    social_security_number NUMERIC,
    FOREIGN KEY (group_id) REFERENCES school.group (group_id)
);

CREATE TABLE IF NOT EXISTS school.Parent
(
    parent_id    INTEGER      NOT NULL PRIMARY KEY,
    name         VARCHAR(255) NOT NULL,
    surname      VARCHAR(255) NOT NULL,
    priority     BOOLEAN      NOT NULL,
    phone_number VARCHAR(20)  NOT NULL,
    telegram_id  VARCHAR(100),
    vk_id        VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS school.StudentParent
(
    student_id INTEGER NOT NULL,
    parent_id  INTEGER NOT NULL,
    PRIMARY KEY (student_id, parent_id),
    FOREIGN KEY (student_id) REFERENCES school.student (student_id),
    FOREIGN KEY (parent_id) REFERENCES school.parent (parent_id)
);

CREATE TABLE IF NOT EXISTS school.Teacher
(
    teacher_id   INTEGER      NOT NULL PRIMARY KEY,
    name         VARCHAR(255) NOT NULL,
    surname      VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20)  NOT NULL,
    telegram_id  VARCHAR(100),
    vk_id        VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS school.Subject
(
    subject_id INTEGER      NOT NULL PRIMARY KEY,
    name       VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS school.TeacherSubject
(
    teacher_subject_id INTEGER NOT NULL PRIMARY KEY,
    teacher_id         INTEGER NOT NULL,
    subject_id         INTEGER NOT NULL,
    FOREIGN KEY (teacher_id) REFERENCES school.teacher (teacher_id),
    FOREIGN KEY (subject_id) REFERENCES school.subject (subject_id)
);

CREATE TABLE IF NOT EXISTS school.Homework
(
    homework_id        INTEGER   NOT NULL PRIMARY KEY,
    teacher_subject_id INTEGER,
    group_id           VARCHAR(15),
    deadline           TIMESTAMP NOT NULL,
    text               VARCHAR,
    FOREIGN KEY (teacher_subject_id) REFERENCES school.teachersubject (teacher_subject_id),
    FOREIGN KEY (group_id) REFERENCES school.group (group_id)
);

CREATE TABLE IF NOT EXISTS school.GradeBook
(
    book_id            INTEGER   NOT NULL PRIMARY KEY,
    grade_date         TIMESTAMP NOT NULL,
    student_id         INTEGER,
    teacher_subject_id INTEGER,
    mark               INTEGER   NOT NULL,
    FOREIGN KEY (student_id) REFERENCES school.student (student_id),
    FOREIGN KEY (teacher_subject_id) REFERENCES school.teachersubject (teacher_subject_id)
);

CREATE TABLE IF NOT EXISTS school.Message
(
    parent_id          INTEGER   NOT NULL,
    student_id         INTEGER   NOT NULL,
    grade_date         TIMESTAMP NOT NULL,
    teacher_subject_id INTEGER,
    mark               INTEGER   NOT NULL,
    message_text       TEXT      NOT NULL,
    PRIMARY KEY (parent_id, student_id, grade_date)
);

CREATE TABLE IF NOT EXISTS school.GradeBookArchiveFresh AS
SELECT *
FROM school.GradeBook;
