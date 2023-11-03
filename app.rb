require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/database_connection'

DatabaseConnection.connect('listy-db')

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end
end