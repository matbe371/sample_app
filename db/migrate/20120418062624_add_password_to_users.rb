class AddPasswordToUsers < ActiveRecord::Migration
 
  #Lägger till så att varje användare ska ha ett lösenord. 
  def change
    add_column :users, :encrypted_password, :string
  end
end
