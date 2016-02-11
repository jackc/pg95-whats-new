create table expenses(
  id serial primary key,
  date date not null,
  department varchar not null,
  category varchar not null,
  vendor varchar not null,
  amount numeric(10,2)
);

insert into expenses(date, department, category, vendor, amount)
  values
  ('2015-10-12', 'Marketing', 'Computer Hardware', 'CDW', 7200),
  ('2015-11-18', 'Marketing', 'Printing', 'Alpha Beta Press', 4300),
  ('2015-12-05', 'Marketing', 'Printing', 'Alpha Beta Press', 3700),
  ('2016-01-08', 'Marketing', 'Printing', 'Alpha Beta Press', 2225),
  ('2016-01-09', 'Marketing', 'Printing', 'Acme Printing', 3000),
  ('2016-01-12', 'Marketing', 'Training', 'Sales Conference', 1500),
  ('2015-10-21', 'Marketing', 'Travel', 'Southwest Airlines', 5800),
  ('2015-12-01', 'Marketing', 'Travel', 'United Airlines', 1400),
  ('2015-11-21', 'Marketing', 'Travel', 'Southwest Airlines', 1100),
  ('2015-11-02', 'Personnel', 'Printing', 'Acme Printing', 500),
  ('2016-01-12', 'Personnel', 'Printing', 'Alpha Beta Press', 500),
  ('2015-10-01', 'Personnel', 'Online Services', 'Harvest', 100),
  ('2015-11-01', 'Personnel', 'Online Services', 'Harvest', 100),
  ('2015-12-01', 'Personnel', 'Online Services', 'Harvest', 100),
  ('2016-01-01', 'Personnel', 'Online Services', 'Harvest', 100),
  ('2015-10-12', 'Personnel', 'Computer Hardware', 'Dell', 7500),
  ('2016-01-15', 'Engineering', 'Computer Hardware', 'CDW', 19200),
  ('2016-01-10', 'Engineering', 'Printing', 'Acme Printing', 500),
  ('2016-01-12', 'Engineering', 'Training', 'RubyConf', 2500),
  ('2015-10-01', 'Engineering', 'Online Services', 'Github', 200),
  ('2015-10-01', 'Engineering', 'Online Services', 'Heroku', 300),
  ('2015-10-01', 'Engineering', 'Online Services', 'AWS', 1100),
  ('2015-11-01', 'Engineering', 'Online Services', 'Github', 200),
  ('2015-11-01', 'Engineering', 'Online Services', 'Heroku', 350),
  ('2015-11-01', 'Engineering', 'Online Services', 'AWS', 1300),
  ('2015-12-01', 'Engineering', 'Online Services', 'Github', 200),
  ('2015-12-01', 'Engineering', 'Online Services', 'Heroku', 250),
  ('2015-12-01', 'Engineering', 'Online Services', 'AWS', 1200),
  ('2016-01-01', 'Engineering', 'Online Services', 'Github', 200),
  ('2016-01-01', 'Engineering', 'Online Services', 'Heroku', 250),
  ('2016-01-01', 'Engineering', 'Online Services', 'AWS', 1800),
  ('2015-11-21', 'Engineering', 'Travel', 'Southwest Airlines', 2800);

select department, sum(amount)
from expenses
group by department;

select category, sum(amount)
from expenses
group by category;

select vendor, sum(amount)
from expenses
group by vendor;

select department, category, vendor, sum(amount)
from expenses
group by grouping sets((department), (category), (vendor), ());

select
  extract(year from date),
  extract(month from date),
  department,
  category,
  vendor,
  sum(amount)
from expenses
group by grouping sets(
  (extract(year from date), extract(month from date)),
  (department),
  (category),
  (vendor),
  ());

select
  extract(year from date),
  extract(month from date),
  department,
  category,
  vendor,
  sum(amount)
from expenses
group by rollup(
  (extract(year from date), extract(month from date)),
  (department),
  (category),
  (vendor));

select
  extract(year from date),
  extract(month from date),
  department,
  category,
  vendor,
  sum(amount)
from expenses
group by cube(
  (extract(year from date), extract(month from date)),
  (department),
  (category),
  (vendor));
