select
    courses.name,
    sum(students_amount) over (partition by streams.course_id) as total_students_amount
from courses
    inner join streams 
        on streams.course_id = courses.id;

select distinct
    teachers.id,
    teachers.surname,
    teachers.name,
    avg(grades.grade) over (partition by grades.teacher_id) as avg_grade
from teachers
    left join grades on grades.teacher_id = teachers.id;

create index academic_performance_teacher_idx on academic_performance(teacher_id);
create index academic_performance_stream_idx on academic_performance(stream_id);
create index stream_number_idx on streams(number);
