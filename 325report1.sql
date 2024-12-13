-- Samuel Sparenga
-- Ashton Bruce
-- Jeremy Shueh

-- CS 325 - Fall 2024
-- December 10, 2024

set linesize 200
set pagesize 20
set newpage 0
set feedback off

-- This report details the total sales of fiction books across each world region

spool 325report1-results.txt

ttitle "Total Sales of Fictional Books by World Region"

select rpad (region, 16, '.') "World Region",
       '$' || sum (book_sales_dat) "Total Sales"
  from Book join Book_fiction
       on Book.IBSN = Book_fiction.IBSN
  group by region
  order by sum (book_sales_dat) desc;

spool off
