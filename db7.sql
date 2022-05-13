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
