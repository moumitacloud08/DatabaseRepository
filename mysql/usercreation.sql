CREATE USER 'sammy'@'localhost' IDENTIFIED BY 'password';

CREATE USER 'sammy'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';

ALTER USER 'sammy'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';

GRANT PRIVILEGE ON database.table TO 'username'@'host';

GRANT CREATE, ALTER, DROP, INSERT, UPDATE, DELETE, SELECT, REFERENCES, RELOAD on *.* TO 'sammy'@'localhost' WITH GRANT OPTION;

GRANT ALL PRIVILEGES ON *.* TO 'sammy'@'localhost' WITH GRANT OPTION;

FLUSH PRIVILEGES;

REVOKE type_of_permission ON database_name.table_name FROM 'username'@'host';

SHOW GRANTS FOR 'username'@'host';

DROP USER 'username'@'localhost';

mysql -u sammy -p