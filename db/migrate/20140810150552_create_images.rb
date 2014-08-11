class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :url
      t.integer :position
      t.string :title
      t.string :type
      t.references :variant, index: true
      t.references :product, index: true

      t.timestamps
    end
  end
end
