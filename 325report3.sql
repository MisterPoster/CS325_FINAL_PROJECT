-- Samuel Sparenga
-- Ashton Bruce
-- Jeremy Shueh

-- CS 325 - Fall 2024
-- December 10, 2024

set linesize 200
set pagesize 55
set feedback off

-- This report showcases the top valued music product by genre, then by artist

spool 325report3-results.txt

ttitle "Top Value of Music Products by Genre/Artist"

column genre heading "Musical|Genre" format a16
column artist heading "Artist|Music Group" format a16

column price heading "Top Price" format $9999.99

break on genre skip 1
/

select genre,
       artist,
       price
  from Music_product MP join Music_product_artist MPA
       on MP.MUSIC_PRODUCT_ID = MPA.MUSIC_PRODUCT_ID
  group by genre,
	   artist,
	   price
  order by price desc;

spool off
