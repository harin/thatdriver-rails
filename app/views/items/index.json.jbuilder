json.array!(@lost_items) do |lost_item|
  json.extract! lost_item, :returned, :location, :when
  json.url lost_item_url(lost_item, format: :json)
end
