class Image < ActiveRecord::Base
  belongs_to :variant
  belongs_to :product

  has_many :dimensions

  validates_presence_of :url
end
