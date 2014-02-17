json.array!(@products) do |product|
  json.extract! product, :id, :title, :cover, :body
  json.url product_url(product, format: :json)
end
