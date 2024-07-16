-- Сокрытие номера соц страхования от посторонних лиц
CREATE OR REPLACE VIEW encrypted_social_security_number AS
SELECT student_id,
       name,
       surname,
       group_id,
       phone_number,
       telegram_id,
       vk_id,
       REGEXP_REPLACE(social_security_number::text, '(\d{2})\d{6}(\d{2})', '\1******\2') AS encrypted_ssn
FROM school.Student;
