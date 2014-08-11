class CreateSources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      t.string :name
      t.integer :month
      t.integer :year
      t.string :cc_type
      t.integer :last_digits
      t.references :payment, index: true

      t.timestamps
    end
  end
end
