-- 7. Наиболее старательная группа (субъективно, по оценкам)
--    Результат статистически не значен на таких малых группах)
SELECT group_id
FROM school.gradebook
         NATURAL JOIN school.student
GROUP BY group_id
ORDER BY AVG(mark) DESC
LIMIT 1;
