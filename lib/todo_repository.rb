require_relative 'todo'
require_relative 'database_connection'

class TodoRepository

  def todos_by_account_id(id, complete)
    sql = 'SELECT id, content, complete, account_id FROM todos WHERE account_id = $1 AND complete = $2;'
    results = DatabaseConnection.exec_params(sql, [id, complete])
      
    todos = []
    results.each do |item|
      todo = Todo.new
      todo.id = item['id']
      todo.content = item['content']
      todo.complete = item['complete']
      todo.account_id = item['account_id']
      todos << todo
    end

    return todos
  end 

  def add_todo(todo)
    sql = 'INSERT INTO todos (content, complete, account_id) VALUES ($1, $2, $3)'
    result = DatabaseConnection.exec_params(sql, [todo.content, todo.complete, todo.account_id])
    return result
  end
end