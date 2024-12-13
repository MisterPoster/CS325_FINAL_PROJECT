prompt ========================================
prompt Trigger to ensure our business rule that
prompt any past editions of reference
prompt books are not to be priced higher than
prompt newer editions
prompt ========================================

drop table price_edition_archive;

create table price_edition_archive
( price_change_id number generated always as identity,
  IBSN char (13),
  old_bp number,
  new_bp number,
  change_info varchar2 (99),
  update_date date default sysdate,
  primary key (price_change_id)
);


drop trigger trg_log_price_prior_editions;

create or replace trigger trg_log_price_prior_editions
  before update of book_price on book
  for each row
  begin
    if :NEW.book_price > :OLD.book_price THEN
       RAISE_APPLICATION_ERROR (-20000, 'Prior Editions can not be increased in price');
    else
       insert into price_edition_archive (IBSN, old_bp, new_bp, change_info, update_date)
	 values (:OLD.IBSN,
		 :OLD.book_price,
		 :NEW.book_price,
		 'Prior Edition Price Cut',
		 SYSDATE);
    end if;
  end;
/

update Book
  set book_price = book_price * 1.1
  where IBSN = '9781510750463';

update Book
  set book_price = book_price * 0.9
  where IBSN = '9781138826243';

select *
  from price_edition_archive;
