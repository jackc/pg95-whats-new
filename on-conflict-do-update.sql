create table sparse_matrix(
  x integer,
  y integer,
  val integer,
  primary key(x, y)
);

-- Initial insert
insert into sparse_matrix(x, y, val)
  values (4, 3, 12);

-- Replacement pre-9.5
-- Suffers from race condition
with upsert as (
  update sparse_matrix
  set val = 7
  where x = 4 and y = 3
  returning *
)
insert into sparse_matrix(x, y, val)
select 4, 3, 7
where not exists (
  select 1
  from upsert
  where x = 4 and y = 3
);

-- Replacement with on conflict do update
insert into sparse_matrix as sm (x, y, val)
  values (4, 3, 7)
on conflict (x, y) do update set
  val = excluded.val
where sm.x = excluded.x
  and sm.y = excluded.y;

-- Increment pre-9.5
-- Suffers from race condition
with upsert as (
  update sparse_matrix
  set val = val + 1
  where x = 4 and y = 3
  returning *
)
insert into sparse_matrix(x, y, val)
select 4, 3, 1
where not exists (
  select 1
  from upsert
  where x = 4 and y = 3
);

-- Increment with on conflict do update
insert into sparse_matrix as sm (x, y, val)
  values (4, 3, 1)
on conflict (x, y) do update set
  val = sm.val + excluded.val
where sm.x = excluded.x
  and sm.y = excluded.y;



