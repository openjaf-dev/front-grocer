class Company < ActiveRecord::Base
  has_many :addresses
  has_many :users
  
  # has_one primary_contact class User
  
end
