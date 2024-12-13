-- Samuel Sparenga
-- Ashton Bruce
-- Jeremy Shueh

-- CS 325 - Fall 2024
-- December 10, 2024

set linesize 200
set pagesize 99
set feedback off

-- This report explores the consumption habits of Members and their drinks

spool 325report4-results.txt

ttitle "Status of Membership Drink Consumption"

column MEMBER_ID heading "Membership|ID" format a20
column mem_lname heading "Last|Name" format a20
column mem_fname heading "First|Name" format a20

column drink_price heading "Drink|Price" format $99.99
column drink_name heading "Drink|Name" format a20

compute count avg sum of drink_price on MEMBER_ID

break on Member_ID skip 1
/

select Member.MEMBER_ID,
       mem_lname,
       mem_fname,
       drink_name,
       drink_price
  from Member, Member_orders_drink, Drink
  where Member.MEMBER_ID = Member_orders_drink.member_id and
 	Member_orders_drink.drink_num = Drink.DRINK_NUM
  group by Member.MEMBER_ID,
	   mem_lname,
	   mem_fname,
	   drink_name,
	   drink_price;

spool off
