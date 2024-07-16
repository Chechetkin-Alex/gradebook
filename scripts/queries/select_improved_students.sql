-- 10. Для каждого ученика узнать, получил ли он оценку лучше своей предыдущей по тому же предмету
WITH pretty_students AS (SELECT student_id
                         FROM (SELECT student_id,
                                      mark,
                                      LAG(mark) OVER (PARTITION BY student_id, teacher_subject_id ORDER BY grade_date) AS previous_mark
                               FROM school.gradebook) t
                         WHERE mark > previous_mark)
SELECT name, surname
FROM pretty_students t
         JOIN school.student s
              ON t.student_id = s.student_id;
