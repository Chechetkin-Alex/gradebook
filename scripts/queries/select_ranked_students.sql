-- 9. Порядковый номер каждого студента внутри его группы по среднему баллу
WITH top_students AS (SELECT student_id,
                             group_id,
                             ROW_NUMBER()
                             OVER (PARTITION BY group_id ORDER BY AVG(mark) DESC, student_id) AS rank_within_group
                      FROM school.gradebook
                               NATURAL JOIN school.student
                      GROUP BY student_id, group_id)
SELECT rank_within_group, t.group_id, name, surname
FROM top_students t
         JOIN school.student s ON t.student_id = s.student_id;
