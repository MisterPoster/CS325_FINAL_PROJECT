-- Samuel Sparenga
-- Ashton Bruce
-- Jeremy Shueh

-- CS 325 - Fall 2024
-- December 10, 2024

set linesize 200
set pagesize 30
set feedback off

-- This report contains all video games that have greate than average pricing

spool 325report2-results.txt

ttitle "Report of Above-Average Priced Video Games"

column title heading Name format a12 wor
column format heading Disc format a10 wor
column genre format a12
column publisher format a12

column price format $9999.99

select *
  from Game
  where (format like '(VG)%') and
         price > (select avg (price)
                    from Game
                    where format like '(VG)%');

spool off
