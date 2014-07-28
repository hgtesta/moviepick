class User < ActiveRecord::Base

  has_secure_password # validations: false
  
  # attr_accessor :password_confirmation

  # validates :username, presence: true, uniqueness: true, length: { minimum: 3 }

end
