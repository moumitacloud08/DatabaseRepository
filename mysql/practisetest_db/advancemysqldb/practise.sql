

use advanced_mysql;
SELECT MIN(book_id) 
FROM book_details 
WHERE book_category='Sci-Fi';

SELECT EVENT_ID, TRUNCATE(TIMER_WAIT/1000000000000,6) as Duration, SQL_TEXT 
FROM performance_schema.events_statements_history_long;

SELECT event_name AS Stage, TRUNCATE(TIMER_WAIT/1000000000000,6) AS Duration 
FROM performance_schema.events_stages_history_long WHERE NESTING_EVENT_ID=1;

use performance_schema;
select * from setup_consumers;

update setup_consumers set enabled="YES" where name="events_stages_history_long";

select count(sql_text) from events_statements_history;

select THREAD_ID, NAME, PROCESSLIST_ID, PROCESSLIST_USER, PROCESSLIST_HOST, INSTRUMENTED from threads;

select * from setup_instruments where name like "statement/%" and enabled='NO';

update setup_instruments set enabled="YES" where name like "statement/%";

-------- PRACTISE INDEX-------------


use advanced_mysql;
EXPLAIN 
SELECT bd.book_name, ad.author_name, cd.country_code 
FROM country_details cd JOIN author_details ad 
ON cd.country_name=ad.author_country 
JOIN book_details bd 
ON ad.author_name = bd.author_name 
WHERE ad.author_name='Brittany Gray';


CREATE INDEX auth_email ON author_details (author_email);
CREATE INDEX auth_coun ON author_details (author_country);
CREATE INDEX auth_email_ph ON author_details (author_email, author_phone);
CREATE INDEX auth_ph_email ON author_details (author_phone,author_email);

SHOW INDEXES FROM author_details;

EXPLAIN SELECT * FROM author_details WHERE author_email='justinbell@gmail.com';

EXPLAIN SELECT * FROM  author_details FORCE INDEX(auth_email_ph) WHERE author_email='justinbell@gmail.com' AND author_phone=7090978781;

ALTER TABLE book_details
DROP INDEX book_cat_publisher;


SELECT book_name, year_of_publishing
FROM book_details
WHERE book_category='Sci-Fi'
AND publisher='Pathfinder Press';

CREATE INDEX book_cat_publisher ON book_details (book_category, publisher);

CREATE INDEX book_publisher_cat ON book_details (publisher,book_category);
CREATE INDEX book_name ON book_details (book_name);

ALTER TABLE book_details
DROP INDEX book_publisher_cat;

DROP INDEX book_cat ON book_details;

SHOW INDEXES FROM book_details;

CREATE INDEX book_cat_pub_bkname_year ON book_details (book_category, publisher, book_name, year_of_publishing); 

SELECT book_category, count(1) AS book_count 
FROM book_details 
GROUP BY book_category;

EXPLAIN SELECT book_category, count(1) AS book_count 
FROM book_details 
GROUP BY book_category;

CREATE INDEX book_cat ON book_details (book_category);

EXPLAIN SELECT book_name, year_of_publishing 
FROM book_details 
WHERE book_category='Sci-Fi' AND publisher='Pathfinder Press' AND year_of_publishing > 2000 
ORDER BY year_of_publishing DESC;

EXPLAIN SELECT book_name, year_of_publishing 
FROM book_details 
WHERE year_of_publishing > 2000  AND publisher='Pathfinder Press' AND book_category='Sci-Fi'  
ORDER BY year_of_publishing DESC;

CREATE INDEX book_cat_pub ON book_details (book_category, publisher);

DROP INDEX book_cat_pub_year ON book_details;

CREATE INDEX book_cat_pub_year ON book_details (book_category, publisher, year_of_publishing );

CREATE INDEX book_year_pub_cat ON book_details (year_of_publishing, publisher, book_category);


EXPLAIN  SELECT bd.book_name, ad.author_name, cd.country_code 
FROM country_details cd JOIN author_details ad 
ON cd.country_name=ad.author_country
JOIN book_details bd 
ON ad.author_name=bd.author_name
WHERE ad.author_email='victoriabell@gmail.com';

SHOW INDEXES FROM author_details;

DROP INDEX book_cat ON book_details;

CREATE INDEX auth_email ON author_details (author_email);

CREATE INDEX bk_auth_name ON book_details (author_name);


explain select count(author_name), author_country from author_details group by author_country;

