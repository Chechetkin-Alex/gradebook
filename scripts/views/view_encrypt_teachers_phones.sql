-- Сокрытие номеров учителей от посторонних лиц
CREATE OR REPLACE VIEW encrypt_teachers_phones AS
SELECT
    teacher_id,
    name,
    surname,
    REGEXP_REPLACE(phone_number, '(\+\d{4})\d{5}(\d{2})', '\1*****\2') AS encrypted_phone_number,
    telegram_id,
    vk_id
FROM
    school.teacher;
