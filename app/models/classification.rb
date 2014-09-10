class Classification < ActiveRecord::Base
  self.table_name = 'products_taxons'
  acts_as_list
  belongs_to :product, inverse_of: :classifications
  belongs_to :taxon, inverse_of: :classifications

  # For #3494
  validates_uniqueness_of :taxon_id, :scope => :product_id, :message => :already_linked
end