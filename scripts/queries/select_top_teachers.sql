-- 4. Топ 3 самых знающих учителя (которые ведут больше всего предметов)
WITH top_teachers AS (SELECT teacher_id, cnt_subjects
                      FROM (SELECT teacher_id,
                                   COUNT(subject_id)                                   AS cnt_subjects,
                                   DENSE_RANK() OVER (ORDER BY COUNT(subject_id) DESC) AS rank
                            FROM school.teachersubject
                            GROUP BY teacher_id) AS t
                      WHERE rank < 3
                      LIMIT 3)
SELECT name, surname, cnt_subjects
FROM top_teachers tt
         JOIN school.teacher t ON t.teacher_id = tt.teacher_id;
