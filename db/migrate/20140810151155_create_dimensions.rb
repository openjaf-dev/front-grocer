class CreateDimensions < ActiveRecord::Migration
  def change
    create_table :dimensions do |t|
      t.integer :height
      t.integer :width
      t.references :image, index: true

      t.timestamps
    end
  end
end
