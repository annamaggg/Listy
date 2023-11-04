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

  def colour_mode_toggle
    session[:colour_mode] = (session[:colour_mode] == "day" ? "night" : "day")
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

  post '/logout' do 
    session.clear
    return erb(:index)
  end

  get '/homepage' do
    todo_repo = TodoRepository.new
    @incomplete_todos = todo_repo.todos_by_account_id(session[:user_id], false)
    @complete_todos = todo_repo.todos_by_account_id(session[:user_id], true)
    @mode_status = session[:colour_mode]
    return erb(:homepage)
  end

  get '/add-todo' do 
    return erb (:add_todo)
  end

  post '/add-todo' do 
    todo_repo = TodoRepository.new
    todo = Todo.new
    todo.title = params[:todo_title]
    todo.content = params[:todo_content]
    todo.complete = false
    todo.account_id = session[:user_id]
    todo_repo.add_todo(todo)
    redirect '/homepage'
  end

  post '/mark-completed' do
    todo_repo = TodoRepository.new
    todo_repo.mark_completed(params[:id])
    redirect '/homepage'
  end

  post '/todo' do 
    todo_repo = TodoRepository.new
    @todo = todo_repo.todo_by_id(params[:id])
    return erb(:todo)
  end

  post '/update-todo' do 
    todo_repo = TodoRepository.new
    todo_repo.update_todo_content(params[:content], params[:id])
    redirect '/homepage'
  end

  post '/colour-mode' do
    colour_mode_toggle
    redirect '/homepage'
  end
end