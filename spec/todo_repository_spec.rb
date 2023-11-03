require 'todo_repository'
require 'database_connection'

def reset_tables 
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'listy-db' })
  connection.exec(seed_sql)
end

describe TodoRepository do 
  before(:each) do 
    reset_tables
  end

  it "returns all todos by id" do
    repo = TodoRepository.new
    expect(repo.todos_by_account_id(1)[0].content).to eq('Buy groceries')
    expect(repo.todos_by_account_id(1)[0].account_id).to eq('1')
  end

  it "adds a todo to the database" do 
    repo = TodoRepository.new
    todo = Todo.new
    todo.content = "Clean my room"
    todo.account_id = 1
    repo.add_todo(todo)

    todos = repo.todos_by_account_id(1)
    expect(todos.length).to eq(2)
    expect(todos[1].content).to eq('Clean my room')
  end
end