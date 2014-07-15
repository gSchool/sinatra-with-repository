class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :username, :null => false
      t.string :password, :null => false
    end
  end

  def down
    # add reverse migration code here
  end
end
