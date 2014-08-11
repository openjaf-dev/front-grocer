class Variant < ActiveRecord::Base
  belongs_to :product
  has_many :options
  has_many :images
  has_many :shipments

  accepts_nested_attributes_for :images
  accepts_nested_attributes_for :options

  validates_presence_of :sku
  validates_uniqueness_of :sku
end
