require "sinatra"
require "gschool_database_connection"
require "users_table"

class App < Sinatra::Application
  enable :sessions

  def initialize
    super
    @users_table = UsersTable.new(
      GschoolDatabaseConnection::DatabaseConnection.establish(ENV["RACK_ENV"])
    )
  end

  get "/" do
    current_user = if session[:id]
                     @users_table.find(session[:id])
                   end
    erb :index, :locals => {:user => current_user}
  end

  post "/login" do
    user = @users_table.find_by(params[:username], params[:password])

    if user
      session[:id] = user.fetch("id")
    end

    redirect "/"
  end

  get "/register" do
    erb :register, :locals => {:errors => ""}
  end

  post "/register" do
    if params[:username] == ""
      erb :register, :locals => {:errors => "Username is required"}
    else
      @users_table.create(params[:username], params[:password])

      redirect "/"
    end
  end
end
