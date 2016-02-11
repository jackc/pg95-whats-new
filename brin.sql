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
from generate_series(make_date(2015,1,1), make_date(2016,1,1), '1 second') t;


-- Notice natural order
select * from sensor_samples limit 100;

-- ensure statistics up to date to get best query plan
analyze sensor_samples;


-- Try with no index
select avg(val) from sensor_samples
where time between '2015-09-01' and '2015-10-01';

-- btree index
create index on sensor_samples (time);

-- Try again
select avg(val) from sensor_samples
where time between '2015-09-01' and '2015-10-01';

drop index sensor_samples_time_idx;

create index on sensor_samples using brin(time);

select avg(val) from sensor_samples
where time between '2015-09-01' and '2015-10-01';
