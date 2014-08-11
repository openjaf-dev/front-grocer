class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :number
      t.string :status
      t.string :channel
      t.string :email
      t.string :currency
      t.datetime :placed_on

      t.timestamps
    end
  end
end
