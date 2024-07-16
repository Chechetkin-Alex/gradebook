-- 1. Ранжировать всех учеников по баллам
WITH top_students AS (SELECT student_id, AVG(mark) AS rating
                      FROM school.gradebook
                      GROUP BY student_id
                      ORDER BY AVG(mark) DESC)
SELECT name, surname, rating
FROM top_students t
         JOIN school.student s ON t.student_id = s.student_id;
