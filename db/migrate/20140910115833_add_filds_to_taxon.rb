class AddFildsToTaxon < ActiveRecord::Migration
  def change
    add_column :taxons, :lft, :integer
    add_column :taxons, :rgt, :integer
    add_column :taxons, :depth, :integer
  end
end
