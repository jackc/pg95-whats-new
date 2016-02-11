-- reusing sensor_samples table from brin.sql

-- Old, slow way to select a random row
select *
from sensor_samples
order by random()
limit 1;

select *
from sensor_samples tablesample bernoulli (0.001)
order by random()
limit 1;

select *
from sensor_samples tablesample system (0.001)
order by random()
limit 1;
