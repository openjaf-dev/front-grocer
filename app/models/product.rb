class Product < ActiveRecord::Base
    has_many :variants
    has_many :images

    validates_presence_of :id, :name, :price, :available_on, :shipping_category
    validates_numericality_of :price, { greater_than: 0 }
end
