class CreateTaxons < ActiveRecord::Migration
  def change
    create_table :taxons do |t|
      t.string :name
      t.string :permalink

      t.timestamps
    end
  end
end
