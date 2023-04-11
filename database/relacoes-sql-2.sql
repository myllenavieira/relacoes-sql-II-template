
-- Práticas

CREATE TABLE users(
    id TEXT PRIMARY KEY UNIQUE NOT NULL,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL,
    created_at TEXT DEFAULT(DATETIME()) NOT NULL
);

SELECT * FROM users;

INSERT INTO users(id, name, email, password) VALUES
("U001", "Fulano", "fulano@email.com", "123"), --A
("U002", "Ciclano", "ciclano@email.com", "456"), --B
("U003", "Beltrano", "beltrano@email.com", "789"); --C


-- Prática 2

CREATE TABLE follows (
    follower_id TEXT NOT NULL,
    followed_id TEXT NOT NULL,
    FOREIGN KEY (follower_id) REFERENCES users(id),
    FOREIGN KEY (followed_id) REFERENCES users(id)
);

SELECT * FROM follows;

INSERT INTO follows VALUES
    ("U001", "U002"), -- Pessoa A segue B
    ("U001", "U003"), -- Pessoa A segue C
    ("U002", "U001"); -- Pessoa B segue A

SELECT * FROM follows
INNER JOIN users
ON follows.follower_id = users.id;

SELECT * FROM users
INNER JOIN follows
ON follows.follower_id = users.id;

-- LEFT - > RIGHT
-- (from)users -> (join) follows 
SELECT * FROM users
LEFT JOIN follows
ON follows.follower_id = users.id;



-- mostrar as informações da pessoa que está sendo seguida followed_id

SELECT * FROM users
LEFT JOIN follows
ON follows.follower_id = users.id
INNER JOIN users AS user2 ON follows.followed_id = user2.id;

SELECT * FROM users
LEFT JOIN follows
ON follows.follower_id = users.id
LEFT JOIN users AS user2 ON follows.followed_id = user2.id;

--Vendo colunas específicas
SELECT
    users.id AS userID,
    users.name AS userName,
    follows.followed_id AS seguidoId,
    user2.name AS seguidoName
FROM users
LEFT JOIN follows
ON follows.follower_id = users.id
LEFT JOIN users AS user2 ON follows.followed_id = user2.id;