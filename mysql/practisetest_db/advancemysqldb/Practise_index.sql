use advanced_mysql;

-- WHERE INDEX---- 

SHOW INDEXES FROM book_details;

CREATE INDEX book_cat_publisher ON book_details (book_category, publisher);

EXPLAIN SELECT book_name, year_of_publishing
FROM book_details
WHERE book_category='Sci-Fi'
AND publisher='Pathfinder Press';

-- COVERING INDEX ----

DROP INDEX book_cat_publisher ON book_details;

CREATE INDEX book_cat_pub_bkname_year ON book_details (book_category, publisher, book_name, year_of_publishing); 

-- CREATE INDEX book_cat_publisher ON book_details (book_category, publisher);

EXPLAIN SELECT book_name, year_of_publishing
FROM book_details
WHERE book_category='Sci-Fi' 
AND publisher='Pathfinder Press';

DROP INDEX book_cat_pub_bkname_year ON book_details; 

-- GROUP BY

CREATE INDEX book_cat ON book_details (book_category);

DROP INDEX book_cat ON book_details;

EXPLAIN SELECT book_category, count(1) AS book_count 
FROM book_details 
GROUP BY book_category;

-- ORDER BY

CREATE INDEX book_cat_pub ON book_details (book_category, publisher);

DROP INDEX book_cat_pub ON book_details;

CREATE INDEX book_cat_pub_year ON book_details (book_category, publisher, year_of_publishing );

DROP INDEX book_cat_pub_year ON book_details;

CREATE INDEX book_cat_pub_year_bkname ON book_details (book_category, publisher, year_of_publishing , book_name);

EXPLAIN SELECT book_name, year_of_publishing 
FROM book_details 
WHERE book_category='Sci-Fi' AND publisher='Pathfinder Press' AND year_of_publishing > 2000 
ORDER BY year_of_publishing DESC;



