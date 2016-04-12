create table race(
  val integer
);

insert into race values (9), (10);

-- conn 1

begin;
update race set val=val+1;

-- conn 2

begin;
delete from race where val=10;

-- conn 1

commit;

