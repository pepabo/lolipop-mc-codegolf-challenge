SET NAMES utf8mb4 COLLATE utf8mb4_general_ci;

DROP TABLE IF EXISTS tokens;

CREATE TABLE tokens (
  id int PRIMARY KEY AUTO_INCREMENT,
  `key` text NOT NULL,
  `value` text NOT NULL
) COMMENT = 'Token';
