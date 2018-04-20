class Owner < ActiveRecord::Base
  has_many :books
  has_secure_password
  # has_many :backpacks
end
