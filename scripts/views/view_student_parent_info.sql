-- Расширение сводной таблицы УченикРодитель личной информацией участников
CREATE OR REPLACE VIEW StudentParentInfo AS
SELECT s.student_id,
       s.name    AS student_name,
       s.surname AS student_surname,
       s.group_id,
       p.parent_id,
       p.name    AS parent_name,
       p.surname AS parent_surname,
       p.phone_number AS parent_phone_number
FROM school.Student s
         JOIN
     school.StudentParent sp ON s.student_id = sp.student_id
         JOIN
     school.Parent p ON sp.parent_id = p.parent_id;