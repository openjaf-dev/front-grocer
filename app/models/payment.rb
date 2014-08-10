class Payment < ActiveRecord::Base
  belongs_to :order

  validates_presence_of :number, :status, :amount, :payment_method
end
