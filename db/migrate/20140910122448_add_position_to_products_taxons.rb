class AddPositionToProductsTaxons < ActiveRecord::Migration
  def change
    add_column :products_taxons, :position, :integer
  end
end
