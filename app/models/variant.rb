class Variant < ActiveRecord::Base
  belongs_to :product
  has_many :options
  has_many :images

  validates_presence_of :sku
  validates_uniqueness_of :sku
end
