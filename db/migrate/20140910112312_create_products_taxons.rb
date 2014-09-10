class CreateProductsTaxons < ActiveRecord::Migration
  def change
    create_table :products_taxons do |t|
      t.references :product, index: true
      t.references :taxon, index: true

      t.timestamps
    end
  end
end
