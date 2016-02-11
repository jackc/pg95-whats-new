create table positions(
  name varchar primary key
);

-- Initial insert
insert into positions(name) values
  ('Database Administrator'),
  ('Project Manager'),
  ('Software Engineer');

-- Fails due to uniqueness violation
insert into positions(name) values
  ('Database Administrator'),
  ('Project Manager'),
  ('Software Engineer'),
  ('QA Director');

-- Without on conflict
-- Uses CTE, values, and except
-- Race condition
with t as (
  values
  ('Database Administrator'),
  ('Project Manager'),
  ('Software Engineer'),
  ('QA Director')
)
insert into positions(name)
select * from t
except
select * from positions;

-- Succeeds and inserts one row
insert into positions(name) values
  ('Database Administrator'),
  ('Project Manager'),
  ('Software Engineer'),
  ('QA Director')
on conflict do nothing;


