DROP TABLE IF EXISTS tokens;

CREATE TABLE tokens (
  id int PRIMARY KEY AUTO_INCREMENT,
  `key` text NOT NULL,
  `value` text NOT NULL
);
