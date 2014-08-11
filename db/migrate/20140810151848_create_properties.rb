class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :name
      t.string :presentation
      t.references :product, index: true

      t.timestamps
    end
  end
end
