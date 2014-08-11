class Payment < ActiveRecord::Base
  belongs_to :order
  has_one :source
  
  accepts_nested_attributes_for :source

  validates_presence_of :number, :status, :amount, :payment_method
end
