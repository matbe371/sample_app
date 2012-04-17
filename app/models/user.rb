# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#
class User < ActiveRecord::Base
  attr_accessible :email, :name #globala variabler, som kan nås från utomstående anv.
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i #Sträng som mailaddressen ska matchas mot. Reguliärt uttryck.
  
  validates :name, :presence => true, 
                   :length   => { :maximum => 50 } #ser till så att användaren inte har ett tomt namn eller ett namn längre än 50 tecken.
  
  validates :email, :presence => true, 
                    :format   => { :with => email_regex }, #Matchar mot reguliärt uttryck
                    :uniqueness => { :case_sensitive => false } #Ser till så att varje mailaddress i databasen är unik.
  
end
