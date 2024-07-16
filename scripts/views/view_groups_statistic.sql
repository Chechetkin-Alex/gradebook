-- Количество учеников в группе
CREATE OR REPLACE VIEW GroupStats AS
SELECT group_id,
       COUNT(student_id) AS cnt_students
FROM school.Student
GROUP BY group_id;
