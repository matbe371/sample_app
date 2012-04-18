# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  password   :string(6..40) 
#  created_at :datetime
#  updated_at :datetime
#
class User < ActiveRecord::Base
  
  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation #globala variabler, som kan nås från utomstående anv och kommer att fyllas i från formulär.
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i #Sträng som mailaddressen ska matchas mot. Reguliärt uttryck.
  
  validates :name, :presence => true, 
                   :length   => { :maximum => 50 } #ser till så att användaren inte har ett tomt namn eller ett namn längre än 50 tecken.
  
  validates :email, :presence => true, 
                    :format   => { :with => email_regex }, #Matchar mot reguliärt uttryck
                    :uniqueness => { :case_sensitive => false } #Ser till så att varje mailaddress i databasen är unik.
                    
  # Automatically create the virtual attribute 'password_confirmation'.
  validates :password, :presence     => true,
                       :confirmation => true,
                       :length       => { :within => 6..40 }
                       
  
  before_save :encrypt_password #Använder den privata metoden innan ett lösen skapas för att kryptera.
  
  # Return true if the user's password matches the submitted password.
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end
  
  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil  if user.nil?
    return user if user.has_password?(submitted_password)
  end
  
  private #Saker som ej akn användas publikt.

    #Krypterar lösenordet
    def encrypt_password
      self.salt = make_salt unless has_password?(password)
      self.encrypted_password = encrypt(password)
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
  
end
