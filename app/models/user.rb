class User < ActiveRecord::Base

  has_secure_password validations: false
  
  # attr_accessor :password_confirmation

end
