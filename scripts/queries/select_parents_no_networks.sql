-- 6. У скольких родителей нет либо ВК, либо Telegram?
SELECT COUNT(parent_id)
FROM school.parent
WHERE telegram_id IS NULL
   OR vk_id IS NULL;
