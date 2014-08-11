class CreateVariants < ActiveRecord::Migration
  def change
    create_table :variants do |t|
      t.string :sku
      t.float :price
      t.float :cost_price
      t.integer :quantity
      t.references :product, index: true

      t.timestamps
    end
  end
end
