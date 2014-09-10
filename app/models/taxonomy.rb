class Taxonomy < ActiveRecord::Base
  validates :name, presence: true

  has_many :taxons, inverse_of: :taxonomy
  has_one :root, -> { where parent_id: nil }, class_name: "Spree::Taxon", dependent: :destroy


  default_scope -> { order("#{self.table_name}.position") }
end
