class Image < ActiveRecord::Base
  belongs_to :variant
  belongs_to :product

  validates_presence_of :url
end
