class AddVariantRefToLineItems < ActiveRecord::Migration
  def change
    add_reference :line_items, :variant, index: true
  end
end
