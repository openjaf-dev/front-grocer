class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.string :name
      t.integer :quantity
      t.float :price
      t.references :order, index: true

      t.timestamps
    end
  end
end
