json.array!(@taxis) do |taxi|
  json.extract! taxi, :plate_no, :owner, :color
  json.url taxi_url(taxi, format: :json)
end
