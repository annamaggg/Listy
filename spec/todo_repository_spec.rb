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

  it "returns all incomplete todos by id" do
    repo = TodoRepository.new
    expect(repo.todos_by_account_id(1, false)[0].content).to eq('Milk, eggs, bread')
    expect(repo.todos_by_account_id(1, false)[0].title).to eq('Buy groceries')
    expect(repo.todos_by_account_id(1, false)[0].complete).to eq('f')
    expect(repo.todos_by_account_id(1, false)[0].account_id).to eq('1')
  end

  it "adds a todo to the database" do 
    repo = TodoRepository.new
    todo = Todo.new
    todo.title = "Clean my room"
    todo.content = "Get rid of the mugs"
    todo.complete = false
    todo.account_id = 1
    repo.add_todo(todo)

    todos = repo.todos_by_account_id(1, false)
    expect(todos.length).to eq(2)
    expect(todos[1].title).to eq('Clean my room')
    expect(todos[1].content).to eq('Get rid of the mugs')
    expect(todos[1].complete).to eq('f')
  end

  it "finds todo by todo id" do
    repo = TodoRepository.new
    todo = repo.todo_by_id(1)

    expect(todo.id).to eq("1")
    expect(todo.title).to eq('Buy groceries')
    expect(todo.content).to eq('Milk, eggs, bread')
  end

  it "updates todo" do 
    repo = TodoRepository.new
    repo.update_todo_content("Milk, eggs, bread, cheese", "1")
    todo = repo.todo_by_id(1)

    expect(todo.id).to eq("1")
    expect(todo.title).to eq('Buy groceries')
    expect(todo.content).to eq('Milk, eggs, bread, cheese')
  end
end