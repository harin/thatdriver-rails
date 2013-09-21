json.array!(@rates) do |rate|
  json.extract! rate, :comment, :rating
  json.url rate_url(rate, format: :json)
end
