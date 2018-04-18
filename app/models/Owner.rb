class Owner < ActiveRecord::Base
  has_many :books
  has_many :backpacks
end
