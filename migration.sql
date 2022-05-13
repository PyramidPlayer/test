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

# db5 ------------------------------------------------------

select 
	stream.number as stream_number, 
	(select course.name from courses as course where course.id = stream.course_id) as course_name,
	stream.students_amount
from streams as stream where stream.students_amount >= 40;

select 
	(select stream.number from streams stream where stream.id = grade.stream_id) as stream_number, 
	(select (select course.name from courses course where course.id = stream.course_id) from streams as stream where stream.id = grade.stream_id) as course_name, 
	(select teacher.surname || ' ' || teacher.name from teachers as teacher where teacher.id = grade.teacher_id) as teacher,
	grade.grade 
from grades as grade 
order by grade.grade
limit 2;

select 
	teacher.id as teacher_id,
	(select avg(grade.grade) from grades as grade where grade.teacher_id = teacher.id) as avg_grade
from teachers as teacher
where teacher.name = 'Николай' and teacher.surname = 'Савельев';


select
	stream.id as stream_id,
	'Наталья' as teacher_name,
	'Петрова' as teacher_surname
from streams as stream
where stream.id in (
	select grade.stream_id from grades as grade where grade.teacher_id in (
		select teacher.id from teachers as teacher where teacher.name = 'Наталья' and teacher.surname = 'Петрова'))
union
select
	grade.stream_id as stream_id,
	(select teacher.name from teachers as teacher where teacher.id = grade.teacher_id) as teacher_name,
	(select teacher.surname from teachers as teacher where teacher.id = grade.teacher_id) as teacher_surname
from grades as grade
where grade.grade < 4.8;


select
	teacher.name as teacher_name,
	teacher.surname as teacher_surname,
	(select max(grade) from grades) - avg(grade.grade) as grade_to_max,
	avg(grade.grade) - (select min(grade) from grades) as grade_to_min
from teachers as teacher inner join grades as grade on grade.teacher_id = teacher.id
group by teacher.name, teacher.surname;


# db6 ------------------------------------------------------

select
	stream.number as stream_number,
	course.name as course_name,
	stream.started_at
from streams as stream
inner join courses as course on course.id = stream.course_id;

select
	course.name as course_name,
	sum(stream.students_amount) as total_students_amount
from courses as course
inner join streams as stream on stream.course_id = course.id
group by course.name;

select
	teacher.id as teacher_id,
	teacher.surname as teacher_surname,
	teacher.name as teacher_name,
	avg(grade.grade) as avg_grade
from teachers as teacher
left join grades as grade on grade.teacher_id = teacher.id
group by teacher.id, teacher.surname, teacher.name;

# db6 ------------------------------------------------------

create view courses_info as
select
	course.name,
	last_stream.number,
	last_stream.started_at,
	avg(grade.grade)
from courses as course
inner join streams as stream on stream.course_id = course.id
inner join grades as grade on grade.stream_id = stream.id
inner join streams as last_stream on last_stream.course_id = course.id
where last_stream.started_at in (select max(started_at) from streams where course_id = course.id)
group by course.name;

begin transaction;
	delete from grades where teacher_id = 3;
	delete from teachers where id = 3;
commit;

CREATE TRIGGER grade_check BEFORE INSERT
ON grades
BEGIN
	SELECT CASE WHEN NEW.grade NOT BETWEEN 0 AND 5 THEN RAISE(ABORT, 'Wrong value of grade. It should be between 0 and 5') END;
END;

create trigger stream_check before insert
on streams
begin
	select case when NEW.started_at <= DATE('now') then raise(ABORT, 'Started at date should be later than current date') when NEW.number <= (select max(number) from streams) then raise(ABORT, 'New stream number should be grater than existing numbers') end;
end;