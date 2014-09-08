class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_one :owner_organization, :class_name => 'Organization', :foreign_key => :owner_id

  has_many :organization_users
  has_many :organizations, :through => :organization_users  

  accepts_nested_attributes_for :owner_organization
end
