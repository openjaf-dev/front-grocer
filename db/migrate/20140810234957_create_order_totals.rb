class CreateOrderTotals < ActiveRecord::Migration
  def change
    create_table :order_totals do |t|
      t.float :adjustment
      t.float :tax
      t.float :shipping
      t.float :payment
      t.float :total
      t.float :item
      t.references :order, index: true

      t.timestamps
    end
  end
end
