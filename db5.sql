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
