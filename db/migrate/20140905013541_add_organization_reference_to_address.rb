class AddOrganizationReferenceToAddress < ActiveRecord::Migration
  def change
    add_reference :addresses, :organization, index: true
  end
end
