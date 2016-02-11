create table weather_stations(
  name varchar primary key,
  last_temp numeric(6,2),
  last_updated timestamptz
);

create table weather_readings(
  station_name varchar not null,
  temp numeric(6,2) not null,
  time timestamptz not null
);

insert into weather_stations(name) values('Chicago');

insert into weather_readings(station_name, temp, time)
  values
  ('Chicago', 12, '2016-01-11 08:00:00'),
  ('Chicago', 15, '2016-01-11 11:00:00'),
  ('Chicago', 14, '2016-01-11 13:00:00');

update weather_stations
set (last_temp, last_updated) = (
  select temp, time
  from weather_readings
  where station_name=weather_stations.name
  order by time desc
  limit 1
);
