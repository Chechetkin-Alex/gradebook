CREATE OR REPLACE FUNCTION generate_message()
    RETURNS TRIGGER AS
$$
BEGIN
    IF NEW.mark < 3 THEN
        INSERT INTO school.Message (parent_id, student_id, grade_date, teacher_subject_id, mark, message_text)
        VALUES ((SELECT sp.parent_id
                 FROM school.StudentParent sp
                          JOIN school.Parent p ON sp.parent_id = p.parent_id
                 WHERE sp.student_id = NEW.student_id
                   AND p.priority = TRUE),
                NEW.student_id,
                NEW.grade_date,
                NEW.teacher_subject_id,
                NEW.mark,
                'Ваш ребенок ' || (SELECT name FROM school.Student WHERE student_id = NEW.student_id) || ' ' ||
                (SELECT surname FROM school.Student WHERE student_id = NEW.student_id) || ' получил оценку ' ||
                NEW.mark || ' по предмету ' || (SELECT name
                                                FROM school.Subject
                                                WHERE subject_id =
                                                      (SELECT subject_id
                                                       FROM school.TeacherSubject
                                                       WHERE teacher_subject_id = NEW.teacher_subject_id)) || ' ' ||
                TO_CHAR(NEW.grade_date, 'DD.MM.YYYY'));
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER grade_check_trigger
    AFTER INSERT
    ON school.GradeBook
    FOR EACH ROW
EXECUTE FUNCTION generate_message();
