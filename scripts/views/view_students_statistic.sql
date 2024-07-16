-- Статистика каждого ученика по оценкам
CREATE OR REPLACE VIEW StudentGradeStats AS
SELECT s.student_id,
       s.name      AS student_name,
       s.surname   AS student_surname,
       ts.subject_id,
       AVG(g.mark) AS avg_mark
FROM school.Student s
         JOIN
     school.GradeBook g ON s.student_id = g.student_id
         JOIN
     school.TeacherSubject ts ON g.teacher_subject_id = ts.teacher_subject_id
GROUP BY s.student_id, ts.subject_id;
