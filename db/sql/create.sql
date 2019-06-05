DROP TABLE IF EXISTS tbl_user;
CREATE TABLE tbl_user(
user_name varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
password varchar(255)  COLLATE utf8_bin DEFAULT NULL,
email varchar(255)  COLLATE utf8_bin DEFAULT NULL,
mobile_number char(11) COLLATE utf8_bin DEFAULT NULL,
PRIMARY KEY(user_name)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;