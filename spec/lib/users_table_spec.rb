require "spec_helper"

describe UsersTable do

  let(:database_connection) { GschoolDatabaseConnection::DatabaseConnection.establish("test") }

  let(:users_table) { UsersTable.new(database_connection) }

  describe "#create" do
    it "creates a new user record in the database" do
      expect(database_connection.sql("SELECT count(*) FROM users;").first["count"].to_i).to eq(0)

      users_table.create("hunter", "password")

      expect(database_connection.sql("SELECT count(*) FROM users;").first["count"].to_i).to eq(1)
    end
  end

  describe "#find" do
    it "returns the user information with the given id if the user exists" do
      user_id = users_table.create("hunter", "password")

      user = users_table.find(user_id)

      expect(user["username"]).to eq("hunter")
      expect(user["password"]).to eq("password")
    end

    it "return nil if no users are found" do
      user = users_table.find(400)

      expect(user).to eq(nil)
    end
  end

  describe "#find_by" do
    it "returns the user information with the given id if the user exists" do
      users_table.create("hunter", "password")

      user = users_table.find_by("hunter", "password")

      expect(user["username"]).to eq("hunter")
      expect(user["password"]).to eq("password")
    end

    it "return nil if no users are found" do
      user = users_table.find_by("noone", "here")

      expect(user).to eq(nil)
    end
  end
end
