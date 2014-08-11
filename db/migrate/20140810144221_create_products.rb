class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :sku
      t.string :description
      t.float :price
      t.float :cost_price
      t.date :available_on
      t.string :permalink
      t.string :meta_description
      t.string :meta_keywords
      t.string :shipping_category

      t.timestamps
    end
  end
end
