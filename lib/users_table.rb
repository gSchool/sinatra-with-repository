class UsersTable
  def initialize(database_connection)
    @database_connection = database_connection
  end

  def create(username, password)
    insert_user_sql = <<-SQL
      INSERT INTO users (username, password)
      VALUES ('#{username}', '#{password}')
    SQL

    @database_connection.sql(insert_user_sql)
  end

  def find(id)
    find_sql = <<-SQL
      SELECT * FROM users
      WHERE id = #{id}
    SQL

    @database_connection.sql(find_sql).first
  end
end
