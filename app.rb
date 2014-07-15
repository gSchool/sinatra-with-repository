require "sinatra"
require "gschool_database_connection"

class App < Sinatra::Application
  enable :sessions

  def initialize
    super
    @database_connection = GschoolDatabaseConnection::DatabaseConnection.establish(ENV["RACK_ENV"])
  end

  get "/" do
    current_user = if session[:id]
                     @database_connection.sql("select * from users where id = #{session[:id]}").first
                   end
    erb :index, :locals => {:user => current_user}
  end

  post "/login" do
    user = @database_connection.sql("select * from users where username = '#{params[:username]}' and password = '#{params[:password]}'").first

    if user
      session[:id] = user.fetch("id")
    end

    redirect "/"
  end

  get "/register" do
    erb :register
  end

  post "/register" do
    insert_user_sql = <<-SQL
      INSERT INTO users (username, password) VALUES ('#{params[:username]}', '#{params[:password]}')
    SQL

    @database_connection.sql(insert_user_sql)

    redirect "/"
  end
end
