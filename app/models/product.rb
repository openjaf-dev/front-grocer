class Product < ActiveRecord::Base
    has_many :variants
    has_many :images
    has_many :properties
    has_many :shipments
    
    has_many :classifications, dependent: :delete_all, inverse_of: :product
    has_many :taxons, through: :classifications

    accepts_nested_attributes_for :variants
    accepts_nested_attributes_for :images
    accepts_nested_attributes_for :properties
    accepts_nested_attributes_for :taxons
    

    validates_presence_of :name, :price, :available_on, :shipping_category
    validates_numericality_of :price, { greater_than: 0 }

    def get_taxons_format
      tax_result=[]

      self.taxons.each do |t|
        tax = []
        auxiliar_taxon = t
        tax << self.name
        tax << auxiliar_taxon.name
        until auxiliar_taxon.parent.nil?
          auxiliar_taxon = auxiliar_taxon.parent
          tax << auxiliar_taxon.name
        end
        tax << auxiliar_taxon.taxonomy.name
        tax.reverse!
        tax << rand(1000) #Adding the count of products
        tax_result << tax
      end

      tax_result

    end
end
