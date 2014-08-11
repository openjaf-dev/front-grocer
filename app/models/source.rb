class Source < ActiveRecord::Base
  belongs_to :payment

  validates_presence_of :name, :cc_type
end
