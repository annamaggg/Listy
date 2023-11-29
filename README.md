<div align="center">
  <h1 align="center">Listy</h1>
  <p>A todo list app. This project was created to practice the basics of app design, styling and using databases.</p>

  <img src="https://github.com/annamaggg/Listy/blob/main/public/scrnsht.png" width="861" alt="img"/>
</div>
<br/>
<br/>

## Tech

Design: Excalladraw, Figma<br/>
languages: Ruby, HTML, JavaScript, CSS<br/>
Gems: sinatra, webrick, rspec<br/>
Server: rack-test
<br/>
<br/>

## Full functionality

- Login/logout
- View todos, complete and incomplete
- Mark todos as complete
- Add todos
- Edit todos

## Run the project

```shell
# This assumes you have Ruby & RVM installed. If you don't, visit:
# https://rvm.io/ to install RVM.

# Install gem dependencies 
$ bundle install

# Start the server
$ rackup

# In your browser, visit `http://localhost:9292` 
```
<br/>
<br/>

## Notes

The SQL seed data truncates the tables in the database and inserts a sample account for testing purposes.


## Potential improvements 

- Add integration tests
- Add option to uncheck completed todos