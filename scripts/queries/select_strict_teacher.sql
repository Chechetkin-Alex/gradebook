-- 5. Топ 1 "факер" (ставит плохие оценки)
WITH f_cker AS (SELECT teacher_subject_id, AVG(mark) AS average_mark
                FROM school.gradebook
                GROUP BY teacher_subject_id
                ORDER BY AVG(mark)
                LIMIT 1)
SELECT name, surname, average_mark
FROM f_cker f
         JOIN school.teachersubject ts ON ts.teacher_subject_id = f.teacher_subject_id
         JOIN school.teacher t ON t.teacher_id = ts.teacher_id;
