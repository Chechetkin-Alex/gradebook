Таблица `Student`:

| Название                 | Описание                      | Тип данных     | Ограничение   |
|--------------------------|-------------------------------|----------------|---------------|
| `student_id`             | Идентификатор студента        | `INTEGER`      | `PRIMARY KEY` |
| `name`                   | Имя                           | `VARCHAR(255)` | `NOT NULL`    |
| `surname`                | Фамилия                       | `VARCHAR(255)` | `NOT NULL`    |
| `group_id`               | Номер группы                  | `VARCHAR(15)`  | `FOREIGN KEY` |
| `phone_number`           | Номер телефона                | `VARCHAR(20)`  | `NOT NULL`    |
| `telegram_id`            | Ник в Telegram                | `VARCHAR(100)` |               |
| `vk_id`                  | Ник в Вконтакте               | `VARCHAR(100)` |               |
| `social_security_number` | Номер социального страхования | `INTEGER`      |               |

Таблица `Parent`:

| Название       | Описание                         | Тип данных     | Ограничение   |
|----------------|----------------------------------|----------------|---------------|
| `parent_id`    | Идентификатор родителя           | `INTEGER`      | `PRIMARY KEY` |
| `name`         | Имя                              | `VARCHAR(255)` | `NOT NULL`    |
| `surname`      | Фамилия                          | `VARCHAR(255)` | `NOT NULL`    |
| `priority`     | Приоритет при отправке сообщения | `BOOLEAN`      | `NOT NULL`    |
| `phone_number` | Номер телефона                   | `VARCHAR(20)`  | `NOT NULL`    |
| `telegram_id`  | Ник в Telegram                   | `VARCHAR(100)` |               |
| `vk_id`        | Ник в Вконтакте                  | `VARCHAR(100)` |               |

Таблица `StudentParent`:

| Название     | Описание               | Тип данных | Ограничение                  |
|--------------|------------------------|------------|------------------------------|
| `student_id` | Идентификатор студента | `INTEGER`  | `PRIMARY KEY`, `FOREIGN KEY` |
| `parent_id`  | Идентификатор родителя | `INTEGER`  | `PRIMARY KEY`, `FOREIGN KEY` |

Таблица `Teacher`:

| Название       | Описание              | Тип данных     | Ограничение   |
|----------------|-----------------------|----------------|---------------|
| `teacher_id`   | Идентификатор учителя | `INTEGER`      | `PRIMARY KEY` |
| `name`         | Имя                   | `VARCHAR(255)` | `NOT NULL`    |
| `surname`      | Фамилия               | `VARCHAR(255)` | `NOT NULL`    |
| `phone_number` | Номер телефона        | `VARCHAR(20)`  | `NOT NULL`    |
| `telegram_id`  | Ник в Telegram        | `VARCHAR(100)` |               |
| `vk_id`        | Ник в Вконтакте       | `VARCHAR(100)` |               |

Таблица `Subject`:

| Название     | Описание               | Тип данных     | Ограничение   |
|--------------|------------------------|----------------|---------------|
| `subject_id` | Идентификатор предмета | `INTEGER`      | `PRIMARY KEY` |
| `name`       | Название               | `VARCHAR(255)` | `NOT NULL`    |

Таблица `TeacherSubject`:

| Название             | Описание                        | Тип данных | Ограничение   |
|----------------------|---------------------------------|------------|---------------|
| `teacher_subject_id` | Единая сущность учитель-предмет | `INTEGER`  | `PRIMARY KEY` |
| `teacher_id`         | Идентификатор учителя           | `INTEGER`  | `FOREIGN KEY` |
| `subject_id`         | Идентификатор предмета          | `INTEGER`  | `FOREIGN KEY` |

Таблица `Group`:

| Название   | Описание             | Тип данных | Ограничение   |
|------------|----------------------|------------|---------------|
| `group_id` | Идентификатор группы | `INTEGER`  | `PRIMARY KEY` |
| `class`    | Класс (от 1 до 11)   | `INTEGER`  | `PRIMARY KEY` |

Таблица `Homework`:

| Название             | Описание                        | Тип данных  | Ограничение               |
|----------------------|---------------------------------|-------------|---------------------------|
| `homework_id`        | Идентификатор задания           | `INTEGER`   | `PRIMARY KEY`             |
| `teacher_subject_id` | Единая сущность учитель-предмет | `INTEGER`   | `FOREIGN KEY`             |
| `group_id`           | Идентификатор группы            | `INTEGER`   | `NOT NULL`, `FOREIGN KEY` |
| `deadline`           | Крайний срок сдачи              | `TIMESTAMP` | `NOT NULL`                |
| `text`               | Текст задания                   | `VARCHAR`   |                           |

Таблица `GradeBook`:

| Название             | Описание                        | Тип данных | Ограничение               |
|----------------------|---------------------------------|------------|---------------------------|
| `book_id`            | Идентификатор записи в журнал   | `INTEGER`  | `PRIMARY KEY`             |
| `grade_date`         | Дата выставления оценки         | `INTEGER`  | `NOT NULL`                |
| `student_id`         | Идентификатор студента          | `INTEGER`  | `NOT NULL`, `FOREIGN KEY` |
| `teacher_subject_id` | Единая сущность учитель-предмет | `INTEGER`  | `FOREIGN KEY`             |
| `mark`               | Оценка                          | `INTEGER`  | `NOT NULL`                |

Таблица `Message`:

| Название             | Описание                        | Тип данных  | Ограничение   |
|----------------------|---------------------------------|-------------|---------------|
| `parent_id`          | Идентификатор родителя          | `INTEGER`   | `PRIMARY KEY` |
| `student_id`         | Идентификатор ученика           | `INTEGER`   | `PRIMARY KEY` |
| `grade_date`         | Дата выставления оценки         | `TIMESTAMP` | `PRIMARY KEY` |
| `teacher_subject_id` | Единая сущность учитель-предмет | `INTEGER`   | `NOT NULL`    |
| `mark`               | Оценка                          | `INTEGER`   | `NOT NULL`    |
| `message_text`       | Сообщение родителю              | `TEXT`      | `NOT NULL`    |

DDL скрипт создания таблиц в файле `scripts/gradebook_ddl.sql`.
