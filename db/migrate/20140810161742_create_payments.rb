class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :number
      t.string :status
      t.float :amount
      t.string :payment_method
      t.references :order, index: true

      t.timestamps
    end
  end
end
