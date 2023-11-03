DROP TABLE IF EXISTS accounts, todos;

CREATE TABLE accounts (
  id SERIAL PRIMARY KEY,
  username text,
  passkey text
);

CREATE TABLE todos (
  id SERIAL PRIMARY KEY,
  content text,
  account_id int,
  constraint fk_post foreign key(account_id)
    references accounts(id)
    on delete cascade
);

TRUNCATE TABLE accounts, todos RESTART IDENTITY;

INSERT INTO accounts (username, passkey) VALUES ('annamag', 'password');
INSERT INTO todos (content, account_id) VALUES ('Buy groceries', (SELECT id FROM accounts WHERE username='annamag'));