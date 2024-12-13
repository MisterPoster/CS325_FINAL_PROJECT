-- Samuel Sparenga
-- Ashton Bruce
-- Jeremy Shueh

-- CS 325 - Fall 2024
-- December 10, 2024

set linesize 200
set pagesize 200
set feedback off

-- This report will be an abridged price summary of the current stock of books based on book type

spool 325report6-results.txt

ttitle "WordsWorth Stock Price Summary"

column book_type heading "Book|Category" format a12
column book_name heading "Book|Title" format a24 wor


column qty heading "Stock" format 9999
column book_price "Book|Price" format $9999.99

break on book_type skip 1
      on book_name skip 2

compute count min max avg of book_price on book_type

select book_type,
       book_name,
       qty,
       book_price
  from Book;

spool off
