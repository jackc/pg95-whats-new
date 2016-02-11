-- depending on typical length of job and strategy
-- to recover from failed job we may or may not
-- have an "in progress" column

create table jobs(
  id serial primary key,
  task varchar not null
);

insert into jobs(task) values
  ('send confirmation email'),
  ('vacuum database'),
  ('bill customer');


-- serializes access
begin;
select * from jobs limit 1 for update;
-- delete
commit;

-- concurrent access
begin;
select * from jobs limit 1 for update skip locked;
-- delete
commit;
