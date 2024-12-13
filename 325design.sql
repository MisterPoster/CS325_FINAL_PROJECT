-- Samuel Sparenga
-- Ashton Bruce
-- Jeremy Shueh

-- CS 325 - Fall 2024

-- December 2, 2024

-- Table: Member
-- Purpose: Tracks members of the organization. Includes unique member IDs, personal details (names, email), 
-- the date they joined, and their cumulative purchase volume.
drop table Member ;
create table Member
( member_id char (20) not null,
  mem_lname varchar2 (24),
  mem_fname varchar2 (24),
  contact_email varchar2 (50),
  join_date date not null,
  total_purchase_volume number (10, 2),
  primary key (member_id)
);

-- Table: Member_Contact_Phone
-- Purpose: Stores contact phone numbers for members.
drop table Member_Contact_Phone ;
create table Member_Contact_Phone
( member_id char (20) not null,
  contact_phone char (10),
  primary key (member_id, contact_phone),
  foreign key (member_id) references Member
);

-- Table: Job_Title
-- Purpose: Defines job titles and associated attributes like hourly pay and maximum assignable hours.
drop table Job_Title ;
create table Job_Title
( job_title_code char (6) not null,
  title varchar2 (20),
  pay_hour number (4, 2),
  max_hour_assignable number (4, 2),
  is_part_time char (1),
  primary key (job_title_code)
);

-- Table: Employee
-- Purpose: Tracks employees and their details, including job titles, hire dates, and personal information.
-- ssn: Social Security Number (9 characters, unique per employee).

drop table Employee ;
create table Employee
( employee_id char (10) not null,
  empl_lname varchar2 (24),
  empl_fname varchar2 (24),
  address varchar2 (50),
  contact_email varchar2 (50),
  contact_phone varchar2 (10),
  ssn char (9),
  hiredate date not null,
  job_title_code char (6) not null,
  primary key (employee_id),
  foreign key (job_title_code) references Job_Title
);

-- Table: Transaction
-- Purpose: Logs transactions made by employees, potentially involving members.
-- is_returnable: Indicates if the transaction allows returns ('Y' or 'N').
drop table Transaction ;
create table Transaction
( transaction_id char (20) not null,
  employee_id char (10) not null,
  member_id char (20),
  purchase_date date,
  total_volume number (6, 2),
  is_returnable char (1),
  primary key (transaction_id),
  foreign key (employee_id) references Employee,
  foreign key (member_id) references Member
);

-- Table: Event
-- Purpose: Details events including name, type, date, and time.
drop table Event ;
create table Event
( event_id char (10) not null,
  event_name varchar2 (50) not null,
  event_date date not null,
  event_type varchar2 (24),
  event_start char (5),
  event_end char (5),
  primary key (event_id)
);

-- Table: Member_attends_Event
-- Purpose: Tracks which members attend which events.
drop table Member_attends_Event ;
create table Member_attends_Event
( member_id char (20) not null,
  event_id char (10) not null,
  primary key (member_id, event_id),
  foreign key (member_id) references Member,
  foreign key (event_id) references Event
);

-- Table: Drink
-- Purpose: Defines drink offerings, including details like type, size, and associated employee.
drop table Drink ;
create table Drink
( drink_num char (6) not null,
  drink_name varchar2 (20),
  drink_type varchar2 (20),
  drink_size char (1),
  drink_price number (4, 2),
  employee_id char (10),
  primary key (drink_num),
  foreign key (employee_id) references Employee
);

-- Table: Member_orders_drink
-- Purpose: Tracks drinks ordered by members.
drop table Member_orders_drink ;
create table Member_orders_drink
( member_id char (20) not null,
  drink_num char (6) not null,
  primary key (member_id, drink_num),
  foreign key (member_id) references Member,
  foreign key (drink_num) references Drink
);

-- Table: Private_rental_booth
-- Purpose: Details private booths available for rental.
drop table Private_rental_booth ;
create table Private_rental_booth
( room_id char (10) not null,
  rental_booth_num char (3),
  primary key (room_id)
);

