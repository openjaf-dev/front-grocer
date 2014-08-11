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
  
  # always include the lower boundary for semi open intervals
  scope :placed_on_gte, -> (reference_time) { where('students.placed_on >= ?', reference_time) }

  # always exclude the upper boundary for semi open intervals
  scope :placed_on_lt, -> (reference_time) { where('students.placed_on < ?', reference_time) }

  scope :placed_on_between, -> (start_date, end_date) { where(placed_on: start_date..end_date) }
  
  scope :by_wday, -> (collection) { collection.group_by{|o| o.placed_on.wday}.sort{|a,b| a[0]<=>b[0]} }
  
  scope :by_hour, -> (collection) { collection.group_by{|o| o.placed_on.to_time.hour}.sort{|a,b| a[0]<=>b[0]} }
  
  scope :complete, -> { where(:status => 'complete') } 
  scope :incomplete, -> { where.not(:status => 'complete') } 
  
  def completed?
    status == 'complete'
  end
  
  def items
    line_items.sum(&:quantity)
  end
  
end
