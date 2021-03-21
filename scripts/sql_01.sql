SELECT DATETIME(ROUND(date), 'unixepoch') AS isodate
     , date
    , coin
    , close
       FROM History

select t1.*
    ,t1.close / t1.prev_close as r_close
   from
                 (select DATETIME(ROUND(date), 'unixepoch') AS isodate
     , date
    , coin
    , close
  , (select close
   from History b
   where b.date = a.date - 300
      and b.coin = a.coin) as prev_close
from History a)
as t1
order by t1.coin, t1.date ;

select t2.* from
                 (select t1.*
    ,t1.close / t1.prev_close as r_close
   from
                 (select DATETIME(ROUND(date), 'unixepoch') AS isodate
     , date
    , coin
    , close
  , (select close
   from History b
   where b.date = a.date - 300
      and b.coin = a.coin) as prev_close
from History a)
as t1 ) as t2
where t2.r_close > 2
order by t2.coin, t2.date ;