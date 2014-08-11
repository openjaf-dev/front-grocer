class Product < ActiveRecord::Base
    has_many :variants
    has_many :images
    has_many :properties
    has_many :shipments

    accepts_nested_attributes_for :variants
    accepts_nested_attributes_for :images
    accepts_nested_attributes_for :properties

    validates_presence_of :name, :price, :available_on, :shipping_category
    validates_numericality_of :price, { greater_than: 0 }
end
