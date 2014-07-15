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
                     find_sql = <<-SQL
                       SELECT * FROM users
                       WHERE id = #{session[:id]}
                     SQL

                     @database_connection.sql(find_sql).first
                   end
    erb :index, :locals => {:user => current_user}
  end

  post "/login" do
    login_sql = <<-SQL
      SELECT * FROM users
      WHERE username = '#{params[:username]}'
      AND password = '#{params[:password]}'
    SQL

    user = @database_connection.sql(login_sql).first

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
      INSERT INTO users (username, password)
      VALUES ('#{params[:username]}', '#{params[:password]}')
    SQL

    @database_connection.sql(insert_user_sql)

    redirect "/"
  end
end
