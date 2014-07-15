require "sinatra"
require "active_record"
require "gschool_database_connection"

class App < Sinatra::Application
  def initialize
    super
    @database_connection = GschoolDatabaseConnection::DatabaseConnection.establish(ENV["RACK_ENV"])
  end

  get "/" do
    "Hello"
  end
end
