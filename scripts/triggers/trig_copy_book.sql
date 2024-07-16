CREATE OR REPLACE FUNCTION copy_gradebook_to_archive()
    RETURNS TRIGGER AS
$$
BEGIN
    INSERT INTO school.GradeBookArchiveFresh (book_id, grade_date, student_id, teacher_subject_id, mark)
    SELECT book_id, grade_date, student_id, teacher_subject_id, mark
    FROM school.GradeBook
    WHERE teacher_subject_id IN (SELECT teacher_subject_id
                                 FROM school.TeacherSubject
                                 WHERE teacher_id = OLD.teacher_id);
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_copy_gradebook_to_archive
    BEFORE DELETE
    ON school.Teacher
    FOR EACH ROW
EXECUTE FUNCTION copy_gradebook_to_archive();
