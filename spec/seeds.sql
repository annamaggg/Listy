DROP TABLE IF EXISTS accounts, todos;

CREATE TABLE accounts (
  id SERIAL PRIMARY KEY,
  username text,
  passkey text
);

CREATE TABLE todos (
  id SERIAL PRIMARY KEY,
  title text,
  content text,
  complete boolean,
  account_id int,
  constraint fk_post foreign key(account_id)
    references accounts(id)
    on delete cascade
);

TRUNCATE TABLE accounts, todos RESTART IDENTITY;

INSERT INTO accounts (username, passkey) VALUES ('annamag', 'password');
INSERT INTO todos (title, content, complete, account_id) VALUES ('Buy groceries', 'Milk, eggs, bread',false, (SELECT id FROM accounts WHERE username='annamag'));