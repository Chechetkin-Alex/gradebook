-- Иногда случаются ситуации, когда семестр подходит к концу, а некоторые оценки оставляют
-- желать лучшего. Поэтому аккурат перед концом семестра учащемуся срочно надо понять, к какому
-- преподавателю сейчас стоит пойти, чтобы урегулировать вопрос с выходящей оценкой
DROP FUNCTION IF EXISTS find_teacher_with_lowest_grade(character varying,character varying);
CREATE OR REPLACE FUNCTION find_teacher_with_lowest_grade(name VARCHAR, surname VARCHAR)
    RETURNS TABLE
            (
                subject_name    VARCHAR,
                teacher_name    VARCHAR,
                teacher_surname VARCHAR,
                lowest_grade    NUMERIC
            )
AS
$$
BEGIN
    IF NOT EXISTS (SELECT 1
                   FROM school.student AS s
                   WHERE s.name = $1
                     AND s.surname = $2) THEN
        RAISE EXCEPTION 'Cannot find %s %s', name, surname
            USING ERRCODE = '404';
    END IF;

    RETURN QUERY
        SELECT s.name                AS subject_name,
               t.name                AS teacher_name,
               t.surname             AS teacher_surname,
               MIN(gb.mark)::NUMERIC AS lowest_grade
        FROM school.Student AS st
                 JOIN school.GradeBook AS gb ON st.student_id = gb.student_id
                 JOIN school.TeacherSubject AS ts ON gb.teacher_subject_id = ts.teacher_subject_id
                 JOIN school.Subject AS s ON ts.subject_id = s.subject_id
                 JOIN school.Teacher AS t ON ts.teacher_id = t.teacher_id
        WHERE st.name = $1
          AND st.surname = $2
        GROUP BY s.name,
                 t.name,
                 t.surname
        LIMIT 1;
END;
$$ LANGUAGE plpgsql;
