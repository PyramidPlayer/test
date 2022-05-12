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
