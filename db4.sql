select id, number from streams order by started_at desc limit 1;
select distinct substr(started_at, 1, 4) as year from streams;
select count(*) as total_teachers from teachers;
select started_at from streams order by started_at desc limit 2;
select avg(grade) as avg_grade from grades where teacher_id = 1;
select teacher_id from grades group by teacher_id having avg(grade) < 4.8;
