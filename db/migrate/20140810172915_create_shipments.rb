class CreateShipments < ActiveRecord::Migration
  def change
    create_table :shipments do |t|
      t.string :email
      t.float :cost
      t.string :status
      t.string :stock_location
      t.string :shipping_method
      t.string :tracking
      t.date :updated_at
      t.date :shipped_at
      t.references :variant, index: true
      t.references :product, index: true
      t.references :order, index: true

      t.timestamps
    end
  end
end
