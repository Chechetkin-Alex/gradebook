-- Для ученика в журнале найти самый сложный предмет (наименьший средний балл)
-- и вывести домашку по этому предмету
DROP FUNCTION IF EXISTS find_hardest_hw(character varying,character varying);
CREATE OR REPLACE FUNCTION find_hardest_hw(VARCHAR, VARCHAR)
    RETURNS TABLE
            (
                subject  VARCHAR,
                deadline      TIMESTAMP,
                homework VARCHAR
            )

AS
$$
DECLARE
    student_id_local INTEGER;
    subject_id_local INTEGER;
BEGIN
    IF NOT EXISTS (SELECT 1
                   FROM school.student AS s
                   WHERE s.name = $1
                     AND s.surname = $2) THEN
        RAISE EXCEPTION 'Cannot find %s %s', $1, $2
            USING ERRCODE = '404';
    END IF;

    SELECT student_id
    INTO student_id_local
    FROM school.Student AS s
    WHERE $1 = s.name
      AND $2 = s.surname;

    SELECT ts.subject_id
    INTO subject_id_local
    FROM school.TeacherSubject ts
             JOIN school.GradeBook gb ON ts.teacher_subject_id = gb.teacher_subject_id
    WHERE gb.student_id = student_id_local
    GROUP BY ts.subject_id
    ORDER BY AVG(gb.mark)
    LIMIT 1;

    RETURN QUERY
        SELECT s.name AS subject, h.deadline, h.text AS homework
        FROM school.Homework AS h
                 JOIN school.TeacherSubject AS ts ON h.teacher_subject_id = ts.teacher_subject_id
                 JOIN school.Subject AS s ON ts.subject_id = s.subject_id
                 JOIN school.Group AS g ON h.group_id = g.group_id
                 JOIN school.Student AS st ON g.group_id = st.group_id
        WHERE st.student_id = student_id_local
          AND ts.subject_id = subject_id_local;
END;
$$ LANGUAGE plpgsql;