-- Table: Booth_rental
-- Purpose: Tracks booth rentals by members, including rental times.
drop table Booth_rental ;
create table Booth_rental
( rental_id char (20) not null,
  room_id char (10),
  member_id char (20),
  rental_start_time char (5),
  rental_end_time char (5),
  primary key (rental_id),
  foreign key (room_id) references Private_rental_booth,
  foreign key (member_id) references Member
);

-- Table: Book
-- Purpose: Stores book details, including price, sales data, and quantity.
-- IBSN: International Standard Book Number (13 characters).
drop table Book ;
create table Book
(
  IBSN char (13) not null,
  book_name varchar2 (99),
  book_sales_dat number (6, 2),
  book_price number (5, 2),
  book_length number (5, 0),
  qty number (3, 0),
  book_type char (10),
  primary key (IBSN)
);

-- Table: Book_authors
-- Purpose: Stores authors for each book.
-- - Each book can have multiple authors, and each author can be associated with multiple books.
drop table Book_authors ;
create table Book_authors
( IBSN char (13),
  book_author varchar2 (50),
  primary key (IBSN, book_author),
  foreign key (IBSN) references Book
);

-- Table: Book_fiction
-- Purpose: Tracks additional details for fiction books, such as genre, region, and series information.
-- number_in_series: Indicates the position of the book in a series (e.g., "001" for the first book).
drop table Book_fiction ;
create table Book_fiction
( IBSN char (13) not null,
  genre varchar2 (20),
  region varchar2 (20),
  country varchar2 (20),
  number_in_series char (3),
  primary key (IBSN),
  foreign key (IBSN) references Book
);

-- Table: Book_fiction_type
-- Purpose: Specifies types of fiction for books, such as "Fantasy" or "Historical Fiction".
drop table Book_fiction_type ;
create table Book_fiction_type
( IBSN char (13) not null,
  fiction_type varchar2 (25),
  primary key (IBSN, fiction_type),
  foreign key (IBSN) references Book
);

-- Table: Book_nonfiction
-- Purpose: Stores additional details for nonfiction books, including subject and reading level.
-- reading_level: Denoted by two characters (ex: "01" for Grade 1).
-- number_in_series: Indicates the position of the book in a series.
drop table Book_nonfiction ;
create table Book_nonfiction
( IBSN char (13) not null,
  subject varchar2 (50),
  reading_level char (2),
  number_in_series char (3),
  primary key (IBSN),
  foreign key (IBSN) references Book
);

-- Table: Book_nonfiction_topic
-- Purpose: Tracks specific topics covered in nonfiction books.
drop table Book_nonfiction_topic ;
create table Book_nonfiction_topic
( IBSN char (13) not null,
  nonfiction_topic varchar2 (50),
  primary key (IBSN, nonfiction_topic),
  foreign key (IBSN) references Book_nonfiction
);

-- Table: Book_reference
-- Purpose: Stores details for reference books, including edition, format, and difficulty level.
-- level: Indicates the difficulty level (ex: "UnGd" for Undergraduate).
drop table Book_reference ;
create table Book_reference
( IBSN char (13) not null,
  subject varchar2 (40),
  edition char (4),
  format varchar2 (20),
  reading_level char (4),
  primary key (IBSN),
  foreign key (IBSN) references Book
);

-- Table: Game
-- Purpose: Stores details about games, including price, genre, and player-related information.
-- age_min: Minimum recommended age to play.
drop table Game ;
create table Game
( game_id char (12) not null,
  title varchar2 (48),
  price number (5, 2),
  publisher varchar2 (24),
  format varchar2 (48),
  genre varchar2 (24),
  players_max number (2, 0),
  age_min number (2, 0),
  qty number (2, 0),
  primary key (game_id)
);

-- Table: Music_product
-- Purpose: Stores details about music products, including price, genre, and release information.
drop table Music_product ;
create table Music_product
( music_product_id char (20) not null,
  title varchar2 (50),
  price number (5, 2),
  release_date date,
  format varchar2 (24),
  genre varchar2 (24),
  length char (8),
  qty number (3, 0),
  primary key (music_product_id)
);

-- Table: Music_product_artist
-- Purpose: Associates music products with their respective artists.
-- An artist can have multiple music products.
drop table Music_product_artist ;
create table Music_product_artist
( music_product_id char (20) not null,
  artist varchar2 (50),
  primary key (music_product_id, artist),
  foreign key (music_product_id) references Music_product
);

