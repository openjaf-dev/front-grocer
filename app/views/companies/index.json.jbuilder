json.array!(@companies) do |company|
  json.extract! company, :id, :name, :phone
  json.url company_url(company, format: :json)
end
