class AddEmailUniquenessIndex < ActiveRecord::Migration
  
  #ser till så att varje mailaddress blir unik även i databasen.
  def self.up
    add_index :users, :email, :unique => true
  end

  def self.down
    remove_index :users, :email
  end
end
