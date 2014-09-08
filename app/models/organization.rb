class Organization < ActiveRecord::Base
  has_one :address
  
  has_many :organization_users
  belongs_to :owner, :class_name => 'User', :foreign_key => :owner_id
  
  has_many :users, :through => :organization_users  
  
  accepts_nested_attributes_for :address
end
