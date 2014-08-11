class AddAddressRefToOrders < ActiveRecord::Migration
  def change
    add_reference :orders, :bill_address, index: true
    add_reference :orders, :ship_address, index: true
  end
end
