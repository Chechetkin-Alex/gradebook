-- 3. Для каждой группы определить ближайшую домашку
WITH nearest_deadlines AS (SELECT st.group_id,
                                  s.name                                                                AS subject_name,
                                  h.text                                                                AS homework_text,
                                  MIN(h.deadline)                                                       AS closest_deadline,
                                  ROW_NUMBER() OVER (PARTITION BY st.group_id ORDER BY MIN(h.deadline)) AS rank
                           FROM school.Student st
                                    JOIN
                                school.GradeBook gb ON st.student_id = gb.student_id
                                    JOIN
                                school.Homework h ON gb.teacher_subject_id = h.teacher_subject_id
                                    JOIN
                                school.teachersubject ts ON ts.teacher_subject_id = h.teacher_subject_id
                                    JOIN
                                school.Subject s ON ts.subject_id = s.subject_id
                           GROUP BY st.group_id, s.name, h.text)
SELECT group_id, subject_name, homework_text, closest_deadline, rank
FROM nearest_deadlines
WHERE rank = 1;
