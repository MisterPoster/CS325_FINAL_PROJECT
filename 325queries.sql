-- Samuel Sparenga
-- Ashton Bruce
-- Jeremy Shueh

-- CS 325 - Fall 2024
-- December 10, 2024

set linesize 200
set pagesize 99
set feedback off

spool 325query-results.txt

prompt === 1 - Sales of fiction texts by region ===
select region,
       sum (book_sales_dat)
  from Book join Book_fiction
       on Book.IBSN = Book_fiction.IBSN
  group by region
  order by sum (book_sales_dat);


prompt === 2 - Video games with an above-than-average cost ===
select GAME_ID,
       title,
       genre
  from Game
  where (format like '(VG)%') and
         price > (select avg (price)
                    from Game
                    where format like '(VG)%');


prompt === 3 - Books ranked by count of authors ===
select book_name,
       count (book_author)
  from Book join Book_authors
       on Book.IBSN = Book_authors.IBSN
  group by book_name
  order by count (book_author) desc;


prompt === 4 - Average cost of nonfiction books by reading level ===
select reading_level,
       avg (book_price)
  from Book join Book_nonfiction
       on Book.IBSN = Book_nonfiction.IBSN
  group by reading_level
  order by avg (book_price) desc;


prompt === 5 - Sum of books sales data by author ===
select book_author,
       sum (book_sales_dat)
  from Book join Book_authors
       on Book.IBSN = Book_authors.IBSN
  group by book_author
  order by sum (book_sales_dat) desc;


prompt === 6 - Most valuable Music product by artist ===
select artist,
       max (price)
  from Music_product join Music_product_artist
       on Music_product.MUSIC_PRODUCT_ID = Music_product_artist.MUSIC_PRODUCT_ID
  group by artist;


prompt === 7 - Most valuable game product by format ===
select format,
       max (price)
  from Game
  group by format;


prompt === 8 - Sum of fictional books sales data by type ===
select fiction_type,
	   sum (book_sales_dat)
    from Book join Book_fiction_type
              on Book.IBSN = Book_fiction_type.IBSN
    group by fiction_type;


prompt === 9 - Members ranked by number of drinks ordered ===
select mem_lname, count(*)
    from member_orders_drink d, member m
    where d.member_id = m.member_id
    group by (mem_lname)
    order by count(*) desc;


prompt === 10 - Employees with below average wages ===
select empl_lname, pay_hour
    from employee e, job_title j
where e.job_title_code = j.job_title_code
and pay_hour < (select avg(pay_hour)
   from job_title);


prompt === 11 - Members that never ordered a drink ===
select mem_lname, mem_fname
  from member m
  where not exists (select 1
                    from member_orders_drink d
	            where m.member_id = d.member_id)
     order by mem_lname;


prompt === 12 - Member with Largest Transaction ===
select mem_lname, total_volume, purchase_date
    from transaction t, member m
where t.member_id = m.member_id
      and total_volume =  (select max(total_volume)
  		             from transaction);


 prompt === 13 - Drinks that were ordered large ===
select drink_name, drink_price, drink_size
    from Drink
where drink_size = 'L'
order by drink_name;


prompt === 14 - Members that joined before 2000 ===
select mem_fname || ' ' || mem_lname "Member Name", join_date
    from Member
    where join_date < '01-Jan-2000'
    order by join_date;


prompt === 15 - Full-time employees ===
select empl_lname, pay_hour "Hourly Pay"
  from employee e, job_title j
  where e.job_title_code = j.job_title_code
        and is_part_time = 'N';



prompt === 16 - Most expensive drink ===
select drink_name, drink_price, drink_size
    from drink
where drink_price = (select max(drink_price)
  from drink);


prompt === 17 - Members without any ongoing booth rentals ===
select mem_lname,
	   mem_fname,
	   join_date
    from Member join Booth_rental
     on Member.MEMBER_ID = Booth_rental.member_id
    where not exists (select 1
    from Booth_rental
    where Member.MEMBER_ID = Booth_rental.member_id);


prompt === 18 - Total Value of Drinks by Type ===
select drink_type,
	   sum (drink_price)
    from Drink
    group by drink_type
    order by sum (drink_price) desc;


prompt ===  19 - Total Sale Volume by Employee ===
select employee_id,
       sum (total_volume)
  from Transaction
  group by employee_id
  order by sum (total_volume) desc;


prompt === 20 - Total Sale Volume by Month ===
select to_char (to_date (purchase_date), 'Month'),
       sum (total_volume)
  from Transaction
  group by to_char (to_date (purchase_date), 'Month')
  order by sum (total_volume) desc;


prompt === 21 - Latest Edition of Reference books ===
select Book_name,
       max (edition)
  from Book join Book_reference
       on Book.IBSN = Book_reference.IBSN
  group by Book_name;


prompt === 22 - Value of Musical Products by genre ===
select genre,
       sum (price)
  from Music_product
  group by genre
  order by sum (price);


prompt === 23 - Members not involved in any stated events ===
select M.MEMBER_ID,
       mem_lname,
       mem_fname
  from Member M join Member_attends_Event MaE
       on M.MEMBER_ID = MaE.member_id
  where not exists (select 1
   	  	        from Member_attends_Event
                        where M.MEMBER_ID = MaE.member_id);


prompt === 24 - Overall of Job Categories ===
select title,
       max (pay_hour),
       avg (pay_hour)
    from Job_Title
    group by title;

spool off