SHOW INDEXES FROM author_details;

DROP INDEX auth_coun ON author_details;

CREATE INDEX auth_coun ON author_details (author_country);

explain select count(book_id), availability_status from book_meta_details where  unit_price > 300 GROUP BY availability_status;

CREATE INDEX book_price_avail_status ON book_meta_details(availability_status,unit_price,book_id);

CREATE INDEX book_price_avail_status ON book_meta_details(unit_price,availability_status,book_id);

CREATE INDEX book_price_avail_status ON book_meta_details(book_id,unit_price,availability_status);

CREATE INDEX book_price_avail_status ON book_meta_details(unit_price,availability_status);

DROP INDEX book_price_avail_status ON book_meta_details;






use advanced_mysql;

explain select count(author_name), author_country from author_details group by author_country;

SHOW INDEXES FROM author_details;

DROP INDEX auth_coun ON author_details;

CREATE INDEX auth_coun ON author_details (author_country);

explain select count(book_id), availability_status from book_meta_details where  unit_price > 300 GROUP BY availability_status;

CREATE INDEX book_price_avail_status ON book_meta_details(availability_status,unit_price,book_id);

CREATE INDEX book_price_avail_status ON book_meta_details(unit_price,availability_status,book_id);

CREATE INDEX book_price_avail_status ON book_meta_details(book_id,unit_price,availability_status);

CREATE INDEX book_price_avail_status ON book_meta_details(unit_price,availability_status);

DROP INDEX book_price_avail_status ON book_meta_details;

EXPLAIN select book_id,book_name,author_name FROM book_details WHERE book_category = 'Fantasy' AND publisher = 'Mandrake Press';
EXPLAIN select book_id,book_name,author_name FROM book_details WHERE publisher = 'Mandrake Press';

EXPLAIN select book_id,book_name,author_name FROM book_details WHERE book_category IS NOT NULL  AND publisher = 'Mandrake Press'; 

CREATE INDEX book_cat_publisher ON book_details (book_category, publisher);
DROP INDEX book_cat_publisher ON book_details;

CREATE INDEX book_publisher_cat ON book_details (publisher,book_category);
DROP INDEX book_publisher_cat ON book_details;

----------------------------------------------------------------------

CREATE TABLE SALE_DETAILS (book_id int , book_name VARCHAR(250), book_category VARCHAR(250), sale_date date
-- FOREIGN KEY (book_id) REFERENCES book_details(book_id)
);

INSERT INTO SALE_DETAILS
(
BOOK_ID ,
BOOK_NAME ,
BOOK_CATEGORY ,
SALE_DATE )
VALUES(100015,'He general','Horror','2020-08-11');

--------QUERY OPTIMIZATION---------------

DESC book_details;
DESC author_details;

SHOW INDEXES FROM book_details;
DROP INDEX bk_auth_name ON book_details;
CREATE INDEX bk_auth_name ON book_details (author_name);

SHOW INDEXES FROM author_details;
DROP INDEX ak_auth_name ON author_details;
CREATE INDEX ak_auth_name ON author_details (author_name);

SELECT STRAIGHT_JOIN ad.author_email, ad.author_city, count(*) "NO_OF_BOOKS"
FROM book_details bd JOIN author_details ad 
ON bd.author_name = ad.author_name
GROUP BY ad.author_email, ad.author_city;

EXPLAIN 
SELECT STRAIGHT_JOIN ad.author_email, ad.author_city, count(*) "NO_OF_BOOKS"
FROM book_details bd JOIN author_details ad 
ON bd.author_name = ad.author_name
GROUP BY ad.author_email, ad.author_city;

SELECT STRAIGHT_JOIN ad.author_email, ad.author_city, count(*) "NO_OF_BOOKS"
FROM book_details bd JOIN author_details ad 
ON bd.author_name = ad.author_name
GROUP BY bd.author_name;

EXPLAIN 
SELECT STRAIGHT_JOIN ad.author_email, ad.author_city, count(*) "NO_OF_BOOKS"
FROM book_details bd JOIN author_details ad 
ON bd.author_name = ad.author_name
GROUP BY bd.author_name;

EXPLAIN 
SELECT STRAIGHT_JOIN ad.author_email, ad.author_city, count(*) "NO_OF_BOOKS"
FROM book_details bd JOIN author_details ad 
ON bd.author_name = ad.author_name
GROUP BY ad.author_name;



---

SHOW [FULL] PROCESSLIST;
