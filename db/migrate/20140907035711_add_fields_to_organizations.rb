class AddFieldsToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :anual_sales, :string
    add_column :organizations, :employees, :integer
    add_column :organizations, :organization_type, :string
    add_column :organizations, :demographic_market, :string
  end
end
