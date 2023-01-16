DROP TABLE IF EXISTS users;

CREATE TABLE users(
     email      VARCHAR(255) PRIMARY KEY,
     created_at TIMESTAMP DEFAULT Now()
  );

SELECT COUNT(*)
FROM users
ORDER BY email DESC;
