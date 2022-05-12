alter table streams rename column starts_at to started_at;
alter table streams add column finished_at TEXT;

insert into teachers (name, surname, email) values ('Николай', 'Савельев', 'saveliev.n@mai.ru');
insert into teachers (name, surname, email) values ('Наталья', 'Петрова', 'petrova.n@yandex.ru');
insert into teachers (name, surname, email) values ('Елена', 'Малышева', 'malisheva.e@google.com');

create unique index ux_course_name on courses(name);

insert into courses (name) values ('Базы данных');
insert into courses (name) values ('Основы Python');
insert into courses (name) values ('Linux. Рабочая станция');

alter table streams rename column students_count to students_amount;

insert into streams (course_id, number, started_at, students_amount) values (3, '165', '18.08.2020', 34);
insert into streams (course_id, number, started_at, students_amount) values (2, '178', '02.10.2020', 37);
insert into streams (course_id, number, started_at, students_amount) values (1, '203', '12.11.2020', 35);
insert into streams (course_id, number, started_at, students_amount) values (1, '210', '03.12.2020', 41);

insert into grades (teacher_id, stream_id, grade) values (3, 1, 4.7);
insert into grades (teacher_id, stream_id, grade) values (2, 2, 4.9);
insert into grades (teacher_id, stream_id, grade) values (1, 3, 4.8);
insert into grades (teacher_id, stream_id, grade) values (1, 4, 4.9);
