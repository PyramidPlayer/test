# db2 ------------------------------------------------------

create table teachers (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	name TEXT NOT NULL,
	surname TEXT NOT NULL,
	email TEXT NOT NULL
);

create table courses (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	name TEXT NOT NULL
);

create table streams (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	course_id INTEGER NOT NULL,
	number TEXT NOT NULL,
	starts_at TEXT NOT NULL,
	students_count INTEGER NOT NULL,
	FOREIGN KEY (course_id) REFERENCES courses(id)
);

create table grades (
	teacher_id INTEGER NOT NULL,
	stream_id INTEGER NOT NULL,
	grade REAL,
	PRIMARY KEY (teacher_id, stream_id),
	FOREIGN KEY (teacher_id) REFERENCES teachers(id),
	FOREIGN KEY (stream_id) REFERENCES streams(id)
);

# db3 ------------------------------------------------------

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

# db4 ------------------------------------------------------

update streams set started_at = substr(started_at, 7, 4) || '-' || substr(started_at, 4, 2) || '-' || substr(started_at, 1, 2);
select id, number from streams order by started_at desc limit 1;
select distinct substr(started_at, 1, 4) as year from streams;
select count(*) as total_teachers from teachers;
select started_at from streams order by started_at desc limit 2;
select avg(grade) as avg_grade from grades where teacher_id = 1;
select teacher_id from grades group by teacher_id having avg(grade) < 4.8;