class Backpack < ActiveRecord::Base
  has_many :books
  belongs_to :owner
end
