-- Мотивация: индексы целесообразно давать тем таблицам, которые не часто редактируются или
-- делают это планово, поэтому gradebook и homework отпадают. В остальные таблицы добавить можно,
-- но я добавлю лишь в teacher, student и group, как наиболее задействованные, на мой взгляд

CREATE INDEX idx_teacher_id ON school.Teacher (teacher_id);
CREATE INDEX idx_student_id ON school.Student (student_id);
CREATE INDEX idx_group_id ON school.Group (group_id);
