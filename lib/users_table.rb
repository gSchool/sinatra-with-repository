class UsersTable
  def initialize(database_connection)
    @database_connection = database_connection
  end

  def create(params)
    insert_user_sql = <<-SQL
      INSERT INTO users (username, password)
      VALUES ('#{params[:username]}', '#{params[:password]}')
    SQL

    @database_connection.sql(insert_user_sql)
  end
end
