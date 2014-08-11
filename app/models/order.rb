class Order < ActiveRecord::Base
  belongs_to :bill_address, class_name: 'Address'  
  belongs_to :ship_address, class_name: 'Address'

  has_many :line_items
  has_many :adjustments
  has_many :payments
  has_many :shipments
  has_one :totals,  class_name: 'OrderTotal'
  
  validates_presence_of :number, :status, :channel, :currency, :placed_on
  
  accepts_nested_attributes_for :bill_address
  accepts_nested_attributes_for :ship_address
  accepts_nested_attributes_for :line_items
  accepts_nested_attributes_for :adjustments
  accepts_nested_attributes_for :payments
  accepts_nested_attributes_for :totals
  
  alias_attribute :billing_address, :bill_address
  alias_attribute :shipping_address, :ship_address
  
end
