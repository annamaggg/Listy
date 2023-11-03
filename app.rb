require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/database_connection'
require_relative 'lib/account_repository'
require_relative 'lib/todo_repository'

DatabaseConnection.connect('listy-db')

class Application < Sinatra::Base
  enable :sessions

  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    return erb(:index)
  end

  post '/login' do
    account_repo = AccountRepository.new
    all_usernames = account_repo.all_usernames
    puts all_usernames

    if all_usernames.include? params[:username]

      account = account_repo.find_by_username(params[:username])
      puts account
      if params[:passkey] == account.passkey
        session.clear
        session[:user_id] = account.id
        puts session[:user_id]
        if session[:user_id] == nil
          return "no session"
          puts "no session"
        else
          puts 'error with redirecting'
          redirect '/homepage'
        end
      else
        puts "Password is incorrect, please try again"
        erb(:index)
      end
    else 
      puts "Username does not exist"
      erb(:index)
    end
  end

  get '/homepage' do
    todo_repo = TodoRepository.new
    @todos = todo_repo.todos_by_account_id(session[:user_id])
    puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    puts @todos[0].content
    puts @todos[0].complete
    puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    return erb(:homepage)
  end

  get '/add-todo' do 
    return erb (:add_todo)
  end

  post '/add-todo' do 
    todo_repo = TodoRepository.new
    todo = Todo.new
    todo.content = params[:todo]
    todo.complete = false
    todo.account_id = session[:user_id]
    todo_repo.add_todo(todo)
    redirect '/homepage'
  end
end