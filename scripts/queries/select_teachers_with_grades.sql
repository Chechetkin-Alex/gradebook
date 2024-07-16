-- 8. Средний балл каждого учителя по каждому предмету
WITH avg_teachers AS (SELECT DISTINCT teacher_subject_id,
                                      AVG(mark) OVER (PARTITION BY teacher_subject_id) AS average_mark
                      FROM school.gradebook)
SELECT t.name, t.surname, s.name as subject_name, ROUND(average_mark, 2) as average_mark
FROM avg_teachers a
         NATURAL JOIN school.teachersubject ts
         JOIN school.teacher t ON t.teacher_id = ts.teacher_id
         JOIN school.subject s ON s.subject_id = ts.subject_id
ORDER BY average_mark DESC;
