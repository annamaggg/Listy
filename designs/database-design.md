## User requirements

```
As a user, I can...

# MVP

- Add a todo x
- List a todo as complete 
- See incomplete todos
- See completed todos

# Additional

- Add tags to categorise my todos
- Add a deadline 
- Add sublist of todos on each todo

```

## Tables design

| accounts              | todos               |
| --------------------- | ------------------  |
| id                    | id                  |
| username              | content             |
| password              | account_id          |


```
Table: accounts
id: SERIAL
username: text
password: text

Table: todos
id: SERIAL
content: text
account_id: int
```

## SQL

```sql

CREATE TABLE accounts (
  id SERIAL PRIMARY KEY,
  username text,
  password text
);

CREATE TABLE todos (
  id SERIAL PRIMARY KEY,
  content text,
  account_id int,
  constraint fk_post foreign key(account_id)
    references accounts(id)
    on delete cascade
);
```