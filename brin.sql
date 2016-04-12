create table sensor_samples(
  id bigserial primary key,
  sensor_id integer not null,
  time timestamptz not null,
  val float8 not null
);

insert into sensor_samples(sensor_id, time, val)
select
  (random() * 100)::integer,
  t,
  random()
from generate_series(make_date(2014,1,1), make_date(2016,1,1), '1 second') t;


-- Notice natural order
select * from sensor_samples limit 100;

-- ensure statistics up to date to get best query plan
analyze sensor_samples;

-- create btree and brin indices on time
create index sensor_samples_time_btree_idx on sensor_samples (time);
create index sensor_samples_time_brin_idx on sensor_samples using brin(time);

-- disable both indices
update pg_index set indisvalid = false where indexrelid = 'sensor_samples_time_btree_idx'::regclass;
update pg_index set indisvalid = false where indexrelid = 'sensor_samples_time_brin_idx'::regclass;


-- Try with no index
select avg(val) from sensor_samples
where time between '2015-09-01' and '2015-10-01';

-- Enable btree index
update pg_index set indisvalid = true where indexrelid = 'sensor_samples_time_btree_idx'::regclass;


-- Try again
select avg(val) from sensor_samples
where time between '2015-09-01' and '2015-10-01';

-- Disable btree index and enable brin index
update pg_index set indisvalid = false where indexrelid = 'sensor_samples_time_btree_idx'::regclass;
update pg_index set indisvalid = true where indexrelid = 'sensor_samples_time_brin_idx'::regclass;


select avg(val) from sensor_samples
where time between '2015-09-01' and '2015-10-01';

-- But check out the index sizes

select relname,
  pg_size_pretty(pg_relation_size(c.oid)) as "size"
from pg_class c
left join pg_namespace n on (n.oid = c.relnamespace)
where relname like 'sensor_samples%idx'
order by pg_relation_size(c.oid) desc;
