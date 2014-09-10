class AddReferencesToTaxon < ActiveRecord::Migration
  def change
    add_column :taxons, :parent_id, :integer
    add_reference :taxons, :taxonomy, index: true
  end
end
