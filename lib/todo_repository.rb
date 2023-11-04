require_relative 'todo'
require_relative 'database_connection'

class TodoRepository

  def todos_by_account_id(id, complete)
    sql = 'SELECT id, title, content, complete, account_id FROM todos WHERE account_id = $1 AND complete = $2;'
    results = DatabaseConnection.exec_params(sql, [id, complete])
      
    todos = []
    results.each do |item|
      todo = Todo.new
      todo.id = item['id']
      todo.title = item['title']
      todo.content = item['content']
      todo.complete = item['complete']
      todo.account_id = item['account_id']
      todos << todo
    end

    return todos
  end 

  def todo_by_id(id)
    sql = 'SELECT id, title, content, complete, account_id FROM todos WHERE id = $1;'
    result = DatabaseConnection.exec_params(sql, [id])
    puts result 
    todo = Todo.new
    todo.id = result[0]['id']
    todo.title = result[0]['title']
    todo.content = result[0]['content']
    todo.complete = result[0]['complete']
    todo.account_id = result[0]['account_id']
    return todo
  end 

  def add_todo(todo)
    sql = 'INSERT INTO todos (title, content, complete, account_id) VALUES ($1, $2, $3, $4)'
    result = DatabaseConnection.exec_params(sql, [todo.title, todo.content, todo.complete, todo.account_id])
    return result
  end

  def mark_completed(id)
    sql = 'UPDATE todos SET complete = TRUE WHERE id = $1;'
    result = DatabaseConnection.exec_params(sql, [id])
    return result
  end

  def update_todo_content(content, id)
    sql = 'UPDATE todos SET content = $1 WHERE id = $2;'
    result = DatabaseConnection.exec_params(sql, [content, id])
    return result
  end
end