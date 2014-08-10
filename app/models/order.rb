class Order < ActiveRecord::Base
  has_many :line_items
  has_many :adjustments
  has_many :payments

  validates_presence_of :id, :status, :channel, :currency, :placed_on
end
