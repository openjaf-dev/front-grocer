class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :firstname
      t.string :lastname
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :country
      t.string :phone
      t.string :zipcode

      t.timestamps
    end
  end
end
