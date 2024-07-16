-- Расширение сводной таблицы УчительПредмет
CREATE OR REPLACE VIEW TeacherSubjectInfo AS
SELECT t.teacher_id,
       t.name    AS teacher_name,
       t.surname AS teacher_surname,
       s.subject_id,
       s.name    AS subject_name
FROM school.Teacher t
         JOIN
     school.TeacherSubject ts ON t.teacher_id = ts.teacher_id
         JOIN
     school.Subject s ON ts.subject_id = s.subject_id;
