class Variant < ActiveRecord::Base
  belongs_to :product

  validates_presence_of :sku
  validates_uniqueness_of :sku
end
