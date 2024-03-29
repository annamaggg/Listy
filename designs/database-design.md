## User requirements

```
As a user, I can...

# MVP

- Add a todo 
- List a todo as complete 
- See incomplete todos 
- See completed todos 

# Additional goals

- view and edit todos
- Add a deadline
- Add description on each todo
- Add tags to categorise my todos
- day/night mode

```

## Tables design

| accounts              | todos               | tags
| --------------------- | ------------------  | ------------------
| id                    | id                  | id
| username              | content             | name
| password              | account_id          | colour
|                       |                     | account_id
|                       |                     | todo_id 

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

## Tags 


