class AddPositionToTaxon < ActiveRecord::Migration
  def change
    add_column :taxons, :position, :integer
  end
end
