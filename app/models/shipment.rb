class Shipment < ActiveRecord::Base
  belongs_to :variant
  belongs_to :product
  belongs_to :order
end
