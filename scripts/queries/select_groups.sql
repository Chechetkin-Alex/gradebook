-- 2. Вывести номера групп, где количество учеников больше 2
SELECT group_id, COUNT(*) AS cnt_members
FROM school.student
GROUP BY group_id
HAVING COUNT(*) > 2;
