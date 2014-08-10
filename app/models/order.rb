class Order < ActiveRecord::Base

  validates_presence_of :id, :status, :channel, :currency, :placed_on
end
