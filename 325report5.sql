-- Samuel Sparenga
-- Ashton Bruce
-- Jeremy Shueh

-- CS 325 - Fall 2024
-- December 10, 2024

set linesize 200
set pagesize 99
set feedback off

-- This report will be an abridged Employee roster showcasing their role

spool 325report5-results.txt

ttitle "WordsWorth Employee Roster"

column title heading "Employee|Role" format a7 wor
column empl_lname heading "Last|Name" format a18
column empl_fname heading "First|Name" format a18
colmun address heading "Home|Address" format a5 wor

column pay_hour heading "Hourly|Pay" format $99.99

break on title skip 1
/

select title,
       empl_lname,
       empl_fname,
       address,
       pay_hour
  from Employee join Job_Title
       on Employee.job_title_code = Job_Title.JOB_TITLE_CODE;

spool off
