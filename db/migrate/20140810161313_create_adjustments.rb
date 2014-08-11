class CreateAdjustments < ActiveRecord::Migration
  def change
    create_table :adjustments do |t|
      t.string :name
      t.string :value
      t.references :order, index: true

      t.timestamps
    end
  end
end
