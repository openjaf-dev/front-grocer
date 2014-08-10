class LineItem < ActiveRecord::Base
  belongs_to :order

  validates_presence_of  :name, :quantity, :price
end
