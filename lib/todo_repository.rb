require_relative 'todo'
require_relative 'database_connection'

class TodoRepository

  def todos_by_account_id(id)
    sql = 'SELECT id, content, account_id FROM todos WHERE account_id = $1;'
    results = DatabaseConnection.exec_params(sql, [id])
      
    todos = []
    results.each do |item|
      todo = Todo.new
      todo.id = item['id']
      todo.content = item['content']
      todo.account_id = item['account_id']
      todos << todo
    end

      return todos
  end 

  def add_todo(todo)
    sql = 'INSERT INTO todos (content, account_id) VALUES ($1, $2)'
    result = DatabaseConnection.exec_params(sql, [todo.content, todo.account_id])
    return result
  end
end